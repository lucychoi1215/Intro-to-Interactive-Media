/*
a pong game with the potentiometer as a controller
*/


import processing.serial.*;
PFont f;
Serial myPort; 
float inByte;
//PVector acceleration =new PVector(0.1, 0.1);
float acceleration = 0.02;
PVector speed = new PVector(1, 1);
int dead = 0;
int barWidth = 100;
int barHeight = 20;
int radius = 20;
int score = 0;
void setup () {
  // set the window size:
  size(700, 800);
  f = createFont("American Typewriter", 20);
  textFont(f, 20);
  // List all the available serial ports
  // if using Processing 2.1 or later, use Serial.printArray()
  println(Serial.list());

  // I know that the first port in the serial list on my Mac is always my
  // Arduino, so I open Serial.list()[0].
  // Open whatever port is the one you're using.
  myPort = new Serial(this, Serial.list()[1], 9600);

  // don't generate a serialEvent() unless you get a newline character:
  myPort.bufferUntil('\n');

  // set initial background:
  background(0);
  //wait for communication
  delay(1000);
}
PVector pos = new PVector(width/2, height/2);
void draw () {
  // draw the line:
  stroke(127, 34, 255);
  background(0);
  if(dead == 0){
  ellipse(pos.x, pos.y, radius, radius);
  rect(inByte, height - barHeight, barWidth, barHeight);
  //check for collision with the three borders
  if ( (pos.x<radius) || (pos.x>width-radius)) {
    speed.x = -speed.x;
  }
  if ( (pos.y<radius) ) {
    speed.y = -speed.y;
  }
  //check for collision with the bar
  if (pos.y>height - barHeight) {
    if ((pos.x>inByte)&&(pos.x<inByte + barWidth)) {
      speed.y = -speed.y;
    } else {
      dead = 1;

    }
  }
  if(speed.x>0){
    speed.x+=acceleration;
  }
  else{ speed.x-=acceleration;}
  if(speed.y>0){
    speed.y+=acceleration;
  }
  else{ speed.y-=acceleration;}
  //speed.add(acceleration);
  pos.add(speed);
    // the more time surviving, the higher the score
  score ++;
  text("Score : ",0,30);
  text(int(score/10),textWidth("Score : "),30);
  }
  else{
  text("YOU DIED,PRESS SPACE TO RESTART",width/2-textWidth("YOU DIED,PRESS SPACE TO RESTART")/2,height/2);
  text("Score : ",0,30);
  text(int(score/10),textWidth("Score : "),30);
  }
  
}

void serialEvent (Serial myPort) {
  // get the ASCII string:
  String inString = myPort.readStringUntil('\n');

  if (inString != null) {
    // trim off any whitespace:
    inString = trim(inString);
    // convert to an int and map to the screen width:
    inByte = float(inString);
    //only using [200,900] to make it easier to operate
    if (inByte <200) {
      inByte = 200;
    } else if (inByte >900) {
      inByte = 900;
    }
    inByte = map(inByte, 200, 900, width - barWidth, 0);
    //left > right
    println(inByte);
  }
}
// if space is pressed, reset the game
void keyPressed(){
  if(key == ' '){
    speed = new PVector(1, 1);
    pos = new PVector(width/2, height/2);
    acceleration = 0.04;
    dead = 0;
    score = 0;
  }
}
