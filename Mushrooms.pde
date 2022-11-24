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
      fill(0, 255, 0);
      sizeMushy = size/damageState;
      rect(x, y, size, sizeMushy);
    }
  }

  boolean checkForDamage(Bullet bullet)
  {
    if (bullet.x > x && bullet.x < x + size && bullet.y > y && bullet.y < y+sizeMushy)
    {
      damageState++;
      return true;
      //bullets.removeBullet(bullet);
    }
    return false;
  }
}


void generateMushrooms()
{
  // replace with levelling system later on
  int Level = 1;
  int numMushrooms = (Level*100);

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
