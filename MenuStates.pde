//int gameState;
int MENU = 0;
int INGAME = 1;
int GAMEOVER = 2;
int PAUSE = 3;
int SETTINGS = 4;
int WIN = 5;
int SPLASH = 6;
int HOWTOPLAY = 7;
int ENTERNAME = 8;
boolean SetLevel = false;
boolean paused = false;

float alpha = 0;
float alpha2 = 0;
float alpha3 = 0;
float alpha4 = 0;

int buttonWidth = 180;
int buttonHeight = 80;
int buttonRadius = 30;

SoundFile splashSound;
boolean played = false;


void ENTERNAME()
{
  background(#111822);
  textAlign(CENTER);
  textSize(50);
  fill(200);
  text("Enter your name:", width/2, height/2-60);

  fill(255);
  text(playerName, width/2, height/2);

  //if (keyPressed)
  //{
  //  if (key == CODED && key == ENTER)
  //  {
  //     gameState = MENU;
  //  }
  //  else playerName+=key;
  //}
}


void HOWTOPLAY()
{
  background(#111822);
  fill(255);
  textSize(60);
  text("How to play", width/2, 100);

  fill(200);
  textSize(20);
  text("Welcome to Centipede!\nThe aim of the game is to destory each enemy in the level and get the highest score possible!\nYou have the option to control the player with Keyboard or Mouse\n"+
    "Press the mouse button or spacebar to shoot a bullet\nAim for the head of the centipede to destory in one go!\nOtherwise it gets into a bit of a mess :D\nDestory the mushrooms to make an easier path for the bullets" +
    "\nDon't let any enemy touch the bottom of the screen.. otherwise.. life taken away :(" +
    "\nHere is how the score is awarded:\nCentipede head: 100\nCentipede body: 10\nMushroom: 4\nYou can also pause by pressing P ;)", width/2, 140);

  // go back button time
  fill(#5F5B5B);
  rect(100, height-100, buttonWidth, buttonHeight, buttonRadius);
  fill(255);
  text("Menu", 100 + buttonWidth/2, (height-100) + buttonHeight/2);

  if (mousePressed)
  {
    if (mouseX > 100 && mouseX < 100 + buttonWidth && mouseY > height-100 && mouseY < (height-100) + buttonHeight) currentState = gameStates.MENU;
  }
}

void SPLASH()
{
  background(#111822);

  textSize(30);
  fill(alpha);
  textAlign(CENTER);
  //text("Faheem Saleem presents to you", width/2, height/2);
  //alpha+=2;

  fill(alpha);
  text("Faheem", width/3, height/2);
  alpha+=4;

  fill(alpha2);
  text("Saleem", width/2, height/2);

  fill(alpha3);
  text("Presents", width/3*2, height/2);

  fill(alpha4);
  textSize(80);
  text("CENTIPEDE", width/2, height/2+100);

  if (!played)
  {
    played = !played;
    splashSound.play();
  }

  if (alpha <= 255)
  {
  } else if (alpha >= 255)
  {
    if (alpha2 <= 255)
    {
      alpha2+=4;
    } else if (alpha2 >= 255)
    {
      if (alpha3 <= 255)
      {

        alpha3+=6;
      } else if (alpha3 >= 255)
      {
        if (alpha4 <= 255)
        {

          alpha4+=2;
        } else if (alpha4 > 255)
        {
          currentState = gameStates.ENTERNAME;
        }
      }
    }
  }
}

void drawCity()
{
  image(city, 0, height-150);
}


void MENU()
{
  background(#111822);
  textAlign(CENTER);
  //text("Press A for mouse movement", width/2, height/3);
  //text("Press B for keyboard movement", width/2, height/3+30);

  textSize(60);
  text("Play with", width/2, height/4);

  // button 1
  fill(#5F5B5B);
  rect(width/4, height/3, buttonWidth, buttonHeight, buttonRadius);
  textSize(30);
  fill(255);
  text("Mouse", width/4 + buttonWidth/2, height/3 + buttonHeight/2);

  // button 2
  fill(#5F5B5B);
  rect(width/4 * 2, height/3, buttonWidth, buttonHeight, buttonRadius);
  fill(255);
  text("Keyboard", (width/4 * 2) + buttonWidth/2, height/3 + buttonHeight/2);

  // button 3
  fill(#5F5B5B);
  rect(width/2-buttonWidth/2, height-100, buttonWidth, buttonHeight, buttonRadius);
  fill(255);
  text("How to play", width/2, (height-100) + buttonHeight/2);

  textSize(40);
  text("Current game info", width/2, height/2+60);
  text("Lives: " + Lives.getLives() + " | Level: " + Level.getLevel() + " | Score: " + playerScore + "\n" + playerName, width/2, height/2+100);

  if (mousePressed) {
    if (mouseX > width/4 && mouseX < width/4 + buttonWidth && mouseY > height/3 && mouseY < height/3 + buttonHeight)
    {
      StartGame(true);
    } else if (mouseX > (width/4)*2 && mouseX < (width/4)*2 + buttonWidth && mouseY > height/3 && mouseY < height/3 + buttonHeight)
    {
      StartGame(false);
    } else if (mouseX > width/2-buttonWidth/2 && mouseX < width/2 + buttonWidth/2 && mouseY > height-100 && mouseY < (height-100) + buttonHeight) currentState = gameStates.HOWTOPLAY;
  }

}

void StartGame(boolean useMouse)
{
  SetLevel = false;
  resetEnemies();
  generateEnemies();
  playerShip = new Player(width/2, height-20, speed, useMouse, size);
  currentState = gameStates.INGAME;
}


void INGAME()
{
  if (!SetLevel && Level.getLevel() == 1)
  {
    mushList.clearMushrooms();
    mushList.generateMushrooms();
    SetLevel = true;
  } else {
    for (Mushroom mushie : mushList.mushrooms)
    {
      mushie.display();
    }
  }

  if (!paused)
  {
    //drawPixelsBackground();
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

  if (keyPressed) {
    if (key == 'm' || key == 'M')
    {
      SetLevel = false;
      bullets.clearBullets();
      generateEnemies();
      currentState = gameStates.MENU;
      Lives.setLives(3);
      Level.setLevel(1);
      setScore(0);
    }
  }
}

void WIN()
{
  for (Mushroom mushie : mushList.mushrooms)
  {
    mushie.display();
  }

  fill(0, 255/2);
  rect(0, 0, width, height);
  textAlign(CENTER);
  fill(255);
  textSize(30);
  text("CONGRATULATIONS!!!", width/2, height/2);
  int nextLevel = Level.getLevel()+1;
  text("Press W to go to level " + nextLevel, width/2, height/2+40);

  drawCity();

  if (keyPressed) {
    if (key == 'w' || key == 'W')
    {
      SetLevel = false;
      bullets.clearBullets();
      Level.setLevel(Level.getLevel() + 1);
      resetEnemies();
      generateEnemies();
      currentState = gameStates.INGAME;
      //changeScore(1000);
    }
  }
}

void PAUSE()
{
  textAlign(CENTER);
  textSize(30);
  fill(255, 0, 0);
  text("PAUSED!\nCreated using the advanced dimming display technology\nUnlike anything you've ever seen before\nFrom Faheem Saleem", width/2, height/2);

  fill(255);
  textSize(40);
  text("Current game info", width/2, height/3);
  text("Lives: " + Lives.getLives() + " | Level: " + Level.getLevel() + " | Score: " + playerScore, width/2, height/3+40);
}

void SETTINGS()
{
}

void mousePressed()
{
  if (currentState == gameStates.INGAME) bullets.addBullet();
}

void keyReleased()
{
  if (key == ' ') if (currentState == gameStates.INGAME && !paused) bullets.addBullet();
  if (key == 'p' || key == 'P') paused = !paused;
  if (currentState == gameStates.ENTERNAME)
  {
    if (key == ENTER && playerName != "")
    {
      currentState = gameStates.MENU;
    }
    if (key == BACKSPACE)
    {
      playerName = removeLastChar(playerName);
    } else if (key != CODED) playerName+=key;
  }
}

private String removeLastChar(String s)
{
  //returns the string after removing the last character
  return s.substring(0, s.length() - 1);
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
  text("Score: " + playerScore, 5, 60);


  textAlign(LEFT);
  textSize(40);
  fill(#FEFF03);
  text("Lives: " + Lives.getLives(), 5, 40);
  textAlign(RIGHT);
  textSize(40);
  text("Enemies: " + getNumberofEnemies(), width-5, 40);
  textSize(20);
  text("Level " + Level.getLevel(), width-5, 60);

  drawCity();

  for (int i = 0; i < Lives.getLives(); i++)
  {
    PImage live = playerShip.img;
    image(live, ((i*(size*1.5)))+20, height-20);
  }
}
