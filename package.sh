#!/bin/bash

/home/rustacean/.cargo/bin/cargo build --target=x86_64-pc-windows-gnu --release

mkdir -p package
cp target/x86_64-pc-windows-gnu/release/*.exe package

export DLLS="peldd package/*.exe -t --ignore-errors"
for DLL in $DLLS
    do cp "$DLL" package
done

mkdir -p package/share/{themes,gtk-3.0}
cp -r $GTK_INSTALL_PATH/share/glib-2.0/schemas package/share/glib-2.0
cp -r $GTK_INSTALL_PATH/share/icons package/share/icons

cat << EOF > package/share/gtk-3.0/settings.ini
[Settings]
gtk-theme-name = Windows10
gtk-font-name = Segoe UI 10
gtk-xft-rgba = rgb
gtk-xft-antialias = 1
EOF

mingw-strip package/*.dll
mingw-strip package/*.exe
