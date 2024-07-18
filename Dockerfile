FROM rust:latest as build

RUN rustup target add x86_64-unknown-linux-musl
RUN apt-get update && apt-get install -y musl-tools g++-aarch64-linux-gnu pkg-config fontconfig libfontconfig1-dev

COPY . /app
WORKDIR /app

RUN export CARGO_TARGET_X86_64_UNKNOWN_LINUX_GNU_LINKER=/usr/bin/x86_64-linux-gnu-gcc

# RUN find /usr/lib /usr/local/lib -name "pkgconfig"
# RUN find /usr/lib /usr/local/lib -name "libfontconfig.so*"

RUN export PKG_CONFIG_PATH=/usr/lib/pkgconfig:/usr/lib/aarch64-linux-gnu/pkgconfig:/usr/lib/aarch64-linux-gnu
# RUN export PKG_CONFIG_PATH=/usr/local/opt/fontconfig/lib/pkgconfig:$PKG_CONFIG_PATH
RUN export PKG_CONFIG_SYSROOT_DIR=

RUN cargo build --target x86_64-unknown-linux-musl
RUN cargo build --release --target x86_64-unknown-linux-musl