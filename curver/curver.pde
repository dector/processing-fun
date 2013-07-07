void setup() {
  size(640, 480);
  background(0);
  colorMode(HSB, 500, 1, 1);
}

boolean drawing = false;
int x = (int) random(0, width);
int y = (int) random(0, height);

int drawTime = 5;
long lastTime = millis();

color lineColor = color(0, 100, 100);

void draw() {
  strokeWeight(2);
  
  while (drawing) {
    long currTime = millis();
    if (currTime - lastTime < drawTime) {
      break;
    }
    
    long partsCount = (currTime - lastTime) / drawTime;
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
  
  println(hue(lineColor));
  
  int byX = (int) random(-15, 15);
  int byY = (int) random(-15, 15);
  
  int newX = x + byX;
  int newY = y + byY;
  
  line(x, y, newX, newY);
  
  x = newX;
  y = newY;
  
  if (x < 0 || x > width || y < 0 || y > height) {
    drawing = false;
    println("finished");
  }
}

void mousePressed() {
  drawing = true;
  x = mouseX;
  y = mouseY;
  //x = (int) random(0, width);
  //y = (int) random(0, height);
  lastTime = millis();
}

void keyPressed() {
  if (key == ' ') {
    clear();
  }
}
