include <../lib/common_fan_bracket.scad>
// MKS GEN 1.4 fan bracket

//TODO: Refactor so all the common values are coming from the same file

$fn=30;
mount_len = 125;
second_2040_mount = 126;

translate([0,35,0])
    rotate([90, 0, 0])
        top_bracket();
bottom_bracket(15, [26, 18, 0], [second_2040_mount, 19, 0]);