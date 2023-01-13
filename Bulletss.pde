import java.util.Iterator;

//ArrayList<Bullet> bulletsList = new ArrayList<>();
Bullets bullets = new Bullets();
SoundFile shootSFX;

// Class for a singular bullet, defines the angle based on mouse positon and player position
class Bullet
{
  float x, y, speed;
  float dx, dy;
  float angle;

  Bullet(float x, float y, float speed)
  {
    this.x = playerShip.x;
    this.y = playerShip.y;
    this.speed = speed;
    this.angle = atan2(playerShip.y-y, playerShip.x-x);
    this.dx = cos(angle) * speed;
    this.dy = sin(angle) * speed;
  }

  void update()
  {
    move();
    display();
  }

  void move()
  {
    x-=dx;
    y-=dy;
  }

  void display()
  {
    fill(#F5FA00);
    ellipse(x, y, size/2, size/2);
  }
}

// A class to hold the array of bullets
class Bullets
{
  ArrayList<Bullet> bulletsList = new ArrayList<>();

  void addBullet()
  {
    if (System.currentTimeMillis() - lastShot > COOLDOWN) // Cooldown feature so players arent able to spam it
    {
      lastShot = System.currentTimeMillis();
      bulletsList.add(new Bullet(mouseX, mouseY, speed*3));
      if (soundEnabled) shootSFX.play();
    }
  }
  
  // For level ending
  void clearBullets()
  {
    bulletsList.clear();
  }

  // Just making sure that bullets dont infinitely stay in the array and gets removed when out of sight
  void updateBullets()
  {
    if (bulletToRemove!=null)
    {
      bulletsList.remove(bulletToRemove);
      bulletToRemove = null;
    }

    try {
      Iterator<Bullet> bullet = bulletsList.iterator(); // Due to Concurrent exception
      while (bullet.hasNext())
      {
        Bullet currentBullet = bullet.next();
        currentBullet.update();
        if (currentBullet.y < -size || currentBullet.x > width + size || currentBullet.y < - size || currentBullet.y > height + size) bullet.remove();
        for (Mushroom mushy : mushList.mushrooms)
        {
          if (mushy.checkForDamage(currentBullet)) bullet.remove();
        }
      }
    }
    catch (Exception e)
    {
      //println("Beautiful error that we will ignore: " + e);
    }
  }
}
