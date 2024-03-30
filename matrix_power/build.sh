#! /usr/bin/bash

# COLORS
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

# BUILD VARIABLES
BUILD_PATH="build/"
BUILD_LOG_PATH="${BUILD_PATH}build.log"
BIN_PATH="bin/"
mkdir -p $BUILD_PATH
mkdir -p $BIN_PATH

# BEGIN BUILD SCRIPT
echo "STARTING BUILD PROCESS IN $BUILD_PATH"              > $BUILD_LOG_PATH
cmake -B $BUILD_PATH                                     >> $BUILD_LOG_PATH # creates a Makefile in build/
echo "BUILD FILES AND MAKEFILE GENERATED IN $BUILD_PATH" >> $BUILD_LOG_PATH 
echo "GENERATING EXECUTABLE IN $BIN_PATH"                >> $BUILD_LOG_PATH
make --directory $BUILD_PATH                            &>> $BUILD_LOG_PATH # creates the executable in bin/
if [ $? -eq 0 ]; then
    echo "GENERATED EXECUTABLE IN $BIN_PATH"             >> $BUILD_LOG_PATH
else
    echo -e "${RED}COMPILE ERROR; SEE ${BLUE}$BUILD_LOG_PATH${NC}"
fi
# END BUILD SCRIPT
