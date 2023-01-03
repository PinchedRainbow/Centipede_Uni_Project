// cheats like uhh lives and level idk wtf

String inputLives, inputLevel;

void SETTINGS()
{
  background(#111822);
  drawPixelsBackground();

  Button menuButton = new Button(100-buttonWidth/2, 50-buttonHeight/2, "Menu");
  menuButton.showButton();
  if (menuButton.isClicked())
  {
    currentState = gameStates.MENU;
  }
  // input for 
}
