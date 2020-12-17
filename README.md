Virtualization with Hyper-V Docker on Windows

#Prepare VM to export to BAK folder#
Open a command line session with Run As Administrator
Navigate to C:\Windows\System32\Sysprep folder
Execute the Sysprep.exe tool
In System Cleanup Action select Enter System Out-of-Box Experience (OOBE)
Select the Generalize option
In the Shutdown Options drop down select Shutdown and click on OK
After a while, once the generalization is done, the virtual machine will turn off

# Useful Links
#Config docker on windows
C:\ProgramData\docker\config\daemon.json -> Sample parameters that usually are changed include hosts, dns, graph, group, etc.

#Docker commandline
https://docs.docker.com/engine/reference/commandline/dockerd/

#Get started: Set up Linux Containers on Windows 10
https://docs.microsoft.com/en-us/virtualization/windowscontainers/quick-start/quick-start-windows-10-linux

#Run Hyper-V in a Virtual Machine with Nested Virtualization
https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/user-guide/nested-virtualization

#Hyper-V Integration Services
https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/reference/integration-services

#Generation 1 or 2 virtual machine in Hyper-V
https://docs.microsoft.com/en-us/windows-server/virtualization/hyper-v/plan/should-i-create-a-generation-1-or-2-virtual-machine-in-hyper-v

#Hyper-V Architecture
https://docs.microsoft.com/en-us/windows-server/administration/performance-tuning/role/hyper-v-server/architecture

#Hyper-V Terminology

https://docs.microsoft.com/en-us/windows-server/administration/performance-tuning/role/hyper-v-server/terminology

#System requirements for Hyper-V on Windows Server
https://docs.microsoft.com/en-us/windows-server/virtualization/hyper-v/system-requirements-for-hyper-v-on-windows

