ArrayList<Mushroom> mushrooms = new ArrayList<>();

class Mushroom
{
  float x, y;
  int damageState; // 4 levels of damage
  float sizeMushy;

  Mushroom(float x, float y)
  {
    this.x = x;
    this.y = y;
    damageState = 1;
    sizeMushy = size/damageState;
  }

  void display()
  {
    if (damageState < 3)
    {
      if (Level.getLevel() == 1) fill(0, 255, 0);
      if (Level.getLevel() == 2) fill(#9D03FF);
      if (Level.getLevel() == 3) fill(155, 255, 20);
      sizeMushy = size/damageState;
      rect(x, y, size, sizeMushy);
    } else {
      x = 0;
      y=0;
    }
  }

  boolean checkForDamage(Bullet bullet)
  {
    if (bullet.x > x && bullet.x < x + size && bullet.y > y && bullet.y < y + size)
    {
      damageState++;
      changeScore(5);
      //println("Mushroom damaged, at state of " + damageState);
      return true;
      //bullets.removeBullet(bullet);
    }
    return false;
  }
}


void generateMushrooms()
{
  int numMushrooms = (Level.getLevel()*100);

  for (int i = 0; i < numMushrooms; i++)
  {
    int multWidth = width/size;
    int multHeight = (width)/size;
    int x = int(random(multWidth));
    int y = int(random(multHeight));

    //if ()

    mushrooms.add(new Mushroom(x*multWidth, y*multHeight));
  }
}

void clearMushrooms()
{
  mushrooms.clear();
}
