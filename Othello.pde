import java.util.Collections;
Game g = new Game();
CompPlayer p1;
CompPlayer2 p2;
CompPlayer3 p3;
CompPlayer4 p4;
PFont f;
int red = 2;
int blue = 2;

int counter1 = 100;
int one = 0;
int two = 0;
int tie = 0;

CompPlayer3[] players = new CompPlayer3[] {
  //{new CompPlayer3(g, 200, 0), 
  //new CompPlayer3(g, 200, .1), 
  //new CompPlayer3(g, 200, .2), 
  //new CompPlayer3(g, 200, .3), 
  //new CompPlayer3(g, 200, .4), 
  //new CompPlayer3(g, 200, .5), 
  //new CompPlayer3(g, 200, .6), 
  //new CompPlayer3(g, 200, .7), 
  //new CompPlayer3(g, 200, .8), 
  new CompPlayer3(g, 500, 1), 
  new CompPlayer3(g, 500, .9)};

void setup() {
  size(800, 800);
  f = createFont("Arial", 26, true);
  p1 = new CompPlayer(g, 1000);
  p2 = new CompPlayer2(g, 5, true);
  p3 = new CompPlayer3(g, 1000, .9);
  p4 = new CompPlayer4(g, 1000, .9);

  for (int i = 0; i < 0; i++) {
    println("Player " + i + " VS:");
    for (int j = 0; j < 0; j++) {
      if (i != j) {
        int counter = 10;
        int one = 0;
        int two = 0;
        int tie = 0;
        while (counter > 0) {
          while (g.isOver() < 0) {
            while (g.currPlayer == 1 && g.isOver() < 0) {
              PVector move = p3.getMove();
              g.play((int)move.x, (int)move.y);
              p4.updateTree();
            }
            while (g.currPlayer == 2 && g.isOver() < 0) {
              PVector move = p4.getMove();
              g.play((int)move.x, (int)move.y);
            }
          }
          if (g.isOver() == 1) one++;
          if (g.isOver() == 2) two++;
          if (g.isOver() == 0) tie++;
          counter--;
          g.gameReset();
        }
        print("Player " + j + ": " + one + " " + two + " " + tie + " | ");
      }
    }
    println();
  }

  red = g.countRed();
  blue = g.countBlue();
}


void draw() {
  background(255);

  g.show();
  textFont(f, 20);
  fill(0);
  text("Red Count: " + red, 200, 30);
  text("Blue Count: " + blue, 450, 30);

  //if (g.isOver() >= 0) {
  //  delay(2000);
  //  g.gameReset();
  //  p4.reset(g);
  //}

  //if (counter1 > 0) {
  //  if (g.isOver() < 0) {
  //    if (g.currPlayer == 1 && g.isOver() < 0) {
  //      PVector move = p4.getMove();
  //      g.play((int)move.x, (int)move.y);
  //    } else if (g.currPlayer == 2 && g.isOver() < 0) {
  //      PVector move = p3.getMove();
  //      g.play((int)move.x, (int)move.y);
  //      p4.updateTree();
  //    }
  //    red = g.countRed();
  //    blue = g.countBlue();
  //  }

  //  g.show();
  //  textFont(f, 20);
  //  fill(0);
  //  text("Red Count: " + red, 200, 30);
  //  text("Blue Count: " + blue, 450, 30);

  //  if (g.isOver() >= 0) {
  //    if (g.isOver() == 1) one++;
  //    if (g.isOver() == 2) two++;
  //    if (g.isOver() == 0) tie++;
  //    counter1--;
  //  }
  //} else if (counter1 == 0) {
  //  print(one + " " + two + " " + tie);
  //  counter1--;
  //}
}

void mousePressed() {
  int r = (int)((mouseY-50)*8./(height-100))+1;
  int c = (int)((mouseX-50)*8./(width-100))+1;
  if (r < 9 && c < 9) {
    g.play(r, c);
  }
  while (g.currPlayer == 2 && g.isOver() < 0) {
    PVector move = p3.getMove();
    g.play((int)move.x, (int)move.y);
  }
  red = g.countRed();
  blue = g.countBlue();
}
