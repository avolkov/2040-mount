/* Top wire mount for MKS GEN 1.4 for wiring heated bed and power cables
 * Copyright 2021 Alex Volkov <alex@flamy.ca>
 * License: Attribution-ShareAlike 4.0 International (CC BY-SA)
 * https://creativecommons.org/licenses/by-sa/4.0/
 *
 * Version 1.0 2021-04-10 Initial publication
 */

include <../lib/common_wire_mount.scad>

seventeen = 17;

module top_wire_holder(out_d, in_d){
    translate([0,-2,-10]){
        difference() {
            plate_mount_top(15, 3);
            translate([20, 7, 10]){
                rotate([90, 0, 0])
                cylinder(d=20, h=8);
            }
        }
    }
    difference(){
        union(){
            
            translate([20, -55, 0])
                rotate([0, 0, 90])
                    cable_mount(60, out_d, in_d);
            rotate([0,0,270]){
                translate([50, 20, 0])
                    cable_mount(2, out_d + 3, in_d);
                translate([42, 20, 0])
                    cable_mount(2, out_d + 3, in_d);
                translate([34, 20, 0])
                    cable_mount(2, out_d + 3, in_d);
                translate([8, 20, 0])
                    cable_mount(2, out_d + 3, in_d);
            }
        }
        translate([0,-75, -20])
            cube([40, 80, 10]);
    }
}

top_wire_holder(out_d=25, in_d=17);