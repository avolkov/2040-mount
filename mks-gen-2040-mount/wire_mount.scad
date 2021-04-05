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


module bottom_wire_holder(){
    inner_pipe_d = 12;
    outer_d = 20;
    vert_pipe_offset = 65;
    vert_pipe_len = 40;
    heated_bed_connector = 205;
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
            translate([36, 6, -outer_d/2 + 2])
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

module top_wire_holder(){
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
                    cable_mount(60, 25, 17);
            rotate([0,0,270]){
                translate([50, 20, 0])
                    cable_mount(2, 28, 17);
                translate([42, 20, 0])
                    cable_mount(2, 28, 17);
                translate([34, 20, 0])
                    cable_mount(2, 28, 17);
                translate([8, 20, 0])
                    cable_mount(2, 28, 17);
            }
        }
        translate([0,-75, -20])
            cube([40, 80, 10]);
    }
}

//plate_mount();
bottom_wire_holder();
//top_wire_holder();