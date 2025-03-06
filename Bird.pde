class Bird {
  float y;
  float x;
  float v;
  float g;
  float w;
  float score = 0;
  float fitness;
  NeuralNetwork brain;

  Bird() {
    y = height/2.5;
    x = 128;
    w = 32;
    g = 0.25;
    v = 0;
    brain = new NeuralNetwork(5, 15, 2);
  }
  Bird(NeuralNetwork nn) {
    y = height/2.5;
    x = 128;
    w = 32;
    g = 0.25;
    v = 0;
    brain = nn.duplicate();
  }

  void show() {
    fill(255, 255, 0, 25);
    ellipse(x, y, w, w);
  }

  void mutate(float r) {
    brain.mutate(r);
  }

  void think() {
    Tube closest = new Tube(20);
    float distance = width;
    float d;
    for (int i = 0; i<t.size(); i++) {
      d = (t.get(i).x + t.get(i).w) - x;
      if (d < distance && d > 0) {
        distance = d;
        closest = t.get(i);
      }
    }

    float[] inputArray = new float[5];
    inputArray[0] = y/height;
    inputArray[1] = closest.y/height;
    inputArray[2] = closest.by/height;
    inputArray[3] = closest.x/width;
    inputArray[4] = v/(height/4);
    
    Matrix input = new Matrix(inputArray.length, 1);
    input.fromArray(inputArray);
    Matrix output = brain.feedforward(input);
    float[] outputArray = output.toArray();
    if (outputArray[0] > outputArray[1]) {
      up();
    }
  }

  void update() {
    score++;
    y+=v;
    v+=g;
  }

  void up() {
    v = -6;
  }
}
