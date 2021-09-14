/* Main board mount for BTT SKR 1.4 Turbo
 * Copyright 2021 Alex Volkov <alex@flamy.ca>
 * License: Attribution-ShareAlike 4.0 International (CC BY-SA)
 * https://creativecommons.org/licenses/by-sa/4.0/
 *
 * Version 0.2 2021-04-12 Refactor to use common library with MKS GEN code
 * Version 0.1 2021-04-12 Initial publication
 */

include <variables.scad>;
include <../lib/common_mount.scad>;

$fn=30;

// Board dimensions 
board_h = 109.67;
board_w = 84.3;

mount_h = 101.85;
mount_w = 76.30;

// Custom offset 
plate_extra_h = 10; //extra length for the plate
daughter_board_offset = 20;
peg_h = 8;
cable_mgmt_offset = 8; // offset for mounting cable management accessories


wall_thick = 9;
blocking_rail_offset=2;

module skr_mount(){
    // Setting up skr and mount holes
    difference(){
        mount_offset = 18;
        mount_board(mount_offset);
        // mounting holes for the daughter board
        translate([20, mount_offset, 0]) board_5x7_mount(5);
        translate([8,// mounting holes for the daughter board
            board_w/2 + mount_offset/2, 0]) mount_holes(5);
        translate([
            board_h + plate_extra_h - 8 ,// mounting holes offset for cable mgmt, bottom
            board_w/2 + mount_offset/2, 0]) mount_holes(5);
    }
    difference(){
        wall_thick = 9;
        blocking_rail_offset=2;
        mount_4020(wall_thick);
        translate([0, -1 - blocking_rail_offset, 36])
            fan_mount(
                wall_thick + blocking_rail_offset,
                extra_nut_len=2 + blocking_rail_offset
            );
    }
}

*skr_mount();
