#! /usr/bin/bash

# COLORS
RED='\033[0;31m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'
NC='\033[0m'

# BUILD VARIABLES
BUILD_PATH="build/"
BUILD_LOG_PATH="${BUILD_PATH}build.log"
BIN_PATH="bin/"
DOCS_PATH="docs/"
mkdir -p $BUILD_PATH
mkdir -p $BIN_PATH
mkdir -p $DOCS_PATH

# BEGIN BUILD SCRIPT
echo "BUILDING IN $BUILD_PATH"                                                > $BUILD_LOG_PATH
cmake -B $BUILD_PATH                                                         >> $BUILD_LOG_PATH # creates a Makefile in build/
echo "${GREEN}BUILD FILES AND MAKEFILE GENERATED IN ${BLUE}$BUILD_PATH${NC}" >> $BUILD_LOG_PATH 

echo ""                                                                      >> $BUILD_LOG_PATH

echo "GENERATING EXECUTABLE IN $BIN_PATH"                                    >> $BUILD_LOG_PATH
make --directory $BUILD_PATH                                                &>> $BUILD_LOG_PATH # creates the executable in bin/
if [ $? -eq 0 ]; then
    echo "${GREEN}GENERATED EXECUTABLE IN ${BLUE}$BIN_PATH${NC}"             >> $BUILD_LOG_PATH
else
    echo -e "${RED}COMPILE ERROR; SEE ${BLUE}$BUILD_LOG_PATH${NC}"           >> $BUILD_LOG_PATH
fi

echo ""                                                                      >> $BUILD_LOG_PATH

echo "GENERATING DOCUMENTATION IN $DOCS_PATH"                                >> $BUILD_LOG_PATH
doxygen                                                                      >> $BUILD_LOG_PATH
echo "${GREEN}DOCUMENTATION GENERATED IN ${BLUE}$DOCS_PATH${NC}"             >> $BUILD_LOG_PATH
# END BUILD SCRIPT
