class Logic {
  List<List<int>> rotateAnticlockwise(List<List<int>> matrix) {
    int n = matrix.length;
    List<List<int>> rotatedMatrix =
        List.generate(n, (_) => List.from(matrix[_]));

    int temp = rotatedMatrix[1][1];
    rotatedMatrix[1][1] = rotatedMatrix[1][2];
    rotatedMatrix[1][2] = rotatedMatrix[2][2];
    rotatedMatrix[2][2] = rotatedMatrix[2][1];
    rotatedMatrix[2][1] = temp;

    int tempOuter = rotatedMatrix[0][0];

    for (int i = 0; i < 3; i++) {
      rotatedMatrix[i][0] = rotatedMatrix[i + 1][0];
    }

    for (int i = 0; i < 3; i++) {
      rotatedMatrix[3][i] = rotatedMatrix[3][i + 1];
    }

    for (int i = 3; i > 0; i--) {
      rotatedMatrix[i][3] = rotatedMatrix[i - 1][3];
    }

    for (int i = 3; i > 1; i--) {
      rotatedMatrix[0][i] = rotatedMatrix[0][i - 1];
    }

    rotatedMatrix[0][1] = tempOuter;

    return rotatedMatrix;
  }

  bool checkWinningCondition(List<List<int>> matrix, int player) {
    int size = 4;

    // Horizontal check for 4 in a row
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
