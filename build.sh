sudo apt-get install -y pkg-config && 
sudo apt-get install zlib1g-dev && 
sudo apt-get install libpng-dev && 
sudo apt-get install libsdl2-dev && 
sudo apt-get install libfreetype6-dev && 
sudo apt-get install nasm && 
sudo apt-get install libboost-all-dev && 
sudo ./scripts/pune_build.sh && 
sudo ./test.sh &&
sudo rm -rf ./bin && 
cp -R ./test ./bin
