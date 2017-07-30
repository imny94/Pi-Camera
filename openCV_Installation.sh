#!/usr/bin/env bash

# sudo apt-get update
# sudo apt-get upgrade
# sudo rpi-update

# sudo reboot

# sudo apt-get install build-essential git cmake pkg-config

# sudo apt-get install libjpeg-dev libtiff5-dev libjasper-dev libpng12-dev

# sudo apt-get install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
# sudo apt-get install libxvidcore-dev libx264-dev

# sudo apt-get install libgtk2.0-dev

# sudo apt-get install libatlas-base-dev gfortran

# sudo apt-get install python2.7-dev python3-dev

# cd ~
# wget -O opencv.zip https://github.com/Itseez/opencv/archive/3.2.0.zip
# unzip opencv.zip

# wget -O opencv_contrib.zip https://github.com/Itseez/opencv_contrib/archive/3.2.0.zip
# unzip opencv_contrib.zip

# wget https://bootstrap.pypa.io/get-pip.py
# sudo python get-pip.py

# sudo pip install virtualenv virtualenvwrapper
# sudo rm -rf ~/.cache/pip

echo "Update ~/.profile file and insert the following lines at the bottom of the file:"
echo "
# virtualenv and virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh
"

echo "***********************************"
echo "Press 'y' when complete!\n"

waitForUserInput(){
	echo "Not proceeding, continuing to wait, enter 'y' when ready! \n"
	read -n 1 -p "Ready? " completedInput
	if[$completedInput != "y"] 
	then 
		waitForUserInput
	else
		echo "Continuing execution ..."
	fi
}

getConfirmation(){
	read -n 1 -p "Complete :" completedInput
	if["$completedInput" != "y"] 
	then
		waitForUserInput
	else
		echo "Continuing execution ..."
	fi
}

getConfirmation

source ~/.profile

mkvirtualenv cv -p python3

source ~/.profile
workon cv

pip install numpy

workon cv

cd ~/opencv-3.2.0/
mkdir build
cd build
cmake -D CMAKE_BUILD_TYPE=RELEASE \
	-D CMAKE_INSTALL_PREFIX=/usr/local \
	-D INSTALL_C_EXAMPLES=ON \
	-D INSTALL_PYTHON_EXAMPLES=ON \
	-D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib-3.2.0/modules \
	-D BUILD_EXAMPLES=ON ..

echo "Check that installation has no issues !"
getConfirmation

make -j4

getConfirmation

sudo make install
sudo ldconfig

echo "You're done! Assuming there were no errors! Last step is to verify installation!"
