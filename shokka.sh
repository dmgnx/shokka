LOGGER=${LOGGER:-"stdout"}

if [ "$LOGGER" = "stdout" ]; then
    function __write_log() {
        echo -e "$@"
    }
elif [ "$LOGGER" = "syslog" ]; then
    APPNAME=${APPNAME:-$(basename $0)}
    LOGGER_ANSI_COLOR_DISABLE="true"
    function __write_log() {
        logger -t "$APPNAME" "$@"
    }
elif [[ "$LOGGER" =~ ^file: ]]; then
    __logfile=${LOGGER#file:}
    function __write_log() {
        echo -e "$@" >> $__logfile
    }
else
    function __write_log() {
        :
    }
fi

function __log() {
    local level=$1
    shift
    local msg="$@"
    local color=""
    local color_reset=""

    local timestamp="$(date +'%Y-%m-%d %H:%M:%S')"
    if [ -z "$LOGGER_ANSI_COLOR_DISABLE" -o "$LOGGER_ANSI_COLOR_DISABLE" = "false" ]; then
        case "$level" in
            DEBUG)
                color="\033[34m"
                ;;
            INFO)
                color="\033[32m"
                ;;
            WARN)
                color="\033[33m"
                ;;
            ERROR)
                color="\033[31m"
                ;;
            FATAL)
                color="\033[35m"
                ;;
            *)
                color="\033[0m"
                ;;
        esac
        color_reset="\033[0m"
        timestamp="\033[36m${timestamp}\033[0m"
    fi
    __write_log "${timestamp} ${color}[${level}] ${msg}${color_reset}"
}

function debug() {
    __log DEBUG "$@"
}

function info() {
    __log INFO "$@"
}

function warn() {
    __log WARN "$@"
}

function error() {
    __log ERROR "$@"
}

function fatal() {
    __log FATAL "$@"
}
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
.80c1bcc7c154ff67cb815a301df02e681d572f44b231b76e885624fa22a8b971
H4sIAAAAAAAAA2WN0QrCMAxF3/MVIU7QgeCepeB/iA91S13ZaKHrFB37d7MiZeJ9Sk5u7jWjq6P1DrunDvdht8cJUNT7WvfY8UtRUdEKPXQ/siKCxIbWmpgm4wNKAlqHVJzphI1PfJE1eBE6yX2ryplQySbZhNcTxpZddi76NiT7plQz/VxvgXWXibFpbLxjyE2Ht8SnlP+CwHEMDitYfXPd+vwBK9cRZvgAzcx/wyEBAAA=
.EOF
.57aaeddfca26fc40e16df7228fc9c6345afb2873f3ddbccd0550519b45a6082d
H4sIAAAAAAAAA5WU3W6bQBCF73mK0RYUuxWSU6e9wCIqaYhjiZgIt6oq10UbvNhI/FSwbtSg7bN3WWyymMike2M8c+ZjGM7guNOp7Zlq6YgLQ0cFXWc7ipiiRCEsAal1BoEJhxysJkC3JFWAn3CXBjTKUvD9xzyixI+zzWAIpUhWhwTbDHTCSZ+QCDKFxC+w/xS8ss227u/n1p3N29tfGbo6eMAFSXFCQB0NmZDVFN+aL2b+Z9dxPf96trCuHNtENN8R9Lo++f8NyUGnvK/97VC36VbXf+FnGMXEgJXctV+hq3gz1jdCxf5/XnB5CWrDaxopyOtQxr4ijBRFEsuyOAtwDDH5TWJTPRehYhuFVEomxcZs5lCHgizOchN1Qn5OCkKrhJShUUIKipNfnDJYY0rg3Zn2XdcSXVuDdmtod4a2OBvWMGEM/amZ8gtvFYGenc5zO4WYT6ntpuoE3Dy8Vjwvgug5UZ1r++rrdNgKiZr6YX+MxuPl+CJBHcFk0grN5jduD+V9P+Wb5c17KON+iu15rteDOe/H3FhfLKcH86Ef8/Y0YnSaQAocKK26g9061ZLl6uY+JmrZBFlLz5ej+pF2iBtEEoNaipuxpVoK37AVD/GlYPtE3QVDCpO2bE0eds9bJnau9lf9SZGlURpmR8rKQl3hI87TI2Hlkq6Q5HmWHymFE7rSEFMcH0nF2z5I/wEsshpgIgYAAA==
.EOF
.d7c0d29f73ee30b3e40f1d75208d746eea8df946b30a23e9c5b7acc46fccff17
H4sIAAAAAAAAA5WRT0vEMBDF7/kUjxBoe1hpRffWi1L/XFxw8SYsMZu6YWta2kQX3X53k6WWDXYR32kyk/ebGUbumro1WN6tlounx+siZ3Er+bpSeotZCcpSmhBSWi2MqjWsbrjYxgm+CJyqWvAKnTwUnVWKTQ2WYY9uw88v5519c7GwBrN1hMgRM0fzTsEN2NgVz4ek1x78w7V+H6mUDRFFNP7yuipu7x+GQY6l9GpwIEcalPvgNWEtER/bc2TJxDevplXarZD+KvaTVJZ6Gj2jP3ud4gbTZ/+kF4sbegosd8r8geuj4BAvvJPzC3e6IPtq9adqSE++AQwDs7c7AgAA
.EOF
