int FrameSize = 400;
int ButtonHeight = 20;
int ButtonWidth = 50;
int DIMENSION= 20;
int tileSize = FrameSize/DIMENSION;
int maxSurround = 0;
int BOMB_PROBABILITY =10;
PFont f;   
ArrayList<IntList> to_do_list = new ArrayList<IntList>();
IntList curr = new IntList();
//https://processing.org/tutorials/text/
class Tile {
  boolean isBomb;

  Tile(boolean bomb) {
    isBomb = bomb;
  }
  //counter of surrounding bombs
  int surround=0;

  boolean visible=false;
  boolean flag=false;
  void tileDisplay(boolean dis_bomb) {
    fill(255);
    square(0, 0, tileSize);
    if (dis_bomb) {
      if (isBomb) {
        fill(0);
        arc(tileSize/2, tileSize/2, 0.9 * tileSize, 0.9 * tileSize, radians(0), radians(180));
        arc(tileSize/2, tileSize/2, 0.3 * tileSize, 0.3 * tileSize, radians(180), radians(360));
      } else if (visible && surround!=0) {
        textFont(f, 13);                 
        fill(0);                        
        text(surround, 10, 10);
      } else {
        fill(125);
        square(0, 0, tileSize);
      }
      println();
    } else {
      if (visible && surround!=0) {
        textFont(f, 13);                 
        fill(0);                        
        text(surround, 10, 10);
      } else {
        fill(125);
        square(0, 0, tileSize);
      }
      println();
    }
  }
};



class MyMinesweeper {

  //ArrayList<ArrayList<Tile>> board;


  //modifying  ?

  Tile[][] board = new Tile[DIMENSION+2][DIMENSION+2];


  MyMinesweeper() {




    for (int r=0; r<(DIMENSION+2); r++) {       //fill in the bombs

      for (int c=0; c<(DIMENSION+2); c++) {
        if (r==0 || c==0||r==(DIMENSION+1)||c==(DIMENSION+1)) {       //empty boundary
          Tile tile = new Tile(false);
          board[c][r] = tile;
        } else if (random(100)<BOMB_PROBABILITY) {
          Tile tile = new Tile(true);
          board[c][r] = tile;
        } else {
          Tile tile = new Tile(false);
          board[c][r] = tile;
        }
      }
    }

    for (int r=1; r<(DIMENSION+1); r++) {               //fill in the surroundings
      for (int c=1; c<(DIMENSION+1); c++) {
        if (board[r-1][c-1].isBomb) {
          board[r][c].surround+=1;
          if (board[r][c].surround > maxSurround) {
            maxSurround = board[r][c].surround;
          }
        }
        if (board[r-1][c].isBomb) {
          board[r][c].surround+=1;
          if (board[r][c].surround > maxSurround) {
            maxSurround = board[r][c].surround;
          }
        }
        if (board[r-1][c+1].isBomb) {
          board[r][c].surround+=1;
          if (board[r][c].surround > maxSurround) {
            maxSurround = board[r][c].surround;
          }
        }
        if (board[r][c-1].isBomb) {
          board[r][c].surround+=1;
          if (board[r][c].surround > maxSurround) {
            maxSurround = board[r][c].surround;
          }
        }
        if (board[r][c+1].isBomb) {
          board[r][c].surround+=1;
          if (board[r][c].surround > maxSurround) {
            maxSurround = board[r][c].surround;
          }
        }
        if (board[r+1][c-1].isBomb) {
          board[r][c].surround+=1;
          if (board[r][c].surround > maxSurround) {
            maxSurround = board[r][c].surround;
          }
        }
        if (board[r+1][c].isBomb) {
          board[r][c].surround+=1;
          if (board[r][c].surround > maxSurround) {
            maxSurround = board[r][c].surround;
          }
        }
        if (board[r+1][c+1].isBomb) {
          board[r][c].surround+=1;
          if (board[r][c].surround > maxSurround) {
            maxSurround = board[r][c].surround;
          }
        }
      }
    }
  }

  void display(boolean dis_bomb) {

    for (int r=1; r<(DIMENSION+1); r++) {
      for (int c=1; c<(DIMENSION+1); c++) {

        pushMatrix();
        translate((c-1) * tileSize, (r-1) *tileSize + ButtonHeight);

        board[r][c].tileDisplay(dis_bomb);
        //print(board[r].length);
        popMatrix();
      }
    }
  }
  boolean done() {

    boolean isDone;
    for (int r=1; r<(DIMENSION+1); r++) {
      for (int c=1; c<(DIMENSION+1); c++) {
        isDone=(board[r][c].isBomb!=board[r][c].visible);
        //print(isDone);
        if (!isDone) {
          return false;
        }
      }
    }
    return true;
  }
  boolean isVisible(int r, int c) {
    return board[r][c].visible;
  }

  boolean play(int row, int col) {
    if (board[row][col].isBomb) {
      return false;
    }

    curr.append(row);
    curr.append(col);
    to_do_list.add(curr);


    while (to_do_list.size()!=0) {

      curr=to_do_list.get(to_do_list.size()-1);
      println(1);
      int r=curr.get(0);
      int c=curr.get(1);
      to_do_list.remove(to_do_list.size()-1);
      curr.clear();
      //    Tile tile=board[r][c];                //making a copy do NOT do it!!!!
      if (!board[r][c].isBomb) {

        if (!board[r][c].visible) {
          board[r][c].visible=true;
          if (board[r][c].surround==0) {

            if (r>1) {
              int r1=r-1;
              curr.append(r1);
              if (c>1) {
                int c1=c-1;
                curr.append(c1);
                to_do_list.add(curr);  //r-1,c-1
                curr.remove(1);
                curr.append(c);
                to_do_list.add(curr);   //r-1,c
                curr.remove(1);
              }
              if (c<DIMENSION) {
                int c2=c+1;
                curr.append(c2);
                to_do_list.add(curr); //r-1,c+1
                curr.remove(1);
              }
            }
            curr.clear();
            if (r<DIMENSION) {
              int r2=r+1;
              curr.append(r2);
              if (c>1) {
                int c1=c-1;
                curr.append(c1);
                to_do_list.add(curr);  //r+1,c-1
                curr.remove(1);
                curr.append(c);
                to_do_list.add(curr);    //r+1,c
                curr.remove(1);
              }
              if (c<DIMENSION) {
                int c2=c+1;
                curr.append(c2);
                to_do_list.add(curr); //r+1,c+1
                curr.remove(1);
              }
            }
            curr.clear();
            curr.append(r);
            if (c>1) {
              int c1=c-1;
              curr.append(c1);
              to_do_list.add(curr);  //r,c-1
              curr.remove(1);
            }
            if (c<DIMENSION) {
              int c2=c+1;
              curr.append(c2);
              to_do_list.add(curr); //r,c+1
              curr.remove(1);
            }
            curr.clear();                   //
          }           //surround=0
        }       //not visible
      }       //not bomb
    }       //while loop
    return true;
  }//play function
};


MyMinesweeper sweeper = new MyMinesweeper();
void setup() {
  size(400, 450);
  f = createFont("Arial", 10, true);


  sweeper.display(true);
}
void draw() {
}

void mousePressed() {
  println(mouseX, mouseY);
  int row_sel = (int)((mouseY - ButtonHeight)/tileSize) +1;
  int col_sel = (int)((mouseX)/tileSize)+1;
  println(col_sel, row_sel );
  if (!sweeper.play(row_sel, col_sel)) {
    print( "Sorry, you died..\n");
    sweeper.display(false); // Final board with bombs shown
  }
  if (sweeper.done()) {

    print( "You won!!!!\n");
  } else {
    sweeper.display(false);
  }
}
