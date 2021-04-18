/* Common code for wiring mounts. See top_wire_mount.scad and 
 * bottom_wire_mount.scad for the model.
 * Copyright 2021 Alex Volkov <alex@flamy.ca>
 * License: Attribution-ShareAlike 4.0 International (CC BY-SA)
 * https://creativecommons.org/licenses/by-sa/4.0/
 *
 * Version 1.0 2021-04-10 Initial publication
 */


m3_bolt_d = 3.3;

module cable_mount(cable_len, out_d, in_d){
    rotate([0, 90, 0 ]){
    difference(){
        cylinder(d=out_d, h=cable_len);
        cylinder(d=in_d, h=cable_len);
        translate([-out_d/2, 0, cable_len/2])
            cube([out_d, out_d, cable_len], center=true);
        }
    }
}


module plate_mount_top(y_offset, thickness=2){
    difference(){
        translate([-5, 0, 0]){
            cube([50, 25, thickness]);
            cube([15, 7, thickness*2]);
            translate([35, 0, 0, ])
                cube([15, 7, thickness*2]);
        }
        translate([10, y_offset, 0])
            cylinder(d=m3_bolt_d, h=10, $fn=15);
        translate([30, y_offset, 0])
            cylinder(d=m3_bolt_d, h=10, $fn=15);
    }
    
}

module plate_mount(y_offset, thickness=2){
    difference(){
        translate([-5, 0, 0]) cube([50, 24, thickness]);
        translate([10, y_offset, 0])
            cylinder(d=m3_bolt_d, h=10, $fn=15);
        translate([30, y_offset, 0])
            cylinder(d=m3_bolt_d, h=10, $fn=15);
    }
    
}
