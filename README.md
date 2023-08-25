# Custom RISC-V Processor Spring 2023
This is the main repo of the project and this contains all the subrepos as submodules. 
# Submodules:
## Steps to add a new one:
`git submodule add -b main -f --name <repo_name> <ssh_to_repo> <local_path>`
## Included in this repo:
- Program Counter (PC) `/src/ip/pc`
# Steps to init repo locally
`git clone --recurse-submodules git@github.com:Clarkson-RISC-V-2023/top-main.git`
# Project Top_Level:
`src/top/top.sv`
