/** Casts rays from the center with negative r acceleration, positive initial r velocity, and constant t velocity
  * An art piece by Willow Herron
  */

//Runtime is proportional to the product of these resolutions.  
final int R_RESOLUTION = 200;
final int THETA_RESOLUTION = 5000;

void setup() {
  size(1000,1000); //Scales canvas.  Runtime is agnostic of this.
  colorMode(HSB,1);
  background(0);
  strokeWeight(1);
  cast(0.005, 0.1, 2*PI/3);
  save("example.png");
  //exit(); //Preview?
}

void cast(double ra, double rvi, double ts) {
  for(double ti = 0; ti < 2*PI; ti+=ts) {
    for(double rv = rvi; rv > 0; rv -= rvi/R_RESOLUTION) {
      double mt = endpoint(ra, rv, rvi, ti, ti+ts);
      for(double t = ti; t < mt; t += 2*PI/THETA_RESOLUTION) {
        double tn = t + 2*PI/THETA_RESOLUTION;
        stroke(colorize(rv/rvi, (t-ti)/(mt-ti)));
        polarLine(ray(t, ti, ra, rv), t, ray(tn, ti, ra, rv), tn);
      }
    }
  }
}

/** The equation for casting a ray backwards with a given velocity, fixed t velocity, and negative jerk
  * Consolidates all constants into a single number, to simplify.  
  */
double ray(double t, double ti, double ra, double rv) {
  double to = t-ti;
  return (rv*to-ra*to*to);
}

/** Returns the stopping point for a ray 
  */
double endpoint(double a, double b, double c, double d, double e) {
  return (b*d-c*e+a*(d*d-e*e))/(b-c+2*a*(d-e));
}

/** Draws a line in polar space from the center of the canvas
  * Coordinates scaled to canvas, from 0 to 1
  */
void polarLine(double r1, double t1, double r2, double t2) {
  line((float)(r1*cos((float)t1)+0.5)*width, (float)(r1*sin((float)t1)+0.5)*height, (float)(r2*cos((float)t2)+0.5)*width, (float)(r2*sin((float)t2)+0.5)*height);
}

/** Returns a color for the given ray.
  * Velocity and t scaled to 0-1 based on range
  */
color colorize(double v, double t) {
  return color((float)v, 1, 1);
}
