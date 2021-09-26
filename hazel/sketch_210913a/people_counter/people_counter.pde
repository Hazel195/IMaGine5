import de.voidplus.leapmotion.*;

LeapMotion leap;

PVector fingerPos = new PVector(0,0);;

int cr07_in[], cr07_out[], 
    cr09_in[], cr09_out[], 
    st18_up[], st18_down[], 
    st19_up[], st19_down[];
    
String cr07_in_time[], cr07_out_time[], 
    cr09_in_time[], cr09_out_time[], 
    st18_up_time[], st18_down_time[], 
    st19_up_time[], st19_down_time[];

int index1 = 0;
int index2 = 0;
int index3 = 0;
int index4 = 0;
int index5 = 0;
int index6 = 0;
int index7 = 0;
int index8 = 0;


PImage img, bg, graph;

int boxSize = 9;

int clicked = 0;

boolean showAll = false;

////////////////////////////

/* CR07 */

float cr07_in_x, cr07_in_y;
boolean cr07_overBox = false;
boolean cr07_locked = false;
float cr07_circle_x, cr07_circle_y; 


float cr07_out_x, cr07_out_y;
boolean cr07_out_overBox = false;
boolean cr07_out_locked = false;
float cr07_out_circle_x, cr07_out_circle_y;


////////////////////////////

/* CR09 */

float cr09_in_x, cr09_in_y;
boolean cr09_overBox = false;
boolean cr09_locked = false;
float cr09_circle_x, cr09_circle_y; 


float cr09_out_x, cr09_out_y;
boolean cr09_out_overBox = false;
boolean cr09_out_locked = false;
float cr09_out_circle_x, cr09_out_circle_y;

////////////////////////////

/* ST18 */

float st18_up_x, st18_up_y;
boolean st18_up_overBox = false;
boolean st18_up_locked = false;
float st18_up_circle_x, st18_up_circle_y; 


float st18_down_x, st18_down_y;
boolean st18_down_overBox = false;
boolean st18_down_locked = false;
float st18_down_circle_x, st18_down_circle_y; 


////////////////////////////

/* ST19 */

float st19_up_x, st19_up_y;
boolean st19_up_overBox = false;
boolean st19_up_locked = false;
float st19_up_circle_x, st19_up_circle_y; 


float st19_down_x, st19_down_y;
boolean st19_down_overBox = false;
boolean st19_down_locked = false;
float st19_down_circle_x, st19_down_circle_y; 

PFont font;

void setup() {
  size(1200, 846);
  leap = new LeapMotion(this);
  backend_setup(); 
}

void draw() { 
  background(255);
  image(bg, 0, 0);
  
  display();
  backend_draw();
  show_graph();
  fingerPosition();
}

void fingerPosition() {
  for (Hand hand : leap.getHands()) {
    //hand.draw();
    
    Finger fingerIndex = hand.getIndexFinger();
    PVector indexFingerPosition   = fingerIndex.getPosition();
    fingerPos.x = indexFingerPosition.x;
    fingerPos.y = indexFingerPosition.y;
    
    println(fingerPos.x + " " + fingerPos.y);
    //fill(palette.randomColour());
    fill(252, 53, 3);
    noStroke();
    ellipse(indexFingerPosition.x, indexFingerPosition.y, 10, 10);
  }
}

void display() {
  showAll();
  
  display_cr07_in(cr07_in_x, cr07_in_y, cr07_in, cr07_in_time);
  display_cr07_out(cr07_out_x, cr07_out_y, cr07_out, cr07_out_time);
  
  display_cr09_in(cr09_in_x, cr09_in_y, cr09_in, cr09_in_time);
  display_cr09_out(cr09_out_x, cr09_out_y, cr09_out, cr09_out_time);
  
  display_st18_up(st18_up_x, st18_up_y, st18_up, st18_up_time);
  display_st18_down(st18_down_x, st18_down_y, st18_down, st18_down_time);
  
  display_st19_up(st19_up_x, st19_up_y, st19_up, st19_up_time);
  display_st19_down(st19_down_x, st19_down_y, st19_down, st19_down_time);
  
}

void backend_setup() {
  font = createFont("Arial.ttf", 128);
  textFont(font);
  
  bg = loadImage("bg.png");
  //img = loadImage("05.png");
  //graph = loadImage("AAPL2010V4_2.tif");
  
  /* name & box pos setup */ 
  
  cr07_in_x = width * 0.6;
  cr07_in_y = height * 0.8;
  
  cr07_out_x = width * 0.6;
  cr07_out_y = height * 0.85;
  
  
  cr09_in_x = width * 0.8;
  cr09_in_y = height * 0.8;
  
  cr09_out_x = width * 0.8;
  cr09_out_y = height * 0.85;
  
  st18_up_x = width * 0.25;
  st18_up_y = height * 0.8;
  
  st18_down_x = width * 0.25;
  st18_down_y = height * 0.85;
  
  st19_up_x = width * 0.43;
  st19_up_y = height * 0.8;
  
  st19_down_x = width * 0.43;
  st19_down_y = height * 0.85;
  
  rectMode(RADIUS); 
  
  /* circle zone setup */
  
  st19_up_circle_x = width * 0.52;
  st19_up_circle_y = height * 0.47;
  
  
  /* csv setup */
  
  // CR07_in setup
  cr07_in = setupCsv("CB11.PC05.23_ CB11.05.CR07 In.txt");
  cr07_in_time = setupCsvTime("CB11.PC05.23_ CB11.05.CR07 In.txt");
  
  // CR07_out setup
  cr07_out = setupCsv("CB11.PC05.23_ CB11.05.CR07 Out.txt");
  cr07_out_time = setupCsvTime("CB11.PC05.23_ CB11.05.CR07 Out.txt");
  
  // CR09_in setup
  cr09_in = setupCsv("CB11.PC05.23_ CB11.05.CR09 In.txt");
  cr09_in_time = setupCsvTime("CB11.PC05.23_ CB11.05.CR09 In.txt");
  
  // CR09_out setup
  cr09_out = setupCsv("CB11.PC05.23_ CB11.05.CR09 Out.txt");
  cr09_out_time = setupCsvTime("CB11.PC05.23_ CB11.05.CR09 Out.txt");

  // ST18_up setup
  st18_up = setupCsv("CB11.PC05.22_ CB11.04.ST18 Up.txt");
  st18_up_time = setupCsvTime("CB11.PC05.22_ CB11.04.ST18 Up.txt");
  
  // ST18_up setup
  st18_down = setupCsv("CB11.PC05.22_ CB11.04.ST18 Down.txt");
  st18_down_time = setupCsvTime("CB11.PC05.22_ CB11.04.ST18 Down.txt");
  
  // ST19_up setup
  st19_up = setupCsv("CB11.PC05.22_ CB11.06.ST19 Up.txt");
  st19_up_time = setupCsvTime("CB11.PC05.22_ CB11.06.ST19 Up.txt");
  
  // ST19_down setup
  st19_down = setupCsv("CB11.PC05.22_ CB11.06.ST19 Down.txt");
  st19_down_time = setupCsvTime("CB11.PC05.22_ CB11.06.ST19 Down.txt");
}

void backend_draw() {
  // draw the show all button
  rect(width*0.1 , height*0.82, boxSize, boxSize);
  
  stroke(59, 82, 255);
  // Draw the name & box
  rect(cr07_in_x, cr07_in_y, boxSize, boxSize);
  rect(cr07_out_x, cr07_out_y, boxSize, boxSize);
  rect(cr09_in_x, cr09_in_y, boxSize, boxSize);
  rect(cr09_out_x, cr09_out_y, boxSize, boxSize);
  rect(st18_up_x, st18_up_y, boxSize, boxSize);
  rect(st18_down_x, st18_down_y, boxSize, boxSize);
  rect(st19_up_x, st19_up_y, boxSize, boxSize);
  rect(st19_down_x, st19_down_y, boxSize, boxSize);
  
  wrteZoneName(" CORRIDOR 07 IN", cr07_in_x + boxSize * 1.5, cr07_in_y + boxSize * 0.6);
  wrteZoneName(" CORRIDOR 07 OUT", cr07_out_x + boxSize * 1.5, cr07_out_y + boxSize * 0.6);
  
  wrteZoneName(" CORRIDOR 09 IN", cr09_in_x + boxSize * 1.5, cr09_in_y + boxSize * 0.6);
  wrteZoneName(" CORRIDOR 09 OUT", cr09_out_x + boxSize * 1.5, cr09_out_y + boxSize * 0.6);
  
  wrteZoneName(" STAIR 18 UP", st18_up_x + boxSize * 1.5, st18_up_y + boxSize * 0.6);
  wrteZoneName(" STAIR 18 DOWN", st18_down_x + boxSize * 1.5, st18_down_y + boxSize * 0.6);

  wrteZoneName(" STAIR 19 UP", st19_up_x + boxSize * 1.5, st19_up_y + boxSize * 0.6);
  wrteZoneName(" STAIR 19 DOWN", st19_down_x + boxSize * 1.5, st19_down_y + boxSize * 0.6);

  wrteZoneName(" SHOW ALL", width*0.1 + boxSize * 1.5, height*0.82 + boxSize * 0.6);
}

void show_graph() {
  if (clicked % 2 == 1) {
    image(graph, width * 0.2, height/2);
  }
}

void wrteZoneName(String zone, float xpos, float ypos) {
  fill(0);
  textFont(font);
  textSize(17);
  text(zone, xpos, ypos);
}

int[] setupCsv(String fileName) {
  
  int[] result;
  String[] lines = loadStrings(fileName);

  // How long is the dataset
  result = new int[lines.length];
  
  for (int i=0; i<lines.length; i++) {
    // Frst split each line using commas as separator
    String[] pieces = split(lines[i], ",");

    // get the closing price of stock, and month
    result[i] = int(pieces[1]);
  }
  println(fileName + " Data Loaded: " + result.length + " entries.");
  
  return result;
  
}

String[] setupCsvTime(String fileName) {
  
  String[] result;
  String[] lines = loadStrings(fileName);

  // How long is the dataset
  result = new String[lines.length];
  
  for (int i=0; i<lines.length; i++) {
    // Frst split each line using commas as separator
    String[] pieces = split(lines[i], ",");

    // get the closing price of stock, and month
    result[i] = pieces[0];
  }
  println(fileName + " Data Loaded: " + result.length + " entries.");
  
  return result;
  
}


void drawCircle_cr07(int num) {
  int colour = color(0);
  
  if (num > 0 && 2 > num) {
    colour = color(142, 194, 85);
  } else if (num > 1 && 4 > num) {
    colour = color(252, 186, 3);
  } else if (num > 3 && 7 > num) {
    colour = color(252, 136, 3);
  } else if (num > 6 && 9 > num) {
    colour = color(252, 111, 3);
  } else if (num > 8 && 11 > num) {
    colour = color(252, 53, 3);
  } else {
    colour = color(204, 12, 12);
  }
  
  pushMatrix();
  for (int i = 0; i < num; i++) {
    fill(colour);
    noStroke();
    ellipse(random(530, 570),random(430,460), 7, 7);
    }
    popMatrix();
  }
  
  void drawCircle_cr09(int num) {
  int colour = color(0);
  
  if (num > 0 && 3 > num) {
    colour = color(142, 194, 85);
  } else if (num > 2 && 6 > num) {
    colour = color(252, 186, 3);
  } else if (num > 5 && 10 > num) {
    colour = color(252, 136, 3);
  } else if (num > 9) {
    colour = color(252, 111, 3);
  }
  
  pushMatrix();
  for (int i = 0; i < num; i++) {
    fill(colour);
    noStroke();
    ellipse(random(510, 550),random(385, 400), 7, 7);
    }
    popMatrix();
  }
  
void drawCircle_st18(int num) {
  int colour = color(0);
  
  if (num > 0 && 3 > num) {
    colour = color(142, 194, 85);
  } else if (num > 2 && 6 > num) {
    colour = color(252, 186, 3);
  } else if (num > 5 && 10 > num) {
    colour = color(252, 136, 3);
  } else if (num > 9) {
    colour = color(252, 111, 3);
  }
  
  pushMatrix();
  for (int i = 0; i < num; i++) {
    fill(colour);
    noStroke();
    ellipse(random(st19_up_circle_x-boxSize, st19_up_circle_x+boxSize*2),random(st19_up_circle_y-boxSize, st19_up_circle_y+boxSize*3), 7, 7);
    }
    popMatrix();
  }
  
void drawCircle_st19(int num) {
  int colour = color(0);
  
  if (num > 0 && 3 > num) {
    colour = color(142, 194, 85);
  } else if (num > 2 && 6 > num) {
    colour = color(252, 186, 3);
  } else if (num > 5 && 10 > num) {
    colour = color(252, 136, 3);
  } else if (num > 9) {
    colour = color(252, 111, 3);
  }
  
  pushMatrix();
  for (int i = 0; i < num; i++) {
    fill(colour);
    noStroke();
    ellipse(random(st19_up_circle_x-boxSize, st19_up_circle_x+boxSize*2),random(st19_up_circle_y-boxSize, st19_up_circle_y+boxSize*3), 7, 7);
    }
    popMatrix();
  }
  
  


void display_cr07_in(float xpos, float ypos, int[] data, String[] time) {
  if ((fingerPos.x > xpos-boxSize && fingerPos.x < xpos+boxSize && 
        fingerPos.y > ypos-boxSize && fingerPos.y < ypos+boxSize) 
        ||(mouseX > xpos-boxSize && mouseX < xpos+boxSize && 
      mouseY > ypos-boxSize && mouseY < ypos+boxSize)) {
    //cr17_overBox = true;  
    //index = 0;
    wrteZoneName("CORRIDOR 07 IN", width*0.835, height*0.32);
   
        
        if (index1 == data.length) {
          index1 = 0;
        }
    

    drawCircle_cr07(data[index1]);
    wrteZoneName("Date/Time: \n"+time[index1], width*0.82, height*0.43);
    wrteZoneName("Number of People: "+data[index1], width*0.82, height * 0.5);

    delay(300);
    index1++;

    if(!cr07_overBox) { 
      stroke(255); 
      fill(255, 236, 150);
      rect(cr07_in_x, cr07_in_y, boxSize, boxSize);
  
      stroke(252, 186, 3);
      strokeWeight(4);
      noFill();
      rect(st19_up_x, st19_up_y, boxSize, boxSize);
  
    }
  } else {
    stroke(252, 186, 3);
    strokeWeight(4);
    noFill();
    //index1 = 0;
  }
}

void display_cr07_out(float xpos, float ypos, int[] data, String[] time) {
  if ((fingerPos.x > xpos-boxSize && fingerPos.x < xpos+boxSize && 
        fingerPos.y > ypos-boxSize && fingerPos.y < ypos+boxSize) 
        ||(mouseX > xpos-boxSize && mouseX < xpos+boxSize && 
      mouseY > ypos-boxSize && mouseY < ypos+boxSize)) {
    //index = 0;    
    wrteZoneName("CORRIDOR 07 OUT", width*0.825, height*0.32);
    
        index2++;
        if (index2 == data.length) {
          index2 = 0;
        }
    
    drawCircle_cr07(data[index2]);
    wrteZoneName("Date/Time: \n"+time[index2], width*0.82, height*0.43);
    wrteZoneName("Number of People: "+data[index2], width*0.82, height * 0.5);

    //graph = loadImage("AAPL2010V4_2.tif");
    //image(graph, width * 0.8, height*0.55);
    delay(300);
    

    if(!cr07_out_overBox) { 
      stroke(255); 
      fill(255, 236, 150);
      rect(cr07_out_x, cr07_out_y, boxSize, boxSize);
  
      stroke(252, 186, 3);
      strokeWeight(4);
      noFill();
      
    }
  } else {
    stroke(252, 186, 3);
    strokeWeight(4);
    noFill();
    //overBox = false;
    //index2 = 0;
  }
}

void display_cr09_in(float xpos, float ypos, int[] data, String[] time) {
  if ((fingerPos.x > xpos-boxSize && fingerPos.x < xpos+boxSize && 
        fingerPos.y > ypos-boxSize && fingerPos.y < ypos+boxSize) 
        ||(mouseX > xpos-boxSize && mouseX < xpos+boxSize && 
      mouseY > ypos-boxSize && mouseY < ypos+boxSize)) {
    
    //index = 0;
    wrteZoneName("CORRIDOR 09 IN", width*0.835, height*0.32);
    
    if(frameCount % int(3) == 0) {
        index3++;
        if (index3 == data.length) {
          index3 = 0;
        }
    }
    
    drawCircle_cr09(data[index3]);
    wrteZoneName("Date/Time: \n"+time[index3], width*0.82, height*0.43);
    wrteZoneName("Number of People: "+data[index3], width*0.82, height * 0.5);
    delay(300);
    

    if(!cr09_overBox) { 
      stroke(255); 
      fill(255, 236, 150);
      rect(cr09_in_x, cr09_in_y, boxSize, boxSize);
  
      stroke(252, 186, 3);
      strokeWeight(4);
      noFill();
  
    }
  } else {
    stroke(252, 186, 3);
    strokeWeight(4);
    noFill();
    //index = 0;
  }
}

void display_cr09_out(float xpos, float ypos, int[] data, String[] time) {
  if ((fingerPos.x > xpos-boxSize && fingerPos.x < xpos+boxSize && 
        fingerPos.y > ypos-boxSize && fingerPos.y < ypos+boxSize) 
        ||(mouseX > xpos-boxSize && mouseX < xpos+boxSize && 
      mouseY > ypos-boxSize && mouseY < ypos+boxSize)) {
    //index = 0;    
    wrteZoneName("CORRIDOR 09 OUT", width*0.825, height*0.32);
    
    if(frameCount % int(3) == 0) {
        index4++;
        if (index4 == data.length) {
          index4 = 0;
        }
    }
    
    drawCircle_cr09(data[index4]);
    wrteZoneName("Date/Time: \n"+time[index4], width*0.82, height*0.43);
    wrteZoneName("Number of People: "+data[index4], width*0.82, height * 0.5);
    delay(300);
    

    if(!cr09_out_overBox) { 
      stroke(255); 
      fill(255, 236, 150);
      rect(cr09_out_x, cr09_out_y, boxSize, boxSize);
  
      stroke(252, 186, 3);
      strokeWeight(4);
      noFill();
      
    }
  } else {
    stroke(252, 186, 3);
    strokeWeight(4);
    noFill();
    //overBox = false;
    //index4 = 0;
  }
}

void display_st18_up(float xpos, float ypos, int[] data, String[] time) {
  if ((fingerPos.x > xpos-boxSize && fingerPos.x < xpos+boxSize && 
        fingerPos.y > ypos-boxSize && fingerPos.y < ypos+boxSize) 
        ||(mouseX > xpos-boxSize && mouseX < xpos+boxSize && 
      mouseY > ypos-boxSize && mouseY < ypos+boxSize)) {
    //index = 0;
    wrteZoneName("STAIR 18 UP", width*0.845, height*0.32);
    
    if(frameCount % int(3) == 0) {
        index5++;
        if (index5 == data.length) {
          index5 = 0;
        }
    }
    
    drawCircle_st18(data[index5]);
    wrteZoneName("Date/Time: \n"+time[index5], width*0.82, height*0.43);
    wrteZoneName("Number of People: "+data[index5], width*0.82, height * 0.5);
    delay(300);
    

    if(!st18_up_overBox) { 
      stroke(255); 
      fill(255, 236, 150);
      rect(st18_up_x, st18_up_y, boxSize, boxSize);
  
      stroke(252, 186, 3);
      strokeWeight(4);
      noFill();
      
    }
  } else {
    stroke(252, 186, 3);
    strokeWeight(4);
    noFill();
    index5 = 0;
  }
}

void display_st18_down(float xpos, float ypos, int[] data, String[] time) {
  if ((fingerPos.x > xpos-boxSize && fingerPos.x < xpos+boxSize && 
        fingerPos.y > ypos-boxSize && fingerPos.y < ypos+boxSize) 
        ||(mouseX > xpos-boxSize && mouseX < xpos+boxSize && 
      mouseY > ypos-boxSize && mouseY < ypos+boxSize)) {
    //index = 0;
    wrteZoneName("STAIR 18 DOWN", width*0.835, height*0.32);
    
    if(frameCount % int(3) == 0) {
        index6++;
        if (index6 == data.length) {
          index6 = 0;
        }
    }
    
    drawCircle_st18(data[index6]);
    wrteZoneName("Date/Time: \n"+time[index6], width*0.82, height*0.43);
    wrteZoneName("Number of People: "+data[index6], width*0.82, height * 0.5);
    delay(300);
    

    if(!st18_down_overBox) { 
      stroke(255); 
      fill(255, 236, 150);
      rect(st18_down_x, st18_down_y, boxSize, boxSize);
  
      stroke(252, 186, 3);
      strokeWeight(4);
      noFill();
      
    }
  } else {
    stroke(252, 186, 3);
    strokeWeight(4);
    noFill();
    //index6 = 0;
  }
}

void display_st19_up(float xpos, float ypos, int[] data, String[] time) {
  if ((fingerPos.x > xpos-boxSize && fingerPos.x < xpos+boxSize && 
        fingerPos.y > ypos-boxSize && fingerPos.y < ypos+boxSize) 
        ||(mouseX > xpos-boxSize && mouseX < xpos+boxSize && 
      mouseY > ypos-boxSize && mouseY < ypos+boxSize)) {
    //index = 0;
    wrteZoneName("STAIR 19 UP", width*0.845, height*0.32);
    
    if(frameCount % int(3) == 0) {
        index7++;
        if (index7 == data.length) {
          index7 = 0;
        }
    }
    
    drawCircle_st19(data[index7]);
    wrteZoneName("Date/Time: \n"+time[index7], width*0.82, height*0.43);
    wrteZoneName("Number of People: "+data[index7], width*0.82, height * 0.5);
    delay(300);
    

    if(!st19_up_overBox) { 
      stroke(255); 
      fill(255, 236, 150);
      rect(st19_up_x, st19_up_y, boxSize, boxSize);
  
      stroke(252, 186, 3);
      strokeWeight(4);
      noFill();
      
    }
  } else {
    stroke(252, 186, 3);
    strokeWeight(4);
    noFill();
    //index7 = 0;
  }
}

void display_st19_down(float xpos, float ypos, int[] data, String[] time) {
  if ((fingerPos.x > xpos-boxSize && fingerPos.x < xpos+boxSize && 
        fingerPos.y > ypos-boxSize && fingerPos.y < ypos+boxSize) 
        ||(mouseX > xpos-boxSize && mouseX < xpos+boxSize && 
      mouseY > ypos-boxSize && mouseY < ypos+boxSize)) {
    //index = 0;
    wrteZoneName("STAIR 19 DOWN", width*0.835, height*0.32);
    
    if(frameCount % int(3) == 0) {
        index8++;
        if (index8 == data.length) {
          index8 = 0;
        }
    }
    
    drawCircle_st19(data[index8]);
    wrteZoneName("Date/Time: \n"+time[index8], width*0.82, height*0.43);
    wrteZoneName("Number of People: "+data[index8], width*0.82, height * 0.5);
    delay(300);
    

    if(!st19_down_overBox) { 
      stroke(255); 
      fill(255, 236, 150);
      rect(st19_down_x, st19_down_y, boxSize, boxSize);
  
      stroke(252, 186, 3);
      strokeWeight(4);
      noFill();
      
     
      
    }
  } else {
    stroke(252, 186, 3);
    strokeWeight(4);
    noFill();
    //index8 = 0;
  }
}

void mouseClicked() {
  //cr07_in_x, cr07_in_y
  if (mouseX > cr07_in_x-boxSize && mouseX < cr07_in_x+boxSize && 
      mouseY > cr07_in_y-boxSize && mouseY < cr07_in_y+boxSize) {
      clicked++;
  } 
}

void showAll() {
 index1 = 0;
 if(frameCount % int(3) == 0) {
        index1++;
      }
  if (mouseX > width*0.1-boxSize && mouseX < width*0.1+boxSize && 
      mouseY > height*0.82-boxSize && mouseY < height*0.82+boxSize) {
        fill(255, 236, 150);
        rect(width*0.1, height*0.82, boxSize, boxSize);
        
         drawCircle_st18(st18_up[index1]);
         drawCircle_st18(st18_down[index1]);
         drawCircle_st19(st19_up[index1]);
         drawCircle_st19(st19_down[index1]);
         drawCircle_cr07(cr07_in[index1]);
         drawCircle_cr07(cr07_out[index1]);
         drawCircle_cr09(cr09_in[index1]);
         drawCircle_cr09(cr09_out[index1]);
         delay(300);
      }
}
