include <../../libs/hardware-recess.scad>;


fan_d=35;

module bracket_mount(bolt_l, mount_offset){
        y_offset = mount_offset + 0.3;
        translate([13, y_offset, 0])hole_w_end(bolt_l+0.5, m3_nut_thick, "round", m3_bolt_thick);
        //translate([13, mount_offset,0]) cylinder(d=m3_d, h=bolt_l);
        translate([55, y_offset,0]) hole_w_end(bolt_l+0.5, m3_nut_thick, "round", m3_bolt_thick);
        translate([95, y_offset,0]) hole_w_end(bolt_l+0.5, m3_nut_thick, "round", m3_bolt_thick);
}

module fan_mount(duct_len){
    translate([8, 0, 8])
            rotate([90,0,0])
                cylinder(d=m3_bolt_thick, h=5);
    translate([fan_d/2 + 6.5, 5 + duct_len, fan_d/2 + 4])
        rotate([90, 0, 0])
            cylinder(d=fan_d, h=20 + duct_len, $fn=50);
    translate([40, 0, 8])
            rotate([90,0,0])cylinder(d=m3_bolt_thick, h=5);
}



module bottom_bracket(mount_offset, bolt_cutout_1, bolt_cutout_2, fan_count=3, ) {
    //fan mounts on the side of the board 
    //mount_offset --  Offset between board mounting screws and board for mounting fans
    difference(){
        union(){
            cube([mount_len, mount_offset, 5]);
            translate([0,-2, 0])
                cube([mount_len, 2, 12]);
        }
        translate([0, m3_bolt_thick - 1, 0])
            bracket_mount(5, mount_offset - 6);
        if (fan_count > 0)
            fan_mount(mount_offset);
        if (fan_count > 1)
            translate([39, 0, 0])fan_mount(mount_offset);
        if (fan_count > 2)
            translate([79, 0, 0])fan_mount(mount_offset);
        if (bolt_cutout_1)
            translate(bolt_cutout_1)cylinder(d=m5_bolt_head_d + 2, h=5);
        if (bolt_cutout_2)
            translate(bolt_cutout_2)cylinder(d=m5_bolt_head_d + 2, h=5);
    }
}


module top_bracket() {
    // TODO: Modify top bracket based on fan count
    bottom_offset = 5;
    difference(){
        cube([55, 2, 13]);
        translate([3,5, -1])
            fan_mount(0);
        translate([4, 5, 7])
            rotate([90, 0, 0])
                cylinder(d=m3_bolt_thick, h=5);
        translate([51, 5, 7])
            rotate([90, 0, 0])
                cylinder(d=m3_bolt_thick, h=5);
    }
}

