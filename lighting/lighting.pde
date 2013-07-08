import java.util.List;
import java.util.LinkedList;

Maxim maxim;
List<Light> lights;
List<Light> lightsToRemove;

AudioPlayer[] lightSound;
int maxSounds = 3;
int lastPlayedSound;

void setup() {
  size(640, 480);
  background(0);
  
  maxim = new Maxim(this);
  lightSound = new AudioPlayer[maxSounds];
  for (int i = 0; i < lightSound.length; i++) {
    lightSound[i] = maxim.loadFile("lighting.wav");
    lightSound[i].setLooping(false); 
  }
  
  lights = new LinkedList<Light>();
  lightsToRemove = new LinkedList<Light>();
}

void draw() {
  for (Light light : lights) {
    light.draw();
    
    if (light.isFinished()) {
      lightsToRemove.add(light);
    }
  }
  
  if (! lightsToRemove.isEmpty()) {
    lights.removeAll(lightsToRemove);
    
    if (lights.isEmpty()) {
      clear();
    }
  }
}

void mousePressed() {
  lights.add(new Light(mouseX, 0, 5));
  
  lastPlayedSound++;
  if (lastPlayedSound >= maxSounds) {
    lastPlayedSound = 0;    
  }
  
  lightSound[lastPlayedSound].cue(0);
  lightSound[lastPlayedSound].play();
}

