int gameState;
int MENU = 0;
int INGAME = 1;
int GAMEOVER = 2;
int PAUSE = 3;
int SETTINGS = 4;
int WIN = 5;
boolean SetLevel = false;

void MENU()
{
  background(#111822);
  textSize(30);
  textAlign(CENTER);
  fill(255);
  text("Press A for mouse movement", width/2, height/2-30);
  text("Press B for keyboard movement", width/2, height/2+30);

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
  drawPixelsBackground();
  playerShip.update();
  bullets.updateBullets();

  //if (keyPressed) if (key == ' ' && gameState == INGAME && SetLevel) bullets.addBullet();
  drawGameUI();


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

  updateEnemies();
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
  }
}

void WIN()
{
  background(#111822);
  textAlign(CENTER);
  textSize(30);
  text("CONGRATULATIONS!!!", width/2, height/2);
  text("Press W to go to the next level!", width/2, height/2+40);

  if (key == 'w' || key == 'W')
  {
    SetLevel = false;
    gameState = MENU;
    bullets.clearBullets();
    Level.setLevel(Level.getLevel() + 1);
    generateEnemies();
    println("On Level " + Level.getLevel());
  }
}

void PAUSE()
{
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
  if (key == ' ') if (gameState == INGAME) bullets.addBullet();
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
  
  
  
}
