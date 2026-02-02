if status is-interactive
	# startup code goes here
    direnv hook fish | source
    zoxide init fish | source
end
