# MCTSSA CTF Generator :boom:
[![Code style: size](https://img.shields.io/github/repo-size/GarrettHaley/CTF_Generator)](https://img.shields.io/github/repo-size/deptofdefense/solo)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Code style: open issue](https://img.shields.io/github/issues-raw/GarrettHaley/CTF_Generator)](https://img.shields.io/github/issues-raw/GarrettHaley/CTF_Generator)
[![Code style: open pull request](https://img.shields.io/github/issues-pr-raw/GarrettHaley/CTF_Generator)](https://img.shields.io/github/issues-pr-raw/GarrettHaley/CTF_Generator)
##### The purpose of this project is to encourage cyber CTF challenges within the Marine Corps, and streamline the process of developing local/public CTF competitions for the Department of Defense. This project can instantiate local instances of __[CTFD](https://hub.docker.com/r/ctfd/ctfd/)__, create docker images/containers for challenges located in this repository, and optionally push those to the remote __[CTFD remote hosting service](https://ctfd.io/hosting/)__ for public competitions.

---
# Building challenges
---
##### Each challenge should exist within this repository. To clone this repository locally, issue the following commands:
    git clone https://github.com/GarrettHaley/CTF_Generator.git
    cd CTF_Generator.git
##### Once you have cloned and entered the repository, you can create a new challenge by running the following:
    mkdir challenge_x #(where x is the challenge you wish to create)
    cd challenge_x
##### (NOTE: Program requires sequential numbering per challenge starting with challenge_1)
Once inside the new challenge directory, instantiate a new Dockerfile and open it up in an editor and make sure to follow the Dockerfile rules below:

    touch Dockerfile
    vi Dockerfile
    

## Dockerfile Rules
    # Required code in Dockerfile
    ARG FLAG 
    RUN touch <path to flag placement>/flag.txt
    RUN echo $FLAG > <path to flag placement>/flag.txt
##### Make sure everything needed to create the challenge image and container is located within the same directory: challenge_x.
---

# Running the software
##### Once the challenges have been built, the following commands can be issues to build the challenge images and containers:
    chmod +x build_script.sh
    source ./build_script.sh
---
The repository can currently be run as is if you like the current challenges. Feel free to add more, or change them at your discretion.

__Contributors :)__
- __[Ong Thao](https://github.com/ongthao)__ - Developer
- __[Garrett Haley](https://github.com/GarrettHaley)__ - Developer
