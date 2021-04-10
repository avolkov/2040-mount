SOCKET_LEN=25;
difference(){
    union(){
        cylinder(d=7, h=60, $fn=6);
        cylinder(d=10, h=SOCKET_LEN, $fn=50);
    }
    cylinder(d=6.5, h=SOCKET_LEN - 1, $fn=6);
}
