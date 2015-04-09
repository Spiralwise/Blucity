static int texSize = 512;
static float texScale = 300.0f;

class Building {
  
  private PVector position;
  private PVector size;
  private float orientation;
  private PImage texture;
  private PImage texture_night;
  
  Building(float x, float y, float w, float h, float d) {
    // Settings
    position = new PVector(x, y);
    size = new PVector(w/2, h, d/2);
    orientation = random(QUARTER_PI/3);
    
    // Generate textures
    texture = createImage(texSize, texSize, RGB);
    texture.loadPixels();
    color _selectedColor;
    color _windowColor = color(24,48,96);
    color _lightWindowColor = color(255,255,105);
    color _concreteColor = color(153,153,153);
    for (int _y = 0; _y < texSize; _y++)
      for (int _x = 0; _x < texSize; _x++)
      {
        if (_y % 2 == 0) _selectedColor = _windowColor;
        else             _selectedColor = _concreteColor;
        texture.pixels[_x + _y*texSize] = _selectedColor;
      }
    texture_night = createImage(texSize, texSize, RGB);
    texture_night.copy(texture, 0, 0, texSize, texSize, 0, 0, texSize, texSize);
    texture.loadPixels();
    for (int _y = 0; _y < texSize; _y++)
      for (int _x = 0; _x < texSize; _x++)
        if (_y % 2 == 0)
        {
          if (floor(random(10)) == 0)
            texture_night.pixels[_x + _y*texSize] = _lightWindowColor;
        }
    textureMode(NORMAL);
    textureWrap(REPEAT);
  }
  
  void draw() {
    pushMatrix();
      //translate(position.x, -size.y/2, position.y); // Legacy code
      translate(position.x, 0.0f, position.y);
      rotateY(orientation);
      beginShape(QUADS);
      texture(texture);
      // +x
      vertex (size.x, 0, -size.z, 0, 0);
      vertex (size.x, 0, size.z, size.x/texScale, 0);
      vertex (size.x, -size.y, size.z, size.x/texScale, size.y/texScale);
      vertex (size.x, -size.y, -size.z, 0, size.y/texScale);
      // -x
      vertex (-size.x, 0, -size.z, 0, 0);
      vertex (-size.x, 0, size.z, size.x/texScale, 0);
      vertex (-size.x, -size.y, size.z, size.x/texScale, size.y/texScale);
      vertex (-size.x, -size.y, -size.z, 0, size.y/texScale);
      // +z
      vertex (-size.x, 0, size.z, 0, 0);
      vertex (size.x, 0, size.z, size.x/texScale, 0);
      vertex (size.x, -size.y, size.z, size.x/texScale, size.y/texScale);
      vertex (-size.x, -size.y, size.z, 0, size.y/texScale);
      // -z
      vertex (size.x, 0, -size.z, 0, 0);
      vertex (-size.x, 0, -size.z, size.x/texScale, 0);
      vertex (-size.x, -size.y, -size.z, size.x/texScale, size.y/texScale);
      vertex (size.x, -size.y, -size.z, 0, size.y/texScale);
      endShape();
      beginShape();
      // +y
      vertex (-size.x, -size.y, size.z, 0, 0);
      vertex (size.x, -size.y, size.z, 1, 0);
      vertex (size.x, -size.y, -size.z, 1, 1);
      vertex (-size.x, -size.y, -size.z, 0, 1);
      endShape();
      //box(size.x, size.y, size.z); // Legacy code
    popMatrix();
  }
}
