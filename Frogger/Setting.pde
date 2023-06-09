public class Setting{
  Line[] lines = new Line[15];
  float difficulty = 0;
  
  public Setting() {
    lines[0] = new Line(1, 2, difficulty);
    lines[1] = new Line(1, 0, difficulty);
    for (int i = 2; i < 15; i++) {
      lines[i] = new Line(i, chooseType(i), difficulty);
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
    lines[14] = new Line(14, chooseType(14), difficulty);
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
  
  public void changeDifficulty() {
    if (difficulty < 4) {
    difficulty += 0.2;
    difficult.play();
    }
  }
  
}



public class Line {
  int ypos; // y position from the bottom out of 15
  int size = 70;
  int safe;
  int type;
  float difficulty;
  PImage texture;
  Obstacle obstacle;


  public Line(int ypos, int type, float difficulty) {
    this.ypos = ypos;
    this.type = type;
    this.difficulty = difficulty;
    if (type == 0) {
      safe = 1;
      texture = road;
      obstacle = new Cars(difficulty, ypos);

    }
    if (type == 1) {
      safe = -1;
      texture = water;
      obstacle = new Logs(difficulty, ypos);
    }
    if (type == 2) {
      safe = 1;
      texture = blank;
      obstacle = new Obstacle(-2, ypos);

    }
  }

  public void printLine() {
    if (type == 0) image(road, 2, (1160 - ypos * size));
    if (type == 1) image(water, 2, (1160 - ypos * size));
    if (type == 3) image(blank, 2, (1160 - ypos * size));
    obstacle.display();
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
  float difficulty;
  int spacing;
  int numOfobjects;
  PVector[] objects;
  int direction = (int) (Math.random() * 2);
  int ypos;
  int len;
  float spd;
  int type;
  
  public Obstacle(float difficulty, int ypos) {
    this.difficulty = difficulty;
    this.ypos = ypos;
    if (Math.random() * 2 > 1) direction = -1;
    else direction = 1;
    objects = new PVector[0];
  }
  
  public void display() {
    
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
  
  public Logs(float difficulty, int ypos) {
    super(difficulty, ypos);
    safe = 2;
    type = 1;
    len = (int) (Math.random() * (4-difficulty)) + 1;
    spacing = (int) (Math.random() * (1 + difficulty)) + 1;
    spd = (float) (Math.random() * (1 + 2 * difficulty) + 1);
    numOfobjects = 13 / (len + spacing);
    objects = new PVector[numOfobjects];
    for (int i = 0; i < numOfobjects; i++) {
      objects[i] = new PVector(2+ (spacing + len) * i * 70, 1160 - ypos * 70);
    }
  }
  
  public void display() {
    for (PVector logPos : objects) {
      for (int i = 0; i < len; i++){
        image(log, logPos.x + i * 70, logPos.y);
      }
    }
  }
}

public class Cars extends Obstacle {
  int carOrBus;
  
  public Cars(float difficulty, int ypos) {
    super(difficulty, ypos);
    safe = -10;
    type = 0;
    if ((int) (Math.random() * 3) < 2) carOrBus = 1;
    else carOrBus = 2;
    len = carOrBus;
    spacing = (int) (Math.random() * (6 - difficulty)) + 2;
    spd = (float) (Math.random() * (1 + 2 * difficulty) + 1);
    numOfobjects = 13 / (len + spacing);
    objects = new PVector[numOfobjects];
    for (int i = 0; i < numOfobjects; i++) {
      objects[i] = new PVector(2+ (spacing + len) * i * 70, 1160 - ypos * 70);
    }
  }
  
  public void display() {
    for (PVector carPos : objects) {
      if (direction == 1) {
        if (carOrBus == 1) image(car, carPos.x, carPos.y);
        else image(truck, carPos.x, carPos.y);
      }
      if (direction == -1) {
        if (carOrBus == 1) image(carLeft, carPos.x, carPos.y);
        else image(truckLeft, carPos.x, carPos.y);
      }
    }
  }
}
