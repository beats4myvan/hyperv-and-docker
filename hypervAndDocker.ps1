#Open PowerShell session with Run as Administrator on the Hyper-V host
# Clone an existing virtual hard disk
cp 'C:\bak\WIN-SRV-2K19-ST-CORE\VHD\WIN-SRV-2K19-ST-CORE.vhdx' c:\HV\HW-M1.vhdx

# Create a new virtual machine
New-VM -Name HW-M1 -MemoryStartupBytes 3gb -VHDPath C:\HV\HW-M1.vhdx -Generation 2 -SwitchName "Private Switch"

# Add second network adapter
Add-VMNetworkAdapter -VMName HW-M1 -SwitchName "External Switch"

# Turn on MAC address spoofing##Change the factory-assigned MAC#
Set-VMNetworkAdapter -VMName HW-M1 -MacAddressSpoofing On

# Turn off dynamic memory
Set-VM -VMName HW-M1 -StaticMemory

# Expose virtualization instructions
Set-VMProcessor -VMName HW-M1 -ExposeVirtualizationExtensions $true

# Create second disk
New-VHD -Path "C:\HV\HW-M1-DISK1.vhdx" -SizeBytes 2gb -Fixed

# Attach the second disk
Add-VMHardDiskDrive -VMName HW-M1 -Path "C:\HV\HW-M1-DISK1.vhdx"

# Power on the VM
Start-VM -VMName HW-M1

# Rename the VM
Invoke-Command -VMName HW-M1 -ScriptBlock { Rename-Computer -NewName HW-M1 -Restart }

# We will assume that network connectivity is set up as expected and we have communication with both the DC and the world

# Domain join
Invoke-Command -VMName HW-M1 -ScriptBlock { Add-Computer -DomainName Lenovo.LOCAL -Restart }

# Role installation
Invoke-Command -VMName HW-M1 -ScriptBlock { Install-WindowsFeature -Name Hyper-V, Containers -IncludeManagementTools -Restart }

# Install Docker Provider
Invoke-Command -VMName HW-M1 -ScriptBlock { Install-Module -Name DockerMsftProvider -Repository PSGallery -Force }

# Install Docker
Invoke-Command -VMName HW-M1 -ScriptBlock { Install-Package -Name Docker -ProviderName DockerMsftProvider }

# Ensure the Docker service is started
Invoke-Command -VMName HW-M1 -ScriptBlock { Start-Service docker }

# Switch current session to the VM
Enter-PSSession -VMName HW-M1

# Check if Docker is working
docker version

# Pull the image
docker pull mcr.microsoft.com/windows/servercore/iis:latest

# Start the required container
docker run --detach --isolation hyperv --publish 9000:80 --name iis mcr.microsoft.com/windows/servercore/iis:latest

# Visit the container
curl -Uri http://localhost:9000 -UseBasicParsing

