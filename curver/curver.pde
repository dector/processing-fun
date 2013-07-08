import java.util.List;
import java.util.LinkedList;

List<Line> lines;
List<Line> toRemove;

void setup() {
  size(640, 480);
  background(0);
  colorMode(HSB, 500, 1, 1);
  
  lines = new LinkedList<Line>();
  toRemove = new LinkedList<Line>();
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
}

void mousePressed() {
  lines.add(new Line(mouseX, mouseY, 2));
}

void keyPressed() {
  switch (key) {
    case ' ':
      if (lines.isEmpty()) {
        clear();
      } else {
        lines.clear();
      }
      
      break;
  }
}
