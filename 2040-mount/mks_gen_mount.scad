/* Main board mount model
 * Copyright 2021 Alex Volkov <alex@flamy.ca>
 * License: Attribution-ShareAlike 4.0 International (CC BY-SA)
 * https://creativecommons.org/licenses/by-sa/4.0/
 *
 * TODO: Combine MKS & SKR common code in a single library
 * Version 1.2 2020-04-12 Refactoring for the board to use common code
 * Version 1.1 2020-04-12 Backporting changes from skr_14_turbo, making code more generic
 * Version 1.0 2021-04-10 Initial publication
 */

 include <common_mount.scad>;


$fn=30;

/* Board dimensions */
board_h = 143;
board_w = 84;

mount_h = 135.5;
mount_w = 76;

/* custom offsets*/
daughter_board_offset = 20;
fan_rail_offset = 17;
peg_h = 8;
cable_mgmt_offset = 8; // offset for mounting cable management accessories
plate_extra_h = 10;
mount_offset = 18;


/* Logic for mounting the board */
difference(){
    mount_board(mount_offset);
    // mounting holes for the daughter boards
    translate([5, mount_offset, 0]) board_5x7_mount(5);
    // Second board
    translate([65, mount_offset, 0]) board_5x7_mount(5);

    translate([
        8, // mounting holes offset for cable mgmt, top
        board_w/2 + mount_offset/2, 0]) mount_holes(5);
    translate([
        board_h + plate_extra_h - 8 , // mounting holes offset for cable mgmt, bottom
        board_w/2 + mount_offset/2, 0]) mount_holes(5);
}

/* Logic for mounting the rail */
difference(){
    wall_thick = 9;
    mount_4020(wall_thick);
    translate([0, -1, 36])
        fan_mount(wall_thick, 2);
}
