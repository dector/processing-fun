class Line {
  
  final int DRAW_TIME = 5;
  final int BUFFER_ZONE = max(width / 3, height / 3);
  
  int x, y;
  boolean drawing;
  long lastTime;
  
  int stroke;
  
  color lineColor = color(0, 100, 100);
  
  Line(int x, int y, int stroke) {
    this.x = x;
    this.y = y;
    this.stroke = stroke;
    
    lineColor = color((int) random(0, 500), 100, 100);
    
    lastTime = millis();
    drawing = true;
  }
  
  void draw() {
    strokeWeight(stroke);
  
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
  
    lineColor = color(hue(lineColor)
        + (int) random(-5, 15), 100, 100);  
    
    int byX = (int) random(-15, 15);
    int byY = (int) random(-15, 15);
    
    int newX = x + byX;
    int newY = y + byY;
    
    line(x, y, newX, newY);
    
    x = newX;
    y = newY;
    
    if (x < 0 - BUFFER_ZONE || x > width + BUFFER_ZONE || y < 0 - BUFFER_ZONE || y > height + BUFFER_ZONE) {
      drawing = false;
      println("finished");
    }
  }
}
