public class Setting{
  Line[] lines = new Line[15];
  
  public Setting() {
    lines[0] = new Line(1, 2);
    lines[1] = new Line(1, 0);
    for (int i = 2; i < 15; i++) {
      lines[i] = new Line(i, chooseType(i));
    }
  }
  
  public int chooseType(int pos) {
      int rand = (int) (Math.random() * 3);
      if (rand >= 1) return lines[pos-1].type;
      if (rand == 0) return Math.abs(lines[pos-1].type - 1);
      else return 0;
  }
  
  public void displayScreen(){
    for (int i = 0; i < 15; i++) {
      lines[i].printLine();
    }
  }
  
  public void nextLine() {
    for (int i = 0; i < 14; i++) {
      lines[i] = lines[i + 1];
      lines[i].moveUp();
    }
    lines[14] = new Line(14, chooseType(14));
    this.displayScreen();
  }
  
  public Line getLine(int pos) {
    return this.lines[pos];
  }
  
  public void update() {
    for (Line eachLine : lines) {
      eachLine.update();
    }
  }
  
}



public class Line {
  int ypos; // y position from the bottom out of 15
  int size = 70;
  int safe;
  int type;
  color mainColor;
  PImage[] textures = new PImage[2];
  PImage texture;
  Obstacle obstacle;


  public Line(int ypos, int type) {
    this.ypos = ypos;
    this.type = type;
    if (type == 0) {
      safe = 1;
      mainColor = color(125, 120, 120);
      obstacle = new Cars(0, ypos);

    }
    if (type == 1) {
      safe = -1;
      mainColor = color(110, 150, 250);
      obstacle = new Logs(0, ypos);
    }
    if (type == 2) {
      safe = 1;
      mainColor = color(0,0,0);
      obstacle = new Obstacle(-2, ypos);

    }
  }

  public void printLine() {
    fill(mainColor);
    rect(2, (1160 - ypos * size), 910, size);
    if (type == 1) obstacle.display(log);
    if (type == 0) obstacle.display(car);
  }

  public void moveUp() {
    if (ypos < 15) {
      ypos--;
      obstacle.moveUp();
    }
  }
  
  public void update() {
    obstacle.move();
  }
  
}

public class Obstacle {
  int safe;
  int difficulty;
  int spacing;
  PImage texture;
  int numOfobjects;
  PVector[] objects;
  int direction = (int) (Math.random() * 2);
  int ypos;
  int len;
  float spd;
  int type;
  
  public Obstacle(int difficulty, int ypos) {
    this.difficulty = difficulty;
    this.ypos = ypos;
    objects = new PVector[0];
  }
  
  public void display(PImage img) {
    
  }
   
  public void moveUp() {
    ypos--;
    for (int i = 0; i < objects.length; i++) {
      objects[i].y = 1160 - ypos * 70;
    }
  }
  
  public void move() {
    for (int i = 0; i < objects.length; i++) {
      if (direction == -1) {
      if (objects[i].x > -len * 70) {
      objects[i].x += spd * direction;
      }
      else objects[i].x = 912;
      }
      if (direction == 1) {
      if (objects[i].x < 912) {
      objects[i].x += spd * direction;
      }
      else objects[i].x = -len * 70;
      }
    }
  }

}

public class Logs extends Obstacle {
  
  public Logs(int difficulty, int ypos) {
    super(difficulty, ypos);
    safe = 2;
    type = 1;
    if (Math.random() * 2 > 1) direction = -1;
    else direction = 1;
    len = (int) (Math.random() * (3-difficulty)) + 1;
    spacing = (int) (Math.random() * (2 + 2*difficulty)) + 1;
    spd = (float) (Math.random() * (2 + difficulty) + 1);
    numOfobjects = 13 / (len + spacing);
    objects = new PVector[numOfobjects];
    for (int i = 0; i < numOfobjects; i++) {
      objects[i] = new PVector(2+ (spacing + len) * i * 70, 1160 - ypos * 70);
    }
  }
  
  public void display(PImage img) {
    for (PVector logPos : objects) {
      for (int i = 0; i < len; i++){
        image(img, logPos.x + i * 70, logPos.y);
      }
    }
  }
}

public class Cars extends Obstacle {
  
  public Cars(int difficulty, int ypos) {
    super(difficulty, ypos);
    safe = -10;
    type = 0;
    if (Math.random() * 2 > 1) direction = -1;
    else direction = 1;
    len = (int) (Math.random() * (1+difficulty)) + 1;
    spacing = (int) (Math.random() * (6 - difficulty)) + 3;
    spd = (float) (Math.random() * (2 + difficulty) + 1);
    numOfobjects = 13 / (len + spacing);
    objects = new PVector[numOfobjects];
    for (int i = 0; i < numOfobjects; i++) {
      objects[i] = new PVector(2+ (spacing + len) * i * 70, 1160 - ypos * 70);
    }
  }
  
  public void display(PImage img) {
    for (PVector carPos : objects) {
      image(car, carPos.x, carPos.y);
    }
  }
}