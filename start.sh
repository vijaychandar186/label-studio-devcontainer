#!/bin/bash
set -e

mkdir -p mydata
sudo chgrp 0 mydata
sudo chmod 775 mydata

docker run -it \
  -p 8080:8080 \
  -v "$(pwd)/mydata:/label-studio/data" \
  heartexlabs/label-studio:latest