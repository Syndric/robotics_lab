#!/usr/bin/env python3
import rospy
from geometry_msgs.msg import PoseStamped

# Step 1: Initialize a node
rospy.init_node('go_to_goal')


# Step 2: Create a publisher that publishes PoseStamped messages to /move_base_simple/goal topic
pub = rospy.Publisher('/move_base_simple/goal', PoseStamped, queue_size=10)


rospy.sleep(3)
goal = PoseStamped()
goal.header.frame_id = "map"
goal.header.stamp = rospy.Time.now()
goal.pose.position.z = 0

try:
    while not rospy.is_shutdown(): # Safer than "while True" in ROS

        # Step 3: Take the destination coordinates
        # (Indentation here is now strictly spaces)
        user_x = float(input("Enter a input x: "))
        user_y = float(input("Enter a input y: "))

        # CRITICAL FIX: Update timestamp or the robot will ignore the goal
        goal.header.stamp = rospy.Time.now()

        # Step 4: Set goal position
        goal.pose.position.x = user_x
        goal.pose.position.y = user_y
        goal.pose.orientation.w = 1.0

        # Step 5: Publish
        pub.publish(goal)

        rospy.sleep(1)
        
except KeyboardInterrupt:
    pass