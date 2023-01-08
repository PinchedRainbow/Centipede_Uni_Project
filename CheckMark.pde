class CheckMark
{
  // has on or off state, x, y, texts for each button ig but not neccessary just on or off really
  int x, y, x1;
  int state;
  int size = 50;
  int count = 1;
  float alpha0, alpha1;
  String text;

  CheckMark(int x, int y, int state, String text)
  {
    this.x = x;
    this.y = y;
    this.x1 = x + int((size*1.5));
    this.state = state;
    this.text = text;
  }

  int getState() {
    return state;
  }
  
  void update()
  {
    display();
    listenForChanges();
  }

  void display()
  {
    float distance = dist(mouseX, mouseY, x+buttonWidth/2, y+buttonHeight/2);
    stroke(255, distance, distance);
    //fill(#5F5B5B, 50+distance);
    if (state == 1)
    {
      alpha0 = 20;
      alpha1 = 255;
    } else if (state == 0)
    {
      alpha0 = 255;
      alpha1 = 20;
    }

    textSize(40);
    text(text, x-90, y+37);

    textSize(20);

    // true
    fill(#5F5B5B, alpha1);
    rect(x, y, size, size);
    fill(255);
    text("On", x+size/2, y+size/2);

    // false
    fill(#5F5B5B, alpha0);
    rect(x1, y, size, size);
    fill(255);
    text("Off", x1+size/2, y+size/2);
  }

  void listenForChanges()
  {
    if (!mousePressed) return;
    if (mouseX >= x && mouseX <= x+size && mouseY>=y && mouseY <= y+size) {
      state = 1;
      stateChanged();
    }
    else if (mouseX >= x1 && mouseX <= x1+size && mouseY>=y && mouseY <= y+size) {
      state = 0;
      stateChanged();
    }
  }

  boolean stateChanged() {
    return true;
  }
}
