ParticleSystem ps;
Particle p;
ArrayList<ParticleSystem> systems;
float hue=0;
//float dt = 0.5;
float CIRCLESIZE = 15;
int count;
boolean bounce1= false;
boolean bounce2= false;


void setup() {
  size(640, 360);
  systems= new ArrayList<ParticleSystem>();
  colorMode(HSB, 360, 100, 100, 100);
  smooth();
}

void draw() {
  background(0);
  for (ParticleSystem ps : systems) {
    //ps.addParticle();
    ps.run();
  }
}

void mousePressed() {
  systems.add(new ParticleSystem(1, new PVector(mouseX, mouseY)));
}


// A class to describe a group of Particles
// An ArrayList is used to manage the list of Particles 

class ParticleSystem {

  ArrayList<Particle> particles;
  PVector origin;


  ParticleSystem(int num, PVector position) {
    origin = position.copy();
    particles = new ArrayList<Particle>();


    for (int i=0; i<num; i++) {
      particles.add(new Particle(origin));
    }
  }

  void addParticle() {
    Particle p;
    p= new Particle(origin);
    particles.add(p);

    //if (int(random(0, 2)) ==0) {
    //  p= new Particle(origin);
    //}
  }

  void run() {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
      //p.move();
      //p.show();

      //if (p.isDead()) {
      //  particles.remove(i);
      //}
    }
  }
}



// A simple Particle class

class Particle {
  //PVector position;
  //PVector velocity;
  //PVector acceleration;
  //float lifespan;
  PVector loc;
  PVector vel;
  PVector grav;
  float drag= .995;
  //float theta;
  //float rad;
  //float dtval;

  Particle(PVector l) {
    //acceleration = new PVector(0, 0.05);
    //velocity = new PVector(random(-1, 1), random(-2, 0));
    //position = l.copy();
    //lifespan = 100.0;

    //loc= new PVector ( l.x, l.y);
    //Vel = new PVector ( random(-1, 1), random(-1, 1));
    //Vel.rotate(radians(random(360)));
    loc= l.copy();
    vel= new PVector(random(-1.5, 1.5), 2.1);
    grav= new PVector (0, 0.2);
    //theta = random (TWO_PI);
    //rad= random ( 2, 10);
    //dtval = random (0, 0.5)*0.1;
  }

  void run() {
    //update();
    //display();c
    move();
    show();
    check();
    open();
  }

  // Method to update position
  //void update() {
  //  velocity.add(acceleration);
  //  position.add(velocity);
  //  lifespan -= 3.0;
  //}

  // Method to display
  //void display() {
  //  stroke(300, 100, 100, lifespan);
  //  fill(300, 100, 100, lifespan);
  //  ellipse(position.x, position.y, 5, 5);
  //}

  //// Is the particle still useful?
  //boolean isDead() {
  //  if (lifespan < 0.0) {
  //    return true;
  //  } else {
  //    return false;
  //  }
  //}

  void move() {
    //loc.x += Vel.x*dt;
    //loc.y += Vel.y*dt;
    //Vel.x = cos(theta)*rad;
    //Vel.y = sin(theta)*rad;
    //theta += random (-1, 1)*0.2;

    loc.add(vel);
    vel.add(grav);
    vel.mult(drag);
  }

  void show() { //yellow, red, blue, green, white?
    ellipse(loc.x, loc.y, CIRCLESIZE, CIRCLESIZE);
  }

  void check() {
    float r= CIRCLESIZE/2;

    if ((loc.x>width-r) || (loc.x<r)) {
      vel.x *= -1;
      bounce1= true;
    }
    if ((loc.y>height-r) || (loc.y<r)) {
      vel.y *= -1;
      bounce2= true;
    }
  }

  void open() {
    if (bounce1 == true || bounce2 == true) {
      count++;
    }

    if (count > 400) {
      rect(100, 100, 100, 100);
    }
  }
}
