// $vpr = [-110, 180, 30]; // shows rotation
// $vpt = [50, 50, 150]; // shows translation (i.e. won't be affected by rotate and zoom)
// $vpd = 1000; // shows the camera distance [Note: Requires version 2015.03]

module vectorWithArrow(lenght=100, width="meduim") {

    w = width == "thin" ? 0.5 : 
        width == "meduim" ? 1 : 
        width == "thick" ? 2 : 
        0;

    arrow = width == "thin" ? 5 : 
            width == "meduim" ? 10 : 
            width == "thick" ? 20 : 
            0;

    cylinder(h=lenght-arrow, r1=w, r2=w);
    translate([ 0, 0, lenght-arrow ]) {
        cylinder(h=arrow, r1=3*w, r2=0);
    }

}

module vectorsKa(start, lenght) {
    
    translate([ start, 0, start ]) rotate([ 0, -45, 0 ]) vectorWithArrow(lenght);
    translate([ start, 0, start ]) rotate([ 0, -135, 0 ]) vectorWithArrow(lenght);

}

module circleKa(start) {

    translate([0, 0, start]) color("gray", 0.5) difference() {

        circle(start);
        circle(start-0.25);

    }

}

module vectorKb(start, lenght) {
    translate([ start, 0, start ]) rotate([ 0, -135, 0 ]) vectorWithArrow(lenght);
}

module circleKb(start) {

    translate([0, 0, start]) color("black", 0.5) difference() {
        circle(start);
        circle(start-0.25);
    }

}

module sphereKb(start, lenght) {

    translate([start, 0, start]) color("gray", 0.6) difference() {
        difference() {
            sphere(lenght);
            sphere(lenght-0.25);
        }
        sphereSector(lenght);
    }

}

module sphereSector(lenght) {
    translate([-2*lenght, 0, -lenght]) cube(lenght*2);
}

module vectorsKbDif(start, lenght) {

    translate([ start, 0, start ]) {

        rotate([ 0, 0, 0 ]) vectorWithArrow(lenght, width="thin");
        rotate([ 0, -45, 0 ]) vectorWithArrow(lenght, width="thin");
        rotate([ 0, -150, 0 ]) vectorWithArrow(lenght, width="thin");

        rotate([ -90, 0, 0 ]) vectorWithArrow(lenght, width="thin");
        rotate([ -135, 0, 0 ]) vectorWithArrow(lenght, width="thin");
        rotate([ -180, 0, 0 ]) vectorWithArrow(lenght, width="thin");
        
        rotate([ 90, 0, 0 ]) vectorWithArrow(lenght, width="thin");
        rotate([ 90, 0, 45 ]) vectorWithArrow(lenght, width="thin");
        rotate([ 0, 135, 0 ]) vectorWithArrow(lenght, width="thin");

    }

}

module torus(start, lenght) {

    // vertical lines
    for (i=[0:15:180]) {

        translate([start * cos(i), start * -sin(i), start])
        rotate([90, 0, -i])
        difference() {
            circle(r = lenght);
            circle(r = lenght-0.25);
        }
    
    }

    // horizontal lines
    for (i=[0:15:180]) {

        translate([0, 0, start+lenght*cos(i)]) difference() {
            circle(start+lenght*sin(i));
            circle(start+lenght*sin(i)-0.25);
        }

    }

}

module torusSector(lenght) {
    translate([-2*lenght, 0, -2*lenght]) cube(4*lenght);
}

vectorWithArrow();

lenght_a = 100*sin(45);
start_a = lenght_a*cos(45);

vectorsKa(start_a, lenght_a);
circleKa(start_a);

lenght_b = 140*sin(45);
start_b = lenght_b*cos(45);

vectorKb(start_b, lenght_b);
circleKb(start_b);
color("gray", 0.8) vectorsKbDif(start_b, lenght_b);
sphereKb(start_b, lenght_b);

difference() {

    torus(start_b, lenght_b);
    torusSector(lenght_b);

}
