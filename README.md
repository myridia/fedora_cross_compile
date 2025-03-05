# Fedora Cross Compile 
Docker what includes many programs and libs to cross compile C and Rust application

## Example Usage

Move to your project and run the below docker command.

It will mount your location into the docker fedora container and you can run compiler tasks

```
docker run --name hello_gtk  -it --rm  -v "$(pwd)":"/root/src"   myridia/fedora_cross_compile /bin/bash
```


## Example with rust and gtk4
```
https://github.com/veto8/hello_rust_gtk4.git
cd hello_rust_gtk4
docker run --name hello_gtk  -it --rm  -v "$(pwd)":"/root/src"   myridia/fedora_cross_compile /bin/bash 
./win64.sh
```



