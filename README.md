# How to write a simple wasm-filter for istio 1.5.x

## Development

### wasm32
```
rustup update
rustup target add wasm32-unknown-unknown
```

### wasme install
* https://docs.solo.io/web-assembly-hub/latest/installation/

```
# GFW blocked
curl -sL https://run.solo.io/wasme/install | sh
export PATH=$HOME/.wasme/bin:$PATH

# confirm install
wasme --version
```

### Example

create lib project with cargo
```
cargo new --lib istio-wasm-example

# business logical in src/lib.rs

make gen

make build

wasme list

# local test, visit http://localhost:8080/hello
wasme deploy envoy webassemblyhub.io/sdrzlyz/istio_wasm_example:v0.1 --envoy-image=istio/proxyv2:1.5.4
```

## Deploy to istio

### Before start up, you need install wasme operator for k8s

* https://docs.solo.io/web-assembly-hub/latest/tutorial_code/wasme_operator/

```
kubectl apply -f https://github.com/solo-io/wasme/releases/latest/download/wasme.io_v1_crds.yaml
kubectl apply -f https://github.com/solo-io/wasme/releases/latest/download/wasme-default.yaml

# confirm install
kubectl get pod -n wasme
```

### Deploy to you k8s(need istio installed)
```
cat <<EOF | kubectl apply -f -
apiVersion: wasme.io/v1
kind: FilterDeployment
metadata:
  name: istio-wasm-example-filter
  namespace: xxx
spec:
  deployment:
    istio:
      kind: Deployment
  filter:
    image: webassemblyhub.io/sdrzlyz/istio_wasm_example:v0.1
EOF
```

#### Ref:
> https://github.com/solo-io/wasm-image-spec  
> https://docs.solo.io/web-assembly-hub/latest/tutorial_code/wasme_operator/  
> https://blog.red-badger.com/extending-istio-with-rust-and-webassembly  