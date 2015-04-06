class Building {
  
  private PVector position;
  private PVector size;
  private float orientation;
  
  Building(float x, float y, float w, float h, float d) {
    position = new PVector(x, y);
    size = new PVector(w, h, d);
    orientation = random(QUARTER_PI/3);
  }
  
  void draw() {
    pushMatrix();
      translate(position.x, -size.y/2, position.y);
      rotateY(orientation);
      box(size.x, size.y, size.z);
    popMatrix();
  }
}
