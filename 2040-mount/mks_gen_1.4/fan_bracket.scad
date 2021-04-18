
// MKS GEN 1.4 fan bracket
include <../lib/common_fan_bracket.scad>
include <variables.scad>;

$fn=30;

second_2040_mount = 126;
translate([0,35,0])
    rotate([90, 0, 0])
        top_bracket();
bottom_bracket(15, [26, 18, 0], [second_2040_mount, 19, 0]);