#git clone --depth=1 https://github.com/emacs-mirror/emacs.git
cd emacs/
#git pull
# sudo apt install -y autoconf make gcc texinfo libgtk-3-dev libxpm-dev \
#       libjpeg-dev libgif-dev libtiff5-dev libgnutls28-dev libncurses5-dev \
#       libjansson-dev libharfbuzz-dev libharfbuzz-bin
export CC=/usr/bin/gcc-10 CXX=/usr/bin/gcc-10
./autogen.sh
./configure --with-native-compilation --with-json --with-all CFLAGS="-O3 -mtune=native -march=native -fomit-frame-pointer"
make -j$(nproc)
sudo make install
