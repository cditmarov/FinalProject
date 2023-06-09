
import processing.sound.*;
  
  SoundFile backgroundMusic;
  SoundFile difficult;
  SoundFile crash;
  SoundFile plop;
  SoundFile wan;
  
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
  PImage truckLeft;
  PImage road;
  PImage water;
  PImage blank;
  PImage tint;
  PImage sad;
  PImage start;
  PImage controls;

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
  truckLeft = loadImage("truckLeft.png");
  road = loadImage("road.png");
  blank = loadImage("blank.png");
  water = loadImage("water.png");
  tint = loadImage("tint.png");
  sad = loadImage("sad.png");
  start = loadImage("start.png");
  controls = loadImage("controls.png");
  backgroundMusic = new SoundFile(this, "backgroundMusic.wav");
  difficult = new SoundFile(this, "difficulty.wav");
  crash = new SoundFile(this, "crash.wav");
  plop = new SoundFile(this, "plop.wav");
  wan = new SoundFile(this, "wan.wav");
  backgroundMusic.play();
  backgroundMusic.loop();

}

Boolean startGame = false;
Boolean menuOn = false;
Boolean canMove = false;
Setting setting = new Setting();
Frog f = new Frog(setting);
Menu menu = new Menu(f, setting);
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
  image(dead, f.updateXpos(), f.updateYpos());
  if (! wan.isPlaying()) wan.play();
  if (! crash.isPlaying()) crash.play();
}
  if (f.alive == -2) {
  image(drowned, f.updateXpos(), f.updateYpos());
  if (! wan.isPlaying()) wan.play();
  if (! plop.isPlaying()) plop.play();
}
  menu.displayMenu();
  f.update();
  menu.update();
  if (startGame == false) {
    image(start, 2,0);
  }
  if (menuOn == true) {
    image(controls, 2,0);
  }
  
  fill(255);
  rect(0,0, 914, 2);
  rect(0,0,2, 1330);
  rect(912, 0, 2, 1330);
  rect(0, 1328, 914, 2);

}

  
void keyPressed() {
  if (canMove){
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
  }
  if (key == 'r') {
    setting = new Setting();
    f = new Frog(setting);
    menu.reset(f, setting);
    wan.stop();
    crash.stop();
    plop.stop();
  }
  if (key == 't') {
    setting.changeDifficulty();
  }
  
  if (key == 'q') {
    startGame = true;
    menuOn = false;
    canMove = true;
  }
  
  if(key == 'm') {
    menuOn = true;
    canMove = false;
    setting = new Setting();
    f = new Frog(setting);
    menu.reset(f, setting);
    wan.stop();
    crash.stop();
    plop.stop();
  }
}
