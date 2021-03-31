/** Recursively splits the screen orthogonally until max recursion depth is reached or screen is filled with splitlines
  * An art piece by Willow Herron
  */
final int DEPTH_MAX = 50; //Hard limit on recursion depth.  Runtime is proportional to 2^this in worst  case.  Should be increased for a larger screen size if full fill is desired.  However, if set too high, it will be unusable for calculating colors with depth.

void setup() {
  size(1000, 1000); //Fills this entire space.  Larger is more detailed and slower.  
  strokeWeight(1);
  colorMode(HSB, 1); //HSB is nice for hue rotation with x and y, while RGB is better for specific two-color gradients, which usually look decent.
  recursiveSplit(0, 0, 0, width, height, false);
  save("example.png");
  exit();
}
void recursiveSplit(int depth, double x, double y, double w, double h, boolean axis) {
  if(w < 1 || h < 1 || depth < 0 || depth > DEPTH_MAX) return;
  double s = splitlinePosition(depth, x, y, w, h);
  stroke(colorize(depth, x, y, w, h, s));
  double x1 = x + (axis ? 0 : w*s);
  double x2 = x + (axis ? w : w*s);
  double y1 = y + (!axis ? 0 : h*s);
  double y2 = y + (!axis ? h : h*s);
  line((float)x1, (float)y1, (float)x2, (float)y2);
  recursiveSplit(depth+1, x, y, axis ? w : w*s, axis ? h*s : h, !axis);
  recursiveSplit(depth+1, x1, y1, axis ? w : w*(1-s), axis ? h*(1-s) : h, !axis);
}
/**
  * Returns a value between zero and one which decides where to split the box.  
  * For interesting and unique patterns, should incorporate randomness.
  * Can be modified to weight towards specific orientations, fill areas of the screen more densely, or generate different patterns.can be modified to weight towards specific orientations, fill areas of the screen more densely, or generate different patterns.
  */
double splitlinePosition(int depth, double x, double y, double w, double h) {
  return random(1);
}
/**
  * Returns a color for the given splitline.
  * Depth should almost always be used in this if the distinct splitlines are to be seen, but smooth.  It works very nicely in brightness.  
  * Other fun options:  tying hue to x and y.  
  */
color colorize(int depth, double x, double y,  double w, double h, double s) {
  return color((float)depth/DEPTH_MAX);
}
