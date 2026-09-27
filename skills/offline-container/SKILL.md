---
name: offline-container
description: Produce a Dockerfile and run instructions for a service that builds reproducibly, starts fast, runs with no outbound network, fits tight CPU and memory limits, and reads its port from the environment. Use whenever you create or change how a service is built or started.
---

# Offline container

The service is judged by building its folder's Dockerfile and talking to the container over HTTP
on an isolated network. Anything that needs the internet at run time fails.

## Dockerfile rules

- Pin the base image to a specific version tag. Prefer small official images.
- Install every dependency **at build time**, pinned to exact versions (lock file or pinned list).
- Copy all runtime assets into the image: static files, fonts, scripts, stylesheets, time zone
  data, seed data. No CDN links, no remote fonts, no runtime downloads.
- Read the listening port from the `PORT` environment variable with the default the spec names;
  bind all interfaces.
- One process serving HTTP, started with `CMD` in exec form so signals work.
- The folder is self-contained: no symlinks outside it, no git submodules, no nested `.git`.
- Keep the build context small with a `.dockerignore` (caches, virtual environments, test output).

## Startup and limits

- Become healthy well inside the startup limit: initialise storage at start, no heavy work on boot.
- Stay within the memory and CPU limits: bounded worker counts, no unbounded caches.
- Health endpoint answers only when the store is actually usable.

## Run instructions file

Write the exact commands to build and start the image, the port it listens on, and how to confirm
it is healthy. A stranger must succeed by copy and paste with no other steps.

## Self-check before handoff

1. Build from a clean state with no cache.
2. Start the container with networking disabled (`--network none`) or on an internal network, and
   confirm the service starts and serves its main page and health check.
3. Start it with a non-default port through the environment variable and confirm it listens there.
4. Start it with the stated CPU and memory limits and run the tests against it.
