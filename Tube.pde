class Tube {
  float x, y, w, by;
  Tube(float y1) {
    x = width;
    y = y1;
    w = 64;
    by = y+space;
  }

  void update() {
    x-=4;
  }

  void show() {
    stroke(200, 255, 200);
    strokeWeight(5);
    rectMode(CORNERS);
    fill(0, 255, 0);
    rect(x, 0, x+w, y);
    rect(x, by, x+w, height);
  }

  boolean hits(Bird bird) {
    return (bird.x+bird.w/2 > x && bird.x - bird.w/2 < x+w && (bird.y - bird.w/2 < y || bird.y + bird.w/2 > by));
  }
}
