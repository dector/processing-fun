class Light {

  int x, y;
  boolean finished;

  Light(int x, int y) {
    this.x = x;
    this.y = y;
  }

  void draw() {
    if (finished) return;
    
    int newX = x + (int) random(-15, 15);
    int newY = y + (int) random(10, 30);
    
    stroke(255);
    line(x, y, newX, newY);
    
    x = newX;
    y = newY;
    if (y > height) {
      finished = true;
      clear();
    }
  }
}

