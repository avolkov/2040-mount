/* Bottom wire mount for MKS GEN 1.4 for wiring heated bed and power cables
 * Copyright 2021 Alex Volkov <alex@flamy.ca>
 * License: Attribution-ShareAlike 4.0 International (CC BY-SA)
 * https://creativecommons.org/licenses/by-sa/4.0/
 *
 * Version 1.0 2021-04-10 Initial publication
 */
 
include <../lib/common_wire_mount.scad>



module bottom_wire_holder(){
    inner_pipe_d = 12;
    outer_d = 20;
    vert_pipe_offset = 65;
    vert_pipe_len = 40;
    heated_bed_connector = 120;
    bottom_shave_offset = 2;
    difference(){
        union(){
            cable_mount(heated_bed_connector, outer_d, inner_pipe_d);
            translate([heated_bed_connector - 12, 0, 0])
                cable_mount(2, outer_d+2, inner_pipe_d);
            translate([heated_bed_connector - 2 , 0, 0])
                cable_mount(2, outer_d+2, inner_pipe_d);
            // vertical pipe #1
            translate([vert_pipe_offset, 0 , 0]){
                rotate([0,0,270]){
                    cable_mount(vert_pipe_len, outer_d , inner_pipe_d);
                    translate([28, 0, 0])
                        cable_mount(2, outer_d + 3, inner_pipe_d + 5);
                    translate([22, 0, 0])
                        cable_mount(2, outer_d + 3, inner_pipe_d + 5);
                }
            }
            // vertical pipe #2
            /*
            pipe_2 = 60;
            translate([vert_pipe_offset + 60, 0 , 0]){
                rotate([0,0,270]){
                    cable_mount(pipe_2, outer_d, inner_pipe_d);
                    translate([pipe_2, 0, 0])
                        cable_mount(2, outer_d+2, inner_pipe_d);
                    translate([pipe_2 - 10, 0, 0])
                        cable_mount(2, outer_d+2, inner_pipe_d);
                }
            }
            */
            translate([36, 7, -outer_d/2 + 2])
                plate_mount(14, 3);
        }
        // horizontal cutout
        rotate([0, 90, 0 ])
            cylinder(d=inner_pipe_d, h=heated_bed_connector);
        // vertical pipe cutout #1
        
        translate([vert_pipe_offset, 0, 0])
            rotate([90, 0, 0 ])
                cylinder(d=inner_pipe_d, h=vert_pipe_len);
        // vertical pipe cutout #2
        /*
        translate([vert_pipe_offset + 60, 20, 0])
            rotate([90, 0, 0 ])
                cylinder(d=inner_pipe_d, h=heated_bed_connector);
        */
        //shave off bottom
        
        translate([0, -70, -outer_d + bottom_shave_offset])
            cube([heated_bed_connector, 100, 10]);
        
    }
}

bottom_wire_holder();