function Get-MobileIronDeviceSpaces {
    <#
        .SYNOPSIS
            Gets all MobileIron Device Spaces with the specified Credentials from MobileIron Cloud
        .DESCRIPTION
            Uses the Credentials specified to make a Basic Authentication Token and Query the MobileIron API for Device Spaces
        .PARAMETER Username
            MobileIron Cloud Username - Typically an Email Address
        .PARAMETER Password
            MobileIron Cloud Password
        .EXAMPLE
            Get-MobileIronDeviceSpaces -Username 'Username' -Password 'Password'
    #>
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $true)]$Username,
        [Parameter(Mandatory = $true)]$Password
    ) 
    BEGIN { 
        $pair = "$($Username):$($Password)"

        $encodedCreds = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($pair))
        $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
        $headers.Add("Authorization", "Basic $encodedCreds" )

    } #BEGIN

    PROCESS {
        $response = Invoke-RestMethod 'https://na2.mobileiron.com/api/v1/tenant/partition/device' -Method 'GET' -Headers $headers -Body $body
    } #PROCESS

    END { 
        $response.result.searchresults
    } #END

} #FUNCTION