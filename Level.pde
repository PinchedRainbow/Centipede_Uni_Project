SoundFile levelUp;

// Static so I dont need to make an object
static class Level
{
  static int currentLevel;
  static void setLevel(int level) { currentLevel = level; }
  static int getLevel() {return currentLevel; }
}
