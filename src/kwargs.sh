function kwargs() {
    local key="$1"
    local value=""

    shift
    for arg in "$@"; do
        if [ "${arg%=*}" = "$key" ]; then
            value="${arg#*=}"
            break
        fi
    done
    if [ -z "$value" ]; then
        return 1
    fi
    echo "$value"
    return 0
}
