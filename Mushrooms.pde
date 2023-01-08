MushroomsList mushList = new MushroomsList();

SoundFile hit;

class Mushroom
{
  float x, y;
  int damageState; // 4 levels of damage
  float sizeMushy;
  PImage img;

  Mushroom(float x, float y)
  {
    this.x = x;
    this.y = y;
    damageState = 1;
    sizeMushy = size/damageState;
    img = loadImage("images/mushroom.png");
    img.resize(size, 0);
  }

  void display()
  {
    if (damageState < 4)
    {
      sizeMushy = size/damageState;
      //rectMode(CORNER);
      //rect(x, y, size, sizeMushy);

      if (Level.getLevel() == 1) tint(#02E51A);
      if (Level.getLevel() == 2) tint(#C2E502);
      if (Level.getLevel() >= 3) tint(255);
      imageMode(CORNER);
      image(img, x, y);
      img.resize(size, int(sizeMushy));
      noTint();
    } else {
      //explode();
      x = -100;
      y = -100;
    }
  }

  boolean checkForDamage(Bullet bullet)
  {
    if (bullet.x >= x && bullet.x <= x + size && bullet.y >= y && bullet.y <= y + size)
    {
      if (soundEnabled) hit.play();
      damageState++;
      changeScore(4);
      //println("Mushroom damaged, at state of " + damageState);
      return true;
      //bullets.removeBullet(bullet);
    }
    return false;
  }

  void explode()
  {
    // compute a random displacement for each vertex
    float x1 = random(-50, 50);
    float y1 = random(-50, 50);
    float x2 = random(-50, 50);
    float y2 = random(-50, 50);
    float x3 = random(-50, 50);
    float y3 = random(-50, 50);
    float x4 = random(-50, 50);
    float y4 = random(-50, 50);

    // draw the distorted image using the displaced vertices
    image(img, x, y);
    noStroke();
    fill(255, 255, 255, 150);
    beginShape();
    vertex(x + x1, y + y1);
    vertex(img.width + x2, y + y2);
    vertex(img.width + x3, img.height + y3);
    vertex(x + x4, img.height + y4);
    endShape(CLOSE);
  }
}

class MushroomsList
{
  ArrayList<Mushroom> mushrooms = new ArrayList<>();
  void generateMushrooms()
  {
    int numMushrooms = 100;
    //(Level.getLevel()*100);

    for (int i = 0; i < numMushrooms; i++)
    {
      int multWidth = width/size;
      int multHeight = (width)/size;
      int x = int(random(multWidth));
      int y = int(random(multHeight));

      while (validatePos(x, y))
      {
        x = int(random(multWidth));
        y = int(random(multHeight));
      }

      mushrooms.add(new Mushroom(x*multWidth, y*multHeight));
    }
  }
  
  void checkForDamage()
  {
  }

  void spawnMushroom(int x, int y)
  {
    mushrooms.add(new Mushroom(x, y));
  }

  void clearMushrooms()
  {
    mushrooms.clear();
  }

  boolean validatePos(int x, int y)
  {
    return x == 0 || x == width/size || y == 0 || y >= (width/size)-2;
  }
}
