import 'dart:math';

class GameLogic {
  List<String> board = List.filled(9, '');
  List<int> xMoves = [];
  List<int> oMoves = [];

  bool isXTurn = true;
  String winner = '';
  bool isHardMode = false;
  String statusMessage = 'Your turn!';

  void resetGame(bool isHard) {
    board = List.filled(9, '');
    xMoves.clear();
    oMoves.clear();
    isXTurn = true;
    winner = '';
    isHardMode = isHard;
    statusMessage = 'Your turn!';
  }

  bool playerMove(int index) {
    if (board[index] != '' || winner != '') return false;

    // RULE: If Opponent (AI/O) has 3 pieces, remove their first one.
    // "Move 5 (Human) -> Lose first move (AI)"
    if (oMoves.length >= 3) {
      int removedIndex = oMoves.removeAt(0);
      board[removedIndex] = '';
    }

    xMoves.add(index);
    board[index] = 'X';

    isXTurn = false;
    statusMessage = 'AI is thinking...';

    // Check winner immediately after placing
    _checkWinner();
    return true;
  }

  void makeAIMove() {
    if (winner != '') return;

    int moveIndex = -1;

    if (isHardMode) {
      // Hard Mode: Minimax logic
      moveIndex = _getBestMove();
    } else {
      // Easy Mode: Random
      moveIndex = _getRandomMove();
    }

    if (moveIndex != -1) {
      // RULE: If Opponent (Human/X) has 3 pieces, remove their first one.
      // "Move 4 (AI) -> Lose first move (Human)"
      if (xMoves.length >= 3) {
        int removedIndex = xMoves.removeAt(0);
        board[removedIndex] = '';
      }

      oMoves.add(moveIndex);
      board[moveIndex] = 'O';

      isXTurn = true;
      statusMessage = 'Your turn!';
      _checkWinner();
    }
  }

  // --- MINIMAX ALGORITHM ---
  int _getBestMove() {
    int bestScore = -1000;
    int move = -1;

    if (board.every((element) => element == '')) return 4;

    for (int i = 0; i < 9; i++) {
      if (board[i] == '') {
        // --- SIMULATE O'S MOVE ---
        // Check if we need to remove X's (Human's) piece
        int? removedIndex;
        if (xMoves.length >= 3) {
          removedIndex = xMoves[0]; // Store to backtrack later
          board[removedIndex] = ''; // Remove from board simulation
        }

        // Place new piece
        board[i] = 'O';
        List<int> nextOMoves = List.from(oMoves)..add(i);
        List<int> nextXMoves = List.from(xMoves);
        if (removedIndex != null) nextXMoves.removeAt(0); // Update X list simulation

        // Call Minimax
        int score = _minimax(board, 0, false, -1000, 1000, nextXMoves, nextOMoves);

        // BACKTRACK
        board[i] = '';
        if (removedIndex != null) {
          board[removedIndex] = 'X';
        }

        if (score > bestScore) {
          bestScore = score;
          move = i;
        }
      }
    }
    return move != -1 ? move : _getRandomMove();
  }

  int _minimax(
    List<String> board,
    int depth,
    bool isMaximizing,
    int alpha,
    int beta,
    List<int> currentXMoves,
    List<int> currentOMoves
  ) {
    String result = _checkWinner(checkOnly: true);
    if (result == 'O') return 10 - depth;
    if (result == 'X') return depth - 10;

    // 6 moves ahead is deep enough for this game variant to be "Hard".
    if (depth >= 6) return 0;

    if (isMaximizing) {
      int bestScore = -1000;
      for (int i = 0; i < 9; i++) {
        if (board[i] == '') {
          int? removedIndex;
          if (currentXMoves.length >= 3) {
            removedIndex = currentXMoves[0];
            board[removedIndex] = '';
          }

          board[i] = 'O';
          List<int> nextOMoves = List.from(currentOMoves)..add(i);
          List<int> nextXMoves = List.from(currentXMoves);
          if (removedIndex != null) nextXMoves.removeAt(0);

          int score = _minimax(board, depth + 1, false, alpha, beta, nextXMoves, nextOMoves);

          // Backtrack
          board[i] = '';
          if (removedIndex != null) board[removedIndex] = 'X';

          bestScore = max(score, bestScore);
          alpha = max(alpha, bestScore);
          if (beta <= alpha) break;
        }
      }
      return bestScore;
    } else {
      int bestScore = 1000;
      for (int i = 0; i < 9; i++) {
        if (board[i] == '') {
          int? removedIndex;
          if (currentOMoves.length >= 3) {
            removedIndex = currentOMoves[0];
            board[removedIndex] = '';
          }

          board[i] = 'X';
          List<int> nextXMoves = List.from(currentXMoves)..add(i);
          List<int> nextOMoves = List.from(currentOMoves);
          if (removedIndex != null) nextOMoves.removeAt(0);

          int score = _minimax(board, depth + 1, true, alpha, beta, nextXMoves, nextOMoves);

          // Backtrack
          board[i] = '';
          if (removedIndex != null) board[removedIndex] = 'O';

          bestScore = min(score, bestScore);
          beta = min(beta, bestScore);
          if (beta <= alpha) break;
        }
      }
      return bestScore;
    }
  }

  int _getRandomMove() {
    var available = [];
    for (int i = 0; i < 9; i++) {
      if (board[i] == '') available.add(i);
    }
    if (available.isNotEmpty) {
      return available[Random().nextInt(available.length)];
    }
    return -1;
  }

  String _checkWinner({bool checkOnly = false}) {
    List<List<int>> winPatterns = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8], // Cols
      [0, 4, 8], [2, 4, 6]             // Diagonals
    ];

    for (var pattern in winPatterns) {
      String a = board[pattern[0]];
      String b = board[pattern[1]];
      String c = board[pattern[2]];

      if (a == b && b == c && a != '') {
        if (!checkOnly) {
          winner = a;
          statusMessage = (a == 'X') ? 'You win!' : 'AI wins!';
        }
        return a;
      }
    }
    return '';
  }
}