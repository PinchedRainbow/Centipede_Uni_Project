int gameState;
int MENU = 0;
int INGAME = 1;
int GAMEOVER = 2;
int PAUSE = 3;
int SETTNIGS = 4;

void MENU()
{}


void INGAME()
{
  drawPixelsBackground();
  playerShip.update();
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
