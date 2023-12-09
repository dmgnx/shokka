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
