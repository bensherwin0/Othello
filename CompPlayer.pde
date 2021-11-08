class CompPlayer {
  Game g;
  int MAXTIME;
  float c; //exploration parameter

  public CompPlayer(Game g, int m) {
    this.g = g;
    //c = (float) Math.sqrt(2);
    c = .9;
    MAXTIME = m;
  }

  PVector getMove() {
    GameTree tree = new GameTree(g);

    int t1 = millis();
    while (millis() - t1 < MAXTIME) {
      //select node
      Position p = tree.root;
      while (p.children != null) {
        Position pnext = null;
        float maxval = -1;
        for (Position child : p.children) {
          if (child.checked == 0) {
            pnext = child;
            break;
          }
          float val = (child.value / child.checked) + c * (float) Math.sqrt(Math.log(p.checked) / child.checked);
          if (val > maxval) {
            maxval = val;
            pnext = child;
          }
        }
        if (pnext == null) break;
        p = pnext;
      } //now p is a leaf node

      if (p.checked != 0 && p.children == null) {
        if (p.g.isOver() < 0)
          p.backprop(randomPlayout(p.probeChildren().get(0)));
        else {
          if (p.g.isOver() == 0) p.backprop(0.5);
          else if (p.g.isOver() != p.player) p.backprop(1.);
          else p.backprop(0.0);
        }
      } else if (p.checked == 0) {
        p.backprop(randomPlayout(p));
      } else println("ya fucked up!");
    }

    int max = 0;
    Position m = null;
    PVector  choice = null;
    int count = 0;
    for (Position move : tree.root.children) {
      print(move.checked + " ");
      if (move.checked > max) {
        max = (int) move.checked;
        m = move;
        choice = tree.root.g.legalMoves.get(count);
      }
      count++;
    }
    if (choice != null) {
      println();
      println("EVAL1: " + (m.value / m.checked));
      
      return new PVector(choice.y+1, choice.x+1);
    }
    else {
      println("AAAASSSS");
      return null;
    }
  }

  float randomPlayout(Position p) {
    Game newgame = new Game(p.g);
    while (newgame.isOver() == -1) {
      int choice = (int) Math.random() * newgame.legalMoves.size();
      newgame.play((int)(newgame.legalMoves.get(choice).y + 1), (int)(newgame.legalMoves.get(choice).x + 1));
    }
    if (newgame.isOver() == 0) return 0.5;
    else if (newgame.isOver() != p.player) return 1.;
    else return 0.0;
  }
}
