class Logic {
  List<List<int>> rotateAnticlockwise(List<List<int>> matrix) {
    int n = matrix.length;
    List<List<int>> rotatedMatrix = List.generate(n, (_) => List.filled(n, 0));

    for (int i = 0; i < n; i++) {
      if (i == 0) {
        for (int j = 0; j < n - 1; j++) {
          rotatedMatrix[0][j] = matrix[0][j + 1];
        }
        rotatedMatrix[0][n - 1] = matrix[1][n - 1];
      } else if (i == n - 1) {
        for (int j = n - 1; j > 0; j--) {
          rotatedMatrix[n - 1][j] = matrix[n - 1][j - 1];
        }
        rotatedMatrix[n - 1][0] = matrix[n - 2][0];
      } else {
        rotatedMatrix[i][0] = matrix[i - 1][0];
        rotatedMatrix[i][n - 1] = matrix[i + 1][n - 1];
      }
    }

    if (n > 2) {
      rotatedMatrix[1][1] = matrix[1][2];
      rotatedMatrix[1][2] = matrix[2][2];
      rotatedMatrix[2][2] = matrix[2][1];
      rotatedMatrix[2][1] = matrix[1][1];
    }

    return rotatedMatrix;
  }

  bool checkWinningCondition(List<List<int>> matrix, int player) {
    int size = 4;

    for (int i = 0; i < size; i++) {
      for (int j = 0; j <= size - 4; j++) {
        if (matrix[i][j] == player &&
            matrix[i][j + 1] == player &&
            matrix[i][j + 2] == player &&
            matrix[i][j + 3] == player) {
          return true;
        }
      }
    }

    for (int j = 0; j < size; j++) {
      for (int i = 0; i <= size - 4; i++) {
        if (matrix[i][j] == player &&
            matrix[i + 1][j] == player &&
            matrix[i + 2][j] == player &&
            matrix[i + 3][j] == player) {
          return true;
        }
      }
    }

    for (int i = 0; i <= size - 4; i++) {
      for (int j = 0; j <= size - 4; j++) {
        if (matrix[i][j] == player &&
            matrix[i + 1][j + 1] == player &&
            matrix[i + 2][j + 2] == player &&
            matrix[i + 3][j + 3] == player) {
          return true;
        }
      }
    }

    for (int i = 3; i < size; i++) {
      for (int j = 0; j <= size - 4; j++) {
        if (matrix[i][j] == player &&
            matrix[i - 1][j + 1] == player &&
            matrix[i - 2][j + 2] == player &&
            matrix[i - 3][j + 3] == player) {
          return true;
        }
      }
    }

    return false;
  }
}
