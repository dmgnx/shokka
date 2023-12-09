{%+include:src/logger.sh%}
{%+include:src/unpack.sh%}


function macro_include() {    
    awk '{
            if (match($0, /{%\+include:(.+)%}/, matches)) {
                system("cat " matches[1])
            } else {
                print $0
            }
        }'
}

function macro_pack() {
    awk '{
            if (match($0, /{%\+pack:(.+)%}/, matches)) {
                system("echo .$(echo " matches[1] " | sha256sum | cut -d \" \" -f 1)")
                system("cat " matches[1] " | gzip -c | base64 -w 0")
                print "\n.EOF"
            } else {
                print $0
            }
        }'
}

function macro_use() {
    export -f unpack
    awk '{
            if (match($0, /{%\+use:(.+)%}/, matches)) {
                system("unpack src/" matches[1] ".sh")
            } else {
                print $0
            }
        }'
}



function generate() {
    local source="$1"
    local destination="${source%~.sh}.sh"

    cat $source \
        | macro_include \
        | macro_pack \
        | macro_use \
        > $destination
    chmod +x $destination
}

for source in "$@"; do
    info "Generating $source"
    generate "$source"
    info "Done"
done

exit 0
{%+pack:src/kwargs.sh%}
{%+pack:src/logger.sh%}
{%+pack:src/unpack.sh%}