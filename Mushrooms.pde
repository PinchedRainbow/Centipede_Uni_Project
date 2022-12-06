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
    if (damageState < 3)
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
      x = -100;
      y = -100;
    }
  }

  boolean checkForDamage(Bullet bullet)
  {
    if (bullet.x >= x && bullet.x <= x + size && bullet.y >= y && bullet.y <= y + size)
    {
      hit.play();
      damageState++;
      changeScore(4);
      //println("Mushroom damaged, at state of " + damageState);
      return true;
      //bullets.removeBullet(bullet);
    }
    return false;
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
    return x == 0 || x == width/size || y == 0 || y >= (width/size)-1;
  }
}
