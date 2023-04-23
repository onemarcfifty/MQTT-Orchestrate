function startFunction() {
    # example: launch iperf3 in client mode
    iperf3 -c $1 -p $2 -t $3 -P $4 &
    LAST_PID=$!
}

function stopFunction() {
#    kill `pidof iperf3`
    kill "$LAST_PID"
}
