#!/usr/bin/env python3
import rospy
import math
from sensor_msgs.msg import LaserScan
import numpy as np
from geometry_msgs.msg import Twist  # Message type for controlling robot motion

def move_turtle_vel(pub, linear_speed, angular):
    # Create a Twist message object to hold velocity commands
    move_cmd = Twist()

    # Set the linear velocity for forward movement
    move_cmd.linear.x = linear_speed  
    move_cmd.angular.z = angular

    # Inform the user that the node has started
    rospy.loginfo(f"Moving the turtle at {linear_speed} m/s...")
        
    # Publish the Twist message
    pub.publish(move_cmd)

    rospy.loginfo("Turtle has stopped moving.")

def scan_callback(msg):
    # Print the total number of scan elements (360 for a full 360-degree LIDAR scan)
    num_elements = len(msg.ranges)
    print(f"Total scan elements: {num_elements}")

    # Print the range directly ahead of the robot
    range_ahead = msg.ranges[0]
    print(f"Range ahead (laser 0): {range_ahead:.2f} meters")

    # TODO: Uncomment and complete the code to divide the scan data into front, left, and right sections
    # Hint: can use list comprehensions
    front = msg.ranges[300:359] + msg.ranges[0:59]
    left = msg.ranges[60:179] 
    right = msg.ranges[180:299] 

    # TODO: Uncomment and complete the code to find the minimum distance in each section
    min_front = min(front)
    min_left = min(left)
    min_right = min(right)

    # TODO: Print the min distance from the front, left, and right sections
    print(f"Min distance ahead: {min_front:.2f} meters")
    print(f"Min distance to the left: {min_left:.2f} meters")
    print(f"Min distance to the right: {min_right:.2f} meters")

    if min_front < 2.0:
        move_turtle_vel(pub, -1, 0)
    else:
        move_turtle_vel(pub, 0, 0)

# Initialize the node
rospy.init_node('lidar_scan')

pub = rospy.Publisher('/cmd_vel', Twist, queue_size=10)

# Subscribe to the scan topic
scan_sub = rospy.Subscriber('scan', LaserScan, scan_callback)

# Keep the program running
rospy.spin()
