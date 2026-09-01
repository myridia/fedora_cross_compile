# AGENTS.md — fedora_cross_compile

## What this is
Docker image (Fedora-based) with toolchains for cross-compiling C and Rust applications to Windows and other targets.

## Stack
- Fedora Linux
- MinGW (mingw64/mingw32 GCC, GTK3/4)
- Rust (via rustup, many cross-compile targets)
- CMake, Boost
- peldd (PE dependency finder)

## Build
```bash
docker build -t myridia/fedora_cross_compile .
```

## Run
```bash
docker run -it --rm -v "$(pwd)":/root/src myridia/fedora_cross_compile /bin/bash
```

## Structure
- `Dockerfile` — Fedora image with full cross-compile toolchain
- `cargo.config` — Rust cargo cross-compile config
- `build.sh` — build script
- `package.sh` — packaging utility
- `clean.sh` — cleanup

## Conventions
- No comments in code unless asked.
