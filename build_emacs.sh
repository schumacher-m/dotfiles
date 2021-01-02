sudo apt install -y autoconf automake g++-10 gcc gcc-10 libgccjit-10-dev libgccjit0 libgif-dev \
    libgnutls28-dev libgtk-3-dev libgtk2.0-dev libharfbuzz-bin libharfbuzz-dev libjansson-dev \
    libjansson4 libjpeg-dev libncurses5-dev libpng-dev libtiff-dev libtiff5-dev libx11-dev \
    libxpm-dev make texinfo

git clone https://github.com/emacs-mirror/emacs.git
cd emacs/
git checkout feature/native-comp

export CC=/usr/bin/gcc-10 CXX=/usr/bin/gcc-10
./autogen.sh
./configure --with-nativecomp --with-json CFLAGS="-O3 -mtune=native -march=native -fomit-frame-pointer"
make -j$(nproc)
sudo make install
