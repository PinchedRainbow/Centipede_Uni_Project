import java.util.Iterator;

ArrayList<Enemy> enemies = new ArrayList<>();
ArrayList<Enemy> toAddEnemies = new ArrayList<>();

void updateEnemies()
{
  Iterator<Enemy> enemyIter = enemies.iterator();
  while (enemyIter.hasNext())
  {
    Enemy currentEnemy = enemyIter.next();
    currentEnemy.update();
    
    int resultOfBulletCollision = currentEnemy.collisionWithBullet();
    if (resultOfBulletCollision != -1)
    {
      if (resultOfBulletCollision == 0)
      {
        // head hit, kill snake
        //enemies.remove(this);
        enemyIter.remove();
      } else {
        println("Bullet collided with centipede at index " + resultOfBulletCollision);
        int newSize = currentEnemy.sizeOfBody - resultOfBulletCollision;
        enemyIter.remove();
        toAddEnemies.add(new Enemy(currentEnemy.x+(size*resultOfBulletCollision), currentEnemy.y, newSize, 1));
        toAddEnemies.add(new Enemy(currentEnemy.x-(size*resultOfBulletCollision), currentEnemy.y, resultOfBulletCollision, -1));
      }
    }
  }
  
  enemies.addAll(toAddEnemies);
  toAddEnemies.clear();
  
  if (enemies.size() == 0)
  {
    gameState = MENU;
  }
  
  
}

void resetEnemies()
{
  for (Enemy enemy: enemies)
  {
    enemy.y=0;
  }
}

class Enemy
{
  int x, y;
  int sizeOfBody = int(random(10, 12));
  int dx = speed/2;
  PVector[] bodyPos = new PVector[sizeOfBody];

  Enemy(int x, int y)
  {
    this.x = x;
    this.y = y;

    for (int i = 0; i<sizeOfBody; i++)
    {
      bodyPos[i] = new PVector(x, y);
    }
  }

  Enemy(int x, int y, int size, int direction)
  {
    this.x = x;
    this.y = y;
    this.sizeOfBody = size;
    this.dx *= direction;

    for (int i = 0; i<sizeOfBody; i++)
    {
      bodyPos[i] = new PVector(x, y);
    }
  }

  void update()
  {
    //display();
    move();

    if (x%size==0) {
      for (int i = bodyPos.length-2; i >=0; i--)
      {
        bodyPos[i+1] = bodyPos[i];
      }
      bodyPos[0] = new PVector(x, y);
    }

    float multiplier = 255/sizeOfBody;
    for (int i = 0; i < sizeOfBody; i++)
    {
      fill((i+1)*multiplier, 150, 200);
      display(bodyPos[i].x, bodyPos[i].y);
    }

    if (collisionWithMushroom()) {
      dx*=-1;
      y+=size;
    }
    if (y >= height) gameState = GAMEOVER;

    
  }

  void display()
  {
    fill(155, 155, 0);
    rect(x, y, size, size, 2);
  }

  void display(float x, float y)
  {
    //fill(#075F01);
    rect(x, y, size, size, 2);
  }

  void move()
  {
    x+=dx;
    if (x < 0 || x > width-size) {
      dx*=-1;
      y+=size;
    }
  }

  int collisionWithBullet()
  {
    for (Bullet bully : bullets.bulletsList)
    {
      for (int i = 0; i < sizeOfBody; i++)
      {
        float x = bodyPos[i].x;
        float y = bodyPos[i].y;
        if (bully.x > x && bully.x < x + size && bully.y > y && bully.y < y + size)
        {
          return i;
        }
      }
    }
    return -1;
  }

  boolean collisionWithMushroom()
  {
    for (Mushroom mush : mushrooms)
    {
      // check for any collision left and right
      if (x >= mush.x && x <= mush.x + size && y >= mush.y && y <= mush.y + size) {
        return true;
      }
    }
    return false;
  }
}
