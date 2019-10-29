void setup() {

  size(1400, 800);
  background(255);
  noFill();
  rectMode(CENTER);
}
int minSize = 30;
int sizeOfBlock = 200;
boolean change = true;
void draw() {

  //give a new set of squares every 100 frames
  if (frameCount %  100 == 0 && change) {
    background(255);
    for (int y = 0; y< height; y +=sizeOfBlock) {
      for (int x = 0; x<width; x +=sizeOfBlock) {
        pushMatrix();
        //defining the origin to be block specific
        translate(x, y);
        //drawing the biggest square / boudary for each block
        rect(sizeOfBlock/2, sizeOfBlock/2, sizeOfBlock, sizeOfBlock);

        // drawing the smallest at a random point
        float x1 = random(minSize/2, sizeOfBlock - minSize/2);
        float y1 = random(minSize/2, sizeOfBlock - minSize/2);
        rect(x1, y1, minSize, minSize);
        // number of sqares per block
        float density =int( random(15));
        float xn = x1;
        float yn = y1;
        float size = minSize;
        //draw multiple squares with their center gradually going to the center of the block; size gradually incrementing to the size of the block
        for (int count = 1; count < density; count ++) {
          xn += (sizeOfBlock/2-x1)/density;
          yn += (sizeOfBlock/2-y1)/density;
          size += (sizeOfBlock - minSize)/density;
          rect(xn, yn, size, size);
        }

        popMatrix();
      }
    }
  }
  //stop / start changing
  if(mousePressed){change = !change;}
}
