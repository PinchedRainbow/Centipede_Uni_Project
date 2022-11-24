import java.util.Iterator;

//ArrayList<Bullet> bulletsList = new ArrayList<>();
Bullets bullets = new Bullets();
  
class Bullet
{
  float x, y, speed;
  int size = 10;
  
  Bullet(float x, float y, float speed)
  {
    this.x = x;
    this.y = y;
    this.speed = speed;
  }
  
  void update()
  {
    move();
    display();
  }
  
  void move()
  {
    y-=speed;
  }
  
  void display()
  {
    fill(#F5FA00);
    ellipse(x,y,size,size);
  }
}

class Bullets
{
  ArrayList<Bullet> bulletsList = new ArrayList<>();
  
  void addBullet()
  {
    bulletsList.add(new Bullet(playerShip.getCoordinates().x, playerShip.getCoordinates().y, speed));
  }
  
  void updateBullets()
  {
    Iterator<Bullet> bullet = bulletsList.iterator();
    while (bullet.hasNext())
    {
      Bullet currentBullet = bullet.next();
      currentBullet.update();
      if (currentBullet.y < -size) bullet.remove();
      for (Mushroom mushy: mushrooms)
      {
        if (mushy.checkForDamage(currentBullet)) bullet.remove();
      }
    }
  } 
}
