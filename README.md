# Ubuntu-GPU-Mining

## Hardware

| Component     | Model     |
|:--------------|:----------|
| Motherboard | Gigabyte B450M DS3H |
| RAM | Corsair Vengeance LPX 16GB |
| CPU | AMD Ryzen 3 1200 |
| CPU Cooler | *Fan came with CPU |
| Power Supply | ARESGAME 500W Power Supply |
| GPU | AMD Radeon 6600 XT |
| Storage | WD Black Series 500 GB HDD |

I purchased these components on Amazon or BestBuy & used the following site to help pick each of them out!
https://pcpartpicker.com/


## OS

Ubuntu 20.04

### To install Ubuntu on a bare metal PC:
1. Download Ubuntu https://ubuntu.com/download/desktop
2. Download Rufus https://rufus.ie/en/
3. Insert a USB storage device and use Rufus to turn it into an Ubuntu bootable
4. Plug the USB into your new PC and turn it on
5. Select Ubuntu
6. You can choose to try it first or install it - eventually you want to install it
7. When you install Ubuntu, you’ll want to select Minimal Installation and uncheck the boxes for updates & third-party software

## GPU Driver Configuration

If you happen to have the exact same model GPU as I do (AMD Radeon 6600 XT), the bash script in this repository will install the 
necessary AMD GPU driver software for your PC.

If you have a different GPU model - whether it be NVIDIA or AMD - your steps will change a bit. Here's a breakdown:

#### 1. Update repositories and install `wget`.
```shell
sudo apt update
sudo apt dist-upgrade
sudo apt install -y wget
```
#### 2. Download the proper GPU driver software.

If you are using any AMD GPU, you can find information about which software packages to download here: <link>

The link in the code below is the specific AMD GPU Pro driver package compatible with my GPU model.
```shell
wget --referer https://www.amd.com/en/support/kb/release-notes/rn-amdgpu-unified-linux-21-30 https://drivers.amd.com/drivers/linux/amdgpu-pro-21.30-1290604-ubuntu-20.04.tar.xz
tar xJf amdgpu-pro-21.30-1290604-ubuntu-20.04.tar.xz
```

#### 3. Now you need to unpack & install the driver software. Again, the name of my `tar.gz` file is specific to the driver I downloaded.
```shell
cd amdgpu-pro-21.30-1290604-ubuntu-20.04/
chmod +x amdgpu-install
./amdgpu-install -y --opencl=rocr,legacy
```
Two major keys here: 
- You must run `./amdgpu-install` or `./amdgpu-pro-install` based on which driver is compatible with your GPU model.
- Make sure you add the `--opencl=rocr,legacy` option so that your software will support OpenCL.

#### 4. Configure the driver software.
```shell
sudo usermod -a -G render $LOGNAME
sudo usermod -a -G video $LOGNAME
```

#### 5. Download OpenCL and upgrade the driver libraries.
```shell
sudo apt-get install -y clinfo
sudo apt upgrade amdgpu
```

#### 6. Download a mining software of your choice. I chose LolMiner.
```shell
wget https://github.com/Lolliedieb/lolMiner-releases/releases/download/1.42/lolMiner_v1.42_Lin64.tar.gz
tar -xf lolMiner_v1.42_Lin64.tar.gz
```

#### 7. Restart your PC.
```shell
sudo reboot
```

#### You're good to go! Open LolMiner and choose which hashing algorithm you want to mine!
