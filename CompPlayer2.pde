//Minimax
class CompPlayer2 {
  Game g;
  int depth;
  int player;
  boolean print;

  public CompPlayer2(Game g, int d, boolean p) {
    this.g = g;
    depth = d;
    print = p;
    player = 0;
  }

  PVector getMove() {
    player = g.currPlayer;
    float max = -101;
    PVector move = null;
    ArrayList<PVector> m = orderMoves(g);
    for (PVector i : m) {
      int d = depth;
      Game newGame = new Game(g);
      newGame.play((int)i.y + 1, (int)i.x + 1);
      float eval = -101;
      if(newGame.currPlayer == g.currPlayer) {
        eval = evalMove(newGame, d, -101, 101, 1);
      }
      else {
        eval = -1*evalMove(newGame, d, -101, 101, -1);
      }
      if (eval>max) {
        max = eval;
        move = i;
      }
    }
    if(print) println("EVAL2: " + map(max, -100, 100, 0, 1));
    return new PVector(move.y+1, move.x+1);
  }

  float evalMove(Game g, int depth, float alpha, float beta, int factor) {
    if (g.gameState != -1) {
      if (g.gameState == 0) return 0;
      else if(g.gameState == player) return 100 * factor;
      else return -100 * factor;
    }   

    if (depth <= 0) return heuristicEval2(g);

    ArrayList<PVector> move = orderMoves(g);
    float bestVal = -101;
    for (int i = 0; i < move.size(); i++) {
      Game newg = new Game(g);
      newg.play((int)move.get(i).y+1, (int)move.get(i).x+1);
      float val = -101;
      if (newg.currPlayer == g.currPlayer) {
        val = evalMove(newg, depth-1, alpha, beta, 1);
      } else {
        val = -1*evalMove(newg, depth-1, -1*beta, -1*alpha, -1);
      }
      bestVal = max(bestVal, val);
      if (bestVal >= beta) break;
      else if (bestVal > alpha) alpha = bestVal;
    }
    return bestVal;
  }

  float heuristicEval(Game g) {
    float[][] weight = {{10, 1, 3, 3, 3, 3, 1, 10}, 
      {1, .5, 1, 1, 1, 1, .5, 1}, 
      {3, 1, 1, 1, 1, 1, 1, 3}, 
      {3, 1, 1, 1, 1, 1, 1, 3}, 
      {3, 1, 1, 1, 1, 1, 1, 3}, 
      {3, 1, 1, 1, 1, 1, 1, 3}, 
      {1, .5, 1, 1, 1, 1, .5, 1}, 
      {10, 1, 3, 3, 3, 3, 1, 10}};

    int factor = 1;
    if (g.currPlayer == 2) factor = -1;
    int red = 0;
    int blue = 0;
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        if (g.board[i][j] == 1) red += weight[i][j];
        else if (g.board[i][j] == 2) blue += weight[i][j];
      }
    }
    return factor * (red - blue);
  }

  float heuristicEval2(Game g) {
    float[][] weight = {{4, -3, 2, 2, 2, 2, -3, 4}, 
      {-3, -4, -1, -1, -1, -1, -4, -3}, 
      {2, -1, 1, 0, 0, 1, -1, 2}, 
      {2, -1, 0, 1, 1, 0, -1, 2}, 
      {2, -1, 0, 1, 1, 0, -1, 2}, 
      {2, -1, 1, 0, 0, 1, -1, 2}, 
      {-3, -4, -1, -1, -1, -1, -4, -3}, 
      {4, -3, 2, 2, 2, 2, -3, 4}};

    int factor = 1;
    if (g.currPlayer == 2) factor = -1;
    int red = 0;
    int blue = 0;
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        if (g.board[i][j] == 1) red += weight[i][j];
        else if (g.board[i][j] == 2) blue += weight[i][j];
      }
    }
    return factor * ((red - blue));
  }

  ArrayList<PVector> orderMoves(Game g) {
    return g.legalMoves;
  }
}
