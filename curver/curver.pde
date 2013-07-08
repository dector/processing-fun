import java.util.List;
import java.util.LinkedList;

List<Line> lines;
List<Line> toRemove;

FrameRecorder recorder;

void setup() {
  size(640, 480);
  background(0);
  colorMode(HSB, 500, 1, 1);
  
  lines = new ArrayList<Line>();
  toRemove = new ArrayList<Line>();
  
  recorder = new FrameRecorder("curver");
  recorder.setEnabled(false);
}

void draw() {
  for (Line line : lines) {
    line.draw();
    
    if (! line.drawing) {
      toRemove.add(line);
    }
  }
  
  if (! toRemove.isEmpty()) {
    lines.removeAll(toRemove);
    toRemove.clear();
  }
  
  recorder.capture();
}

void mousePressed() {
  lines.add(new Line(mouseX, mouseY, 2));
  
  recorder.recStart();
}

void keyPressed() {
  switch (key) {
    case ' ':
      if (lines.isEmpty()) {
        clear();
      } else {
        lines.clear();
      }
      
      recorder.recStop();  
      break;
    case '1':
      recorder.setEnabled(true);
      break;
    case '2':
      recorder.setEnabled(false);
      break;
  }
}
class FrameRecorder {
  
  String name;
  int index;
  
  long captureTime;
  long timestamp;
  
  boolean enabled;
  boolean started;
  
  FrameRecorder(String name) {
    this(name, 1000/25);
  }
  
  FrameRecorder(String name, long captureTime) {
    this.name = name;
    this.captureTime = captureTime;
    
    setEnabled(true);
  }
  
  void setEnabled(boolean enabled) {
    this.enabled = enabled;
    
    println("Frame Recorder `"+ name +"` "+ (enabled ? "on" : "off"));
  }
  
  void recStart() {
    if (started) return;
    
    timestamp = millis();
    started = true;
  }
  
  void reset() {
    index = 0;
  }
  
  void recStop() {
    started = false;
  }
  
  void capture() {
    if (! enabled) return;
    if (! started) return;
    
    long currTime = millis();
    if (currTime - timestamp < captureTime) return;
    
    timestamp = currTime;
    
    saveFrame("frames/"+ name +"-"+ index +".tiff");
    index++;
  }
}
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

