class Sun {
  
  private final color cSunrise  = color(#FF8705);
  private final color cDaylight = color(#FFFFFF);
  private final color cNight    = color(#000000);
  private final color cAmbientSunrise  = color(#273955);
  private final color cAmbientDaylight = color(#B5DAFF);
  private final color cAmbientNight    = color(#0A1436);
  private final float ellipseRadius = 100.0;
  
  private PVector position;
  private float ellipticCenter;
  private float angle;
  private color lightColor;
  private color ambientColor;
  
  Sun() {
    position = new PVector(ellipseRadius, -ellipseRadius, 0.0);
    ellipticCenter = 50.0;
    angle = 0.0;
  }
  
  void draw() {
    float observedAngle;
    
    angle += 0.005; // FIXME Faire avec un deltatime
    if ( angle > TWO_PI )
      angle = angle - TWO_PI;
    position.set(ellipseRadius*cos(angle), -(ellipseRadius*sin(angle)+ellipticCenter), 0.0);
    observedAngle = PVector.angleBetween(new PVector(1.0, 0.0, 0.0), position);
      
    // Day
    if ( position.y < 0.0 ) {
      // Sunrise
      if ( observedAngle < (QUARTER_PI/2) ) {
        lightColor   = lerpColor(cNight, cSunrise, observedAngle/(QUARTER_PI/2));
        ambientColor = lerpColor(cAmbientNight, cAmbientSunrise, observedAngle/(QUARTER_PI/2));
      // Morning
      } else if ( observedAngle < QUARTER_PI ) { 
        lightColor   = lerpColor(cSunrise, cDaylight, (observedAngle-(QUARTER_PI/2))/(QUARTER_PI/2));
        ambientColor = lerpColor(cAmbientSunrise, cAmbientDaylight, (observedAngle-(QUARTER_PI/2))/(QUARTER_PI/2));
      // Midday
      } else if ( observedAngle < HALF_PI+QUARTER_PI ) {
        lightColor   = cDaylight;
        ambientColor = cAmbientDaylight; 
      // Afternoon
      } else if ( observedAngle < (HALF_PI+QUARTER_PI+(QUARTER_PI/2)) ) {
        lightColor   = lerpColor(cDaylight, cSunrise, (observedAngle-(HALF_PI+QUARTER_PI))/(QUARTER_PI/2));
        ambientColor = lerpColor(cAmbientDaylight, cAmbientSunrise, (observedAngle-(HALF_PI+QUARTER_PI))/(QUARTER_PI/2));
      // Sunset
      } else {
        lightColor   = lerpColor(cSunrise, cNight, (observedAngle-(HALF_PI+QUARTER_PI+(QUARTER_PI/2)))/(QUARTER_PI/2));
        ambientColor = lerpColor(cAmbientSunrise, cAmbientNight, (observedAngle-(HALF_PI+QUARTER_PI+(QUARTER_PI/2)))/(QUARTER_PI/2));
      }
    // Night
    } else {
      lightColor = color(#000000);
      ambientColor = color(#0A1436);
    }
    
    background(ambientColor);
    ambientLight(red(ambientColor), green(ambientColor), blue(ambientColor));
    directionalLight(red(lightColor), green(lightColor), blue(lightColor), -position.x, -position.y, -position.z);
   /* pushMatrix();
      translate(position.x, position.y, position.z);
      sphere(10.0);
    popMatrix();*/
  }
  
  public int getHour() {
    return int( ((angle/TWO_PI +0.25) * 24) % 24 );
  }
  
  public int getMinute () {
    return int( ((angle/TWO_PI +0.25) * 3600) % 60 );
  }
  
  public String printHour() {
     return getHour() + ":" + getMinute(); 
  }
}
