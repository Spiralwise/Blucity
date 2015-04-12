import java.awt.event.*;

PFont myFont;

Sun sun;
City city;

PVector cameraPosition = new PVector(100.0, -100.0, 100.0);
PVector cameraTarget = new PVector(0.0, -50.0, 0.0);
float cameraRadius = 250.0;
float cameraAngle = 0.0;

void setup() {
  size(1280, 960, P3D);
  //frustum(-4, 4, -3, 3, 5, 500); // Arbitrary...
  
  addMouseWheelListener(new MouseWheelListener() { 
    public void mouseWheelMoved(MouseWheelEvent mwe) { 
      mouseWheel(mwe.getWheelRotation());
  }});
  
  myFont = loadFont("BitLow-48.vlw");
  sun  = new Sun();
  city = new City(70, 150.0);
}

void draw() {
  // Pre-processing
  cameraPosition.x = cameraRadius*cos(cameraAngle);
  cameraPosition.z = cameraRadius*sin(cameraAngle);
  
  camera(
    cameraPosition.x, cameraPosition.y, cameraPosition.z,
    cameraTarget.x, cameraTarget.y, cameraTarget.z, 
    0.0, 1.0, 0.0);
  
  // Scene
  sun.draw();
  city.draw();
  
  // UI
  resetShader();
  noLights();
  textFont(myFont, 8);
  fill(#FCB808);
  PVector textProjection = PVector.sub(cameraTarget, cameraPosition);
  textProjection.normalize();
  textProjection.mult(100);
  pushMatrix();
    translate(cameraPosition.x, cameraPosition.y, cameraPosition.z);
    translate(textProjection.x, textProjection.y, textProjection.z);
    rotate(-cameraAngle+HALF_PI, 0.0, 1.0, 0.0);
    rotate ( PVector.angleBetween(textProjection, new PVector(textProjection.x, 0.0, textProjection.z)), 1.0, 0.0, 0.0 );
    text(sun.printHour(), -75, -50); // TODO How to put the text exactly on the upper left corner of the screen not arbitrarly?
  popMatrix();
  lights();
}

void mouseDragged() {
  float deltaX = mouseX - pmouseX;
  cameraAngle += deltaX/100.0;
}

void mouseWheel(int delta) {
  cameraRadius -= 15*delta;
}
