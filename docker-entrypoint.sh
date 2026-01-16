#!/bin/bash
set -e

# Source ROS Noetic
source /opt/ros/noetic/setup.bash

# Fix CMakeLists.txt symlink issue (Windows mounts break symlinks)
# Check if CMakeLists.txt exists but is not a valid symlink to toplevel.cmake
if [ -f /catkin_ws/src/CMakeLists.txt ]; then
    if [ ! -L /catkin_ws/src/CMakeLists.txt ]; then
        echo "Fixing CMakeLists.txt symlink (broken by Windows mount)..."
        rm /catkin_ws/src/CMakeLists.txt
        ln -s /opt/ros/noetic/share/catkin/cmake/toplevel.cmake /catkin_ws/src/CMakeLists.txt
    fi
elif [ ! -e /catkin_ws/src/CMakeLists.txt ]; then
    echo "Creating CMakeLists.txt symlink..."
    ln -s /opt/ros/noetic/share/catkin/cmake/toplevel.cmake /catkin_ws/src/CMakeLists.txt
fi

# Initialize catkin workspace if devel/setup.bash doesn't exist
# This handles the case where build and devel volumes are empty
if [ ! -f /catkin_ws/devel/setup.bash ]; then
    echo "Initializing catkin workspace..."
    cd /catkin_ws

    # Create the .catkin_workspace file if it doesn't exist
    if [ ! -f /catkin_ws/src/.catkin_workspace ]; then
        catkin_init_workspace /catkin_ws/src 2>/dev/null || true
    fi

    # Run catkin_make to initialize build and devel folders
    catkin_make
    echo "Catkin workspace initialized."
fi

# Source the catkin workspace
if [ -f /catkin_ws/devel/setup.bash ]; then
    source /catkin_ws/devel/setup.bash
fi

# Execute the command passed to the container
exec "$@"
