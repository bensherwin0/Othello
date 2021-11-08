class Game {

  int [][] board; //[row][col]
  int currPlayer; //1 or 2 = red or blue, 0 = empty
  int gameState; // 1 or 2 for winner, -1 for still in progress, 0 for tie  
  ArrayList<PVector> legalMoves;

  public Game() {
    board = new int[8][8];
    currPlayer = 1;
    gameState = -1;
    board[3][3] = 1;
    board[3][4] = 2;
    board[4][3] = 2;
    board[4][4] = 1;
    legalMoves = getLegalMoves();
  }

  public Game(Game g) {
    board = new int[8][8];
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        board[i][j] = g.board[i][j];
      }
    }
    this.currPlayer = g.currPlayer;
    this.gameState = g.gameState;
    legalMoves = getLegalMoves();
  }

  void gameReset() {
    board = new int[8][8];
    currPlayer = 1;
    gameState = -1;
    board[3][3] = 1;
    board[3][4] = 2;
    board[4][3] = 2;
    board[4][4] = 1;
    legalMoves = getLegalMoves();
  }

  boolean play(int x, int y) {
    if (gameState >= 0) return false;
    PVector move = new PVector(y - 1, x - 1);
    boolean[] directions = isLegal(move);
    if (directions == null) return false;

    board[x-1][y-1] = currPlayer;

    if (directions[0]) {
      int offset = 1;
      while (board[x-1-offset][y-1-offset] == (currPlayer % 2) + 1) {
        board[x-1-offset][y-1-offset] = currPlayer;
        offset++;
      }
    }
    if (directions[1]) {
      int offset = 1;
      while (board[x-1-offset][y-1] == (currPlayer % 2) + 1) {
        board[x-1-offset][y-1] = currPlayer;
        offset++;
      }
    }
    if (directions[2]) {
      int offset = 1;
      while (board[x-1-offset][y-1+offset] == (currPlayer % 2) + 1) {
        board[x-1-offset][y-1+offset] = currPlayer;
        offset++;
      }
    }
    if (directions[3]) {
      int offset = 1;
      while (board[x-1][y-1-offset] == (currPlayer % 2) + 1) {
        board[x-1][y-1-offset] = currPlayer;
        offset++;
      }
    }
    if (directions[4]) {
      int offset = 1;
      while (board[x-1][y-1+offset] == (currPlayer % 2) + 1) {
        board[x-1][y-1+offset] = currPlayer;
        offset++;
      }
    }
    if (directions[5]) {
      int offset = 1;
      while (board[x-1+offset][y-1-offset] == (currPlayer % 2) + 1) {
        board[x-1+offset][y-1-offset] = currPlayer;
        offset++;
      }
    }
    if (directions[6]) {
      int offset = 1;
      while (board[x-1+offset][y-1] == (currPlayer % 2) + 1) {
        board[x-1+offset][y-1] = currPlayer;
        offset++;
      }
    }
    if (directions[7]) {
      int offset = 1;
      while (board[x-1+offset][y-1+offset] == (currPlayer % 2) + 1) {
        board[x-1+offset][y-1+offset] = currPlayer;
        offset++;
      }
    }
    currPlayer = (currPlayer % 2) + 1;
    legalMoves = getLegalMoves();

    if (legalMoves == null) {
      currPlayer = (currPlayer % 2) + 1;
      legalMoves = getLegalMoves();
      if (legalMoves == null) {
        if (countRed() > countBlue()) gameState = 1;
        else if (countRed() < countBlue()) gameState = 2;
        else gameState = 0;
      }
    }
    return true;
  }

  int countRed() {
    int counter = 0;
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        if (board[i][j] == 1)
          counter++;
      }
    }
    return counter;
  }

  int countBlue() {
    int counter = 0;
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        if (board[i][j] == 2)
          counter++;
      }
    }
    return counter;
  }


  boolean[] isLegal(PVector move) { //null if none legal
    //takes a PVector and returns not null if the move is legal
    if (board[(int)move.y][(int)move.x] != 0) return null;
    int x = (int) move.x;
    int y = (int) move.y;
    boolean[] legals = new boolean[8];
    int num = -1; //top left
    for (int row = -1; row < 2; row++) {
      for (int col = -1; col < 2; col++) {
        num++;
        if (row == 0 && col == 0) num--;
        else if (x + col >= 0 && x + col < 8 && y + row >= 0 && y + row < 8) {
          if (board[y+row][x+col] == (currPlayer % 2) + 1) {
            legals[num] = true;
          }
        }
      }
    }
    if (legals[0]) {
      // up and left
      int offset = 1;
      while (x - offset > 0 && y - offset > 0 && board[y - offset][x - offset] == (currPlayer % 2) + 1) offset++;
      if (board[y - offset][x - offset] != currPlayer) legals[0] = false;
    }
    if (legals[1]) {
      // up
      int offset = 1;
      while (y - offset > 0 && board[y - offset][x] == (currPlayer % 2) + 1) offset++;
      if (board[y - offset][x] != currPlayer) legals[1] = false;
    }
    if (legals[2]) {
      // up and right
      int offset = 1;
      while (x + offset < 7 && y - offset > 0 && board[y - offset][x + offset] == (currPlayer % 2) + 1) offset++;
      if (board[y - offset][x + offset] != currPlayer) legals[2] = false;
    }
    if (legals[3]) {
      // left
      int offset = 1;
      while (x - offset > 0 && board[y][x - offset] == (currPlayer % 2) + 1) offset++;
      if (board[y][x - offset] != currPlayer) legals[3] = false;
    }
    if (legals[4]) {
      //right
      int offset = 1;
      while (x + offset < 7 && board[y][x + offset] == (currPlayer % 2) + 1) offset++;
      if (board[y][x + offset] != currPlayer) legals[4] = false;
    }
    if (legals[5]) {
      // bottom left
      int offset = 1;
      while (y + offset < 7 && x - offset > 0 && board[y + offset][x - offset] == (currPlayer % 2) + 1) offset++;
      if (board[y + offset][x - offset] != currPlayer) legals[5] = false;
    }
    if (legals[6]) {
      // bottom
      int offset = 1;
      while (y + offset < 7 && board[y + offset][x] == (currPlayer % 2) + 1) offset++;
      if (board[y + offset][x] != currPlayer) legals[6] = false;
    }
    if (legals[7]) {
      // bottom right
      int offset = 1;
      while (y + offset < 7 && x + offset < 7 && board[y + offset][x + offset] == (currPlayer % 2) + 1) offset++;
      if (board[y + offset][x + offset] != currPlayer) legals[7] = false;
    }

    for (int i = 0; i < 8; i++) 
      if (legals[i]) {
        return legals;
      }
    return null;
  }

  ArrayList<PVector> getLegalMoves() {
    ArrayList<PVector> moves = new ArrayList<PVector>();
    for (int row = 0; row < 8; row++) {
      for (int col = 0; col < 8; col++) {
        PVector move = new PVector(col, row);
        if (isLegal(move) != null) {
          moves.add(move);
        }
      }
    }
    if (moves.size() == 0) return null;
    return moves;
  }

  int isOver() {
    return gameState;
  }


  void show() {
    //grid lines
    stroke(0);
    strokeWeight(3);
    int h = height-100;
    int w = width-100;
    for (int i = 0; i <= 9; i++) {
      line(50, i*h/8+50, width-50, i*h/8+50);
    }
    for (int i = 0; i <= 9; i++) {
      line(i*w/8+50, 50, i*w/8+50, height-50);
    }


    //colors
    noStroke();
    for (int row = 0; row < 8; row++) {
      for (int col = 0; col < 8; col++) {
        if (board[row][col] == 1) fill(255, 0, 0);
        else if (board[row][col] == 2) fill(0, 0, 255);
        if (board[row][col] != 0)
          ellipse(51+w*col/8+w/16, 51+h*row/8+w/16, h/12, h/12);
      }
    }
    if (legalMoves != null) {
      if (currPlayer == 1) fill(255, 0, 0);
      else fill(0, 0, 255);
      for (PVector move : legalMoves) {
        ellipse(51+w*move.x/8+w/16, 51+h*move.y/8+w/16, 10, 10);
      }
    }
  }
  
  boolean equals(Game g1) {
      for(int i = 0; i < 8; i++) {
        for(int j = 0; j < 8; j++) {
          if(board[i][j] != g1.board[i][j]) return false;
        }
      }
      return g1.currPlayer == currPlayer;
  }
}
