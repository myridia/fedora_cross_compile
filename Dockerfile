FROM fedora:latest
LABEL version="0.1"
MAINTAINER veto<veto@myridia.com>


#
# Set up system
#
WORKDIR /root/
RUN dnf -y update
RUN dnf clean all
RUN dnf install -y mingw64-gtk3 mingw32-binutils mingw32-nsiswrapper mingw64-gcc mingw64-gtk4 make pkg-config git emacs-nw gtk4-devel gcc-c++ boost boost-devel cmake file man sudo tar mingw32-gcc mingw32-gtk3 mingw32-gtk4 \
    webkit2gtk* \
    openssl-devel \
    curl \
    wget \
    file \
    libappindicator-gtk3-devel \
    librsvg2-devel \
    libsoup3* \
    javascriptcoregtk*    



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
    rustup target add x86_64-pc-windows-gnu i686-pc-windows-gnu

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

