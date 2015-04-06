class City {
  
  private float r;
  private Building[] buildings;
  
  City(int popBuilding, float radius) {
    r = radius;
    buildings = new Building[popBuilding];
    PVector buildingPosition;
    float buildingDistance, buildingHeight;
    float randomRadius, randomAngle;
    for ( int i = 0; i < buildings.length; i++ ) {
      randomRadius = random(radius);
      randomAngle  = random(TWO_PI);
      buildingPosition = new PVector( 
        randomRadius*cos(randomAngle), 
        randomRadius*sin(randomAngle) );
      buildingDistance = dist(buildingPosition.x, buildingPosition.y, buildingPosition.z, 0.0, 0.0, 0.0);  
      buildingHeight = max(10.0, random(radius) - buildingDistance);
      buildings[i] = new Building(
        buildingPosition.x,
        buildingPosition.y,
        5.0+random(15.0),
        buildingHeight, 
        5.0+random(15.0));
    } 
  }
  
  void draw() {
    // Ground
    noStroke();
    fill(color(#344350));
    pushMatrix();
      rotateX(HALF_PI);
      rectMode(CENTER);
      rect(0.0, 0.0, r*2, r*2);
    popMatrix();
    
    // Buildings
    fill(color(#99A1A5));
    for ( int i = 0; i < buildings.length; i++ )
      buildings[i].draw();
  }
}
