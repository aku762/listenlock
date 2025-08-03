# Define the endpoint to listen on
$listenerPrefix = "http://192.168.31.157:8080/"

# Create HttpListener object
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add($listenerPrefix)

# Start listening for incoming requests
$listener.Start()

Write-Host "Listening for requests on $listenerPrefix ..."

try {
    # Keep the listener running until explicitly stopped
    while ($true) {
        # Wait for incoming request
        $context = $listener.GetContext()
        $request = $context.Request

        # Get the requested URL
        $url = $request.Url.LocalPath

        # Check if the requested URL matches the command to lock the machine
        if ($url -eq "/lock") {
            Write-Host "Received lock command. Locking the machine..."
            # Lock the machine
            rundll32.exe user32.dll,LockWorkStation
        }

        # Send response to the client
        $response = $context.Response
        $response.StatusCode = 200
        $responseStatusDescription = "OK"
        $responseStatusDescriptionBytes = [System.Text.Encoding]::ASCII.GetBytes($responseStatusDescription)
        $response.OutputStream.Write($responseStatusDescriptionBytes, 0, $responseStatusDescriptionBytes.Length)
        $response.Close()
    }
}
finally {
    # Stop the listener and perform cleanup when done
    $listener.Stop()
    $listener.Close()
}
