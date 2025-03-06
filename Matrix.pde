class Matrix {
  int rows;
  int cols;
  float[][] data;
  Matrix() {
    rows = 0;
    cols = 0;
    data = new float[rows][cols];
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        data[i][j] = 0;
      }
    }
  }
  Matrix(int r, int c) {
    rows = r;
    cols = c;
    data = new float[rows][cols];
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        data[i][j] = 0;
      }
    }
  }

  float[] toArray() {
    ArrayList<Float> arrList = new ArrayList<Float>();
    for (int i = 0; i<rows; i++) {
      for (int j = 0; j<cols; j++) {
        arrList.add(data[i][j]);
      }
    }

    float[] arr = new float[arrList.size()];
    for (int i = 0; i<arr.length; i++) {
      arr[i] = arrList.get(i);
    }
    return arr;
  }

  void fromArray(float[] arr) {
    for (int i = 0; i < arr.length; i++) {
      data[i][0] = arr[i];
    }
  }

  void randomize() {
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        data[i][j] = (float) (Math.random()*2)-1;
      }
    }
  }

  void printData() {
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        print(data[i][j] + " ");
      }
      println();
    }
    println();
  }


  void add(Matrix m) {
    if (rows!=m.rows || cols!=m.cols) {
      println("Rows and Columns are not equal");
    } else {
      for (int i = 0; i < rows; i++) {
        for (int j = 0; j<cols; j++) {
          data[i][j]+=m.data[i][j];
        }
      }
    }
  }
  void add(float n) {
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j<cols; j++) {
        data[i][j]+=n;
      }
    }
  }

  void subtract(Matrix m) {
    if (rows!=m.rows || cols!=m.cols) {
      println("Rows and Columns are not equal");
    } else {
      for (int i = 0; i < rows; i++) {
        for (int j = 0; j<cols; j++) {
          data[i][j]-=m.data[i][j];
        }
      }
    }
  }
  void subtract(float n) {
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j<cols; j++) {
        data[i][j]-=n;
      }
    }
  }

  void multiply(Matrix m) {
    if (rows!=m.rows || cols!=m.cols) {
      println("Rows and Columns are not equal");
    } else {
      for (int i = 0; i < rows; i++) {
        for (int j = 0; j<cols; j++) {
          data[i][j]*=m.data[i][j];
        }
      }
    }
  }
  void multiply(float n) {
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j<cols; j++) {
        data[i][j]*=n;
      }
    }
  }

  void mutate(float r) {
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        if (random(1) < r) {
          data[i][j] += randomGaussian()/10;
        }
      }
    }
  }

  Matrix duplicate() {
    Matrix m = new Matrix(rows, cols);
    for (int i = 0; i<rows; i++) {
      for (int j = 0; j<cols; j++) {
        m.data[i][j] = data[i][j];
      }
    }
    return m;
  }

  Matrix crossover(Matrix other) {
    Matrix salad = new Matrix(rows, cols);

    int midpoint = int(random(data.length));

    for (int i = 0; i<rows; i++) {
      if (i < midpoint) {
        salad.data[i] = data[i];
      } else {
        salad.data[i] = other.data[i];
      }
    }

    return salad;
  }

  void download(String textFile) {
    String[] text = new String[data.length];
    
    for (int i = 0; i < data.length; i++) {
      text[i] = join(nf(data[i]), " <> ");
    }
    
    saveStrings(textFile, text);
  }
}

Matrix multiply(Matrix m1, Matrix m2) {
  if (!(m1.cols==m2.rows)) {
    println("Rows do not equal columns");
    return null;
  } else {
    Matrix result = new Matrix(m1.rows, m2.cols);
    for (int i = 0; i < m1.rows; i++) {
      for (int j = 0; j < m2.cols; j++) {
        float sum;
        sum = 0;
        for (int s = 0; s < m1.cols; s++) {
          sum += m1.data[i][s] * m2.data[s][j];
        }
        result.data[i][j] = sum;
      }
    }
    return result;
  }
}

Matrix subtract(Matrix m1, Matrix m2) {
  if (m1.rows!=m2.rows || m1.cols!=m2.cols) {
    println("Rows and Columns are not equal");
    return null;
  } else {
    Matrix result = new Matrix(m1.rows, m1.cols);
    for (int i = 0; i < result.rows; i++) {
      for (int j = 0; j < result.cols; j++) {
        result.data[i][j] = m1.data[i][j] - m2.data[i][j];
      }
    }
    return result;
  }
}

Matrix transpose(Matrix m) {
  Matrix result = new Matrix(m.cols, m.rows);
  for (int i = 0; i < result.cols; i++) {
    for (int j = 0; j < result.rows; j++) {
      result.data[j][i] = m.data[i][j];
    }
  }
  return result;
}
