CUBE_WIDTH_BIGGER = 100;
CUBE_WIDTH_SMALLER = 20;

CUBE_WIDTH = 2;
CUBE_DEPTH= 30;
CUBE_HEIGHT = 70;

X_BIGGER_OFFSET = 11;
X_OFFSET = -40;
X_SMALLER_OFFSET = -51;

/* [CORNERS] */
CORNER_DIAMETER = 8;

/* [BUTTONS] */
BUTTON_SIZE = 6.00; //5.80
BUTTON_TOTAL_WIDTH = 31.10;
BUTTON_DISTANCE = (BUTTON_TOTAL_WIDTH - 4*BUTTON_SIZE) / 3 + BUTTON_SIZE;

/* [MOUNTING ELEMS] */
SCREW_DIAMETER = 3; // M3 screw
SCREW_HEAD_DIAMETER = 6.4; // M3 screw
SCREW_HEAD_THICKNESS = 3.07; // M3 screw
SCREW_X_OFFSET = 46;
SCREW_Z_OFFSET = 28.0; //27.8

/* EXTRA_SIZE */
WIDER_BY = 2;
EXTRA_DEPTH = 3.5;

EXPLODE = 0;

/* [HIDDEN] */
$fn = 128;


back_united();
translate([0,-16.5,0])
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

module screw_head(height) {;
    cylinder(height,SCREW_HEAD_DIAMETER/2, SCREW_HEAD_DIAMETER/2, true);      
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

module extra_border_rounded_base_side(){
    height = 1;
    x_offset = 51 - CORNER_DIAMETER/2;
    z_offset = 32 - CORNER_DIAMETER/2; 
    antenna_limiter = 14.6;    
    antenna_limiter_z = 7.5;
    
    color("pink")
    hull(){
        translate([x_offset-antenna_limiter,0,-(z_offset-antenna_limiter_z)])
        rotate([90,0,0])
        cylinder(height,CORNER_DIAMETER/2, CORNER_DIAMETER/2, true);

        translate([x_offset+1,0,-(z_offset-antenna_limiter_z)])
        rotate([90,0,0])
        cylinder(height,CORNER_DIAMETER/2, CORNER_DIAMETER/2, true);        
        
        translate([x_offset+1,0,z_offset])
        rotate([90,0,0])
        cylinder(height,CORNER_DIAMETER/2, CORNER_DIAMETER/2, true);   

        translate([x_offset-antenna_limiter,0,z_offset])
        rotate([90,0,0])
        cylinder(height,CORNER_DIAMETER/2, CORNER_DIAMETER/2, true);            
    }    
    
}

module extra_border_rounded_base(){
    height = 1;
    x_offset = 51 - CORNER_DIAMETER/2;
    z_offset = 32 - CORNER_DIAMETER/2;
    antenna_limiter = 14.6;
    
    color("red")
    hull(){
        translate([-x_offset,0,-z_offset])
        rotate([90,0,0])
        cylinder(height,CORNER_DIAMETER/2, CORNER_DIAMETER/2, true);          
        
        translate([-x_offset,0,z_offset])
        rotate([90,0,0])
        cylinder(height,CORNER_DIAMETER/2, CORNER_DIAMETER/2, true);       
    
        translate([x_offset-antenna_limiter,0,-z_offset])
        rotate([90,0,0])
        cylinder(height,CORNER_DIAMETER/2, CORNER_DIAMETER/2, true);          
        
        translate([x_offset-antenna_limiter,0,z_offset])
        rotate([90,0,0])
        cylinder(height,CORNER_DIAMETER/2, CORNER_DIAMETER/2, true);         
    }
}

module extra_border_rounded(){
    //This is the new base shape
    height = 1;    
    
    union(){
        extra_border_rounded_base();
        extra_border_rounded_base_side();        
    }            
}

module extra_border_rounded_empty_inside(thickness){
    // This is the new rim
    
    base_height = 1;
    
    scale([1,thickness,1])
    difference(){
        extra_border_rounded();     

        translate([-7,0,0])    
        cube([82,base_height*2,52], true);     
        
        translate([40,0,2])       
        cube([18,base_height*2,48], true); //53 Z              
    } 
}

module extra_stablisers(){
    thickness = 5 + EXTRA_DEPTH;
    z_offset = 23.6;
    
    smaller_thickness = 3 + EXTRA_DEPTH;
    
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
    
    color("purple")
    translate([50.5,-smaller_thickness/2,12.3])
    cube([2,smaller_thickness,8.8], true);         
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
//            import("BACK.stl", convexity=3); 
            rotate([180,0,0])            
            extra_border_rounded();            
            
            translate([22.5, -1, -19.4])
            rotate([90,0,0])        
            larger_button_slots();            
        }
//        extra_border_rounded();
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

module screw_heads(){
    screw_depth = 3;
    slot_diameter = SCREW_HEAD_DIAMETER/2 + 1.0;      
    y_offset = 6;    

    union(){      
        color("red")
        translate([-SCREW_X_OFFSET,y_offset,SCREW_Z_OFFSET])
        rotate([90,0,0])
        screw_head(screw_depth);     

        color("red")
        translate([-SCREW_X_OFFSET,y_offset,-SCREW_Z_OFFSET])
        rotate([90,0,0])
        screw_head(screw_depth);             
        
        color("red")
        translate([SCREW_X_OFFSET,y_offset,SCREW_Z_OFFSET])
        rotate([90,0,0])
        screw_head(screw_depth);           
        
        color("red")
        translate([SCREW_X_OFFSET-14,y_offset,-SCREW_Z_OFFSET])
        rotate([90,0,0])
        screw_head(screw_depth);    
    }
}

module back_body(){
    difference(){
        union(){
            back_body_base();
            translate([0,-4/2,0])
            extra_border_rounded_empty_inside(4);
        }
        translate([0,-4,0])
        screw_slots();     
        
        translate([0,-6.5,0])
        screw_heads();          
    }    

//    translate([0,-6.5,0])
//    screw_heads();            
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

module usb_slot(){
    //scaled cube
    cube([10,20,10],true);
}

module antenna_slot(){
//    hulled cylinder
    diameter = 6.2;
    hull(){
        cylinder(20,diameter/2, diameter/2, true);     
        translate([0,10,0])
        cylinder(20,diameter/2, diameter/2, true);                 
    }
}

module minijack_slot(){
    diameter = 4.8;
    union(){
        translate([0,-2,11.2])
        cube([8.1,10,20],true);  
        
        translate([0,-2.4,0])
        hull(){
            cylinder(10,diameter/2, diameter/2, true);     
            translate([0,10,0])
            cylinder(10,diameter/2, diameter/2, true);                 
        }
    }
}

module led_slot(){
    cube([1,0.8,10],true);      
}

module front_body_base(){
    // This is the new rim
    height = 1;
    union(){
        difference(){
            import("FRONT.stl", convexity=3);
            translate([-40,3.3,-14])
            cube([10,4,6], true);        

            translate([0, 11.6, 0])
            cube([120,3,100], true);        
        }
        
        translate([0,5.2,0])
        
        difference(){
            extra_border_rounded_empty_inside(10.0);

            translate([-8,0,0])    
            cube([80,height*2,54], true);     
            
            translate([40,0,3])       
            cube([18,height*2,48], true); //53 Z              
            
            translate([48,8.2,12.2])            
            usb_slot();   

            translate([42.6,-0.7,-20])                        
            antenna_slot();
            
            translate([0,4.5,-28])                                                    
            minijack_slot();

            translate([-8.5,0.4,-28])                         
            led_slot();         
        
            translate([0,0.4,28])               
            led_slot();       
        };    
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

