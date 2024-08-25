#!/bin/bash -e

echo "Preparing server..."
apt update -y
apt install -y \
    openjdk-21-jre \
    awscli \
    zip
echo "User: $tf_node_user."
echo "Home: $tf_home_path."
echo "Preparation Successful!"
