int speed = 10;
int size = 20;


void setup()
{
  size(800, 800);
  gameState = MENU;
  createHighScoreFile();
  Level.setLevel(1);
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
