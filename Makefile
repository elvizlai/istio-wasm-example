all: gen build

gen:
	cargo build --target wasm32-unknown-unknown --release

build:
	wasme build precompiled ./target/wasm32-unknown-unknown/release/istio_wasm_example.wasm --tag webassemblyhub.io/sdrzlyz/istio_wasm_example:v0.1

push:
	wasme push webassemblyhub.io/sdrzlyz/istio_wasm_example:v0.1