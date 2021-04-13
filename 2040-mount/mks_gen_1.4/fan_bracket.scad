include <../lib/common_fan_bracket.scad>

$fn=30;
mount_len = 125;

translate([0,35,0])
    rotate([90, 0, 0])
        top_bracket();
bottom_bracket(15, fan_count=3);