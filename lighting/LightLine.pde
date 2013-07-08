class LightLine {
  
  int[] startPos = new int[2];
  int[] pos = new int[2];
  int endY;
  int lightWidth;
  int lightLength;
  boolean finished;
  long time;
  int angle;
  
  LightLine(int startX, int startY, int w, int l, int angle) {
    startPos[0] = startX;
    startPos[1] = startY;    
    
    pos[0] = startX;
    pos[1] = startY;
    
    endY = startY + l;
    
    lightWidth = w;
    lightLength = l;
    
    this.angle = angle;
    
    time = millis();
  }
  
  void draw() {
    if (finished) return;
    
    if (millis() - time < 10) return;
    time = millis();
    
    float bend = (pos[1] < startPos[1] + lightLength/2 ? 1 : -1) * random(0, 4) * 2;
    
    int newX = pos[0] + (int) (random(-15, 15) + bend);
    int newY = pos[1] + (int) random(10, 30);
    
    pushMatrix();
    if (angle != 0) {
      translate(startPos[0], startPos[1]);
      rotate(radians(angle));
      translate(-startPos[0], -startPos[1]);
    }
    stroke(255);
    strokeWeight(lightWidth);
    line(pos[0], pos[1], newX, newY);
    /*if (angle != 0) {
      rotate(-radians(angle));
      translate(-pos[0], -pos[1]);
    }*/
    popMatrix();
    
    pos[0] = newX;
    pos[1] = newY;
    if (pos[1] > endY) {
      finished = true;
    }
  }
  
  int getCurLength() {
    return pos[1] - startPos[1];
  }
}
