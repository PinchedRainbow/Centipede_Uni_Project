import processing.sound.*;
import java.util.Scanner;

Table highscoreTable;

gameStates currentState; 

int speed = 10; 
int size = 20;
int playerScore = 0;
int COOLDOWN = 400;
long lastShot = System.currentTimeMillis();

PImage city;
PImage playerImg;
ArrayList<PImage> characters = new ArrayList<>();

String playerName = "";
SoundFile keySFX;


void setup()
{
  size(800, 800);
  surface.setTitle("Centipede - Faheem Saleem");
  //gameState = SPLASH;
  Level.setLevel(1);
  Lives.setLives(3);
  loadAssets();
  createHighscore();
  currentState = gameStates.SPLASH;
}

void loadAssets()
{
  shootSFX = new SoundFile(this, "sounds/shoot.mp3");
  splitSound = new SoundFile(this, "sounds/explode.mp3");
  hit = new SoundFile(this, "sounds/hit.mp3");
  levelUp = new SoundFile(this, "sounds/levelUp.mp3");
  splashSound = new SoundFile(this, "sounds/countDown.mp3");
  gameOver = new SoundFile(this, "sounds/gameOver.mp3");
  keySFX = new SoundFile(this, "sounds/key.mp3");

  for (int i = 0; i < centiBodies.length; i++)
  {
    centiBodies[i] = loadImage("images/body" + (i+1) + ".png");
    centiHeads[i] = loadImage("images/head" + (i+1) + ".png");
    
    scorpions[i] = loadImage("images/s" + i + ".png");

    centiBodies[i].resize(size, size);
    centiHeads[i].resize(size, size);
    
    scorpions[i].resize(size+int(size/2), 0);
  }

  city = loadImage("images/city.png");
  
  for (int i = 0; i < 2; i++)
  {
    characters.add(loadImage("images/player" + i + ".png"));
  }
  
  playerImg =loadImage("images/player.png");
  
}

void createHighscore()
{
  highscoreTable = loadTable("data/scores.csv", "header");
  if (highscoreTable == null)
  {
    highscoreTable = new Table();
    println("Creating highscore file!");
    highscoreTable.addColumn("Name");
    highscoreTable.addColumn("Score");
    highscoreTable.addColumn("Level");
    saveTable(highscoreTable, "data/scores.csv");
  } else {
    println("Loaded highscore file!");
  }
}

void draw()
{
  background(0);

  switch(currentState)
  {
  case SPLASH:
    SPLASH();
    break;
  case ENTERNAME:
    ENTERNAME();
    break;
  case MENU:
    MENU();
    break;
  case INGAME:
    INGAME();
    break;
  case PAUSE:
    PAUSE();
    break;
  case GAMEOVER:
    GAMEOVER();
    break;
  case SETTINGS:
    SETTINGS();
    break;
  case WIN:
    WIN();
    break;
  case HOWTOPLAY:
    HOWTOPLAY();
    break;
  case HIGHSCORES:
    HIGHSCORES();
    break;
  }

  //if (gameState == SPLASH) SPLASH();
  //if (gameState == ENTERNAME) ENTERNAME();
  //if (gameState == MENU) MENU();
  //if (gameState == INGAME) INGAME();
  //if (gameState == GAMEOVER) GAMEOVER();
  //if (gameState == PAUSE) PAUSE();
  //if (gameState == SETTINGS) SETTINGS();
  //if (gameState == WIN) WIN();
  //if (gameState == HOWTOPLAY) HOWTOPLAY();
}


//void createHighScoreFile()
//{
//  try {
//    File f = new File("highscores.txt");
//    println(f.getAbsolutePath());
//    if (f.createNewFile())
//    {
//      // creates highscore file
//      //PrintWriter file = createWriter("highscores.txt");
//      //FileOutputStream fos = null;
//      //file.println("--- HighScores in Centipede ----");
//      //file.flush();
//      //file.close();
//      println("Created highscore file!!!");
//    } else {
//      println("Found existing highscore file");
//    }
//  }
//  catch(IOException e)
//  {
//    println("I have no idea but uhh yea here u go " + e);
//  }
//}

// Could do 2 seperate methods for incresae and decrease but prefer to just use one method and use parameter with minus scoring nstead
void changeScore(int score)
{
  playerScore+=score;
}

void setScore(int newScore) {
  playerScore = newScore;
}

void saveHighscore(String name, int score, int level)
{
  highscoreTable.addRow();
  //println(highscoreTable.getRowCount() + " total rows in table");
  highscoreTable.setString(highscoreTable.getRowCount() - 1, "Name", name);
  highscoreTable.setInt(highscoreTable.getRowCount()-1, "Score", score);
  highscoreTable.setInt(highscoreTable.getRowCount()-1, "Level", level);
  saveTable(highscoreTable, "data/scores.csv");
}
