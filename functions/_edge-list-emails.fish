function _edge-list-emails -d 'Lists unique email addresses from Edge profiles'
    argparse 'flavor=' -- $argv
    or return 1

    if set -q _flag_flavor
        _edge-list-profiles | jq -r --arg flavor "$_flag_flavor" \
            '.[] | select(.edgeFlavor == $flavor) | .email | select(. != null and . != "")' | sort -u
    else
        _edge-list-profiles | jq -r '.[].email | select(. != null and . != "")' | sort -u
    end
end
