#!/bin/sh
set -e

docker run --rm -v poro-client-build-output:/app/out poro-client-builder