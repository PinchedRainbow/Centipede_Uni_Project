int gameState;
int MENU = 0;
int INGAME = 1;
int GAMEOVER = 2;
int PAUSE = 3;
int SETTINGS = 4;
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
    playerShip = new Player(width/2, height-20, speed, true, size);
    gameState = INGAME;
  } else if (key == 'b' || key == 'B')
  {
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
  updateEnemies();

  if (!SetLevel)
  {
    generateMushrooms();
    SetLevel = true;
  }
  else{
    for (Mushroom mushie : mushrooms)
    {
      mushie.display();
    }
  }
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
    resetEnemies();
    gameState = MENU;
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

void drawPixelsBackground()
{
  for (int i = 0; i<100; i++)
  {
    strokeWeight(2);
    stroke(random(255), random(255), random(255));
    point(random(width), random(height));
  }
}
