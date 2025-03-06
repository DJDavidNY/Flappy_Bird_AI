void nextGen() {
  calcFitness();

  for (int i = 0; i<TOTAL; i++) {
    birds.add(selection());
  }
  backup.clear();
}

Bird selection() {
  int[] index = {0, 0};
  for (int i = 0; i < index.length; i++) {
    float r = random(1);
    while (r>0) {
      r = r - backup.get(index[i]).fitness;
      index[i]++;
    }
    index[i]--;
  }
  Bird mommy = backup.get(index[0]);
  Bird daddy = backup.get(index[1]);
  Bird hatchling = new Bird(daddy.brain.crossover(mommy.brain));
  hatchling.mutate(0.01);
  return hatchling;
}

void calcFitness() {
  float sum = 0;
  for (Bird bird : backup) {
    sum+=bird.score;
  }

  for (Bird bird : backup) {
    bird.fitness = bird.score/sum;
  }
}
