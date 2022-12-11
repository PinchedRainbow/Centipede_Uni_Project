import processing.sound.*;
import java.util.Scanner;

enum gameStates
{
  MENU,
    INGAME,
    GAMEOVER,
    PAUSE,
    SETTINGS,
    WIN,
    SPLASH,
    HOWTOPLAY,
    ENTERNAME
}

gameStates currentState;

int speed = 10;
int size = 20;
int playerScore = 0;
int COOLDOWN = 400;
long lastShot = System.currentTimeMillis();
PImage[] centiBodies = new PImage[8];
PImage[] centiHeads = new PImage[8];
PImage city;

String playerName = "";


void setup()
{
  size(800, 800);
  surface.setTitle("Centipede - Faheem Saleem");
  //gameState = SPLASH;
  createHighScoreFile();
  Level.setLevel(1);
  Lives.setLives(3);
  loadAssets();
  currentState = gameStates.SPLASH;
}

void loadAssets()
{
  shootSFX = new SoundFile(this, "sounds/shoot.mp3");
  splitSound = new SoundFile(this, "sounds/explode.mp3");
  hit = new SoundFile(this, "sounds/hit.mp3");
  levelUp = new SoundFile(this, "sounds/levelUp.mp3");
  splashSound = new SoundFile(this, "sounds/countDown.mp3");
  
  for (int i = 0; i < centiBodies.length; i++)
  {
    centiBodies[i] = loadImage("images/body" + (i+1) + ".png");
    centiHeads[i] = loadImage("images/head" + (i+1) + ".png");
    
    centiBodies[i].resize(size, size);
    centiHeads[i].resize(size, size);
  }
  
  city = loadImage("images/city.png");
}


void draw()
{
  background(0);
  
  switch(currentState)
  {
    case SPLASH: SPLASH(); break;
    case ENTERNAME: ENTERNAME(); break;
    case MENU: MENU(); break;
    case INGAME: INGAME(); break;
    case PAUSE: PAUSE(); break;
    case GAMEOVER: GAMEOVER(); break;
    case SETTINGS: SETTINGS(); break;
    case WIN: WIN(); break;
    case HOWTOPLAY: HOWTOPLAY(); break;
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


void createHighScoreFile()
{
  try {
    File f = new File("highscores.txt");
    if (f.createNewFile())
    {
      // creates highscore file
      PrintWriter file = createWriter("highscores.txt");
      file.println("--- HighScores in Centipede ----");
      file.flush();
      file.close();
      println("Created highscore file!!!");
    } else {
      println("Found existing highscore file");
    }
  }
  catch(IOException e)
  {
    println("I have no idea but uhh yea here u go " + e);
  }
}

// Could do 2 seperate methods for incresae and decrease but prefer to just use one method and use parameter with minus scoring nstead
void changeScore(int score)
{
  playerScore+=score;
}

void setScore(int newScore) { playerScore = newScore; }
