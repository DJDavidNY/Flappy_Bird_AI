int space = 192;
ArrayList<Tube> t = new ArrayList<Tube>();
int TOTAL = 200;
ArrayList<Bird> birds= new ArrayList<Bird>();
ArrayList<Bird> backup = new ArrayList<Bird>();
int f;
int d;
int points = 0;
int bestpoints = 0;
boolean lose = false;
int speed = 1;


int gen = 1;
int birdsLeft;
void setup() {
  size(700, 700);
  for (int i = 0; i<TOTAL; i++) {
    birds.add(new Bird());
  }
  birdsLeft = TOTAL;
  f = 0;
  d = 74;
}

void draw() {
  for (int q = 0; q < speed; q++) {
    if (f%d==0) {
      t.add(new Tube(random(10, height-space-10)));
    }
    f++;
    for (int j = 0; j<t.size(); j++) {
      if (t.get(j).x+t.get(j).w<=0) t.remove(j);
      for (int i = birds.size()-1; i>=0; i--) {
        if (t.get(j).hits(birds.get(i))) {
          backup.add(birds.get(i));
          birds.remove(i);
          birdsLeft--;
          i--;
        }
      }
    }
    for (int i = 0; i < birds.size(); i++) {
      if (birds.get(i).y > height || birds.get(i).y < 0) {
        backup.add(birds.get(i));
        birds.remove(i);
        i--;
        birdsLeft--;
      }
    }

    for (Tube t : t) {
      t.update();
    }

    for (Bird bird : birds) {
      bird.think();
      bird.update();
    }

    if (birds.size() == 0) {
      nextGen();
      birdsLeft = TOTAL;
      t.clear();
      f = 0;
      points = 0;
      gen++;
    }

    if (t.size() > 0) {
      if (t.get(0).x == 128) {
        points++;
      }
    }
    if (points >= bestpoints) {
      bestpoints = points;
    }
  }
  background(120);

  for (Bird bird : birds) {
    bird.show();
  }
  for (Tube t : t) {
    t.show();
  }

  textAlign(LEFT, TOP);
  textSize(32);
  fill(0);
  text(points, 5, 5);
  textAlign(RIGHT, TOP);
  text("BEST: " + bestpoints, width-5, 5);

  textAlign(LEFT, BOTTOM);
  text("Birds Left " + birdsLeft, 0, height);

  textAlign(RIGHT, BOTTOM);
  text("Gen " + gen, width, height);

  if (points >= 100000) {
    //if (points == 150000) {
    NeuralNetwork saved = birds.get(0).brain;

    saved.weightsIH.download("weightsIH.txt");
    saved.weightsHO.download("weightsHO.txt");
    //}
  }
}


void keyPressed() {
  if (key == 's') {
    NeuralNetwork saved = birds.get(0).brain;

    saved.weightsIH.download("weightsIH.txt");
    saved.weightsHO.download("weightsHO.txt");
    println("saved");
  }

  if (key == 'g') {
    if (speed == 10) speed = 1;
    else speed = 10;
  }
}
