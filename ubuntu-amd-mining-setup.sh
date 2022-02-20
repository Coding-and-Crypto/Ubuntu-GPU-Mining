#!/bin/bash

# AMD GPU setup script for Ubuntu machines.
# This particular script is for GPU model:
#     AMD Radeon 6600 XT
#

# To run this script, run it with sudo bash from the home directory ~

# Update Ubuntu
sudo apt update
sudo apt dist-upgrade
sudo apt install -y wget

# Download AMD GPU Driver
wget --referer https://www.amd.com/en/support/kb/release-notes/rn-amdgpu-unified-linux-21-30 https://drivers.amd.com/drivers/linux/amdgpu-pro-21.30-1290604-ubuntu-20.04.tar.xz
tar xJf amdgpu-pro-21.30-1290604-ubuntu-20.04.tar.xz

# Install Driver Software
cd amdgpu-pro-21.30-1290604-ubuntu-20.04/
chmod +x amdgpu-install
./amdgpu-install -y --opencl=rocr,legacy

# Configure Driver Software
sudo usermod -a -G render $LOGNAME
sudo usermod -a -G video $LOGNAME

# Configure OpenCL
sudo apt-get install -y clinfo
sudo apt upgrade amdgpu

# Download Mining Software: LOL Miner
wget https://github.com/Lolliedieb/lolMiner-releases/releases/download/1.42/lolMiner_v1.42_Lin64.tar.gz
tar -xf lolMiner_v1.42_Lin64.tar.gz

echo -e "\n\nInstall successful. You are ready to mine.\n\n"
echo "To start mining, open one of the shell scripts in the LOLMiner folder, such as mine_eth.sh"
echo -e "\n\nYou''ll need to paste in your wallet address and run the script with sudo\n\n"

echo -e "\n\nYour machine will now restart\n\n"
sleep 10
sudo reboot
