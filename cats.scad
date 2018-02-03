extruder = 1;

/* [Measurements] */

calicat_width = 20;

calicat_paw_width = 8;
calicat_paw_height = 2;
calicat_paw_length = 9;
calicat_toes_length = 1;
calicat_tail_width = 5;
calicat_tail_height = 19;
calicat_ear_height = 5;
calicat_ear_width = 5;
calicat_leg_height = 3;

calicat_face_depth = 2.5;

calicat_paw_gap = 4;
calicat_tail_gap = 2.5;

calicat_tail_left = 0.465; // this could probably be derived better
calicat_left = 9;
calicat_head_top = 30;
calicat_head_bottom = 15;
calicat_neck_middle = 12.5;
calicat_body_top = 10;
calicat_eyes_bottom = 21.5;
calicat_eye_width = 1;
calicat_eye_height = 2;
calicat_whisker_bottom = 19;
calicat_nose_top = 21;
calicat_nose_bottom = 19.5;

// note that this is relative to calicat_left
calicat_right_eye_left = 7;
calicat_left_eye_left = 12;
calicat_nose_right = 11.33;

/* [Tweaks] */

$fn = 8;
fudge = .0025;
layer_height = 0.15;

/* [Cat Details] */

ear_outline = 0.5;

/* [Hidden] */

calicat_left_paw_left = calicat_left + calicat_paw_width + calicat_paw_gap;
calicat_rear_paw_front = calicat_paw_width + calicat_paw_gap;
calicat_tail_front = calicat_width + calicat_toes_length + calicat_tail_gap;
calicat_ear_top = calicat_head_top + calicat_ear_height;

ear_diag = 2*sqrt(2)*ear_outline;

module dualize () {
  if (extruder) {
    intersection () {children(0); children(1);}
  } else {
    difference() {children(0); children(1);}
  }
}

module fudged_paw() {
  cube([calicat_paw_width+2*fudge,calicat_paw_length+2*fudge, calicat_paw_height+2*fudge]);
}

module dora_base () {
  import("calicat.stl");
}

module punkin_base () {
  union() {
    import("calicat.stl");
    translate([calicat_left + calicat_right_eye_left - fudge,
      calicat_toes_length, calicat_eyes_bottom-fudge])
        cube([calicat_eye_width + 2*fudge, calicat_face_depth, calicat_eye_height + 2*fudge]);
  }
}

module dora_highlights() {
  dora_tail_tip = 3;
  dora_face_pattern_edge = (calicat_nose_right + calicat_left_eye_left)/2;
  
  union () {
    // paws
    translate([calicat_left-fudge,-fudge,-fudge]) fudged_paw();
    translate([calicat_left_paw_left-fudge,-fudge,-fudge]) fudged_paw();
    translate([calicat_left-fudge,calicat_rear_paw_front-fudge,-fudge]) fudged_paw();
    translate([calicat_left_paw_left-fudge,calicat_rear_paw_front-fudge,-fudge]) fudged_paw();
    // tail tip
    translate([calicat_tail_left-fudge,calicat_tail_front-fudge,calicat_tail_height-dora_tail_tip-fudge])
      cube([calicat_tail_width+2*fudge, calicat_tail_width+2*fudge, dora_tail_tip+2*fudge]);
    
    // front details
    translate([0,calicat_toes_length-fudge,0]) rotate([90,0,0]) mirror([0,0,1])
      linear_extrude(calicat_face_depth+2*fudge) translate([calicat_left,0,0]) union() {
      
      // inner ears
      polygon([[ear_outline,calicat_head_top+ear_outline],
        [calicat_ear_width-ear_diag,calicat_head_top+ear_outline],
        [ear_outline,calicat_ear_top-ear_diag]]);
      polygon([[calicat_width-ear_outline,calicat_head_top+ear_outline],
        [calicat_width-(calicat_ear_width-ear_diag),calicat_head_top+ear_outline],
        [calicat_width-ear_outline,calicat_ear_top-ear_diag]]);
      
      // belly tuft
      polygon([[calicat_width/4,calicat_neck_middle],
        [calicat_width/2,calicat_leg_height],
        [3*calicat_width/4,calicat_neck_middle]]);
        
      difference() {
        polygon([
          [calicat_width/2,calicat_eyes_bottom+calicat_eye_height/2],
          [dora_face_pattern_edge, calicat_eyes_bottom+calicat_eye_height+1],
          [dora_face_pattern_edge, calicat_nose_top],
          [calicat_width-1,calicat_nose_top],
          [2*calicat_width/3,calicat_neck_middle],
          [calicat_width/2,calicat_neck_middle]]);
        translate([calicat_left_eye_left+calicat_eye_width,calicat_nose_bottom]) circle(r = 1);
      }
      // chin
      translate([-fudge,calicat_neck_middle])
        square([calicat_width+2*fudge, calicat_head_bottom-calicat_neck_middle]);
    }
  }
}

module punkin_highlights() {
  union () {
    // paws
    translate([calicat_left-fudge,-fudge,-fudge]) fudged_paw();
    translate([calicat_left_paw_left-fudge,-fudge,-fudge]) fudged_paw();
    translate([calicat_left-fudge,calicat_rear_paw_front-fudge,-fudge]) fudged_paw();
    translate([calicat_left_paw_left-fudge,calicat_rear_paw_front-fudge,-fudge]) fudged_paw();
    
    // front details
    translate([0,calicat_toes_length-fudge,0]) rotate([90,0,0]) mirror([0,0,1])
      linear_extrude(calicat_face_depth+2*fudge) translate([calicat_left,0,0]) union() {
      
      // inner ears
      polygon([[ear_outline,calicat_head_top+ear_outline],
        [calicat_ear_width-ear_diag,calicat_head_top+ear_outline],
        [ear_outline,calicat_ear_top-ear_diag]]);
      polygon([[calicat_width-ear_outline,calicat_head_top+ear_outline],
        [calicat_width-(calicat_ear_width-ear_diag),calicat_head_top+ear_outline],
        [calicat_width-ear_outline,calicat_ear_top-ear_diag]]);
      
      // belly tuft
      polygon([[calicat_width/4,calicat_neck_middle],
        [calicat_width/2,calicat_leg_height],
        [3*calicat_width/4,calicat_neck_middle]]);
        
      // muzzle
      translate([-fudge,calicat_neck_middle])
        square([calicat_width+2*fudge, calicat_whisker_bottom-calicat_neck_middle]);
    }
    // tabby striping
      for (stripe_bottom = [0 : 2*layer_height : calicat_head_top + calicat_ear_height]) {
        translate([-fudge, -fudge, stripe_bottom])
          cube([calicat_left + calicat_width + 2*fudge,
            calicat_toes_length + calicat_width + calicat_tail_gap + calicat_tail_width + 2*fudge,
          layer_height]);
      }
  }
}

dualize() {
  punkin_base();
  punkin_highlights();
}
