include <../lib/common_fan_bracket.scad>

//SKS 1.4 Turbo fan bracket

$fn=30;
mount_len = 121;

translate([0,35,0])
    rotate([90, 0, 0])
        top_bracket();
bottom_bracket(15, [22, 18, 0], [102, 19, 0]);