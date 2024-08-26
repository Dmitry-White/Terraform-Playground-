#!/bin/bash -e

SERVER_BUCKET=$1
SERVER_FOLDER=$2

GAME_ARCHIVE_NAME=minecraft
GAME_ARCHIVE_PATH=$GAME_ARCHIVE_NAME.zip

GAME_PROCESS=""
GAME_PROCESS_JAVA_FILTER=java
GAME_PROCESS_USER_FILTER=^root

find_process() {
    echo "Seaching for game process..."

    GAME_PROCESS=$(ps aux | grep "$GAME_PROCESS_JAVA_FILTER" | grep "$GAME_PROCESS_USER_FILTER" | awk '{print $2}')

    if [ -n "$GAME_PROCESS" ]; then
        echo "Search Successful!"
    else
        echo "Game process not found!"
        exit 1
    fi
}

terminate_process() {
    echo "Terminating game process..."

    sudo kill -9 $GAME_PROCESS

    echo "Termination Successful!"
}

archive() {
    echo "Archiving game files..."


    echo "---- Before ----"
    ls -al .
    echo "---- During ----"

    zip -r ./$GAME_ARCHIVE_PATH /$GAME_ARCHIVE_NAME

    echo "---- After ----"
    ls -al .
    echo "---- After ----"

    echo "Archival Successful!"
}

upload() {
    echo "Uploading game archive..."

    aws s3 cp ./$GAME_ARCHIVE_PATH s3://$SERVER_BUCKET/$SERVER_FOLDER/

    echo "Upload Successful!"
}

find_process
terminate_process
archive
upload
