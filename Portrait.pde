
void setup() {
  size(500, 500);
  background(255);
  color skinColor = color(250,235,215);
  color hairColor = color(41,36,33);
  color clotheColor = color(128,128,105);
  color eyeColor = color(94,38,18);
  color glassColor = color(0);
  color red = color(178,34,34);
  color pink = color(255,192,203);
  stroke(hairColor);
  fill(hairColor);
  //hair
  rect(width/2 - 80, height/2 - 50 ,160,230);
  stroke(skinColor);
  fill(skinColor);
  //face
  arc(width/2, height/2, 160, 170, radians(0), radians(180));
  rect(width/2 - 80, height/2 - 90 ,160,90);
  stroke(hairColor);
  fill(hairColor);
  //forehair
  arc(width/2 , height/2 - 80 ,160,130,radians(180), radians(360));
  triangle(width/2-80,height/2 - 80,width/2-50,height/2 - 80,width/2-80,height/2 - 20);
  triangle(width/2+80,height/2 - 80,width/2+50,height/2 - 80,width/2+80,height/2 - 20);
  
  
  stroke(eyeColor);
  //eye brows
  noFill();
  arc(width/2-40, height/2 - 40,30,10,radians(210), radians(330));
  arc(width/2+40, height/2 - 40,30,10,radians(210), radians(330));
  
  fill(eyeColor);
  //eyes
  ellipse(width/2-40, height/2 - 20,10, 20);
  ellipse(width/2+40, height/2 - 20,10, 20);
  
  stroke(skinColor);
  fill(skinColor);
  //neck
  rect(width/2 -20, height/2 + 70 ,40,70);
  //left + right ear
  arc(width/2-75, height/2, 30, 50, radians(80), radians(270));
  arc(width/2+75, height/2, 30, 50, radians(270), radians(360+90));
  
  stroke(pink);
  fill(pink);
  //mouth
  arc(width/2,height/2+50,50,15,radians(30), radians(150));
  
  stroke(red);
  fill(red);
  //ear piecings
  ellipse(width/2-80, height/2+20, 5, 5);
  ellipse(width/2+80, height/2+20, 5, 5);
  
  
  //glasses
  stroke(glassColor);
  noFill();
  rect(width/2-65, height/2 - 20,50, 20);
  rect(width/2+15, height/2 - 20,50, 20);
  arc(width/2,242,30,10,radians(210), radians(330));
  line(width/2-67,height/2-8,width/2-80,height/2-24);
  line(width/2+67,height/2-8,width/2+80,height/2-24);
  //clothe
  stroke(clotheColor);
  fill(clotheColor);
  arc(width/2, height-60, 240, 160, radians(180), radians(360));
 
}

//loop to find coordinates
void draw(){
  if(mousePressed){
  println(mouseX,mouseY);}
}
