
include <variables.scad>
include <fan_bracket.scad>;
use <fan_bracket.scad>;
include <skr_14_turbo.scad>;


include <NopSCADlib/core.scad>
include <NopSCADlib/vitamins/fans.scad>


skr_mount();
translate([0, 8, 47.5]){
    rotate([270, 0, 0]) bb();
    translate([33.5, 12, 13])tb();
    
}
translate([20, 32, 55]){
    for (i = [0: 40.5 : 81])
    translate([i, 0, 0]) fan(fan40x11);
}



