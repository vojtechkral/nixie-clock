// Base of the Nixie clock case

$fn = 50;

module nixieBase() {
    difference() {
        // Base shape
        cube([15, 10, 1]);
        
        // Inset
        translate([.5, .5, .2]) cube([14, 9, 2]);
        
        // Side screwholes
        union() {   
            for (i = [0:1])
                translate([1.5+12*i, 11, .5])
                    rotate([90, 0, 0]) cylinder(13, .2, .2);
            
            for (i = [0:1])
                translate([-.5, 1.5+7*i, .5])
                    rotate([0, 90, 0]) cylinder(16, .2, .2);
        }

        // Perforations
        union() {
            for (i = [0:1.7:13]) {
                translate([1.5+i, 1.5, -.5])
                    rotate([0, 0, 30])
                    cylinder(1, .75, .75, $fn = 6);
            }
            
            for (i = [0:5]) {
                for (j = [0:3]) {
                    translate([1.5+2.4*i, 5+1.2*j, -.5]) {
                        cylinder(1, .6, .6, $fn = 6);
                        if (i < 5 && j < 3)
                        translate([1.2, .6, 0])
                            cylinder(1, .6, .6, $fn = 6);
                    }
                }
            }
        }
    }

    // PCB support
    union() {
        // Base
        translate([.25, 3.25, -.95]) {
            intersection() {
                rotate([45, 0, 0]) cube([14.5, 1.5, 1.5]);
                translate([-1, -2, 1]) cube([17, 4, 2]);
            }
        }
        
        // Wall
        translate([0, 3, 0]) difference() {
            cube([15, .5, 3.5]);
            
            // PCB screwholes
            translate([2.4, 1, 1.6]) rotate([90, 0, 0]) union() {
                translate([0, 0, 0]) cylinder(2, .2, .2);
                translate([3.1, .1, 0]) cylinder(2, .2, .2);
                translate([6.8, .1, 0]) cylinder(2, .2, .2);
                translate([10.1, .1, 0]) cylinder(2, .2, .2);
            
                translate([.5, 1.4, 0]) cylinder(2, .2, .2);
                translate([9.4, 1.4, 0]) cylinder(2, .2, .2);
            }
        }
    }
}

scale(10) nixieBase();
