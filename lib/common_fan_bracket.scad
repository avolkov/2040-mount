include <hardware-recess.scad>;


fan_d=35;

module bracket_mount(bolt_l, mount_offset){
        y_offset = mount_offset + 0.3;
        translate([13, y_offset, 0])hole_w_end(bolt_l+0.5, 2, "round", M_DIM[M3][0]);
        translate([55, y_offset,0]) hole_w_end(bolt_l+0.5, 2, "round", M_DIM[M3][0]);
        translate([95, y_offset,0]) hole_w_end(bolt_l+0.5, 2, "round", M_DIM[M3][0]);
}

module bracket_fan_mount(duct_len){
    translate([8, 0, 8])
            rotate([90,0,0])
                cylinder(d=M_DIM[M3][0], h=5);
    translate([fan_d/2 + 6.5, 5 + duct_len, fan_d/2 + 4])
        rotate([90, 0, 0])
            cylinder(d=fan_d, h=20 + duct_len, $fn=50);
    translate([40, 0, 8])
            rotate([90,0,0])cylinder(d=M_DIM[M3][0], h=5);
}



module bottom_bracket(mount_offset, bolt_cutout_1, bolt_cutout_2, fan_count=3, ) {
    //fan mounts on the side of the board
    //mount_offset --  Offset between board mounting screws and board for mounting fans
    difference(){
        union(){
            cube([$mount_len, mount_offset, 5]);
            translate([0,-2, 0])
                cube([$mount_len, 2, 12]);
        }
        translate([0, M_DIM[3][0] - 1, 0])
            bracket_mount(5, mount_offset - 6 );
        for (i = [0 : fan_count - 1]){
            translate([-4 + 40.5 * i, 0, 0])
                bracket_fan_mount(mount_offset);
        };
        if (bolt_cutout_1)
            translate(bolt_cutout_1)cylinder(d=M_DIM[5][1] + 2, h=5);
        if (bolt_cutout_2)
            translate(bolt_cutout_2)cylinder(d=M_DIM[5][1] + 2, h=5);
    }
}


module top_bracket() {
    // TODO: Modify top bracket based on fan count
    bottom_offset = 5;
    difference(){
        cube([55, 2, 13]);
        translate([3, 5, -1])
            bracket_fan_mount(0);
        translate([2.5, 5, 7])
            rotate([90, 0, 0])
                cylinder(d=M_DIM[M3][0], h=5);
        translate([51.5, 5, 7])
            rotate([90, 0, 0])
                cylinder(d=M_DIM[M3][0], h=5);
    }
}

