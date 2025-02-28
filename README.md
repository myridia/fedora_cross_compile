# Fedora Cross Compile 
* Docker Image to easy crosscompile to windows and mac


## Example Use

## Run the docker and you will be logged into bash 
```
sudo docker run --name hello_gtk  -it myridia/fedora_cross_compile /bin/bash 
```
## Inside the Docker Contianer execute 
```
cd /root/
git clone  https://github.com/veto8/hello_c_gtk.git
cd hello_c_gtk
x86_64-w64-mingw32-gcc -o hello_64 hello.c `mingw64-pkg-config --cflags gtk+-3.0 --libs gtk+-3.0` -mwindows
```


## Outside Docker Container get your compiled files
```
docker cp hello_gtk:/root/hello_c_gtk/main.exe /home/veto/Downloads/
docker cp hello_gtk://usr/x86_64-w64-mingw32/sys-root/mingw/bin  /home/veto/Downloads/
```
