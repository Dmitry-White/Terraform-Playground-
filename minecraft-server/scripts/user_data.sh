#!/bin/bash -e

SERVER_BUCKET=${tf_server_bucket}
SERVER_FOLDER=${tf_server_bucket_game_folder}
GAME_SERVER_RAM=${tf_server_ram}

JAVA_PACKAGE=openjdk-21-jre
GAME_ARCHIVE_NAME=minecraft
GAME_ARCHIVE_PATH=$GAME_ARCHIVE_NAME.zip

prepare() {
    echo "Preparing server..."

    apt update -y
    apt install -y \
        $JAVA_PACKAGE \
        awscli \
        zip

    echo "Preparation Successful!"
}

download() {
    echo "Downloading game files..."

    aws s3 cp s3://$SERVER_BUCKET/$SERVER_FOLDER/$GAME_ARCHIVE_PATH .

    echo "Download Successful!"
}

extract() {
    echo "Extracting game files..."

    unzip $GAME_ARCHIVE_PATH

    echo "Extraction Successful!"
}

run() {
    echo "Running game server..."

    cd $GAME_ARCHIVE_NAME/server
    java -Xms$GAME_SERVER_RAM -Xmx$GAME_SERVER_RAM -jar server.jar nogui
}

prepare
download
extract
run
