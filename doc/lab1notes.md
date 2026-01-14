# ROS Tutorial Notes
==================

### Tutorial 2: ros commands

-   `rospack`: list ros packages

-   `roscore` must be ran

-   `roscd`: move to a subdirectory package or stackr

-   `rosls`: ls directly into a package by its name

-   ros supports tab completion

### Tutorial 3: catkin packages

-   `catkin_create_pkg packagename dependencies`

-   `catkin_make` builds the workspace

-   everythig has been sourced, but you can use `devel/setup.bash`. Don't forget to source the normal ros opt folder

### Tutorial 5&6: nodes, topics

-   `roscore`

-   `rosnode`

    -   `list`

    -   `info /rosout`

-   `rosrun <package> <exec> __param:=valueerosc`

-   `rosrun rqt_graph rqt_graph`

-   `rosrun rqt_plot rqt_plot`

-   `rostopic`

-   `rostopic echo <topic>`

-   `rostopic list -v`

-   `rostoipc type <topic>`

-   `rostopic pub [topic] [msg_type] [args]`

-   `rostopic hz`

### Tutorial 7: services

-   `rosservice` (list, call, type, find uri)

-   `rosservice type /spawn | rossrv show`

-   `rosparam` (set, get, load, dump, delete, list)

catlyn kalana aldem crystal

### Tutorial 8: rqt_console, rqt_logger_level

-   `rosrun rqt_console rqt_console`

-   `rosrun rqt_logger_level rqt_logger_level`

### Tutorial 10:

-   `roscp`

-   deatils on how to add messages

-   `rosmsg`

-   `rospack`

-   `roscd`

-   `rosls`

-   `roscp`

-   `rosmsg`

-   `rossrv`

-   `catkin_make`

### Tutorial 15:

-   `rosbag` (info play)

-   `rosbag record -O subset /turtle1/cmd_vel /turtle1/pose`

-   `rosbag play -r 2 <your bagfile>`