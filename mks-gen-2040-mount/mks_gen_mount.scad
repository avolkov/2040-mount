/* Main board mount model
 * Copyright 2021 Alex Volkov <alex@flamy.ca>
 * License: Attribution-ShareAlike 4.0 International (CC BY-SA)
 * https://creativecommons.org/licenses/by-sa/4.0/
 *
 * Version 1.1 2020-04-12 Backporting changes from skr_14_turbo, making code more generic
 * Version 1.0 2021-04-10 Initial publication
 */

include <../libs/hardware-recess.scad>;
$fn=30;

board_h = 143;
board_w = 84;

mount_h = 135.5;
mount_w = 76;

daughter_board_offset = 20;
fan_rail_offset = 17;
peg_h = 8;
cable_mgmt_offset = 8; // offset for mounting cable management accessories
plate_extra_h = 10;

module daughter_board_mount(bolt_l){
    translate([daughter_board_offset, 9.5, 0]) hole_w_end(bolt_l, m3_nut_thick, "round", m3_bolt_thick);
    translate([daughter_board_offset, 9.5 + 65, 0]) hole_w_end(bolt_l, m3_nut_thick, "round", m3_bolt_thick);
    translate([daughter_board_offset + 40.5, 9.5, 0]) hole_w_end(bolt_l, m3_nut_thick, "round", m3_bolt_thick);
    translate([daughter_board_offset + 40.5, 9.5 + 65, 0]) hole_w_end(bolt_l, m3_nut_thick, "round", m3_bolt_thick);
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
    mount_rails_d = 6.4;
    m5_head_len_offset = 5;
    m5_bolt_offset = 2;
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
                    m5_nut_thick+m5_head_len_offset+4,
                    5,
                    "round",
                    5.3,
                    flip=true);
        }

        translate([25, wall_thick + m5_head_len_offset + m5_bolt_offset + 2, 9.5]){
            rotate([90, 0, 0])
                hole_w_end(
                    wall_thick+m5_head_len_offset*2 + m5_bolt_offset,
                    m5_nut_thick+m5_head_len_offset+3,
                    "round",
                    5.3,
                    flip=true);
        }

        translate([board_h - fan_rail_offset, wall_thick + m5_bolt_offset, rail2_offset + m5_r]){
            rotate([90, 0, 0])
                hole_w_end(wall_thick+5+m5_bolt_offset, 5, "round", 5.3, flip=true);
        }
        translate([board_h - fan_rail_offset, wall_thick + m5_head_len_offset + m5_bolt_offset + 2, 9.5]){
            rotate([90, 0, 0])
                hole_w_end(
                    wall_thick+m5_head_len_offset*2+m5_bolt_offset,
                    m5_nut_thick+m5_head_len_offset+3,
                    "round",
                    5.3,
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


module mount_skr(mount_offset){
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

// TODO: mount this bit to the bottom later, I won't be able to print this properly
/*
module wiring(){
    translate([0, 100, 0])
    rotate([90,0, 0])
        cylinder(d=20, h=100);
}
*/

// Setting up skr and mount holes
difference(){
    mount_offset = 18;
    mount_skr(mount_offset);
    // mounting holes for the daughter board
    translate([5, mount_offset, 0]) daughter_board_mount(5);
    translate([65, mount_offset, 0]) daughter_board_mount(5);
    translate([8, board_w/2 + mount_offset/2, 0]) mount_holes(5);
    translate([
        board_h + plate_extra_h - 8 ,
        board_w/2 + mount_offset/2, 0]) mount_holes(5);
}
difference(){
    wall_thick = 9;
    mount_4020(wall_thick);
    translate([0, -1, 36])
        fan_mount(wall_thick, 2);
}

