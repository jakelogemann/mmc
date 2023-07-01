#!/usr/bin/env -S just --justfile
# ^ A shebang isn't required, but allows a justfile to be executed
#   like a script, with `./justfile help`, for example.

# ignore-comments allows comments to be placed after commands.
set ignore-comments := true

# dotenv-load allows automatic use of .env files.
set dotenv-load := true

# output help text.
@help:
    {{ just_executable() }} --list

# install is build+run.
@start:
    just build && just run

# build the docker image.
@build:
  docker build \
    --iidfile image-id \
    .

# run the minecraft server.
@run:
  docker run --rm -it --name=mmc \
    -p 25565:25565 \
    $(cat image-id)

# run the minecraft server.
@run-persist:
  docker run --rm -it --name=mmc \
    --env-file=env \
    -v mmc_data:/data \
    -p 25565:25565 \
    $(cat image-id)
