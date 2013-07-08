class Light {

  int x, y;
  boolean finished;
  
  long time;

  Light(int x, int y) {
    this.x = x;
    this.y = y;
    
    time = millis();
  }

  void draw() {
    if (finished) return;
    
    if (millis() - time < 10) return;
    time = millis();
    
    float bend = (y < height/2 ? 1 : -1) * 1.5;
    
    int newX = x + (int) (random(-15, 15) * bend);
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

