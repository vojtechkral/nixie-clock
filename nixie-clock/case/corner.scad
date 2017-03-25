// A corner for the Nixie clock case

$fn = 50;

module nixieCorner() {
    scale(.75) difference() {
        cube([2, 2, 2]);
        union() {
            translate([.8, 1.2, 1])
                rotate([90, 0, 0]) 
                    cylinder(1.3, .2, .2);
            
            translate([-.1, 1, 1.2])
                rotate([0, 90, 0]) 
                    cylinder(1.3, .2, .2);
            
            translate([1, .8, .8])
                cylinder(1.3, .25, .25);
            
            translate([2, 2, 0]) sphere(1.5);
        }
    }
}

scale(10)
    translate([0, 0, 1.5])
    mirror([0, 0, 1])
    nixieCorner(0, 0, 0);
