sudo apt-get clean
sudo rm -rf /var/lib/apt/lists/*
sudo apt-get clean
sudo apt-get update && sudo apt-get upgrade
sudo apt-get install build-essential 
sudo apt-get install nasm
sudo apt-get install gdb git


# Libemu
sudo apt-get install autoconf
sudo apt-get install libtool
git clone https://github.com/buffer/libemu
cd libemu && autoreconf -v -i && ./configure --prefix=/opt/libemu && autoreconf -v -i && sudo make install