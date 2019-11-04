int FrameSize = 400;
int ButtonHeight = 20;
int ButtonWidth = 50;
int DIMENSION= 20;
int tileSize = FrameSize/DIMENSION;
int maxSurround = 0;

PFont f;   

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
        arc(0, 0, 0.9 * tileSize, 0.9 * tileSize, radians(0), radians(180));
        arc(0, 0, 0.3 * tileSize, 0.3 * tileSize, radians(180), radians(360));
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
        }
      else {
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

  Tile[][]board;


  MyMinesweeper() {

    Tile[][] board = new Tile[DIMENSION+2][DIMENSION+2];
    int BOMB_PROBABILITY =10;
    
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
        translate((r-1) * tileSize, (c-1) *tileSize + ButtonHeight);
       
       // board[r][c].tileDisplay(dis_bomb);
        print(board[r].length);
        popMatrix();
      }
    }
  }

  boolean isVisible(int r, int c) {
    return board[r][c].visible;
  }
 

};



void setup() {
  size(400, 450);
  f = createFont("Arial", 10, true);
 
 MyMinesweeper sweeper = new MyMinesweeper();
  sweeper.display(true); // Final board with bombs shown
  
}
