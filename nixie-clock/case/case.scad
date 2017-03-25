
use <base.scad>;
use <corner.scad>;

nixieBase();
translate([0, 0, 15-1.5]) nixieCorner();
translate([15, 0, 15-1.5]) mirror([1, 0, 0]) nixieCorner();
translate([0, 10, 15-1.5]) mirror([0, 1, 0]) nixieCorner();
translate([15, 10, 15-1.5]) mirror([1, 1, 0]) nixieCorner();

%translate([0, -.4, 0]) cube([15, .4, 15]);
%translate([0, 10, 0]) cube([15, .4, 15]);
%translate([-.4, 0, 0]) cube([.4, 10, 15]);
%translate([15, 0, 0]) cube([.4, 10, 15]);
%translate([0, 0, 15]) cube([15, 10, .4]);
