class Button
{
  int buttonWidth = 180;
  int buttonHeight = 80;
  int buttonRadius = 30;
  int x, y;
  String text;
  float radius;

  Button(int x, int y, String text)
  {
    this.x = x;
    this.y = y;
    this.text = text;
  }
  
  void showButton()
  {
    fill(#5F5B5B);
    rect(x, y, buttonWidth, buttonHeight, buttonRadius);
    fill(255);
    textAlign(CENTER);
    textSize(30);
    text(text, x+buttonWidth/2, y+buttonHeight/2);
  }
  
  boolean isClicked()
  {
    if (!mousePressed) return false;
    if (mouseX >= x && mouseX <= x + buttonWidth && mouseY >= y && mouseY <= y + buttonHeight)
    {
      return true;
    }
    else{ return false; }
  }
}
