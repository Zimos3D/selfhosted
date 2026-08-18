# mount-and-start-wsl.ps1
# Identifies NVMe by serial number, not disk number

# Find the NVMe by serial number (persistent identifier)
$nvmeSerialNumber = "0025_38D6_1144_CB95."
$disk = Get-Disk | Where-Object { $_.SerialNumber -eq $nvmeSerialNumber }

if ($null -eq $disk) {
    Write-Error "NVMe with serial number $nvmeSerialNumber not found!"
    exit 1
}

$diskNumber = $disk.Number
$physicalDrive = "\\.\PHYSICALDRIVE$diskNumber"

Write-Host "Found NVMe at Disk $diskNumber ($physicalDrive)"

# Step 1: Offline and mount NVMe to WSL
$diskpart_script = @"
select disk $diskNumber
offline disk
exit
"@

$diskpart_script | diskpart
Start-Sleep -Seconds 2

wsl --mount $physicalDrive --bare
Start-Sleep -Seconds 3

# Step 2: Mount the Linux partition by UUID in WSL
$uuid = "f99049d7-de7c-4cdd-bcd9-a0f3c9c4a1c0"
wsl sudo bash -c "mkdir -p /mnt/nvme-linux && mount UUID=$uuid /mnt/nvme-linux"

Start-Sleep -Seconds 2

# Step 3: Start WSL
wsl -d Ubuntu-24.04