void updateScene() {
  for (int k = 1; k < layers - 1; k++) {
    for (int j = 1; j < rows - 1; j++) {
      for (int i = 1; i < columns - 1; i++) {
        updateCube(k,j,i);
      }
    }
  }
  for (int k = 1; k < layers - 1; k++) {
    for (int j = 1; j < rows - 1; j++) {
      for (int i = 1; i < columns - 1; i++) {
        initGen[k][j][i] = nextGen[k][j][i];
      }
    }
  }
}