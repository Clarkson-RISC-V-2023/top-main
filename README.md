# Custom RISC-V Processor Spring 2023
This is the main repo of the project and this contains all the subrepos as submodules. 
# Repo git commands:
- # Init repo locally
    `git clone --recurse-submodules git@github.com:Clarkson-RISC-V-2023/top-main.git`
- ## pull submodules
    `git submodule update --init` 
- ## Steps to add a new submodule:
    `git submodule add -b main -f --name <repo_name> <ssh_to_repo> <local_path>`

# Build commands
- ## Create Vivado project from sourcers 
    `make build_top_project_gui`
- ## Run top_tb
    `make build_top_sim` <= DEFAULT detached

    or
    
    `make build_top_sim VIVADO_SOURCES=Attached` 
- ## 
- ## 
- ## 
- ## 
- ## 
- ## 
- ## 
- ## 
## Included in this repo:
- Program Counter (PC) `/src/ip/pc`