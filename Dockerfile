FROM fedora:latest
LABEL version="0.1"
MAINTAINER veto<veto@myridia.com>
RUN dnf install -y mingw64-gtk3 mingw32-binutils mingw32-nsiswrapper mingw64-gcc mingw64-gtk4 make pkg-config git emacs-nw 

CMD ["/bin/bash"]


