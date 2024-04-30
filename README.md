# Nvidia Docker

This project aims to create a multi-platform docker image contains nvidia cuda, cudnn, and python pytorch.

## Build Scripts

We've provided build scripts for you.

### Local build and Test on x86-64 Platform

Run the following command

```bash
./scripts/local_build.sh -j <threads>
```

where the `threads` specifies the number of threads you want to use, just like `make -j`.

If the number of threads doesn't specify, i.e.,

```bash
./scripts/local_build.sh
```

then the default value is 4.

### Local build Multi-Platform and Push

First of all, login to your docker registry.

```bash
docker login ghcr.io/otischung
```

Then run the following command

```bash
./scripts/local_buildx_push.sh
```
