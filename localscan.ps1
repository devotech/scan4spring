$drives = Get-PSDrive -PSProvider FileSystem
foreach ($drive in $drives) {
    if ($drive.Name -notin $using:ignoreDrives) {
        $items = Get-ChildItem -Path $drive.Root -Filter $using:keyword -ErrorAction SilentlyContinue -File -Recurse
        foreach ($item in $items) {
            $item.FullName # Show all files found with full drive and path
        }
    }
}