class Line {
  
  final int DRAW_TIME = 5;
  final int BUFFER_ZONE = max(width / 3, height / 3);
  
  int x, y;
  boolean drawing;
  long lastTime;
  
  int strokeW;
  
  color lineColor;
  
  Line(int x, int y, int strokeW) {
    this.x = x;
    this.y = y;
    this.strokeW = strokeW;
    
    lineColor = color((int) random(1, 500), 100, 100);
    
    lastTime = millis();
    drawing = true;
  }
  
  void draw() {
    strokeWeight(strokeW);
  
    while (drawing) {
      long currTime = millis();
      if (currTime - lastTime < DRAW_TIME) {
        break;
      }
      
      long partsCount = (currTime - lastTime) / DRAW_TIME;
      for (int i = 0; i < partsCount; i++) {
        drawPart();
      }
      lastTime = currTime;
    }
  }
  
  void drawPart() {
    //lineColor = color(hue(lineColor)
    //  + (int) random(-50, 50), 100, 100);
    stroke(lineColor);
  
    int cc = hue(lineColor) + (int) random(-5, 15);
    lineColor = color((cc > 0) ? cc : 1, 100, 100);  
    
    int byX = (int) random(-15, 15);
    int byY = (int) random(-15, 15);
    
    int newX = x + byX;
    int newY = y + byY;
    
    line(x, y, newX, newY);
    
    x = newX;
    y = newY;
    
    if (x < 0 - BUFFER_ZONE || x > width + BUFFER_ZONE || y < 0 - BUFFER_ZONE || y > height + BUFFER_ZONE) {
      drawing = false;
      //println("finished");
    }
  }
}
