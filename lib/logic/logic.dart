class Logic {
  List<List<int>> rotateAnticlockwise(List<List<int>> matrix) {
    int n = matrix.length;
    List<List<int>> rotatedMatrix = List.generate(n, (_) => List.filled(n, 0));

    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        rotatedMatrix[n - j - 1][i] = matrix[i][j];
      }
    }

    return rotatedMatrix;
  }

  bool checkWinningCondition(List<List<int>> matrix, int player) {
    int size = 4;

    // Horizontal check
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

    for (int i = 0; i <= size - 4; i++) {
      for (int j = 0; j < size; j++) {
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

    for (int i = 0; i <= size - 4; i++) {
      for (int j = 3; j >= 3; j--) {
        if (matrix[i][j] == player &&
            matrix[i + 1][j - 1] == player &&
            matrix[i + 2][j - 2] == player &&
            matrix[i + 3][j - 3] == player) {
          return true;
        }
      }
    }

    return false;
  }
}
