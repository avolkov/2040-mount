cube_dim = 5;
rod_h = 17;
difference(){
    cylinder(d=2.8, h=rod_h, $fn=20);
    translate([-cube_dim/2, 1,0])
        cube([cube_dim, cube_dim, rod_h]);
}
