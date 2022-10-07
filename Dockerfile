FROM rust:1.64

COPY ./wasm-tools ./wasm-tools
COPY ./cargo-component ./cargo-component
COPY ./run.sh ./run.sh

RUN cargo install wasm-tools
RUN cargo install --locked --path ./cargo-component
RUN rustup component add rustfmt

ENTRYPOINT ["./run.sh"]

EXPOSE 8080
