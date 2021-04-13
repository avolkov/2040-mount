/* Common mount functions to be used by specific mainboards
 *
 * Copyright 2021 Alex Volkov <alex@flamy.ca>
 * License: Attribution-ShareAlike 4.0 International (CC BY-SA)
 * https://creativecommons.org/licenses/by-sa/4.0/
 *
 */

 // TODO: rename daughter board mount to 5x7 board mount
 include <../../libs/hardware-recess.scad>;


 module board_5x7_mount(bolt_l){
    x_dim = 40.5;
    y_dim = 65;
    const_offset = 9.5;
    translate([daughter_board_offset, const_offset, 0])
        hole_w_end(bolt_l, m3_nut_thick, "round", m3_bolt_thick);
    translate([daughter_board_offset, const_offset + y_dim, 0])
        hole_w_end(bolt_l, m3_nut_thick, "round", m3_bolt_thick);
    translate([daughter_board_offset + x_dim, const_offset, 0])
        hole_w_end(bolt_l, m3_nut_thick, "round", m3_bolt_thick);
    translate([daughter_board_offset + x_dim, const_offset + y_dim, 0])
        hole_w_end(bolt_l, m3_nut_thick, "round", m3_bolt_thick);
}


module mount_holes(bolt_l){
    hole_w_end(bolt_l, m3_nut_thick, "round", m3_bolt_thick);
    translate([0, 20, 0]) hole_w_end(bolt_l, m3_nut_thick, "round", m3_bolt_thick);
}

module fan_mount(bolt_l, extra_nut_len=0){
    rotate([270, 0, 0]){
        translate([13, 0,1])
            hole_w_end(bolt_l, m3_nut_thick+extra_nut_len, "hex", m3_bolt_thick, flip=true);
        translate([55, 0,1])
            hole_w_end(bolt_l, m3_nut_thick+extra_nut_len, "hex", m3_bolt_thick, flip=true);
        translate([95, 0,1])
            hole_w_end(bolt_l, m3_nut_thick+extra_nut_len, "hex", m3_bolt_thick, flip=true);
    }
}

module mount_4020(wall_thick){
    rail1_offset = 7;
    rail2_offset = 27;
    m5_r = 2.5;
    m5_d = m5_r * 2 + 0.3;
    mount_rails_d = 6.4;
    m5_head_len_offset = 5;
    m5_bolt_offset = 2;

    z_offset = 9.5; //???
    difference(){
        // mount plate
        union() {
            // mount ridge
            cube([board_h + plate_extra_h, wall_thick, 40]);
            translate([0, 2.7, rail1_offset + m5_r])
                rotate([0, 90, 0]){
                    translate([-3.3,-3,0])
                    cube([mount_rails_d, 5, board_h + plate_extra_h]);
                }
                    //cylinder(d=mount_rails_d, h=plate_extra_h + 10, $fn=6);
            // mount ridge
            translate([0, 2.7, rail2_offset + m5_r])
                rotate([0, 90, 0])
                    translate([-3.3,-3,0])
                        cube([mount_rails_d, 5, board_h + 10]);
                    //cylinder(d=mount_rails_d, h=board_h + 10, $fn=6);
            // Connector to the rest of the board
            translate([0,5,5])
                rotate([-45, 0, 0])cube([board_h + plate_extra_h, 7, 5]);
        }
        // mounting holes to 2040 rail
        translate([25, wall_thick + m5_bolt_offset, rail2_offset + m5_r] ){
            rotate([90, 0, 0])
                hole_w_end(
                    m5_nut_thick + m5_head_len_offset + 4,
                    5,
                    "round",
                    m5_d,
                    flip=true);
        }

        translate([25, wall_thick + m5_head_len_offset + m5_bolt_offset + 2, z_offset]){
            rotate([90, 0, 0])
                hole_w_end(
                    wall_thick + m5_head_len_offset * 2 + m5_bolt_offset,
                    m5_nut_thick + m5_head_len_offset + 3,
                    "round",
                    m5_d,
                    flip=true);
        }

        translate([board_h - fan_rail_offset, wall_thick + m5_bolt_offset, rail2_offset + m5_r]){
            rotate([90, 0, 0])
                hole_w_end(wall_thick+5+m5_bolt_offset, 5, "round", m5_d, flip=true);
        }
        translate([
            board_h - fan_rail_offset,
            wall_thick + m5_head_len_offset + m5_bolt_offset + 2,
            z_offset]){
                rotate([90, 0, 0])
                    hole_w_end(
                        wall_thick + m5_head_len_offset * 2 + m5_bolt_offset,
                        m5_nut_thick + m5_head_len_offset + 3,
                        "round",
                        m5_d,
                        flip=true);
        }
    }
}

module board_plate(mount_offset) {
    plate_thick = 4;
    cube([board_h + 10, board_w + mount_offset + 2, plate_thick]);
    translate([0, 2, 0]){
        translate([8, mount_offset, 0]) cylinder(d=8, h=peg_h);
        translate([8, mount_offset, 0]) cylinder(d=8, h=peg_h);
        translate([mount_h + 8, mount_offset, 0]) cylinder(d=8, h=peg_h);
        translate([8, mount_offset + mount_w, 0]) cylinder(d=8, h=peg_h);
        translate([mount_h + 8, mount_offset + mount_w, 0]) cylinder(d=8, h=peg_h);
    }
}


module mount_board(mount_offset){
    difference(){
        board_plate(mount_offset);
        // offset mounting holes by 2mm to let the board fit

        translate([0, 2, 0]){
            // mounting holes for the board
            translate([8, mount_offset, 0])
                hole_w_end(peg_h, m3_nut_thick, "hex", m3_bolt_thick, flip=true);
            translate([mount_h + 8, mount_offset, 0])
                hole_w_end(peg_h, m3_nut_thick, "hex", m3_bolt_thick, flip=true);
            translate([8, mount_offset + mount_w, 0])
                hole_w_end(peg_h, m3_nut_thick, "hex", m3_bolt_thick, flip=true);
            translate([mount_h + 8, mount_offset + mount_w, 0])
                hole_w_end(peg_h, m3_nut_thick, "hex", m3_bolt_thick, flip=true);

        }
    }
}