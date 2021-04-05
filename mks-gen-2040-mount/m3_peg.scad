$fn=20;

module m3_peg(peg_h){
    difference(){
        cylinder(d=8, h=peg_h);
        cylinder(d=3.5, h=peg_h);
    }
}

m3_peg(1.5);