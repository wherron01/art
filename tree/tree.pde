/** Grow factorial branches off a tree.  Change DMAX, the strokeWeights, and the strokes.
  * An art piece by Willow Herron
  */

final int DMAX = 10;

void setup() {
  size(800,800);
  background(255,0,0);
  colorMode(RGB, DMAX);
  //strokeWeight(DMAX);
  line(width/2, height/4, width/2, height);
  drawBranches(width/2, height, width/2, height/4, DMAX);
  save("example.png");
  exit();
}
void drawBranches(float tx1, float ty1, float tx2, float ty2, int depth) {
  if(depth <= 0) return;
  float xlen = tx2-tx1;
  float ylen = ty2-ty1;
  float trunklen = sqrt(xlen*xlen+ylen*ylen);
  for(int j = 0; j < depth; j++) {
    float pos = 0.25+3*(noise(j+depth*100000)/4);
    float x1 = (pos*xlen)+tx1;
    float y1 = (pos*ylen)+ty1;
    float len = random(trunklen/4, 3*trunklen/4);
    float angle = random(2*PI);
    float xv = cos(angle);
    float yv = sin(angle);
    float x2 = x1 + len*xv;
    float y2 = y1 + len*yv;
    stroke((DMAX-depth));
    //strokeWeight(depth);
    line(x1, y1, x2, y2);
    drawBranches(x1, y1, x2, y2, depth-1);
  }
}
