import java.util.Iterator;

ArrayList<Enemy> enemies = new ArrayList<>();
ArrayList<Enemy> toAddEnemies = new ArrayList<>();

void updateEnemies()
{
  if (enemies.size() == 0)
  {
    gameState = WIN;
    changeScore(1000);
  } else {
    Iterator<Enemy> enemyIter = enemies.iterator();
    while (enemyIter.hasNext())
    {
      Enemy currentEnemy = enemyIter.next();
      currentEnemy.update();
      if (currentEnemy.sizeOfBody == 1)
      {
        enemyIter.remove();
      } else {
        int resultOfBulletCollision = currentEnemy.collisionWithBullet();
        if (resultOfBulletCollision != -1)
        {
          if (resultOfBulletCollision == 0)
          {
            // head hit, kill snake
            //enemies.remove(this);
            enemyIter.remove();
            
            // 100 points per snake head kill
            changeScore(100);
            
          } else {
            int newSize = currentEnemy.sizeOfBody - resultOfBulletCollision;
           // println("Splitting snake with body parts: " + newSize + ", " + resultOfBulletCollision);
            enemyIter.remove();
            toAddEnemies.add(new Enemy(currentEnemy.x, currentEnemy.y, newSize, -1));
            toAddEnemies.add(new Enemy(currentEnemy.x, currentEnemy.y, resultOfBulletCollision, +1));
            
            changeScore(10);
            
            //toAddEnemies.add(new Enemy(currentEnemy.x, currentEnemy.y, newSize, 1));
            //toAddEnemies.add(new Enemy(currentEnemy.x, currentEnemy.y, resultOfBulletCollision, -1));
          }
        }
      }
    }

    enemies.addAll(toAddEnemies);
    toAddEnemies.clear();
  }
}

void resetEnemies()
{
  for (Enemy enemy : enemies)
  {
    enemy.y=0;
  }
}


void generateEnemies()
{
  enemies.clear();
  for (int i = 0; i < Level.getLevel(); i++)
  {
    int direction;
    if (i%2==0) direction = 1;
    else direction = -1;
    enemies.add(new Enemy(returningX(), 0, int(random(10, 12)), direction));
  }
}


int returningX()
{
  int number;
  while (true)
  {
    number = int(random(width));
    if (number%size==0) break;
  }

  return number;
}


class Enemy
{
  int x, y;
  int sizeOfBody = int(random(10, 12));
  int dx = speed/2;
  PVector[] bodyPos;
  int colour = 200;


  Enemy(int x, int y)
  {
    this.x = x;
    this.y = y;

    this.bodyPos = new PVector[sizeOfBody];

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

    this.bodyPos = new PVector[sizeOfBody];

    for (int i = 0; i<sizeOfBody; i++)
    {
      bodyPos[i] = new PVector(x, y);
    }
  }
  
  Enemy(int x, int y, int size, int direction, int colour)
  {
    this.x = x;
    this.y = y;
    this.sizeOfBody = size;
    this.dx *= direction;

    this.bodyPos = new PVector[sizeOfBody];
    this.colour = colour;

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
    for (int i = bodyPos.length-1; i > 0; i--)
    {
      fill((i+1)*multiplier, colour, colour);
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
