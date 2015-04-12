static int texSize = 512;
static float texScale = 300.0f;

class Building {
  
  private PVector position;
  private PVector size;
  private float orientation;
  private PImage texture;
  private PShape model;
  
  Building(float x, float y, float w, float h, float d) {
    // ---- Settings
    position = new PVector(x, y);
    size = new PVector(w/2, h, d/2);
    orientation = random(QUARTER_PI/3);
    // --------
    
    // ---- Generate textures
    texture = createImage(texSize*3, texSize, RGB);
    texture.loadPixels();
    color _selectedColor;
    color _blackcolor = #000000;
    color _whitecolor = #ffffff;
    color _windowColor = color(24,48,96);
    color _lightWindowColor = color(220,190,80);
    color _concreteColor = color(153,153,153);
    int texPtr_daytime, texPtr_nighttime, texPtr_selfilum;
    for (int _y = 0; _y < texSize; _y++)
      for (int _x = 0; _x < texSize; _x++)
      {
        texPtr_daytime   = _x + _y*texSize*3;
        texPtr_nighttime = _x+texSize + _y*texSize*3;
        texPtr_selfilum  = _x+texSize*2 + _y*texSize*3;
        // Window
        if (_y % 2 == 0) 
        {
          texture.pixels[texPtr_daytime] = _windowColor;
          if (floor(random(10)) == 0)
          {
            texture.pixels[texPtr_nighttime] = _lightWindowColor;
            texture.pixels[texPtr_selfilum] = _whitecolor;
          }
          else
            texture.pixels[texPtr_nighttime] = _windowColor;
        }
        // Concrete
        else
        {
          texture.pixels[texPtr_daytime] = _concreteColor;
          texture.pixels[texPtr_nighttime] = _concreteColor;
          texture.pixels[texPtr_selfilum] = _blackcolor;
        }
      }
    textureMode(NORMAL);
    textureWrap(REPEAT);
    // --------
    
    // ---- Generate model
    float _texOffsetNight = size.x/texScale;
    model = createShape();
    model.beginShape(QUADS);
    model.texture(texture);
    model.noStroke();
    // +x
    model.normal (1.0, 0.0, 0.0);
    model.vertex (size.x, 0, -size.z, _texOffsetNight, 0);
    model.vertex (size.x, 0, size.z, 0, 0);
    model.vertex (size.x, -size.y, size.z, 0, size.y/texScale);
    model.vertex (size.x, -size.y, -size.z, _texOffsetNight, size.y/texScale);
    // -x
    model.normal (-1.0, 0.0, 0.0);
    model.vertex (-size.x, 0, size.z, _texOffsetNight, 0);
    model.vertex (-size.x, 0, -size.z, 0, 0);
    model.vertex (-size.x, -size.y, -size.z, 0, size.y/texScale);
    model.vertex (-size.x, -size.y, size.z, _texOffsetNight, size.y/texScale);
    // +z
    model.normal (0.0, 0.0, 1.0);
    model.vertex (size.x, 0, size.z, _texOffsetNight, 0);
    model.vertex (-size.x, 0, size.z, 0, 0);
    model.vertex (-size.x, -size.y, size.z, 0, size.y/texScale);
    model.vertex (size.x, -size.y, size.z, _texOffsetNight, size.y/texScale);
    // -z
    model.normal (0.0, 0.0, -1.0);
    model.vertex (-size.x, 0, -size.z, _texOffsetNight, 0);
    model.vertex (size.x, 0, -size.z, 0, 0);
    model.vertex (size.x, -size.y, -size.z, 0, size.y/texScale);
    model.vertex (-size.x, -size.y, -size.z, _texOffsetNight, size.y/texScale);
    // +y
    model.normal (0.0, 1.0, 0.0);
    model.vertex (-size.x, -size.y, size.z, 0, 0);
    model.vertex (size.x, -size.y, size.z, 1, 0);
    model.vertex (size.x, -size.y, -size.z, 1, 1);
    model.vertex (-size.x, -size.y, -size.z, 0, 1);
    model.endShape();
    // --------
  }
  
  void draw() {
    pushMatrix();
      translate(position.x, 0.0f, position.y);
      rotateY(orientation);
      shape(model);
    popMatrix();
  }
}
