class Position {
    float value;
    float checked;
    int player;
    Game g;
    Position parent;
    ArrayList<Position> children;
   
    public Position(Position p, Game g){
        value = 0;
        checked = 0;
        this.g = g;
        player = g.currPlayer;
        parent = p;
        children = null;
    }
   
    ArrayList<Position> probeChildren() {
      children = new ArrayList<Position>();
      for(PVector move : g.legalMoves) {
          Game newGame = new Game(g);
          newGame.play((int)move.y + 1, (int)move.x + 1);
          children.add(new Position(this, newGame));
      }
      //Collections.shuffle(children);
      return children;
    }
   
    void backprop(float val) {
        checked++;
        value += val;
        if(parent != null) {
            if(parent.player != player) parent.backprop(1 - val);
            else parent.backprop(val);
        }
    }
   
}
