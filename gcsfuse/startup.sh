#!/bin/bash
set -euo pipefail

# Create mount directory for FUSE
mkdir -p /mnt/gcs

# While using FUSE to mount the GCS bucket as a network file system we gotta use
# multi-processes containers to run both the the file system mount process and application
# https://docs.docker.com/config/containers/multi-service_container/

# GCS FUSE debugging options: https://cloud.google.com/run/docs/tutorials/network-filesystems-fuse#debugging
gcsfuse --implicit-dirs --debug_gcs --debug_fuse $STORAGE_BASE_LOCATION $CLOUD_STORAGE_MNT_DIR
# uvicorn src.main:app --reload --host 0.0.0.0 --port $PORT &

# Wait for any process to exit
wait -n
