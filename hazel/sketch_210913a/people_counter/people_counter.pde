import de.voidplus.leapmotion.*;
import processing.sound.*;

LeapMotion leap; 

// variable tracking the finger position with leap motion controller
PVector fingerPos = new PVector(0,0);

// arrays for people counter data
int cr07_in[], cr07_out[],
    cr09_in[], cr09_out[], 
    st18_up[], st18_down[], 
    st19_up[], st19_down[];
    
String cr07_in_time[], cr07_out_time[], 
    cr09_in_time[], cr09_out_time[], 
    st18_up_time[], st18_down_time[], 
    st19_up_time[], st19_down_time[];

int index[] = {0, 0, 0, 0, 0, 0, 0, 0, 0};

boolean cr07_in_click = false;
boolean cr07_out_click = false;
boolean cr09_in_click = false;
boolean cr09_out_click = false;
boolean st18_up_click = false;
boolean st18_down_click = false;
boolean st19_up_click = false;
boolean st19_down_click = false;
boolean info_click = false;
boolean all_clicked = false;
boolean showAll = false;
boolean dark_mode = false;

PImage img, bg, bg_dark, graph, info, info_des, details;

SoundFile click, bgm, crowd, alert;

int boxSize = 9;

////////////////////////////

/* CR07 variables */

float cr07_in_x, cr07_in_y;
boolean cr07_overBox = false;
float cr07_circle_x, cr07_circle_y; 


float cr07_out_x, cr07_out_y;
boolean cr07_out_overBox = false;
float cr07_out_circle_x, cr07_out_circle_y;


////////////////////////////

/* CR09 variables */

float cr09_in_x, cr09_in_y;
boolean cr09_overBox = false;
float cr09_circle_x, cr09_circle_y; 


float cr09_out_x, cr09_out_y;
boolean cr09_out_overBox = false;
float cr09_out_circle_x, cr09_out_circle_y;

////////////////////////////

/* ST18 variables */

float st18_up_x, st18_up_y;
boolean st18_up_overBox = false;
float st18_up_circle_x, st18_up_circle_y; 


float st18_down_x, st18_down_y;
boolean st18_down_overBox = false;
float st18_down_circle_x, st18_down_circle_y; 


////////////////////////////

/* ST19 variables */

float st19_up_x, st19_up_y;
boolean st19_up_overBox = false;
float st19_up_circle_x, st19_up_circle_y; 


float st19_down_x, st19_down_y;
boolean st19_down_overBox = false;
float st19_down_circle_x, st19_down_circle_y; 

PFont font;

void setup() {
  size(1200, 790);
  leap = new LeapMotion(this);
  backend_setup(); 
  
  //sound setup
  bgm.play();
  bgm.loop(); //add feature: play/stop button
  bgm.amp(0.01);
  click.amp(2);
  crowd.play();
  crowd.amp(0.05);
  crowd.loop();
  alert.amp(0.7);
 
}

void draw() { 
  background(255);
  
  if (!dark_mode) {
    image(bg, 0, 0);
  } else {
    image(bg_dark, 0, 0);
  }
  
  //generate the people counter circles
  display();
  backend_draw();
  
  //track and show the finger position using the leap motion sensor
  fingerPosition();
}


// track the index finger position
void fingerPosition() {
  for (Hand hand : leap.getHands()) {
    Finger fingerIndex = hand.getIndexFinger();
    PVector indexFingerPosition   = fingerIndex.getPosition();
    fingerPos.x = indexFingerPosition.x;
    fingerPos.y = indexFingerPosition.y;
    
    //draw the pointer on the finger's x & coordinates
    fill(252, 53, 3);
    noStroke();
    ellipse(indexFingerPosition.x, indexFingerPosition.y, 10, 10);
  }
}


//draw the circles according to the people counter data
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
  
  //show the info button
  info();
}


//initial file loadings
void backend_setup() {
  //loading
  font = createFont("Arial.ttf", 128);
  textFont(font);
  
  //loading sound files
  click = new SoundFile(this, "click.mp3");
  bgm = new SoundFile(this, "bgm.mp3");
  crowd = new SoundFile(this, "noise.mp3");
  alert = new SoundFile(this, "alert.mp3");
  
  //loading image files
  bg = loadImage("bg1.png");
  bg_dark = loadImage("bg_2.png");
  info = loadImage("info.png");
  info_des = loadImage("info_des.png");
  details = loadImage("details_2.png");
  
  //name & box pos setup 
  cr07_in_x = width * 0.6;
  cr07_in_y = height * 0.88;
  
  cr07_out_x = width * 0.6;
  cr07_out_y = height * 0.93;
  
  cr09_in_x = width * 0.8;
  cr09_in_y = height * 0.88;
  
  cr09_out_x = width * 0.8;
  cr09_out_y = height * 0.93;
  
  st18_up_x = width * 0.25;
  st18_up_y = height * 0.88;
  
  st18_down_x = width * 0.25;
  st18_down_y = height * 0.93;
  
  st19_up_x = width * 0.43;
  st19_up_y = height * 0.88;
  
  st19_down_x = width * 0.43;
  st19_down_y = height * 0.93;
  
  rectMode(RADIUS); 
  
  //circle zone setup 
  st19_up_circle_x = width * 0.64;
  st19_up_circle_y = height * 0.55;
  
  
  //csv setup
  
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
  //draw the show all button
  stroke(255, 145, 43);
  rect(width*0.1 , height*0.9, boxSize, boxSize);
  
  //dark mode
  rect(width*0.1 , height*0.3, boxSize, boxSize);
  
  //draw the info button
  image(info, width*0.95, height*0.22);
  
  stroke(252, 186, 3); //59, 82, 255); <- blue
  
  //draw the name & box
  rect(cr07_in_x, cr07_in_y, boxSize, boxSize);
  rect(cr07_out_x, cr07_out_y, boxSize, boxSize);
  rect(cr09_in_x, cr09_in_y, boxSize, boxSize);
  rect(cr09_out_x, cr09_out_y, boxSize, boxSize);
  rect(st18_up_x, st18_up_y, boxSize, boxSize);
  rect(st18_down_x, st18_down_y, boxSize, boxSize);
  rect(st19_up_x, st19_up_y, boxSize, boxSize);
  rect(st19_down_x, st19_down_y, boxSize, boxSize);
  
  //write the name for each zone
  wrteZoneName(" CORRIDOR 07 IN", cr07_in_x + boxSize * 1.5, cr07_in_y + boxSize * 0.6);
  wrteZoneName(" CORRIDOR 07 OUT", cr07_out_x + boxSize * 1.5, cr07_out_y + boxSize * 0.6);
  
  wrteZoneName(" CORRIDOR 09 IN", cr09_in_x + boxSize * 1.5, cr09_in_y + boxSize * 0.6);
  wrteZoneName(" CORRIDOR 09 OUT", cr09_out_x + boxSize * 1.5, cr09_out_y + boxSize * 0.6);
  
  wrteZoneName(" STAIR 18 UP", st18_up_x + boxSize * 1.5, st18_up_y + boxSize * 0.6);
  wrteZoneName(" STAIR 18 DOWN", st18_down_x + boxSize * 1.5, st18_down_y + boxSize * 0.6);

  wrteZoneName(" STAIR 19 UP", st19_up_x + boxSize * 1.5, st19_up_y + boxSize * 0.6);
  wrteZoneName(" STAIR 19 DOWN", st19_down_x + boxSize * 1.5, st19_down_y + boxSize * 0.6);

  wrteZoneName(" SHOW ALL", width*0.1 + boxSize * 1.5, height*0.9 + boxSize * 0.6);
}

//function to write string to the sketch
void wrteZoneName(String zone, float xpos, float ypos) {
  if(!dark_mode) {
    fill(120);
  } else {
    fill(200);
  }
  
  textFont(font);
  textSize(17);
  text(zone, xpos, ypos);
}

//load the csv files and save it to the arrays (people counting numbers data)
int[] setupCsv(String fileName) {
  int[] result;
  String[] lines = loadStrings(fileName);

  result = new int[lines.length];
  
  for (int i=0; i<lines.length; i++) {
    String[] pieces = split(lines[i], ",");
    result[i] = int(pieces[1]);
  }
  println(fileName + " Data Loaded: " + result.length + " entries.");
  return result;
}

//load the csv files and save it to the arrays (recorded time data)
String[] setupCsvTime(String fileName) {
  
  String[] result;
  String[] lines = loadStrings(fileName);

  result = new String[lines.length];
  
  for (int i=0; i<lines.length; i++) {
    String[] pieces = split(lines[i], ",");
    result[i] = pieces[0];
  }
  println(fileName + " Data Loaded: " + result.length + " entries.");
  return result;
  
}

//draw the circle in the zone CR07
void drawCircle_cr07(int num) {
  int colour = color(0);
  
  //colour code for each number range
  if (num > 0 && 3 > num) {
    colour = color(142, 194, 85);
    crowd.amp(0.1);
  } else if (num > 2 && 6 > num) {
    colour = color(250, 204, 0);
    crowd.amp(0.2);
  } else if (num > 5 && 9 > num) {
    colour = color(250, 125, 0);
    crowd.amp(0.6);
  } else {
    colour = color(204, 12, 12);
    crowd.amp(1);
  }

  pushMatrix();
  for (int i = 0; i < num; i++) {
    fill(colour);
    noStroke();
    ellipse(random(660, 700),random(420,450), 7, 7);
    }
  popMatrix();
  
  //plays alert sount when people count exceeds 8
  if (num > 8) {
    alert.play();
  }
  
}

  
//draw the circle in the zone CR09
void drawCircle_cr09(int num) {
  int colour = color(0);
  
  //colour code for each number range
  if (num > 0 && 3 > num) {
    colour = color(142, 194, 85);
    crowd.amp(0.1);
  } else if (num > 2 && 6 > num) {
    colour = color(250, 204, 0);
    crowd.amp(0.2);
  } else if (num > 5 && 9 > num) {
    colour = color(250, 125, 0);
    crowd.amp(0.6);
  } else {
    colour = color(204, 12, 12);
    crowd.amp(1);
  }
  
  pushMatrix();
  for (int i = 0; i < num; i++) {
    fill(colour);
    noStroke();
    ellipse(random(675, 715),random(460, 500), 7, 7);
  }
  popMatrix();
  
  //plays alert sount when people count exceeds 8
  if (num > 8) {
    alert.play();
  }
}

//draw the circle in the zone ST18
void drawCircle_st18(int num) {
  int colour = color(0);
  
  //colour code for each number range
  if (num > 0 && 3 > num) {
    colour = color(142, 194, 85);
    crowd.amp(0.1);
  } else if (num > 2 && 6 > num) {
    colour = color(250, 204, 0);
    crowd.amp(0.2);
  } else if (num > 5 && 9 > num) {
    colour = color(250, 125, 0);
    crowd.amp(0.6);
  } else {
    colour = color(204, 12, 12);
    crowd.amp(1);
  }
  
  pushMatrix();
  for (int i = 0; i < num; i++) {
    fill(colour);
    noStroke();
    ellipse(random(st19_up_circle_x-boxSize, st19_up_circle_x+boxSize*2),random(st19_up_circle_y-boxSize, st19_up_circle_y+boxSize*3), 7, 7);
  }
  popMatrix();
    
  //plays alert sount when people count exceeds 8
  if (num > 8) {
    alert.play();
  }
}

//draw the circle in the zone ST19
void drawCircle_st19(int num) {
  int colour = color(0);
  
  //colour code for each number range
  if (num > 0 && 3 > num) {
    colour = color(142, 194, 85);
    crowd.amp(0.1);
  } else if (num > 2 && 6 > num) {
    colour = color(250, 204, 0);
    crowd.amp(0.2);
  } else if (num > 5 && 9 > num) {
    colour = color(250, 125, 0);
    crowd.amp(0.6);
  } else {
    colour = color(204, 12, 12);
    crowd.amp(1);
  }
  
  pushMatrix();
  for (int i = 0; i < num; i++) {
    fill(colour);
    noStroke();
    ellipse(random(st19_up_circle_x-boxSize, st19_up_circle_x+boxSize*2),random(st19_up_circle_y-boxSize, st19_up_circle_y+boxSize*3), 7, 7);
  }
  popMatrix();

  //plays alert sount when people count exceeds 8
  if (num > 8) {
    alert.play();
  }
}
  
//display description when info button is clicked
void info() {
  if (info_click) {
    image(info_des, width * 0.7, height * 0.22);
  }
}

void display_cr07_in(float xpos, float ypos, int[] data, String[] time) {
  if ((fingerPos.x > xpos-boxSize && fingerPos.x < xpos+boxSize && 
        fingerPos.y > ypos-boxSize && fingerPos.y < ypos+boxSize) 
        ||(mouseX > xpos-boxSize && mouseX < xpos+boxSize && 
      mouseY > ypos-boxSize && mouseY < ypos+boxSize) || (cr07_in_click)) {
    //wrteZoneName("CORRIDOR 07 IN", width*0.82, height*0.32);
    
        if(frameCount % int(3) == 0) {
        index[1]++;
            if (index[1] == data.length) {
              index[1] = 0;
            }
        }
    

    noFill();
    stroke(255);
    strokeWeight(2);
    ellipse(680, 430, 70, 70);
    
    drawCircle_cr07(data[index[1]]);
    
    image(details, 0, height*0.72);
    fill(255);
    text(time[index[1]], width*0.01, height*0.76);
    text("Number of People: "+data[index[1]], width*0.01, height * 0.79);

    //graph = loadImage("AAPL2010V4_2.tif");
    //image(graph, width * 0.8, height*0.55);

    delay(300);
    index[1]++;

    if(!cr07_overBox) { 
      if(!st19_down_overBox) { 
        if(!dark_mode) {
          fill(0);
        } else {
          fill(255);
      }
      text(" CORRIDOR 07 IN", cr07_in_x + boxSize * 1.5, cr07_in_y + boxSize * 0.6);
      stroke(59, 82, 255);
      fill(255, 236, 150);
      rect(cr07_in_x, cr07_in_y, boxSize, boxSize);
    }
  } else {
    stroke(252, 186, 3);
    strokeWeight(4);
    noFill();
    //overBox = false;
    //index1 = 0;

  }

}
}


void display_cr07_out(float xpos, float ypos, int[] data, String[] time) {
  if ((fingerPos.x > xpos-boxSize && fingerPos.x < xpos+boxSize && 
        fingerPos.y > ypos-boxSize && fingerPos.y < ypos+boxSize) 
        ||(mouseX > xpos-boxSize && mouseX < xpos+boxSize && 
      mouseY > ypos-boxSize && mouseY < ypos+boxSize)|| (cr07_out_click)) {
    //index = 0;    
    //wrteZoneName("CORRIDOR 07 OUT", width*0.825, height*0.32);
    
        if(frameCount % int(3) == 0) {
        index[2]++;
        if (index[2] == data.length) {
          index[2] = 0;
        }
    }

        
    noFill();
    stroke(255);
    strokeWeight(2);
    ellipse(680, 430, 70, 70);
    
    drawCircle_cr07(data[index[2]]);
    
    image(details, 0, height*0.72);
    fill(255);
    text(time[index[2]], width*0.01, height*0.76);
    text("Number of People: "+data[index[2]], width*0.01, height * 0.79);


    //graph = loadImage("AAPL2010V4_2.tif");
    //image(graph, width * 0.8, height*0.55);
    delay(300);
    

    if(!cr07_out_overBox) { 
      if(!st19_down_overBox) { 
        if(!dark_mode) {
          fill(0);
        } else {
          fill(255);
      }
      text(" CORRIDOR 07 OUT", cr07_out_x + boxSize * 1.5, cr07_out_y + boxSize * 0.6);
      stroke(255); 
      fill(255, 236, 150);
      rect(cr07_out_x, cr07_out_y, boxSize, boxSize);
    }
  } else {
    stroke(252, 186, 3);
    strokeWeight(4);
    noFill();
    //overBox = false;
    //index2 = 0;
  }
}
}

void display_cr09_in(float xpos, float ypos, int[] data, String[] time) {
  if ((fingerPos.x > xpos-boxSize && fingerPos.x < xpos+boxSize && 
        fingerPos.y > ypos-boxSize && fingerPos.y < ypos+boxSize) 
        ||(mouseX > xpos-boxSize && mouseX < xpos+boxSize && 
      mouseY > ypos-boxSize && mouseY < ypos+boxSize) || (cr09_in_click)) {
    
    //index = 0;
    //wrteZoneName("CORRIDOR 09 IN", width*0.835, height*0.32);
    
    if(frameCount % int(3) == 0) {
        index[3]++;
        if (index[3] == data.length) {
          index[3] = 0;
        }
    }
    

    noFill();
    stroke(255);
    strokeWeight(2);
    ellipse(695, 485, 70, 70); 
    
    drawCircle_cr09(data[index[3]]);
    
    image(details, 0, height*0.72);
    fill(255);
    text(time[index[3]], width*0.01, height*0.76);
    text("Number of People: "+data[index[3]], width*0.01, height * 0.79);

    delay(300);
    

    if(!cr09_overBox) { 
      if(!st19_down_overBox) { 
        if(!dark_mode) {
          fill(0);
        } else {
          fill(255);
      }
      text(" CORRIDOR 09 IN", cr09_in_x + boxSize * 1.5, cr09_in_y + boxSize * 0.6);
      stroke(255); 
      fill(255, 236, 150);
      rect(cr09_in_x, cr09_in_y, boxSize, boxSize);
    }
  } else {
    stroke(252, 186, 3);
    strokeWeight(4);
    noFill();
    //index = 0;
  }
}
}

void display_cr09_out(float xpos, float ypos, int[] data, String[] time) {
  if ((fingerPos.x > xpos-boxSize && fingerPos.x < xpos+boxSize && 
        fingerPos.y > ypos-boxSize && fingerPos.y < ypos+boxSize) 
        ||(mouseX > xpos-boxSize && mouseX < xpos+boxSize && 
      mouseY > ypos-boxSize && mouseY < ypos+boxSize) || (cr09_out_click)) {
    //index = 0;    
    //wrteZoneName("CORRIDOR 09 OUT", width*0.825, height*0.32);
    
    if(frameCount % int(3) == 0) {
        index[4]++;
        if (index[4] == data.length) {
          index[4] = 0;
        }
    }
    

    noFill();
    stroke(255);
    strokeWeight(2);
    ellipse(695, 485, 70, 70);
    
    drawCircle_cr09(data[index[4]]);
    
    image(details, 0, height*0.72);
    fill(255);
    text(time[index[4]], width*0.01, height*0.76);
    text("Number of People: "+data[index[4]], width*0.01, height * 0.79);

    delay(300);
    

    if(!cr09_out_overBox) {
      if(!st19_down_overBox) { 
        if(!dark_mode) {
          fill(0);
        } else {
          fill(255);
      }
      text(" CORRIDOR 09 OUT", cr09_out_x + boxSize * 1.5, cr09_out_y + boxSize * 0.6);
      stroke(255); 
      fill(255, 236, 150);
      rect(cr09_out_x, cr09_out_y, boxSize, boxSize);
    }
  } else {
    stroke(252, 186, 3);
    strokeWeight(4);
    noFill();
    //overBox = false;
    //index4 = 0;
  }
}
}

void display_st18_up(float xpos, float ypos, int[] data, String[] time) {
  if ((fingerPos.x > xpos-boxSize && fingerPos.x < xpos+boxSize && 
        fingerPos.y > ypos-boxSize && fingerPos.y < ypos+boxSize) 
        ||(mouseX > xpos-boxSize && mouseX < xpos+boxSize && 
      mouseY > ypos-boxSize && mouseY < ypos+boxSize) || (st18_up_click)) {
    //index = 0;
    //wrteZoneName("STAIR 18 UP", width*0.845, height*0.32);
    
    if(frameCount % int(3) == 0) {
        index[5]++;
        if (index[5] == data.length) {
          index[5] = 0;
        }
    }
    

    noFill();
    stroke(255);
    strokeWeight(2);
    ellipse(st19_up_circle_x + 5, st19_up_circle_y + 10, 70, 70);
    
    drawCircle_st18(data[index[5]]);
    
    image(details, 0, height*0.72);
    fill(255);
    text(time[index[5]], width*0.01, height*0.76);
    text("Number of People: "+data[index[5]], width*0.01, height * 0.79);

    delay(300);
    

    if(!st18_up_overBox) { 
      if(!st19_down_overBox) { 
        if(!dark_mode) {
          fill(0);
        } else {
          fill(255);
      }
      text(" STAIR 18 UP", st18_up_x + boxSize * 1.5, st18_up_y + boxSize * 0.6);
      stroke(255); 
      fill(255, 236, 150);
      rect(st18_up_x, st18_up_y, boxSize, boxSize);
    }
  } else {
    stroke(252, 186, 3);
    strokeWeight(4);
    noFill();
    index[5] = 0;
  }
}
}
void display_st18_down(float xpos, float ypos, int[] data, String[] time) {
  if ((fingerPos.x > xpos-boxSize && fingerPos.x < xpos+boxSize && 
        fingerPos.y > ypos-boxSize && fingerPos.y < ypos+boxSize) 
        ||(mouseX > xpos-boxSize && mouseX < xpos+boxSize && 
      mouseY > ypos-boxSize && mouseY < ypos+boxSize) || (st18_down_click)) {
    //index = 0;
    //wrteZoneName("STAIR 18 DOWN", width*0.835, height*0.32);
    
    if(frameCount % int(3) == 0) {
        index[6]++;
        if (index[6] == data.length) {
          index[6] = 0;
        }
    }
    

    noFill();
    stroke(255);
    strokeWeight(2);
    ellipse(st19_up_circle_x + 5, st19_up_circle_y + 10, 70, 70);
    
    drawCircle_st18(data[index[6]]);
    
    image(details, 0, height*0.72);
    fill(255);
    text(time[index[6]], width*0.01, height*0.76);
    text("Number of People: "+data[index[6]], width*0.01, height * 0.79);

    delay(300);
    

    if(!st18_down_overBox) { 
      if(!st19_down_overBox) { 
        if(!dark_mode) {
          fill(0);
        } else {
          fill(255);
      }
      text(" STAIR 18 DOWN", st18_down_x + boxSize * 1.5, st18_down_y + boxSize * 0.6);
      stroke(255); 
      fill(255, 236, 150);
      rect(st18_down_x, st18_down_y, boxSize, boxSize);
    }
  } else {
    stroke(252, 186, 3);
    strokeWeight(4);
    noFill();
    //index6 = 0;
  }
}
}

void display_st19_up(float xpos, float ypos, int[] data, String[] time) {
  if ((fingerPos.x > xpos-boxSize && fingerPos.x < xpos+boxSize && 
        fingerPos.y > ypos-boxSize && fingerPos.y < ypos+boxSize) 
        ||(mouseX > xpos-boxSize && mouseX < xpos+boxSize && 
      mouseY > ypos-boxSize && mouseY < ypos+boxSize) || (st19_up_click)) {
    //index = 0;
   
    //wrteZoneName("STAIR 19 UP", width*0.845, height*0.32);
    
    if(frameCount % int(3) == 0) {
        index[7]++;
        if (index[7] == data.length) {
          index[7] = 0;
        }
    }

    noFill();
    stroke(255);
    strokeWeight(2);
    ellipse(st19_up_circle_x + 5, st19_up_circle_y + 10, 70, 70);
    
    drawCircle_st19(data[index[7]]);
    
    image(details, 0, height*0.72);
    fill(255);
    text(time[index[7]], width*0.01, height*0.76);
    text("Number of People: "+data[index[7]], width*0.01, height * 0.79);

    delay(300);
    

    if(!st19_up_overBox) { 
      if(!st19_down_overBox) { 
        if(!dark_mode) {
          fill(0);
        } else {
          fill(255);
      }
      text(" STAIR 19 UP", st19_up_x + boxSize * 1.5, st19_up_y + boxSize * 0.6);
      stroke(255); 
      fill(255, 236, 150);
      rect(st19_up_x, st19_up_y, boxSize, boxSize);
    }
  } else {
    stroke(252, 186, 3);
    strokeWeight(4);
    noFill();
    //index7 = 0;
  }
}
}
void display_st19_down(float xpos, float ypos, int[] data, String[] time) {
  if ((fingerPos.x > xpos-boxSize && fingerPos.x < xpos+boxSize && 
        fingerPos.y > ypos-boxSize && fingerPos.y < ypos+boxSize) 
        ||(mouseX > xpos-boxSize && mouseX < xpos+boxSize && 
      mouseY > ypos-boxSize && mouseY < ypos+boxSize) || (st19_down_click)) {
    //index = 0;
    //wrteZoneName("STAIR 19 DOWN", width*0.835, height*0.32);
    
    noFill();
    stroke(255);
    strokeWeight(2);
    ellipse(st19_up_circle_x + 5, st19_up_circle_y + 10, 70, 70);
    
    if(frameCount % int(3) == 0) {
        index[8]++;
        if (index[8] == data.length) {
          index[8] = 0;
        }
    }
    
    drawCircle_st19(data[index[8]]);
    
    image(details, 0, height*0.72);
    fill(255);
    text(time[index[8]], width*0.01, height*0.76);
    text("Number of People: "+data[index[8]], width*0.01, height * 0.79);

    delay(300); 

      if(!st19_down_overBox) { 
        if(!dark_mode) {
          fill(0);
        } else {
          fill(255);
      }

      text(" STAIR 19 DOWN", st19_down_x + boxSize * 1.5, st19_down_y + boxSize * 0.6);
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
  click.play();
  //cr07_in_x, cr07_in_y
  if (mouseX > cr07_in_x-boxSize && mouseX < cr07_in_x+boxSize && 
      mouseY > cr07_in_y-boxSize && mouseY < cr07_in_y+boxSize) {
      if (!cr07_in_click) {
        cr07_in_click = true;
        
      } else {
        cr07_in_click = false;
      }
      
  } else if (mouseX > cr07_out_x-boxSize && mouseX < cr07_out_x+boxSize && 
      mouseY > cr07_out_y-boxSize && mouseY < cr07_out_y+boxSize) {
      if (!cr07_out_click) {
        cr07_out_click = true;
        
      } else {
        cr07_out_click = false;
      }
      
  } else if (mouseX > cr09_in_x-boxSize && mouseX < cr09_in_x+boxSize && 
      mouseY > cr09_in_y-boxSize && mouseY < cr09_in_y+boxSize) {
      if (!cr09_in_click) {
        cr09_in_click = true;
        
      } else {
        cr09_in_click = false;
      }
      
  } else if (mouseX > cr09_out_x-boxSize && mouseX < cr09_out_x+boxSize && 
      mouseY > cr09_out_y-boxSize && mouseY < cr09_out_y+boxSize) {
      if (!cr09_out_click) {
        cr09_out_click = true;
        
      } else {
        cr09_out_click = false;
      }
      
  } else if (mouseX > st18_up_x-boxSize && mouseX < st18_up_x+boxSize && 
      mouseY > st18_up_y-boxSize && mouseY < st18_up_y+boxSize) {
      if (!st18_up_click) {
        st18_up_click = true;
        
      } else {
        st18_up_click = false;
      }
      
  } else if (mouseX > st18_down_x-boxSize && mouseX < st18_down_x+boxSize && 
      mouseY > st18_down_y-boxSize && mouseY < st18_down_y+boxSize) {
      if (!st18_down_click) {
        st18_down_click = true;
        
      } else {
        st18_down_click = false;
      }
      
  } else if (mouseX > st19_up_x-boxSize && mouseX < st19_up_x+boxSize && 
      mouseY > st19_up_y-boxSize && mouseY < st19_up_y+boxSize) {
      if (!st19_up_click) {
        st19_up_click = true;
        
      } else {
        st19_up_click = false;
      }
      
  } else if (mouseX > st19_down_x-boxSize && mouseX < st19_down_x+boxSize && 
      mouseY > st19_down_y-boxSize && mouseY < st19_down_y+boxSize) {
      if (!st19_down_click) {
        st19_down_click = true;
        
      } else {
        st19_down_click = false;
      }
  } else if (mouseX > width * 0.95 - 30 && mouseX < width * 0.95 + 30 && 
      mouseY > height * 0.22 - 30 && mouseY < height * 0.22 + 30) {
      if (!info_click) {
        info_click = true;
        
      } else {
        info_click = false;
      }
  } else if (mouseX > width*0.1-boxSize && mouseX < width*0.1+boxSize && 
      mouseY > height*0.9-boxSize && mouseY < height*0.9+boxSize) {
      if (!all_clicked) {
        all_clicked = true;
        
      } else {
        all_clicked = false;
      }
  } else if (mouseX > width*0.1-boxSize && mouseX < width*0.1+boxSize && 
      mouseY > height*0.3-boxSize && mouseY < height*0.3+boxSize) {
      if (!dark_mode) {
        dark_mode = true;
        
      } else {
        dark_mode = false;
      }
  } 
  
}



void showAll() {
  if (index[0] > 100) {
             index[0] = 0;
           }
  if ((mouseX > width*0.1-boxSize && mouseX < width*0.1+boxSize && 
      mouseY > height*0.9-boxSize && mouseY < height*0.9+boxSize) || (all_clicked)) {
        fill(255, 236, 150); //<- yellow
      
        rect(width*0.1, height*0.9, boxSize, boxSize);
        
         drawCircle_st18(st18_up[index[0]]);
         drawCircle_st18(st18_down[index[0]]);
         drawCircle_st19(st19_up[index[0]]);
         drawCircle_st19(st19_down[index[0]]);
         drawCircle_cr07(cr07_in[index[0]]);
         drawCircle_cr07(cr07_out[index[0]]);
         drawCircle_cr09(cr09_in[index[0]]);
         drawCircle_cr09(cr09_out[index[0]]);

          int sum = 0;
          //
          sum = (st18_up[index[0]] + st18_down[index[0]] + st19_up[index[0]] + st19_down[index[0]] 
                + cr07_in[index[0]] + cr07_out[index[0]] + cr09_in[index[0]] + cr09_out[index[0]]) / 8;
          
          image(details, 0, height*0.72);
          fill(255);
          text("Number of People: " + sum * 8, width*0.01, height * 0.77);
          
          crowd.amp(sum*0.25);
          
         noFill();
          stroke(255);
          strokeWeight(2);
          ellipse(695, 485, 70, 70); 
          ellipse(680, 430, 70, 70);
          ellipse(st19_up_circle_x + 5, st19_up_circle_y + 10, 70, 70);
         delay(300);
      }
      index[0]++;
}
