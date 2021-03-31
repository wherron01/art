/** Recursively splits the screen into arbitrary quadrilaterals until max recursion depth is reached or screen is filled with splitlines
  * An art piece by Willow Herron
  * Much more complex and resource-intensive than ortho- variant.
  */
final int DEPTH_MAX = 30; //Hard limit on recursion depth.  Runtime is proportional to 2^this in worst  case.  Should be increased for a larger screen size if full fill is desired.  However, if set too high, it will be unusable for calculating colors with depth.

void setup() {
  size(200, 200); //Fills this entire space.  Larger is more detailed and slower.
  colorMode(RGB, 1);
  strokeWeight(1);
  recursiveSplit(0, 0, 0, 0, height, width, 0, width, height, false);
  save("example.png");
  exit();
}
void recursiveSplit(int depth, double x00, double y00, double x01, double y01, double x10, double y10, double x11, double y11, boolean axis) {
  if((((x00-x01)*(x00-x01))+((y00-y01)*(y00-y01)) < 1 && ((x10-x11)*(x10-x11))+((y10-y11)*(y10-y11)) < 1) || (((x00-x10)*(x00-x10))+((y00-y10)*(y00-y10)) < 1 && ((x01-x11)*(x01-x11))+((y01-y11)*(y01-y11)) < 1) || depth < 0 || depth > DEPTH_MAX) { 
    return;
  } //Exit conditions: opposite side lengths are both less than one, or max depth is reached.  
  double s1 = splitlinePosition(depth, x00, y00, x01, y01, x10, y10, x11, y11, true);
  double s2 = splitlinePosition(depth, x00, y00, x01, y01, x10, y10, x11, y11, true);
  double x1, y1, x2, y2;
  if(axis) {
    x1 = x00+((x01-x00)*s1);
    y1 = y00+((y01-y00)*s1);
    x2 = x10+((x11-x10)*s2);
    y2 = y10+((y11-y10)*s2);
    recursiveSplit(depth+1, x00, y00, x1, y1, x10, y10, x2, y2, false); //<>//
    recursiveSplit(depth+1, x1, y1, x01, y01, x2, y2, x11, y11, false);
  } else {
    x1 = x00+((x10-x00)*s1);
    y1 = y00+((y10-y00)*s1);
    x2 = x01+((x11-x01)*s2);
    y2 = y01+((y11-y01)*s2);
    recursiveSplit(depth+1, x00, y00, x01, y01, x1, y1, x2, y2, true); //<>//
    recursiveSplit(depth+1, x1, y1, x2, y2, x10, y10, x11, y11, true);
  }
  stroke(colorize(depth, x00, y00, x01, y01, x10, y10, x11, y11, s1, s2));
  line((float)x1, (float)y1, (float)x2, (float)y2);
}
/**
  * Returns a value between zero and one which decides where to split the box.  
  * For interesting and unique patterns, should incorporate randomness.
  */
double splitlinePosition(int depth, double x00, double y00, double x01, double y01, double x10, double y10, double x11, double y11, boolean first) {
  return random(1);
}
/**
  * Returns a color for the given splitline.
  * Depth should almost always be used in this if the distinct splitlines are to be seen, but smooth.  It works very nicely in brightness.  
  */
color colorize(int depth, double x00, double y00, double x01, double y01, double x10, double y10, double x11, double y11, double s1, double s2) {
  return color((float)depth/DEPTH_MAX);
}
