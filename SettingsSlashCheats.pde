// cheats like uhh lives and level idk wtf

String inputLives, inputLevel;
CheckMark soundsCheckMark;
CheckMark spidersEnable;
CheckMark introScreen;

// -------- TO ADD ------------
// Cheats
//* AimBot
//* Remove mushies
//* Remove cooldown
//* Unlimited Lives
//* Set level to what u want
//* Set size of the centipede 
//* Strong ass bullet one taps everything (penetrates thru everyting)


void SETTINGS()
{
  background(#111822);
  drawPixelsBackground();

  Button menuButton = new Button(width/2-buttonWidth/2, (height/3)*2-(buttonHeight/2), "Menu");
  menuButton.showButton();
  if (menuButton.isClicked())
  {
    long future = System.currentTimeMillis() + 100;

    saveTable(settings, "data/config.csv");
    while (System.currentTimeMillis() < future)
    {
      saving();
    }
    currentState = gameStates.MENU;
    getSettings();
  }

  soundsCheckMark.update();
  spidersEnable.update();
  introScreen.update();


  if (soundsCheckMark.stateChanged())
  {
    settings.setInt(0, "Sound", soundsCheckMark.getState());
    soundEnabled = soundsCheckMark.getState() == 1 ? true : false;
    //
  }

  if (spidersEnable.stateChanged())
  {
    settings.setInt(0, "Spiders", spidersEnable.getState());
    //saveTable(settings, "data/config.csv");
    spiders = soundsCheckMark.getState() == 1 ? true : false;
  }

  if (introScreen.stateChanged())
  {
    settings.setInt(0, "Intro", introScreen.getState());
    //saveTable(settings, "data/config.csv");
    intro = soundsCheckMark.getState() == 1 ? true : false;
  }

  // input for
}

void saving()
{
  fill(0, 255/2);
  rect(-10, -10, width, height);
  textSize(60);
  text("Saving settings", width/2, height/2);
}
