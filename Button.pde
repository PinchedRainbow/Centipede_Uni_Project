class Button
{
  int buttonWidth = 180;
  int buttonHeight = 80;
  int buttonRadius = 30;
  int x, y;
  String text;
  float radius;
  float stroke;
  float fill;

  Button(int x, int y, String text)
  {
    this.x = x;
    this.y = y;
    this.text = text;
  }
  
  void showButton()
  {
    float distance = dist(mouseX, mouseY, x+buttonWidth/2, y+buttonHeight/2);
    stroke(255, distance, distance);
    fill(#5F5B5B, 50+distance);
    
    rect(x, y, buttonWidth, buttonHeight, buttonRadius);
    fill(255);
    textAlign(CENTER);
    textSize(30);
    text(text, x+buttonWidth/2, y+buttonHeight/2);
  }
  
  // Method that gets called when mouse is pressed on the button
  boolean isClicked()
  {
    // Guard clause!! (kinda)
    if (!mousePressed) return false;
    return (mouseX >= x && mouseX <= x + buttonWidth && mouseY >= y && mouseY <= y + buttonHeight);
  }
}
