include <../lib/common_fan_bracket.scad>
// MKS GEN 1.4 fan bracket


$fn=30;
mount_len = 125;

translate([0,35,0])
    rotate([90, 0, 0])
        top_bracket();
bottom_bracket(15, [26, 18, 0], [126, 19, 0]);