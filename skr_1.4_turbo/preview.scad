
include <variables.scad>
include <fan_bracket.scad>;
use <fan_bracket.scad>;
include <skr_14_turbo.scad>;




skr_mount();
translate([0, 8, 47.5])
    rotate([270, 0, 0]) bb();





