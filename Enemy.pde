import java.util.Iterator;

// Array Listt SOOO much better, I believe it be dynamic list ?!
ArrayList<Centipede> enemies = new ArrayList<>();
ArrayList<Scorpion> scorpies = new ArrayList<>();
ArrayList<Centipede> toAddEnemies = new ArrayList<>();

// Arrays to hold the PImage
PImage[] centiBodies = new PImage[8];
PImage[] centiHeads = new PImage[8];
PImage[] scorpions = new PImage[8];

// A bullet variable that will hold any bullets that needs to be removed at a specific time, mostly for if the bullet hits an enemy or mushroom
Bullet bulletToRemove = null;
SoundFile splitSound;

void updateEnemies()
{
  // Winss if no enemies present
  if (getNumberofEnemies() == 0)
  {
    currentState = gameStates.WIN;
    if (soundEnabled) levelUp.play();
  } else {
    Iterator<Centipede> enemyIter = enemies.iterator();
    while (enemyIter.hasNext())
    {
      Centipede currentEnemy = enemyIter.next();
      // updates every enemy
      currentEnemy.update();

      // a method tha will return -1 if a bullet has not collided with any of the centipedes
      int resultOfBulletCollision = currentEnemy.collisionWithBullet();
      if (resultOfBulletCollision != -1) // bullet hit snake
      {
        // getting the x and y values of the snake body hit
        int bodyX = int(currentEnemy.bodyPos[resultOfBulletCollision].x);
        int bodyY = int(currentEnemy.bodyPos[resultOfBulletCollision].y);

        // spawn particles for an explosion effect
        spawnParticles(bodyX, bodyY);

        if (resultOfBulletCollision == 0) // head hit, kill off whole snake
        {
          //enemies.remove(this);
          enemyIter.remove();

          // 100 points per snake head kill
          changeScore(100);

          // Spawn mushroom at bullet impact
          mushList.spawnMushroom(bodyX, bodyY);
        } else {
          // Calculates the new size of the two centipedes after they split
          int newSize = currentEnemy.sizeOfBody - resultOfBulletCollision;
          // println("Splitting snake with body parts: " + newSize + ", " + resultOfBulletCollision);

          mushList.spawnMushroom(bodyX, bodyY);

          // Remove the current enemy that was hit and spawn two centipedes in its place travelling in opposite direction
          enemyIter.remove();
          toAddEnemies.add(new Centipede(bodyX, bodyY, newSize, -1));
          toAddEnemies.add(new Centipede(bodyX, bodyY, resultOfBulletCollision, +1));

          changeScore(10);

          //toAddEnemies.add(new Enemy(currentEnemy.x, currentEnemy.y, newSize, 1));
          //toAddEnemies.add(new Enemy(currentEnemy.x, currentEnemy.y, resultOfBulletCollision, -1));
        }

        if (soundEnabled) splitSound.play();
      }

      //if (currentEnemy.sizeOfBody == 1)
      //{
      //  enemyIter.remove();
      //} else {

      //}
    }

    enemies.addAll(toAddEnemies);
    toAddEnemies.clear();

    // Just updates spiders movement... idk why I called it scorpion
    Iterator<Scorpion> sIter = scorpies.iterator();
    while (sIter.hasNext())
    {
      Scorpion s = sIter.next();
      s.update();
      if (s.bulletCollision())
      {
        sIter.remove();
        changeScore(300);
      }
    }
  }
}

// When level ends
void resetEnemies()
{
  for (Centipede enemy : enemies)
  {
    enemy.y=0;
  }
  for (Scorpion s : scorpies)
  {
    s.y=0;
  }
}


// For each level the number of enemies increases
// Ie; Level 1: 1 centipede, 2 spiders
void generateEnemies()
{
  enemies.clear();
  scorpies.clear();
  for (int i = 0; i < Level.getLevel(); i++)
  {
    int direction = i%2==0 ? 1 : -1;
    //if (i%2==0) direction = 1;
    //else direction = -1;
    enemies.add(new Centipede(returningX(), -size, int(random(6, 20)), direction));
    if (spiders) scorpies.add(new Scorpion(int(random(-200, width+200)), int(random(-3000, -25))));
    if (spiders) scorpies.add(new Scorpion(int(random(-200, width+200)), int(random(-3000, -25))));
  }
}

// Returns total enemies
int getNumberofEnemies()
{
  return enemies.size() + scorpies.size();
}


// Spawns them correctly so it appears in a gridlike fashion
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



// Make a base enemy class
// with centipede as child class
// and scorpoions ?


// -------------- Need to introduce base and sub class

// Base Enemy
abstract class BaseEnemy
{
  int x, y, dx, dy;

  void move()
  {
  }

  void update()
  {
  }

  void display()
  {
  }

  Boolean collision(BaseEnemy enemy)
  {
    // returning true until construcuted
    return true;
  }

  boolean collisionWithMushroom()
  {
    for (Mushroom mush : mushList.mushrooms)
    {
      // check for any collision left and right
      if (x >= mush.x && x <= mush.x + size && y >= mush.y && y <= mush.y + size) {
        return true;
      }
    }
    return false;
  }
}

void callGameOver()
{
  if (soundEnabled) gameOver.play();
  Lives.setLives(Lives.getLives()-1);
  delay(100);
  if (Lives.getLives() <= 0) currentState = gameStates.GAMEOVER;
  else currentState = gameStates.MENU;
}


// Subclass Scorpion
class Scorpion extends BaseEnemy
{
  float dx, dy;
  int imageIndex = 0;
  float speed;
  float randomness = 0.7;

  Scorpion(int x, int y)
  {
    this.x = x;
    this.y = y;
    //this.img = scorpions[imageIndex];
    this.speed = Level.getLevel() + 1;
  }

  void update()
  {
    move();
    display();

    // Shows it as a walking animation :D
    if (x%size==0 || y%size==0)
    {
      if (imageIndex < scorpions.length-1)
      {
        imageIndex++;
      } else imageIndex = 0;
    }

    if (abs(x-playerShip.x) < (scorpions[imageIndex].width + playerShip.size)/2 && abs(y-playerShip.y) < (scorpions[imageIndex].height + playerShip.size) / 2)
    {
      callGameOver();
    }


    //if (collisionWithMushroom())
    //{
    //  //changeDirection();
    //  //dy*=-1;
    //  //dx*=-1;
    //}
    //if (y <= 0 || y >= height-size)
    //{
    //  dy*=-1;
    //  //changeDirection();
    //}
    //if (x <= 0 || x >= width-size)
    //{
    //  dx*=-1;
    //  //changeDirection();
    //}
  }

  // Calculates angle based on mouse movement and player ship
  void move()
  {
    float angle = atan2(playerShip.y-y, playerShip.x-x) + random(-randomness, randomness);
    dx = cos(angle) * speed;
    dy = sin(angle) * speed;
    x+=dx;
    y+=dy;
  }

  void display()
  {
    imageMode(CENTER);
    image(scorpions[imageIndex], x, y);
  }

  void changeDirection()
  {
    dy = int(random(1, 4));
    dx = int(random(1, 4));
  }

  boolean bulletCollision()
  {
    for (Bullet bully : bullets.bulletsList)
    {
      if (bully.x >= x && bully.x <= x + size + 10 && bully.y >= y && bully.y <= y + size + 10)
      {
        bulletToRemove = bully;
        return true;
      }
    }

    return false;
  }
}


// ---------- End of hell

// Subclass Centipede
class Centipede extends BaseEnemy
{
  int sizeOfBody = int(random(10, 12));
  int dx = speed/2;
  PVector[] bodyPos;
  int colour = 200;
  int r = int(random(255));
  int g = int(random(255));
  int b = int(random(255));

  int jhead = 0;
  int jx = 1;

  Centipede(int x, int y)
  {
    this.x = x;
    this.y = y;

    this.bodyPos = new PVector[sizeOfBody];

    for (int i = 0; i<sizeOfBody; i++)
    {
      bodyPos[i] = new PVector(x, y);
    }
  }

  Centipede(int x, int y, int size, int direction)
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
      jhead+=jx;

      if (jhead > centiHeads.length -2 || jhead <= 0) jx *= -1;
    }

    //float multiplier = 255/sizeOfBody;
    //float mr = r/sizeOfBody;
    //float mg = g/sizeOfBody;
    //float mb = b/sizeOfBody;
    int j = 0;

    for (int i = bodyPos.length-1; i >= 0; i--)
    {
      //fill((i+1)*multiplier, colour, colour);

      //fill((i+1)*mr, (i+1)*mg, (i+1)*mb);
      //display(bodyPos[i].x, bodyPos[i].y);
      imageMode(CORNER);
      if (i == 0)
      {
        image(centiHeads[jhead], bodyPos[i].x, bodyPos[i].y);
      } else {

        if (i < centiBodies.length)
        {
          image(centiBodies[i], bodyPos[i].x, bodyPos[i].y);
        } else {
          //int random = int(random(0, centiBodies.length));
          image(centiBodies[j], bodyPos[i].x, bodyPos[i].y);
          j++;
          if (j > centiBodies.length-1) j = 0;

          //j = j < centiBodies.length ? j++ : 0;
        }
      }

      // display image

      //if (i < centiBodies.length)
      //{
      //  image(centiBodies[i], bodyPos[i].x, bodyPos[i].y);
      //} else {
      //  fill((i+1)*mr, (i+1)*mg, (i+1)*mb);
      //  display(bodyPos[i].x, bodyPos[i].y);
      //}
    }

    if (collisionWithMushroom()) {
      dx*=-1;
      y+=size;
    }
    if (y >= height)
    {
      callGameOver();
    }

    for (int i = 0; i < centiBodies.length; i++)
    {
      if (abs(x-playerShip.x) < (centiBodies[i].width + playerShip.size)/2 && abs(y-playerShip.y) < (scorpions[i].height + playerShip.size) / 2)
      {
        callGameOver();
        break;
      }
    }
  }

  void display()
  {
    fill(155, 155, 0);
    rect(x, y, size, size, 2);
  }

  void display(float x, float y)
  {
    //fill(#075F01);
    strokeWeight(1);
    stroke(255);
    rect(x, y, size, size, 2);
    noStroke();
  }

  void move()
  {
    x+=dx;
    // If hits wall move down
    if (x < 0 || x > width-size) moveDown();
  }

  void moveDown()
  {
    dx*=-1;
    y+=size;
  }

  int collisionWithBullet()
  {
    for (Bullet bully : bullets.bulletsList)
    {
      for (int i = 0; i < sizeOfBody; i++)
      {
        float x = bodyPos[i].x;
        float y = bodyPos[i].y;
        if (bully.x >= x && bully.x <= x + size && bully.y >= y && bully.y <= y + size)
        {
          bulletToRemove = bully;
          return i;
        }
      }
    }
    return -1;
  }
}
