Maxim maxim;
AudioPlayer lightSound;
Light light;

void setup() {
  size(640, 480);
  background(0);

  maxim = new Maxim(this);
  lightSound = maxim.loadFile("lighting.mp3");
  lightSound.setLooping(false);
}

void draw() {
  if (light != null) {
    light.draw();
  }
}

void mousePressed() {
  light = new Light((int) random(0, width), 0);
  lightSound.cue(0);
  lightSound.play();
}

