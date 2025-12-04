function _edge-list-profiles -d 'Lists Edge profiles as JSON with directory, email, and flavor'
    set -l flavors (_edge-list-flavors)
    set -l json_objects

    for edge_flavor in $flavors
        set -l base_dir "/Users/$USER/Library/Application Support/$edge_flavor"

        # Find all profile directories (Default, Profile 1, Profile 2, etc.)
        for prefs_file in "$base_dir"/*/Preferences
            if test -f "$prefs_file"
                set -l profile_dir (dirname "$prefs_file")
                set -l profile_name (basename "$profile_dir")
                set -l email (jq -r '.account_info[0].email // empty' "$prefs_file" 2>/dev/null)

                # Build JSON object for this profile
                set -a json_objects (jq -n \
                    --arg profileDirectory "$profile_name" \
                    --arg email "$email" \
                    --arg edgeFlavor "$edge_flavor" \
                    '{profileDirectory: $profileDirectory, email: $email, edgeFlavor: $edgeFlavor}')
            end
        end
    end

    # Combine all objects into a JSON array
    if test (count $json_objects) -gt 0
        printf '%s\n' $json_objects | jq -s '.'
    else
        echo '[]'
    end
end
