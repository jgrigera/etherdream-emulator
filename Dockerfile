# pull official base image
FROM rust:1.22-stretch

# set work directory
WORKDIR /usr/src/app

ENV BUILD_VERSION 1

# Update stretch repositories
RUN sed -i -e 's/deb.debian.org/archive.debian.org/g' \
           -e 's|security.debian.org|archive.debian.org/|g' \
           -e '/stretch-updates/d' \
           -e '/stretch\/updates/d' /etc/apt/sources.list
RUN apt-get update && apt install -y xauth xterm && \
    apt-get clean && \ 
    rm -rf /var/lib/apt/lists/*

# Setup additional libraries
# copy project
COPY . .


# Build your program for release
RUN cargo build --release

ENV RUST_BACKTRACE=1

# Run the binary
CMD ["./target/release/etherdream-emulator", "--point", "10.0"]
