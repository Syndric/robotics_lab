# ROS Noetic Development Environment
# Based on Ubuntu 20.04 (Focal)
FROM ros:noetic-ros-base-focal

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install essential packages and tools mentioned in lab instructions
RUN apt-get update && apt-get install -y \
    terminator \
    python3-pip \
    python3-rosdep \
    python3-rosinstall \
    python3-rosinstall-generator \
    python3-wstool \
    build-essential \
    ros-noetic-rospy-tutorials \
    ros-noetic-turtlesim \
    ros-noetic-rqt \
    ros-noetic-rqt-common-plugins \
    vim \
    nano \
    git \
    && rm -rf /var/lib/apt/lists/*

# Initialize rosdep (if not already done)
RUN rosdep update || true

# Create catkin workspace structure
RUN mkdir -p /catkin_ws/src /catkin_ws/build /catkin_ws/devel

WORKDIR /catkin_ws

# Set up ROS environment in bashrc
RUN echo "source /opt/ros/noetic/setup.bash" >> /root/.bashrc && \
    echo "source /catkin_ws/devel/setup.bash 2>/dev/null || true" >> /root/.bashrc

# Set environment variables for ROS
ENV ROS_PACKAGE_PATH=/catkin_ws/src:/opt/ros/noetic/share
ENV ROS_MASTER_URI=http://localhost:11311
ENV PYTHONDONTWRITEBYTECODE=1
ENV TURTLEBOT3_MODEL=waffle

# Copy entrypoint script
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["bash"]
