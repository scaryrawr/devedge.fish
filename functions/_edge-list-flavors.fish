function _edge-list-flavors -d 'Lists the installed Edge applications'
    printf '%s\n' /Applications/Microsoft\ Edge*.app | awk -F/ '{sub(/\.app$/, "", $NF); print $NF}'
end
