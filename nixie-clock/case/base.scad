// Base of the Nixie clock case


module nixieBase() {
    difference() {
        cube([15, 10, 1]);
        translate([.5, .5, .5])
            cube([14, 9, 2]);
    }

    translate([0, 3, .5])
        cube([15, .5, 3]);
}

nixieBase();
