# RUN.md — stage <N>

## Build
```sh
docker build -t stage-<N> .
```

## Run
```sh
docker run --rm -p <port>:<port> stage-<N>
```
Listens on: <port>. Needs no outbound network at runtime. Fits in 2 vCPU / 2 GiB.

## Check
Health: `curl localhost:<port>/<health path from spec>`
