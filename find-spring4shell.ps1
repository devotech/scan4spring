$prefix = Read-host "Enter used prefix for all servers"
$computerNames = @(get-adcomputer -Filter { OperatingSystem -Like '*Windows Server*' } -Properties * |  where { ($_.Name -like "$prefix*" )} | Select name )
$ignoreDrives = @("A", "B" ) # A and B not relevant, D is temp drive of Azure VMs
$keyword = "*spring-*.jar"
$server = Read-Host "Enter server to store logfile"
$path = Read-Host "Enter share to store logfile"
$logfile = "\\$server\$path\spring-servercheck-$prefix.log"

If(!(test-path \\$server\$path))
{
      New-Item -ItemType Directory -Force -Path \\$server\$path
}

Start-Transcript -Path $logfile -NoClobber
[array]$FullItemsArray=@()
foreach ($computer in $computerNames) {
    "Checking $($computer.name)" | write-host # Show computername
    if ((Test-Connection -computername $computer.name -Quiet) -eq $true) {
        "$($computer.name) is online" | write-host
        $FullItemsArray += Invoke-Command -ComputerName $computer.name -ScriptBlock {
            [array]$ComputerItemsArray=@()
            $drives = Get-PSDrive -PSProvider FileSystem
            foreach ($drive in $drives) {
                if ($drive.Name -notin $using:ignoreDrives) {
                    $items = Get-ChildItem -Path $drive.Root -Filter $using:keyword -ErrorAction SilentlyContinue -File -Recurse
                    foreach ($item in $items) {
                        $item.FullName | write-host # Show all files found with full drive and path
                        $obj = New-Object -TypeName psobject
                        $obj | Add-Member -MemberType NoteProperty -Name online -Value $true
                        $obj | Add-Member -MemberType NoteProperty -Name path -Value $($item.FullName)
                        $ComputerItemsArray += $obj
                    }
                }
            }
            return $ComputerItemsArray
        }
    }
    else{
      "$($computer.name) is offline" | write-host
      $obj = New-Object -TypeName psobject
      $obj | Add-Member -MemberType NoteProperty -Name online -Value $false
      $obj | Add-Member -MemberType NoteProperty -Name path -Value $null
      $obj | Add-Member -MemberType NoteProperty -Name PSComputerName -Value $($computer.name)
      $FullItemsArray += $obj
     }
}

Stop-Transcript
$FullItemsArray | Sort-Object -Property Online,PSComputername |Select-Object Online,PScomputername, Path |Format-Table
<#

This is a quick script, don't expect it to be too neat.
It should work for it's intended purpose, readability may be a bit harsh.

#>
