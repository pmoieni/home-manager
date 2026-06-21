{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      home-manager,
      nixpkgs,
      self,
      treefmt-nix,
      ...
    }@inputs:
    let
      systems = [
        "x86_64-linux"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;

      treefmtEval = forAllSystems (
        system:
        treefmt-nix.lib.evalModule nixpkgs.legacyPackages.${system} {
          projectRootFile = "flake.nix";
          programs = {
            nixfmt.enable = true; # Format Nix files
            prettier.enable = true; # Format JSON, YAML, Markdown
            shellcheck.enable = true; # Lint shell scripts
            shfmt.enable = true; # Format shell scripts
          };
          settings.formatter = {
            prettier.excludes = [ "*.lock" ];
          };
        }
      );
    in
    {
      # Formatter for `nix fmt`
      formatter = forAllSystems (system: treefmtEval.${system}.config.build.wrapper);

      # Checks for `nix flake check`
      checks = forAllSystems (system: {
        formatting = treefmtEval.${system}.config.build.check self;
      });

      # For non-NixOS systems
      homeConfigurations."pmoieni" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Corrected this line
        extraSpecialArgs = {
          inherit inputs;
          isNixOS = false;
        };
        modules = [
          {
            nixpkgs.config.allowUnfree = true;
          }
          ./hm/pmoieni/home.nix
        ];
      };

      # NixOS module for home-manager
      nixosModules.default =
        {
          config,
          ...
        }:
        {
          imports = [ ./hm/pmoieni/options.nix ];

          config = {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {
                inherit inputs;
              };
              users.pmoieni = {
                imports = [
                  ./hm/pmoieni/home.nix
                ];
              };
            };
          };
        };

      devShells = forAllSystems (system: {
        default = import ./shell.nix {
          pkgs = import nixpkgs {
            inherit system;
          };
        };
      });
    };
}
