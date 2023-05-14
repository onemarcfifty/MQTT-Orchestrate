function startFunction() {
    # example: launch iperf3 in server mode
    iperf3 -s -p $1 &
    LAST_PID=$!
}

function stopFunction() {
#    kill `pidof iperf3`
    kill "$LAST_PID"
}

# Init function example: Kill all remaining iperf3 processes
function initFunction() {
    killall iperf3
    LAST_PID=""
    rm /tmp/iperf*.log
}