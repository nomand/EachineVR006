INITIAL_WIDTH = 100;
INITIAL_HEIGHT = 60;

CUBE_WIDTH_BIGGER = 100;
CUBE_WIDTH_SMALLER = 20;

CUBE_WIDTH = 2;
CUBE_DEPTH= 30;
CUBE_HEIGHT = 70;

X_BIGGER_OFFSET = 11;
X_OFFSET = -40;
X_SMALLER_OFFSET = -51;

/* [BUTTONS] */
BUTTON_SIZE = 6.00; //5.80
BUTTON_TOTAL_WIDTH = 31.10;
BUTTON_DISTANCE = (BUTTON_TOTAL_WIDTH - 4*BUTTON_SIZE) / 3 + BUTTON_SIZE;

/* [MOUNTING ELEMS] */
SCREW_DIAMETER = 3; // M3 screw
SCREW_HEAD_DIAMETER = 6.4; // M3 screw
SCREW_HEAD_THICKNESS = 3.07; // M3 screw
SCREW_X_OFFSET = 44;
SCREW_Z_OFFSET = 27.8;

/* EXTRA_SIZE */
WIDER_BY = 2;
EXTRA_DEPTH = 3.5;

EXPLODE = 0;

/* [HIDDEN] */
$fn = 128;


back_united();
translate([0,-40,0])
front_united();

module back_united(){
    union(){
        back_bigger_part();
        translate([-EXPLODE, 0 ,0])
        back_middle_part();
        translate([-WIDER_BY, 0 ,0])
        back_middle_part();
        translate([-WIDER_BY-2*EXPLODE, 0 ,0])
        back_smaller_part();
    }    
}

module front_united(){
    union(){
        front_bigger_part();
        translate([-EXPLODE, 0 ,0])
        front_middle_part();
        translate([-WIDER_BY, 0 ,0])
        front_middle_part();
        translate([-WIDER_BY-2*EXPLODE, 0 ,0])
        front_smaller_part();
    }    
}

module screw_slot(height) {
    cube_ratio = 1.5;
//    difference(){
//        cube([cube_ratio*diameter,cube_ratio*diameter, height], true);              
//        cylinder(height*2,SCREW_DIAMETER/2, SCREW_DIAMETER/2, true);  
//    }  
    cylinder(height,SCREW_DIAMETER/2, SCREW_DIAMETER/2, true);      
}

module extra_border(){
    bottom_up_thickness = 5;
    bottom_border_width = 98.5;
    upper_border_width = 85.5;
    
    antenna_side_width = 2;
    antenna_side_height = 52;    
    
    color("red")
    translate([-upper_border_width/2-6.5,-EXTRA_DEPTH,-30.5])
    cube([upper_border_width,2+EXTRA_DEPTH,bottom_up_thickness]);
    
    color("pink")
    translate([-bottom_border_width/2,-EXTRA_DEPTH,26])
    cube([bottom_border_width,2+EXTRA_DEPTH,bottom_up_thickness]);    
    
    color("green")
    translate([46,-EXTRA_DEPTH, -antenna_side_height/2+1.8])
    cube([3.2,2+EXTRA_DEPTH,antenna_side_height]);    
    
    color("violet")
    translate([36,-EXTRA_DEPTH,-24.2])
    cube([13,2+EXTRA_DEPTH,antenna_side_width]);    
    
    color("grey")
    translate([34.3,-EXTRA_DEPTH, -28.2])
    cube([2,2+EXTRA_DEPTH,6]);     
 
    color("orange")
    translate([-49.3,-EXTRA_DEPTH, -antenna_side_height/2])
    cube([3.2,2+EXTRA_DEPTH,antenna_side_height]);     
}

module extra_stablisers(){
    thickness = 5 + EXTRA_DEPTH;
    z_offset = 24.4;
    
    smaller_thickness = 2;
    
    color("violet")
    translate([-30,-thickness/2,z_offset])
    cube([10,thickness,2], true);
     
    color("violet")
    translate([-30,-thickness/2,-z_offset])
    cube([10,thickness,2], true);
    
    color("violet")
    translate([28,-thickness/2,-z_offset])
    cube([10,thickness,2], true);      
    
    color("violet")
    translate([45,-thickness/2,0])
    cube([2,thickness,10], true);     
    
    color("pink")
    translate([48,-smaller_thickness/2,12.5])
    cube([2,smaller_thickness,8], true);         
}

module larger_button(){
    cube([BUTTON_SIZE, BUTTON_SIZE, 4], true);
}

module larger_button_slots(){
    buttons = 4;
    initial_offset = (buttons-1)*BUTTON_DISTANCE;
    
    translate([-initial_offset/2,0,0])    
    union(){            
        for(n=[0:1:buttons-1]){
            translate([n*BUTTON_DISTANCE,0,0])
            larger_button();
        }
    }
}

module back_body_base(){
    union(){
        rotate([180,0,0])
        difference(){
            import("BACK.stl", convexity=3); 
            
            translate([22.5, -1, -19.4])
            rotate([90,0,0])        
            larger_button_slots();            
        }
        extra_border();
        extra_stablisers();
    }
//    translate([0,4,0])  
//    import("FRONT.stl", convexity=3);    
}

module screw_slots(){
    screw_depth = 20;
    slot_diameter = SCREW_DIAMETER/2 + 1.0;      
    y_offset = 6;    

    color("red")
    translate([-SCREW_X_OFFSET,y_offset,SCREW_Z_OFFSET])
    rotate([90,0,0])
    screw_slot(screw_depth);     

    color("red")
    translate([-SCREW_X_OFFSET,y_offset,-SCREW_Z_OFFSET])
    rotate([90,0,0])
    screw_slot(screw_depth);           
    
    color("red")
    translate([SCREW_X_OFFSET,y_offset,SCREW_Z_OFFSET])
    rotate([90,0,0])
    screw_slot(screw_depth);           
    
    color("red")
    translate([SCREW_X_OFFSET-14,y_offset,-SCREW_Z_OFFSET])
    rotate([90,0,0])
    screw_slot(screw_depth);        
}

module back_body(){
    difference(){
        back_body_base();
        translate([0,-4,0])
        screw_slots();
    }    
}

module back_bigger_part(){
    intersection(){
        back_body();
        translate([X_BIGGER_OFFSET,0,0])
        cube([CUBE_WIDTH_BIGGER,CUBE_DEPTH,CUBE_HEIGHT], true);         
    }

      
}

module back_smaller_part(){
    intersection(){
        back_body();
        translate([X_SMALLER_OFFSET,0,0])
        cube([CUBE_WIDTH_SMALLER,CUBE_DEPTH,CUBE_HEIGHT], true);              
    }    
}

module back_middle_part(){
    intersection(){
        back_body();
        translate([-40,0,0])
        cube([CUBE_WIDTH,CUBE_DEPTH,CUBE_HEIGHT], true);            
    }    
}


module front_body_base(){
    union(){
        difference(){
            import("FRONT.stl", convexity=3);
            translate([-40,3.3,-14])
            cube([10,4,6], true);        

            translate([0, 11.6, 0])
            cube([120,3,100], true);        
        }
        
        translate([0,6,0])
        extra_border();        
    }   
}

module front_body(){
    difference(){
        front_body_base();
        screw_slots();
    }    
}

module front_bigger_part(){
    intersection(){
        front_body();
        translate([X_BIGGER_OFFSET,0,0])
        cube([CUBE_WIDTH_BIGGER,CUBE_DEPTH,CUBE_HEIGHT], true);         
    }

      
}

module front_smaller_part(){
    intersection(){
        front_body();
        translate([X_SMALLER_OFFSET,0,0])
        cube([CUBE_WIDTH_SMALLER,CUBE_DEPTH,CUBE_HEIGHT], true);              
    }    
}

module front_middle_part(){
    intersection(){
        front_body();
        translate([-40,0,0])
        cube([CUBE_WIDTH,CUBE_DEPTH,CUBE_HEIGHT], true);            
    }    
}

