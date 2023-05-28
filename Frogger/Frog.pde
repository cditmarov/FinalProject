public class Frog{
  float xpos = 422;
  float ypos = 1160;
  int size = 70;
  int alive = 0;
  int curLine = 0;
  Setting setting;
  
  public Frog(Setting setting) {
    this.setting = setting;
  }
  
  
  public float updateXpos(){
    return xpos;
  }
  
  public float updateYpos(){
    return ypos;
  }
  
  public void up() {
    if (alive == 0) {
    if (ypos > 950) {
    ypos -= size;
    curLine++;
    }
    }
  }
  
  public void down() {
    if (alive == 0) {
    if (ypos < 1160) {
    ypos += size;
    curLine--;
    }
    }
  }
  
  public void right() {
    if (alive == 0) {
    if (xpos < 842) {
    xpos += size;
    }
    }
  }
  
  public void left() {
    if (alive == 0) {
    if (xpos > 2) {
    xpos -= size;
    }
    }
  }
  
  public void dieByCar() {
    alive = -1;
  }
  
  public void dieByWater() {
    alive = -2;
  }
  
  public int checkSafety() {
    int safe = setting.lines[curLine].safe;
    Obstacle obstacle = setting.lines[curLine].obstacle;
    for (PVector eachObstacle : obstacle.objects) {
      if (obstacle.type == 1) {
        if ((xpos >= eachObstacle.x - 45 && xpos <= eachObstacle.x + obstacle.len * 70 + 45) && (xpos + 70 >= eachObstacle.x - 45 && xpos + 70 <= eachObstacle.x + obstacle.len * 70 + 45)) {
          safe += obstacle.safe;
        }
      }
      if (obstacle.type == 0) {
        if((xpos >= eachObstacle.x + 15 && xpos <= eachObstacle.x + obstacle.len * 70 - 15) || (xpos + 70 >= eachObstacle.x + 15 && xpos + 70 <= eachObstacle.x + obstacle.len * 70 - 15)){
          safe += obstacle.safe;
        }
      }
    }
    return safe;
  }
  
  public void update() {
    if (checkSafety() < -5) {
      dieByCar();
    }
    if (checkSafety() < 0 && checkSafety() > -5) {
      dieByWater();
    }
    move(findSpeed());
  }
  
  public float findSpeed() {
    Obstacle obstacle = setting.lines[curLine].obstacle;
    float spd = 0;
    for (PVector eachObstacle : obstacle.objects) {
      if (obstacle.type == 1) {
        if ((xpos >= eachObstacle.x - 45 && xpos <= eachObstacle.x + obstacle.len * 70 + 45) && (xpos + 70 >= eachObstacle.x - 45 && xpos + 70 <= eachObstacle.x + obstacle.len * 70 + 45)) {
          spd += obstacle.spd * obstacle.direction;
        }
      }
      if (obstacle.type == 0) {
        if((xpos >= eachObstacle.x + 15 && xpos <= eachObstacle.x + obstacle.len * 70 - 15) || (xpos + 70 >= eachObstacle.x + 15 && xpos + 70 <= eachObstacle.x + obstacle.len * 70 - 15)){
          spd += obstacle.spd * obstacle.direction;
        }
      }
    }
    return spd;
  }
  
  public void move(float spd) {
    xpos += spd;
  }
  
}
