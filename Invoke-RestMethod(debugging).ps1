<# NOTE: the Invoke-RestMethod call below relies on there being a headerToken function which has already been loaded!

    function headerToken {
        In my example the security credentials for accessing the API/backend are created here
        read the Invoke-RestMethod documentation for other options/replacements here
    }
#>

<# NOTE: you need a 'body' which is usually in this format

    $body = @"
        {
            "Key with int value":0,
            "Key with string value": "some string",
            "Key with boolean value": false,
            "Key with null value": null,
            "Last key has no comma": "more string!"
        }
"@

#>

function POST-Method {

    [Cmdletbinding()]
        param(
            [parameter()]
            [string]$uri,
            [string]$body
        )

    #  

    <# NOTE: this is a basic alternative option using Try/catch
    
        try {
            Invoke-RestMethod -Uri $uri -Header $(headerToken) -Method POST -Body $body -ContentType "application/json" 
        } catch {
            Write-Host "StatusCode:" $_.Exception.Response.StatusCode.value__ 
            Write-Host "StatusDescription:" $_.Exception.Response.StatusDescription
        }
    
    #>

    $POSTcall = Invoke-RestMethod -Uri $Uri -Headers $(headerToken) -Body $Body -Method POST -ContentType "application/json" -ErrorVariable Issue -Timeout 3
    
    # catches any error data from $Error[0] which is the last failure recieved by calling Invoke-RestMethod
    # In this case try/catch is probably better but I wanted more information  
    if ($Issue -ne $null) {
    
        Write-Host "StatusCode:"$Error[0].Exception.Response.StatusCode.value__
        Write-Host "StatusDescription:" $Error[0].Exception.Response.StatusCode
        Write-Host "ErrorCausedBy:" $Error[0].InvocationInfo.Line
        Write-Host "Exception:" $Error[0].Exception
    
    # I'm trying to debug my own stuff to see when/if? something is returned I can see it okay    
    } elseif ($POSTcall -ne $null) {
    
        $POSTcall | ConvertFrom-Json
        Write-Host $POSTcall
    
    # Added -Timeout and 'return' below to try to get out of this function 
    # In my case calling it goes on forever since (as I mentioned) I don't seem to get a 200 Success response
    # Timeout does allow the program to continue in this case although it incorrectly returns Failure(timeout) when in actual fact the API call succeeds... Not very satisfactory!
    
    } else {
    
        return
        
    }
    
}

POST-Method -Uri "https://example" -Body $body -Verbose