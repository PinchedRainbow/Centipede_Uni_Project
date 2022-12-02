int gameState;
int MENU = 0;
int INGAME = 1;
int GAMEOVER = 2;
int PAUSE = 3;
int SETTINGS = 4;
int WIN = 5;
boolean SetLevel = false;
boolean paused = false;

void MENU()
{
  background(#111822);
  textSize(30);
  textAlign(CENTER);
  fill(255);
  text("Press A for mouse movement", width/2, height/3);
  text("Press B for keyboard movement", width/2, height/3+30);

  textSize(20);
  text("Game details", width/2, height/2+60);
  text("Lives: " + Lives.getLives() + " | Level: " + Level.getLevel(), width/2, height/2+80);

  if (key == 'a' || key == 'A')
  {
    SetLevel = false;
    resetEnemies();
    generateEnemies();
    playerShip = new Player(width/2, height-20, speed, true, size);
    gameState = INGAME;
  } else if (key == 'b' || key == 'B')
  {
    SetLevel = false;
    resetEnemies();
    generateEnemies();
    playerShip = new Player(width/2, height-20, speed, false, size);
    gameState = INGAME;
  }
}

Enemy e1 = new Enemy(400, 0);

void INGAME()
{
  if (!SetLevel)
  {
    clearMushrooms();
    generateMushrooms();
    SetLevel = true;
  } else {
    for (Mushroom mushie : mushrooms)
    {
      mushie.display();
    }
  }

  if (!paused)
  {
    drawPixelsBackground();
    playerShip.update();
    bullets.updateBullets();
    updateEnemies();
  } else {
    fill(0, 255/2);
    rect(0, 0, width, height);
    PAUSE();
  }


  // Leave this last as it will draw over everything!!
  drawGameUI();


  //if (!paused)
  //{
  //  frameRate(60);
  //} else
  //{

  //  frameRate(0);
  //}
}

void GAMEOVER()
{
  fill(255, 0, 0);
  textSize(50);
  textAlign(CENTER);
  text("GAME OVER! YOU LOSE", width/2, height/2);
  textSize(20);
  text("Press M to go back to main menu", width/2, height/2+50);

  if (key == 'm' || key == 'M')
  {
    SetLevel = false;
    bullets.clearBullets();
    generateEnemies();
    gameState = MENU;
    Lives.setLives(3);
    Level.setLevel(1);
  }
}

void WIN()
{
  background(#111822);
  textAlign(CENTER);
  textSize(30);
  text("CONGRATULATIONS!!!", width/2, height/2);
  int nextLevel = Level.getLevel()+1;
  text("Press W to go to level " + nextLevel, width/2, height/2+40);

  if (key == 'w' || key == 'W')
  {
    SetLevel = false;
    gameState = MENU;
    bullets.clearBullets();
    Level.setLevel(Level.getLevel() + 1);
    generateEnemies();
    //changeScore(1000);
    println("On Level " + Level.getLevel());
  }
}

void PAUSE()
{
  textAlign(CENTER);
  textSize(30);
  fill(255, 0, 0);
  text("PAUSED!\nCreated using the advanced dimming display technology\nUnlike anything you've ever seen before\nFrom Faheem Saleem", width/2, height/2);
}

void SETTINGS()
{
}

void mousePressed()
{
  if (gameState == INGAME) bullets.addBullet();
}

void keyReleased()
{
  if (key == ' ') if (gameState == INGAME && !paused) bullets.addBullet();
  if (key == 'p' || key == 'P') paused = !paused;
}


void drawPixelsBackground()
{
  for (int i = 0; i<100; i++)
  {
    strokeWeight(2);
    stroke(random(255), random(255), random(255));
    point(random(width), random(height));
  }
}


void drawGameUI()
{
  // TODO: player lives, score and current level

  textAlign(LEFT);
  textSize(20);
  fill(#FEFF03);
  text("Score: " + playerScore, playerShip.x+20, playerShip.y+size/2);


  textAlign(LEFT);
  textSize(40);
  fill(#FEFF03);
  text("Lives: " + Lives.getLives(), 5, 40);
  textAlign(RIGHT);
  textSize(40);
  text("Enemies: " + getNumberofEnemies(), width-5, 40);
}
