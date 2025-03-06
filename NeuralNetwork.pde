class NeuralNetwork {
  int inputs;
  int hiddens;
  int outputs;
  Matrix weightsIH;
  Matrix weightsHO;
  Matrix biasH;
  Matrix biasO;
  float learningRate;
  NeuralNetwork(int i, int h, int o) {
    inputs = i;
    hiddens = h;
    outputs = o;

    weightsIH = new Matrix(hiddens, inputs);
    weightsHO = new Matrix(outputs, hiddens);
    weightsIH.randomize();
    weightsHO.randomize();

    biasH = new Matrix(hiddens, 1);
    biasO = new Matrix(outputs, 1);
    biasH.randomize();
    biasO.randomize();

    learningRate = 0.1;
  }

  Matrix feedforward(Matrix input) {
    Matrix hidden = multiply(weightsIH, input);
    hidden.add(biasH);

    hidden = sigmoid(hidden);

    Matrix output = multiply(weightsHO, hidden);
    output.add(biasO);

    output = sigmoid(output);

    return output;
  }

  Matrix sigmoid(Matrix m) {
    for (int i = 0; i < m.rows; i++) {
      for (int j = 0; j<m.cols; j++) {
        m.data[i][j] = 1/(1+exp(-m.data[i][j]));
      }
    }
    return m;
  }
  float sigmoid(float f) {
    f = 1/(1+exp(-f));
    return f;
  }

  Matrix dSigmoid(Matrix m) {
    for (int i = 0; i < m.rows; i++) {
      for (int j = 0; j<m.cols; j++) {
        m.data[i][j] = sigmoid(m.data[i][j]) * (1 - sigmoid(m.data[i][j]));
      }
    }
    return m;
  }
  Matrix dSigmoided(Matrix m) {
    for (int i = 0; i < m.rows; i++) {
      for (int j = 0; j<m.cols; j++) {
        m.data[i][j] = m.data[i][j] * (1 - m.data[i][j]);
      }
    }
    return m;
  }

  void train(Matrix input, Matrix target) {
    Matrix hidden = multiply(weightsIH, input);
    hidden.add(biasH);
    hidden = sigmoid(hidden);
    Matrix output = multiply(weightsHO, hidden);
    output.add(biasO);
    output = sigmoid(output);

    Matrix errorO = subtract(target, output);

    Matrix gradientO = dSigmoided(output);
    gradientO.multiply(errorO);
    gradientO.multiply(learningRate);

    Matrix tHidden = transpose(hidden);
    Matrix deltaWeightHO = multiply(gradientO, tHidden);

    weightsHO.add(deltaWeightHO);
    biasO.add(gradientO);


    Matrix tWeightsHO = transpose(weightsHO);
    Matrix errorH = multiply(tWeightsHO, errorO);

    Matrix gradientH = dSigmoided(hidden);
    gradientH.multiply(errorH);
    gradientH.multiply(learningRate);

    Matrix tInput = transpose(input);
    Matrix deltaWeightIH = multiply(gradientH, tInput);

    weightsIH.add(deltaWeightIH);
    biasH.add(gradientH);
  }

  // Special for neuroevolution
  NeuralNetwork(NeuralNetwork nn) {
    inputs = nn.inputs;
    hiddens = nn.hiddens;
    outputs = nn.outputs;

    weightsIH = nn.weightsIH.duplicate();
    weightsHO = nn.weightsHO.duplicate();

    biasH = nn.biasH.duplicate();
    biasO = nn.biasO.duplicate();
  }

  NeuralNetwork duplicate() {
    return new NeuralNetwork(this);
  }

  NeuralNetwork crossover(NeuralNetwork parent) {
    NeuralNetwork babyBrain = new NeuralNetwork(this);
    
    babyBrain.weightsIH = weightsIH.crossover(parent.weightsIH);
    babyBrain.weightsHO = weightsHO.crossover(parent.weightsHO);

    return babyBrain;
  }

  void mutate(float r) {
    weightsIH.mutate(r);
    weightsHO.mutate(r);

    biasH.mutate(r);
    biasO.mutate(r);
  }
}
