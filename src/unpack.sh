export SH_SOURCE=$(readlink -f "$0")

function unpack() {
    local section=$(echo $1 | sha256sum | cut -d' ' -f1)

    cat $SH_SOURCE \
        | awk -v section="$section" '
            BEGIN {
                in_section = 0
            }
            {
                if (in_section == 1) {
                    print $0
                }
                if ($0 == "." section) {
                    in_section = 1
                }
                if ($0 == ".EOF") {
                    exit
                }
            }' \
        | base64 -d \
        | gunzip
}
