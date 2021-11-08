class GameTree {
  Position root;

  public GameTree(Game g) {
    root = new Position(null, g);
    root.children = new ArrayList<Position>();
    for (PVector move : g.legalMoves) {
      Game newGame = new Game(g);
      newGame.play((int)move.y + 1, (int)move.x + 1);
      root.children.add(new Position(root, newGame));
    }
  }
}
