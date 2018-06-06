param ($message)
$result = @{"windows" = $message}
ConvertTo-Json -InputObject $result