/** Casts rays from the center with negative r jerk, positive initial r velocity, and constant theta velocity
  * An art piece by Willow Herron
  */

//Runtime is proportional to the product of these resolutions.  
final int R_RESOLUTION = 1000;
final int THETA_RESOLUTION = 1000;

void setup() {
  size(400,400); //Scales canvas.  Runtime is agnostic of this.
  colorMode(HSB,1);
  background(0);
  strokeWeight(1);
  cast(0.001, 0.1, 2*PI/3);
  save("example.png");
  //exit(); //Preview?
}

void cast(double rjerk, double rvelocityinit, double thetastep) {
  for(double thetainit = 0; thetainit < 2*PI; thetainit+=thetastep) {
    for(double rvelocity = rvelocityinit; rvelocity > 0; rvelocity -= rvelocityinit/R_RESOLUTION) {
      double maxtheta = magicNumber(rjerk, rvelocity, rvelocityinit, thetainit, thetainit+thetastep);
      for(double theta = thetainit; theta < maxtheta; theta += 2*PI/THETA_RESOLUTION) {
        double thetanext = theta + 2*PI/THETA_RESOLUTION;
        stroke(colorize(rvelocity/rvelocityinit, (theta-thetainit)/(maxtheta-thetainit)));
        polarLine(rtheta(theta, thetainit, rjerk, rvelocity), theta, rtheta(thetanext, thetainit, rjerk, rvelocity), thetanext);
      }
    }
  }
}

/** The equation for casting a ray backwards with a given velocity, fixed theta velocity, and negative jerk
  * Consolidates all constants into a single number, to simplify.  
  */
double rtheta(double theta, double thetainit, double rjerk, double rvelocity) {
  double thetaout = theta-thetainit;
  return rjerk*thetaout*thetaout*thetaout-rvelocity*thetaout;
}

/** Returns the stopping point for a ray 
  * See derivation
  */
double magicNumber(double a, double b, double c, double d, double e) {
  double f = 3*a*(d*d-e*e)-b+c;
  return (3*a*(e*e-d*d)+b-c+sqrt((float)(f*f-12*a*(e-d)*(a*e*e*e-c*e-a*d*d*d+b*d))))/(6*a*(e-d));
}

/** Draws a line in polar space from the center of the canvas
  * Coordinates scaled to canvas, from 0 to 1
  */
void polarLine(double r1, double theta1, double r2, double theta2) {
  line((float)(r1*cos((float)theta1)+0.5)*width, (float)(r1*sin((float)theta1)+0.5)*height, (float)(r2*cos((float)theta2)+0.5)*width, (float)(r2*sin((float)theta2)+0.5)*height);
}

/** Returns a color for the given ray.
  * Velocity and theta scaled to 0-1 based on range
  */
color colorize(double velocity, double theta) {
  return color((float)velocity, 1, 1);
}
