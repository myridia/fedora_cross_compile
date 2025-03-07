FROM fedora:latest
LABEL version="0.1"
MAINTAINER veto<veto@myridia.com>


#
# Set up system
#
WORKDIR /root/
RUN dnf -y update
RUN dnf clean all
RUN dnf install -y mingw64-gtk3 \
mingw32-binutils \
mingw32-nsiswrapper \
mingw64-gcc \
mingw64-gtk4 \
mingw32-gcc \
mingw32-gtk3 \
mingw32-gtk4 \
make pkg-config \
git \
emacs-nw \
gtk4-devel \
gcc-c++ \
boost \
boost-devel \
cmake \
file \
man \
tar \
webkit2gtk* \
openssl-devel \
curl \
wget \
file \
libappindicator-gtk3-devel \
librsvg2-devel \
libsoup3* \
javascriptcoregtk* \
perl 
    


#
# Build peldd to find dlls of exes
#
RUN git clone https://github.com/gsauthof/pe-util
WORKDIR pe-util
RUN git submodule update --init
RUN mkdir build


WORKDIR build
RUN cmake .. -DCMAKE_BUILD_TYPE=Release
RUN make

RUN mv /root/pe-util/build/peldd /usr/bin/peldd
RUN chmod +x /usr/bin/peldd


#
# Add package.sh
#
ADD package.sh /usr/bin/package.sh
RUN chmod +x /usr/bin/package.sh


#
# Install Windows libraries
#
RUN dnf install -y mingw64-gcc
RUN dnf install -y mingw64-freetype
RUN dnf install -y mingw64-cairo
RUN dnf install -y mingw64-harfbuzz
RUN dnf install -y mingw64-pango
RUN dnf install -y mingw64-poppler
RUN dnf install -y mingw64-gtk3
RUN dnf install -y mingw64-winpthreads-static
RUN dnf install -y mingw64-glib2-static


#
# Install rust
#
#RUN useradd -ms /bin/bash rustacean
#USER rustacean

# Setup rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
RUN . ~/.cargo/env && \
    rustup target add aarch64-apple-darwin \
aarch64-apple-ios \
aarch64-linux-android \
aarch64-unknown-linux-gnu \
arm64ec-pc-windows-msvc \
armv7-linux-androideabi \
i586-pc-windows-msvc \
i586-unknown-linux-gnu \
i686-linux-android \
i686-pc-windows-gnu \
i686-pc-windows-gnullvm \
i686-pc-windows-msvc \
i686-unknown-freebsd \
i686-unknown-linux-gnu \
i686-unknown-linux-musl \
i686-unknown-uefi \
loongarch64-unknown-linux-gnu \
loongarch64-unknown-linux-musl \
loongarch64-unknown-none \
loongarch64-unknown-none-softfloat \
nvptx64-nvidia-cuda \
powerpc-unknown-linux-gnu \
powerpc64-unknown-linux-gnu \
powerpc64le-unknown-linux-gnu \
powerpc64le-unknown-linux-musl \
riscv32i-unknown-none-elf \
riscv32im-unknown-none-elf \
riscv32imac-unknown-none-elf \
riscv32imafc-unknown-none-elf \
riscv32imc-unknown-none-elf \
riscv64gc-unknown-linux-gnu \
riscv64gc-unknown-linux-musl \
riscv64gc-unknown-none-elf \
riscv64imac-unknown-none-elf \
s390x-unknown-linux-gnu \
sparc64-unknown-linux-gnu \
sparcv9-sun-solaris \
thumbv6m-none-eabi \
thumbv7em-none-eabi \
thumbv7em-none-eabihf \
thumbv7m-none-eabi \
thumbv7neon-linux-androideabi \
thumbv7neon-unknown-linux-gnueabihf \
thumbv8m.base-none-eabi \
thumbv8m.main-none-eabi \
thumbv8m.main-none-eabihf \
wasm32-unknown-emscripten \
wasm32-unknown-unknown \
wasm32-wasip1 \
wasm32-wasip1-threads \
wasm32-wasip2 \
wasm32v1-none \
x86_64-apple-darwin \
x86_64-apple-ios \
x86_64-apple-ios-macabi \
x86_64-fortanix-unknown-sgx \
x86_64-linux-android \
x86_64-pc-solaris \
x86_64-pc-windows-gnu  \
x86_64-pc-windows-gnullvm \
x86_64-pc-windows-msvc \
x86_64-unknown-freebsd \
x86_64-unknown-fuchsia \
x86_64-unknown-illumos \
x86_64-unknown-linux-gnu \
x86_64-unknown-linux-gnux32 \
x86_64-unknown-linux-musl \
x86_64-unknown-linux-ohos \
x86_64-unknown-netbsd \
x86_64-unknown-none \
x86_64-unknown-redox \
x86_64-unknown-uefi 

ADD cargo.config /root/.cargo/config.toml

ENV PKG_CONFIG_ALLOW_CROSS=1
ENV PKG_CONFIG_PATH=/usr/x86_64-w64-mingw32/sys-root/mingw/lib/pkgconfig/
ENV GTK_INSTALL_PATH=/usr/x86_64-w64-mingw32/sys-root/mingw/


#
# Setup the mount point
#
VOLUME /root/src
WORKDIR /root/src

#
# Build and package executable
CMD ["/bin/bash"]

#CMD ["/usr/bin/package.sh"]

