class FrameRecorder {
  
  String name;
  int index;
  
  long captureTime;
  long timestamp;
  
  boolean started;
  
  FrameRecorder(String name) {
    this(name, 1000/25);
  }
  
  FrameRecorder(String name, long captureTime) {
    this.name = name;
    this.captureTime = captureTime;
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
    if (! started) return;
    
    long currTime = millis();
    if (currTime - timestamp < captureTime) return;
    
    timestamp = currTime;
    
    saveFrame("frames/"+ name +"-"+ index +".tiff");
    index++;
  }
}
