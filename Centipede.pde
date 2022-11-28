int speed = 10;
int size = 20;
int playerScore = 0;


void setup()
{
  size(800, 800);
  gameState = MENU;
  createHighScoreFile();
  Level.setLevel(1);
  Lives.setLives(3);
  //generateEnemies();
}


void draw()
{
  background(0);
  if (gameState == MENU) MENU();
  if (gameState == INGAME) INGAME();
  if (gameState == GAMEOVER) GAMEOVER();
  if (gameState == PAUSE) PAUSE();
  if (gameState == SETTINGS) SETTINGS();
  if (gameState == WIN) WIN();
}


void createHighScoreFile()
{
  File f = new File("highscores.txt");
  if (!f.exists())
  {
    // creates highscore file
    PrintWriter file = createWriter("highscores.txt");
    file.println("--- HighScores in Centipede ----");
    file.flush();
    file.close();
    println("Created highscore file!!!");
  }
  else{ println("Found existing highscore file");}
}

// Could do 2 seperate methods for incresae and decrease but prefer to just use one method and use parameter with minus scoring nstead 
void changeScore(int score)
{
  playerScore+=score;
}
