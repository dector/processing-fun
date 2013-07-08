class Light {

  LightLine mainPart;
  LightLine[] smallParts;
  
  int branches;
  int lastBranch = -1;
  int branchStep;

  Light(int x, int y, int branches) {
    mainPart = new LightLine(x, y, 4, height, 0);
    
    this.branches = branches;
    smallParts = new LightLine[branches];
    
    branchStep = height/(branches + 1);
  }

  void draw() {
    mainPart.draw();
    
    for (LightLine line : smallParts) {
      if (line != null) line.draw();
    }
    
    int l = getCurLength();
    if ((lastBranch+2) * branchStep <= l && lastBranch+1 < branches && smallParts[lastBranch+1] == null) {
      println(l +"/"+ branchStep);
      lastBranch++;
      float angle = (lastBranch % 2 == 0) ? random(35, 55) : random(-55, -35);
      smallParts[lastBranch] = new LightLine(mainPart.pos[0], mainPart.pos[1], 1, height/2, (int) angle);        
    }  
  }
  
  boolean isFinished() {
    return mainPart.finished;
  }
  
  int getCurLength() {
    return mainPart.getCurLength(); 
  }
}

