# Completions for the edge function

# Disable file completions by default
complete -c edge -f

# --flavor: complete with installed Edge flavors
complete -c edge -l flavor -d 'Edge flavor to launch' -xa '(_edge-list-flavors)'

# --profile: complete with profile emails (flavor-aware)
complete -c edge -l profile -d 'Profile email to use' -xa '(
    set -l edge_flavor (commandline -opc | string match -r -- "--flavor[= ](\S+)" | tail -n1)
    if test -n "$edge_flavor"
        _edge-list-emails --flavor="$edge_flavor"
    else
        _edge-list-emails --flavor="Microsoft Edge"
    end
)'

# --debug: enable remote debugging
complete -c edge -l debug -d 'Enable remote debugging (default port 9222)'
