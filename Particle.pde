ArrayList<Particle> particles;

class Particle {
  PVector pos;
  PVector vel;
  float dx, dy;
  color c;
  int lifespan;

  Particle(PVector pos, PVector vel, color c, int lifespan) {
    this.pos = pos;
    this.vel = vel;
    this.c = c;
    this.lifespan = lifespan;
  }

  Particle(PVector pos, float dx, float dy, color c, int lifespan) {
    this.pos = pos;
    this.dx = dx;
    this.dy = dy;
    this.c = c;
    this.lifespan = lifespan;
  }


  void move() {
    if (dx != 0 && dy != 0)
    {
      pos.x += dx;
      pos.y += dy;
    } else {
      pos.add(vel);
    }
  }

  void display() {
    strokeWeight(1);
    stroke(c, lifespan);
    point(pos.x, pos.y);
  }
}

void updateParticles()
{
  //for (int i = particles.size() - 1; i >= 0; i--) {
  //  Particle p = particles.get(i);
  //  p.move();
  //  p.display();
  //  p.lifespan--;
  //  if (p.lifespan <= 0) {
  //    particles.remove(i);
  //  }
  //}
}

void spawnParticles(int x, int y)
{
  println("Called particles");
  PVector pos = new PVector(x, y);
  for (int i = 0; i < 1000; i++) {
    PVector vel = PVector.random2D();
    vel.mult(random(5, 10));
    
    float angle = random(0, TWO_PI);
    
    float dx = cos(angle) * random(1, 5);
    float dy = sin(angle) * random(1, 5);
    
    color c = color(random(255), random(255), random(255));
    int lifespan = (int)random(1000, 4800);
    particles.add(new Particle(pos, dx, dy, c, lifespan));
  }
}
