function edge -d 'Opens Microsoft Edge with optional arguments'
    argparse 'flavor=' 'profile=' 'debug=?' -- $argv
    or return 1

    # Find matching Edge flavor
    set -l flavors (_edge-list-flavors)
    set -l edge_app

    if set -q _flag_flavor
        # Find flavor matching the flag
        for v in $flavors
            if string match -qi "*$_flag_flavor*" $v
                set edge_app $v
                break
            end
        end
        if not set -q edge_app[1]
            echo "Error: No Edge flavor matching '$_flag_flavor' found" >&2
            return 1
        end
    else
        # Use "plain" Edge (no Canary/Dev/Beta)
        for v in $flavors
            if test "$v" = "Microsoft Edge"
                set edge_app $v
                break
            end
        end
        if not set -q edge_app[1]
            echo "Error: Microsoft Edge not found" >&2
            return 1
        end
    end

    # Build the command
    set -l cmd open -na "/Applications/$edge_app.app" --args

    # Find matching profile
    set -l profile_dir
    if set -q _flag_profile
        set -l profiles (_edge-list-profiles)
        set profile_dir (echo $profiles | jq -r --arg email "$_flag_profile" --arg flavor "$edge_app" \
            '.[] | select(.email == $email and .edgeFlavor == $flavor) | .profileDirectory' | head -n1)

        if test -z "$profile_dir"
            echo "Error: No profile matching '$_flag_profile' for '$edge_app' found" >&2
            return 1
        end
    else
        set profile_dir Default
    end

    set -a cmd --profile-directory="$profile_dir"

    # Add remote debugging if requested
    if set -q _flag_debug
        if test -n "$_flag_debug"
            set -a cmd --remote-debugging-port="$_flag_debug"
        else
            set -a cmd --remote-debugging-port=9222
        end
    end

    # Add any remaining arguments
    set -a cmd $argv

    # Run the command
    $cmd
end
