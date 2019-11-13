PFont f;
int [] data;
String stuff[];

//starting from the second line
int index = 1;
//offset indices for all data fields
int round =0;
int a1_off =1;
int n1_off=3;
int a2_off =4;
int n2_off=6;
int loss1_off = 8;
int loss2_off = 10;
int gp1_off = 12;
int log1_off = 7;
int gp2_off = 14;
int log2_off = 9;

void setup() {
  size(1000, 800);


  stuff = loadStrings("data.csv");
  f = createFont("Monaco", 32);
  textFont(f, 32);
}


void draw() {
  data = int( split(stuff[index], ',' ) );
  background(255);
  fill(0);
  textAlign(LEFT);
  text("Round",0,40);
  text(data[round],textWidth("Round")+20,40);
  text("a1 = ",250,40);
  text(data[a1_off],250+textWidth("a1 = "),40);
  text("a2 = ",400,40);
  text(data[a2_off],400+textWidth("a2 = "),40);
  text("Sending Rates", 0, 80);
  text("Buffer", width/4+textWidth("Buffer"), height/8);
  text("Dropped", width/4+textWidth("Buffer"), height/4+450);
  text("Bandwidth Occupacy", width-textWidth("Bandwidth Occupacy"), 50);
  noFill();
  square(width/4, height/4, 400);
  rect(600,100,400,50);
  fill(255, 0, 0);
  text(data[n1_off], 20, 150);
  rect(600,100,data[gp1_off],50);
  fill(0, 0, 255);
  text(data[n2_off], 20, 200);
  rect(600+data[gp1_off],100,data[gp2_off],50);
  drawLog(data[log1_off],data[log2_off]);
  drawLoss(data[loss1_off],data[loss2_off]);
  index++;
  if (index>501) {
    while(true){}
  }
}
//funtion to fill the log according to the data
void drawLog(int log1,int log2){
  int count1 = log1;
  int count2 = log2;
  int index = 0;
  //squares are drawn in red and blue pairs until one count goes to 0
  while(count1>0 &&count2>0){
    int row = int(index/20);
    int colomn = index %20;
    pushMatrix();
    translate(width/4 +colomn*20, height/4+row*20);
    fill(255, 0, 0);
    square(0, 0, 20);
    fill(0, 0, 255);
    square(20, 0, 20);
    popMatrix();
    index = index +2;
    count1--;
    count2--;
  }
  //reamining red/blue squares are drawn
  while(count1>0){
    int row = int(index/20);
    int colomn = index %20;
    pushMatrix();
    translate(width/4 +colomn*20, height/4+row*20);
    fill(255, 0, 0);
    square(0, 0, 20);
    popMatrix();
    index = index +1;
    count1--;
  }
  while(count2>0){
    int row = int(index/20);
    int colomn = index %20;
    pushMatrix();
    translate(width/4 +colomn*20, height/4+row*20);
    fill(0, 0, 255);
    square(0, 0, 20);
    popMatrix();
    index = index +1;
    count2--;
  }
}

//funtion to fill the log according to the data
void drawLoss(int log1,int log2){
  int count1 = log1;
  int count2 = log2;
  int index = 0;
  //squares are drawn in red and blue pairs until one count goes to 0
  while(count1>0 &&count2>0){
    int row = int(index/20);
    int colomn = index %20;
    pushMatrix();
    translate(width/4 +colomn*20, height/6*5+row*20);
    fill(255, 0, 0);
    square(0, 0, 20);
    fill(0, 0, 255);
    square(20, 0, 20);
    popMatrix();
    index = index +2;
    count1--;
    count2--;
  }
  //reamining red/blue squares are drawn
  while(count1>0){
    int row = int(index/20);
    int colomn = index %20;
    pushMatrix();
    translate(width/4 +colomn*20, height/6*5+row*20);
    fill(255, 0, 0);
    square(0, 0, 20);
    popMatrix();
    index = index +1;
    count1--;
  }
  while(count2>0){
    int row = int(index/20);
    int colomn = index %20;
    pushMatrix();
    translate(width/4 +colomn*20, height/6*5+row*20);
    fill(0, 0, 255);
    square(0, 0, 20);
    popMatrix();
    index = index +1;
    count2--;
  }
}
