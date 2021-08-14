/* Common mount functions to be used by specific mainboards
 *
 * Copyright 2021 Alex Volkov <alex@flamy.ca>
 * License: Attribution-ShareAlike 4.0 International (CC BY-SA)
 * https://creativecommons.org/licenses/by-sa/4.0/
 *
 */

include <hardware-recess.scad>;

module board_5x7_mount(bolt_l){
    x_dim = 40.5;
    y_dim = 65;
    const_offset = 9.5;
    translate([daughter_board_offset, const_offset, 0])
        hole_w_end(bolt_l, M_DIM[3][4], "round", M_DIM[3][1]);
    translate([daughter_board_offset, const_offset + y_dim, 0])
        hole_w_end(bolt_l, M_DIM[3][4], "round", M_DIM[3][1]);
    translate([daughter_board_offset + x_dim, const_offset, 0])
        hole_w_end(bolt_l, M_DIM[3][4], "round", M_DIM[3][1]);
    translate([daughter_board_offset + x_dim, const_offset + y_dim, 0])
        hole_w_end(bolt_l, M_DIM[3][4], "round", M_DIM[3][1]);
}


module mount_holes(bolt_l){
    hole_w_end(bolt_l, M_DIM[3][4], "round", M_DIM[3][1]);
    translate([0, 20, 0]) hole_w_end(bolt_l, M_DIM[3][4], "round", M_DIM[3][1]);
}

module fan_mount(bolt_l, extra_nut_len=0){
    rotate([270, 0, 0]){
        translate([13, 0,1])
            hole_w_end(bolt_l, M_DIM[3][4]+extra_nut_len, "hex", M3, flip=true);
        translate([55, 0,1])
            hole_w_end(bolt_l, M_DIM[3][4]+extra_nut_len, "hex", M3, flip=true);
        translate([95, 0,1])
            hole_w_end(bolt_l, M_DIM[3][4]+extra_nut_len, "hex", M3, flip=true);
    }
}

module mount_4020(wall_thick){
    m5_r = 2.5;
    m5_d = m5_r * 2 + 0.3;
    mount_rails_d = 6.4;
    m5_head_len_offset = 5;
    m5_bolt_offset = 2;
    difference(){
        // mount plate
        union() {
            // mount ridge
            cube([board_h + plate_extra_h, wall_thick, 40]);
            // ALU 2020 bottom rail
            translate([0,0, 20])
                rotate([180, 90, 90])
                    alu_connector(board_h + plate_extra_h, 0);
            // ALU 2020 top rail
            translate([0,0, 40])
                rotate([180, 90, 90])
                    alu_connector(board_h + plate_extra_h, 0);
            // Connector to the rest of the board
            translate([0,5,5])
                rotate([-45, 0, 0])cube([board_h + plate_extra_h, 7, 5]);
        }
        // mounting holes to 2040 rail top
        translate([25, wall_thick + m5_bolt_offset, 30] ){
            rotate([90, 0, 0])
                hole_w_end(
                    M_DIM[5][4] + m5_head_len_offset + 4,
                    5,
                    "round",
                    m5_d,
                    flip=true);
        }
        // mounting holes to 2040 rail bottom
        translate([25, wall_thick + m5_head_len_offset + m5_bolt_offset + 2, 10]){
            rotate([90, 0, 0])
                hole_w_end(
                    wall_thick + m5_head_len_offset * 2 + m5_bolt_offset,
                    M_DIM[5][4] + m5_head_len_offset + 3,
                    "round",
                    m5_d,
                    flip=true);
        }
        // mounting holes to 2040 rail top
        translate([second_2040_mount, wall_thick + m5_bolt_offset, 30]){
            rotate([90, 0, 0])
                hole_w_end(wall_thick+5+m5_bolt_offset, 5, "round", m5_d, flip=true);
        }
        // mounting holes to 2040 rail bottom
        translate([
            second_2040_mount,
            wall_thick + m5_head_len_offset + m5_bolt_offset + 2, 10]){
                rotate([90, 0, 0])
                    hole_w_end(
                        wall_thick + m5_head_len_offset * 2 + m5_bolt_offset,
                        M_DIM[5][4] + m5_head_len_offset + 3,
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
                hole_w_end(peg_h, M_DIM[3][4], "hex", M_DIM[3][0], flip=true, grade=true);
            translate([mount_h + 8, mount_offset, 0])
                hole_w_end(peg_h, M_DIM[3][4], "hex", M_DIM[3][0], flip=true, grade=true);
            translate([8, mount_offset + mount_w, 0])
                hole_w_end(peg_h, M_DIM[3][4], "hex", M_DIM[3][0], flip=true, grade=true);
            translate([mount_h + 8, mount_offset + mount_w, 0])
                hole_w_end(peg_h, M_DIM[3][4], "hex", M_DIM[3][0], flip=true, grade=true);

        }
    }
}