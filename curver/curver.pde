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
