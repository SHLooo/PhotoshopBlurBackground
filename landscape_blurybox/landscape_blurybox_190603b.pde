PImage landscape;
PGraphics rect;
int rect_size = 200;
int strokeweight = 5;
int blurity = 5;

void setup() {
  size(1000, 667);
   background(100);
  landscape = loadImage("landscape.jpg");
  rect = createGraphics(rect_size, rect_size);
  image(landscape,0,0);
}

//void sharpe() {
//  loadPixels();
//  for (int i = 0; i < height; ++i) {
//    for (int j = 0; j < width; ++j) {
//      int loc = i * width + j;
//      pixels[loc] = color(landscape.pixels[loc]);
//    }
//  }
//  updatePixels();
//}

void bluryBox() {
  rect.beginDraw();
  rect.loadPixels();
  landscape.loadPixels();

  for (int i = 0; i < rect_size; ++i) {
    for (int j = 0; j < rect_size; ++j) {
      int i_orig = (mouseY - rect_size/2 + i); 
      int j_orig = (mouseX - rect_size/2) + j;
      float red_sum = 0;
      float green_sum = 0;
      float blue_sum = 0;
      // using loops to find the average color of the pixels around 
      for (int range_i = -blurity; range_i <= blurity; ++range_i) {
        for (int range_j = -blurity; range_j <= blurity; ++range_j) {
          int index = (i_orig + range_i) * width + (j_orig + range_j);
          if (index >= 0 && index < width * height) {
            red_sum += red(landscape.pixels[index]);
            green_sum += green(landscape.pixels[index]);
            blue_sum += blue(landscape.pixels[index]);
          }
        }
      }
      float red = red_sum/sq(2*blurity+1);
      float green = green_sum/sq(2*blurity+1);
      float blue = blue_sum/sq(2*blurity+1);
      rect.pixels[i * rect_size + j] = color(red, green, blue);
    }
  }
  landscape.updatePixels();
  rect.updatePixels();
  rect.noFill();
  rect.strokeWeight(strokeweight);
  rect.stroke(0);
  rect.rect(0, 0, rect_size-1, rect_size-1);
  rect.endDraw();
  image(rect, mouseX-rect_size/2, mouseY-rect_size/2);
}

void draw() {
  image(landscape,0,0);
  bluryBox();
}
