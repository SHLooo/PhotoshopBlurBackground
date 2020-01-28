PImage landscape;
PGraphics rect;
int rect_size = 250;
int strokeweight = 5;
int blurity = 4;

void setup() {
  size(1000, 667);
  // background(100);
  landscape = loadImage("landscape.jpg");
  rect = createGraphics(rect_size, rect_size);
  image(landscape,0,0);
}

void drawBlury() {
  loadPixels();
  for (int i = blurity; i < height-blurity; ++i) {
    for (int j = blurity; j < width-blurity; ++j) {
      float red_sum = 0;
      float green_sum = 0;
      float blue_sum = 0;
      int index = 0;
      for (int range_i = -blurity; range_i <= blurity; ++range_i) {
        for (int range_j = -blurity; range_j <= blurity; ++range_j) {
          index = (i + range_i) * width + (j + range_j);
          red_sum += red(landscape.pixels[index]);
          green_sum += green(landscape.pixels[index]);
          blue_sum += blue(landscape.pixels[index]);
        }
      }
      float red = red_sum/sq(2*blurity+1);
      float green = green_sum/sq(2*blurity+1);
      float blue = blue_sum/sq(2*blurity+1);
      int loc = i * width + j;
      pixels[loc] = color(red, green, blue);
    }
  }
  updatePixels();
}

void sharpeningBox() {
  //if (mouseX < width - rect_size/2 && mouseY < height - rect_size/2 &&
  //  mouseX > rect_size/2 && mouseY > rect_size/2) {
  rect.beginDraw();
  rect.loadPixels();

  for (int i = 0; i < rect_size; ++i) {
    for (int j = 0; j < rect_size; ++j) {

      int i_orig = (mouseY - rect_size/2 + i); 
      int j_orig = (mouseX - rect_size/2) + j;
      int index_rect = i * rect_size + j;
      if (i_orig >= 0 && j_orig >= 0 && i_orig < height && j_orig < width) {
        rect.pixels[index_rect] = landscape.pixels[i_orig * width + j_orig];
      }
    }
  }
  rect.updatePixels();
  rect.noFill();
  rect.strokeWeight(strokeweight);
  rect.stroke(0);
  rect.rect(0, 0, rect_size-1, rect_size-1);
  rect.endDraw();
  image(rect, mouseX-rect_size/2, mouseY-rect_size/2);
}
//}

void draw() {
  drawBlury();
  sharpeningBox();
}
