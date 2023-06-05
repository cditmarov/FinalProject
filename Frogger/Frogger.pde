  PImage up;
  PImage down;
  PImage right;
  PImage left;
  PImage dead;
  PImage drowned;
  PImage log;
  PImage car;
  PImage carLeft;
  PImage truck;

void setup(){
  size(914,1330);
  up = loadImage("fUp.png");
  down = loadImage("fDown.png");
  right = loadImage("fRight.png");
  left = loadImage("fLeft.png");
  dead = loadImage("fDead.png");
  drowned = loadImage("fDrown.png");
  log = loadImage("log.png");
  car = loadImage("car.png");
  carLeft = loadImage("carLeft.png");
  truck = loadImage("truck.png");
}


Setting setting = new Setting();
Frog f = new Frog(setting);
Menu menu = new Menu(f);
boolean upp = true;
boolean downn = false;
boolean rightt = false;
boolean leftt = false;

void draw() {
  frameRate = 10;
  background(0);
  setting.displayScreen();
  setting.update();
  if (upp && f.alive == 0 ) {
  image(up, f.updateXpos(), f.updateYpos()); }
  if (downn && f.alive == 0) {
  image(down, f.updateXpos(), f.updateYpos()); }
  if (rightt && f.alive == 0) {
  image(right, f.updateXpos(), f.updateYpos()); }
  if (leftt && f.alive == 0) {
  image(left, f.updateXpos(), f.updateYpos()); }
  if (f.alive == -1) {
  image(dead, f.updateXpos(), f.updateYpos()); }
  if (f.alive == -2) {
  image(drowned, f.updateXpos(), f.updateYpos());
  }
  menu.displayMenu();
  f.update();
  menu.update();

}

  
void keyPressed() {
  if (key == 'w') {
    if (f.ypos > 950) {
    f.up();
    }
    else { if (f.alive == 0)
      setting.nextLine();
      menu.scoreUp();
    }
    upp = true;
    downn = false;
    rightt = false;
    leftt = false;
  }
  if (key == 'a') {
    f.left();
    rightt = false;
    leftt = true;
    upp = false;
    downn = false;
  }
  if (key == 's') {
    f.down();
    downn = true;
    upp = false;
    rightt = false;
    leftt = false;  
  }
  if (key == 'd') {
    f.right();
    rightt = true;
    leftt = false;
    upp = false;
    downn = false;  
  }
  if (key == 'r') {
    setting = new Setting();
    f = new Frog(setting);
    menu.newFrog(f);
  }
  if (key == 't') {
    setting.changeDifficulty();
  }
}
