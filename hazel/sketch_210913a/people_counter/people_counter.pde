import de.voidplus.leapmotion.*;
import processing.sound.*;

LeapMotion leap; 

PVector fingerPos = new PVector(0,0);;

PImage info;

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

PImage img, bg, graph, info_des;

SoundFile click, bgm, crowd, alert;

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
  size(1200, 790);
  leap = new LeapMotion(this);
  backend_setup(); 
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
  image(bg, 0, 0);
  
  display();
  backend_draw();
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
  
  info();
}

void backend_setup() {
  font = createFont("Arial.ttf", 128);
  textFont(font);
  click = new SoundFile(this, "click.mp3");
  bgm = new SoundFile(this, "bgm.mp3");
  crowd = new SoundFile(this, "noise.mp3");
  alert = new SoundFile(this, "alert.mp3");
  
  bg = loadImage("bg1.png");
  info = loadImage("info.png");
  info_des = loadImage("info_des.png");
  
  /* name & box pos setup */ 
  
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
  
  /* circle zone setup */
  
  st19_up_circle_x = width * 0.64;
  st19_up_circle_y = height * 0.55;
  
  
  /* csv setup */
  
  // CR07_in setup
  cr07_in = setupCsv("CB11.PC05.23_ CB11.05.CR07 In.txt");
  cr07_in_time = setupCsvTime("CB11.PC05.23_ CB11.05.CR07 In.txt");
  
  for (int i = 0; i < 8; i++) {
    println(cr07_in_time[i] +" "+ cr07_in[i] + "\n");
  }
    
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
  stroke(255, 145, 43);
  rect(width*0.1 , height*0.9, boxSize, boxSize);
  
  // draw the info button
  image(info, width*0.95, height*0.22);
  
  stroke(252, 186, 3); //59, 82, 255); <- blue
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

  wrteZoneName(" SHOW ALL", width*0.1 + boxSize * 1.5, height*0.9 + boxSize * 0.6);

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
    
  //crowd.amp(num*0.2);
  
  if (num > 8) {
    alert.play();
  }
  
}
  
  void drawCircle_cr09(int num) {
  int colour = color(0);
  
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
    
    //crowd.amp(num*0.2);
    
    if (num > 8) {
    alert.play();
  }
  }
  
void drawCircle_st18(int num) {
  int colour = color(0);
  
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
    
    //crowd.amp(num*0.2);
    
    if (num > 8) {
      alert.play();
    }
  }
  
void drawCircle_st19(int num) {
  int colour = color(0);
  
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
    
    //crowd.amp(num*0.2);
    
    if (num > 8) {
    alert.play();
  }
  }
  
  
void info() {
  if /*((fingerPos.x > width * 0.95 - 30 && fingerPos.x < 0.95 + 30 && 
        fingerPos.y > height * 0.22 -30 && fingerPos.y < height * 0.22 +30) 
        ||(mouseX > width * 0.95 - 30 && mouseX < width * 0.95 + 30 && 
      mouseY > height * 0.22 - 30 && mouseY < height * 0.22 + 30) || */(info_click){ //) {
        image(info_des, width * 0.7, height * 0.22);
      }
}

void display_cr07_in(float xpos, float ypos, int[] data, String[] time) {
  if ((fingerPos.x > xpos-boxSize && fingerPos.x < xpos+boxSize && 
        fingerPos.y > ypos-boxSize && fingerPos.y < ypos+boxSize) 
        ||(mouseX > xpos-boxSize && mouseX < xpos+boxSize && 
      mouseY > ypos-boxSize && mouseY < ypos+boxSize) || (cr07_in_click)) {
    wrteZoneName("CORRIDOR 07 IN", width*0.82, height*0.32);
    
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
    wrteZoneName("Date/Time: \n"+time[index[1]], width*0.82, height*0.43);
    wrteZoneName("Number of People: "+data[index[1]], width*0.82, height * 0.5);

    //graph = loadImage("AAPL2010V4_2.tif");
    //image(graph, width * 0.8, height*0.55);

    delay(300);
    index[1]++;

    if(!cr07_overBox) { 
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



void display_cr07_out(float xpos, float ypos, int[] data, String[] time) {
  if ((fingerPos.x > xpos-boxSize && fingerPos.x < xpos+boxSize && 
        fingerPos.y > ypos-boxSize && fingerPos.y < ypos+boxSize) 
        ||(mouseX > xpos-boxSize && mouseX < xpos+boxSize && 
      mouseY > ypos-boxSize && mouseY < ypos+boxSize)|| (cr07_out_click)) {
    //index = 0;    
    wrteZoneName("CORRIDOR 07 OUT", width*0.825, height*0.32);
    
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
    wrteZoneName("Date/Time: \n"+time[index[2]], width*0.82, height*0.43);
    wrteZoneName("Number of People: "+data[index[2]], width*0.82, height * 0.5);


    //graph = loadImage("AAPL2010V4_2.tif");
    //image(graph, width * 0.8, height*0.55);
    delay(300);
    

    if(!cr07_out_overBox) { 
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

void display_cr09_in(float xpos, float ypos, int[] data, String[] time) {
  if ((fingerPos.x > xpos-boxSize && fingerPos.x < xpos+boxSize && 
        fingerPos.y > ypos-boxSize && fingerPos.y < ypos+boxSize) 
        ||(mouseX > xpos-boxSize && mouseX < xpos+boxSize && 
      mouseY > ypos-boxSize && mouseY < ypos+boxSize) || (cr09_in_click)) {
    
    //index = 0;
    wrteZoneName("CORRIDOR 09 IN", width*0.835, height*0.32);
    
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
    wrteZoneName("Date/Time: \n"+time[index[3]], width*0.82, height*0.43);
    wrteZoneName("Number of People: "+data[index[3]], width*0.82, height * 0.5);

    delay(300);
    

    if(!cr09_overBox) { 
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

void display_cr09_out(float xpos, float ypos, int[] data, String[] time) {
  if ((fingerPos.x > xpos-boxSize && fingerPos.x < xpos+boxSize && 
        fingerPos.y > ypos-boxSize && fingerPos.y < ypos+boxSize) 
        ||(mouseX > xpos-boxSize && mouseX < xpos+boxSize && 
      mouseY > ypos-boxSize && mouseY < ypos+boxSize) || (cr09_out_click)) {
    //index = 0;    
    wrteZoneName("CORRIDOR 09 OUT", width*0.825, height*0.32);
    
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
    wrteZoneName("Date/Time: \n"+time[index[4]], width*0.82, height*0.43);
    wrteZoneName("Number of People: "+data[index[4]], width*0.82, height * 0.5);

    delay(300);
    

    if(!cr09_out_overBox) { 
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

void display_st18_up(float xpos, float ypos, int[] data, String[] time) {
  if ((fingerPos.x > xpos-boxSize && fingerPos.x < xpos+boxSize && 
        fingerPos.y > ypos-boxSize && fingerPos.y < ypos+boxSize) 
        ||(mouseX > xpos-boxSize && mouseX < xpos+boxSize && 
      mouseY > ypos-boxSize && mouseY < ypos+boxSize) || (st18_up_click)) {
    //index = 0;
    wrteZoneName("STAIR 18 UP", width*0.845, height*0.32);
    
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
    wrteZoneName("Date/Time: \n"+time[index[5]], width*0.82, height*0.43);
    wrteZoneName("Number of People: "+data[index[5]], width*0.82, height * 0.5);

    delay(300);
    

    if(!st18_up_overBox) { 
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

void display_st18_down(float xpos, float ypos, int[] data, String[] time) {
  if ((fingerPos.x > xpos-boxSize && fingerPos.x < xpos+boxSize && 
        fingerPos.y > ypos-boxSize && fingerPos.y < ypos+boxSize) 
        ||(mouseX > xpos-boxSize && mouseX < xpos+boxSize && 
      mouseY > ypos-boxSize && mouseY < ypos+boxSize) || (st18_down_click)) {
    //index = 0;
    wrteZoneName("STAIR 18 DOWN", width*0.835, height*0.32);
    
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
    wrteZoneName("Date/Time: \n"+time[index[6]], width*0.82, height*0.43);
    wrteZoneName("Number of People: "+data[index[6]], width*0.82, height * 0.5);

    delay(300);
    

    if(!st18_down_overBox) { 
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

void display_st19_up(float xpos, float ypos, int[] data, String[] time) {
  if ((fingerPos.x > xpos-boxSize && fingerPos.x < xpos+boxSize && 
        fingerPos.y > ypos-boxSize && fingerPos.y < ypos+boxSize) 
        ||(mouseX > xpos-boxSize && mouseX < xpos+boxSize && 
      mouseY > ypos-boxSize && mouseY < ypos+boxSize) || (st19_up_click)) {
    //index = 0;
   
    wrteZoneName("STAIR 19 UP", width*0.845, height*0.32);
    
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
    wrteZoneName("Date/Time: \n"+time[index[7]], width*0.82, height*0.43);
    wrteZoneName("Number of People: "+data[index[7]], width*0.82, height * 0.5);

    delay(300);
    

    if(!st19_up_overBox) { 
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

void display_st19_down(float xpos, float ypos, int[] data, String[] time) {
  if ((fingerPos.x > xpos-boxSize && fingerPos.x < xpos+boxSize && 
        fingerPos.y > ypos-boxSize && fingerPos.y < ypos+boxSize) 
        ||(mouseX > xpos-boxSize && mouseX < xpos+boxSize && 
      mouseY > ypos-boxSize && mouseY < ypos+boxSize) || (st19_down_click)) {
    //index = 0;
    wrteZoneName("STAIR 19 DOWN", width*0.835, height*0.32);
    
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

    wrteZoneName("Date/Time: \n"+time[index[8]], width*0.82, height*0.43);
    wrteZoneName("Number of People: "+data[index[8]], width*0.82, height * 0.5);

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
