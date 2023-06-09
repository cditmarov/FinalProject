public class Menu{
  public int score;
  public int maxScore;
  public float difficulty;
  public Frog frog;
  public Setting setting;
  
  public Menu(Frog frog, Setting setting){
    this.frog = frog;
    this.setting = setting;
    this.difficulty = setting.difficulty;
  }
  
  public void reset(Frog frog, Setting setting) {
    this.setting = setting;
    this.frog = frog;
    score = 0;
    difficulty = 0;
  }
  
  public void displayMenu(){
    fill(167, 164, 154);
    rect(12, 10, 560, 158);
    rect(584, 10, 318, 158);
    
    fill(0,0,0);
    PFont f = createFont("Arial",30,true);
    textFont(f);
    text("Current Score: " + score, 30, 45);
    text("High Score: " + maxScore, 30, 85);
    text("Difficulty: " + (int) (difficulty * 50) + "%", 30, 125);
    
    text("Press 'm' to access\nthe menu", 602, 45);
  }

  public void die() {
    score = 0;
    image(tint, 0, 0);
    
    fill(167, 164, 154);
    rect(150,500, 600,200);
    
    fill(0,0,0);
    text("You died! \nPress 'r' to restart", 175, 545);
    image(sad, 500, 520);
    
    
  }
   
  
  
  public void scoreUp(){
    score++;
    if (score % 10 == 0) setting.changeDifficulty();  
  }
  
  public void update(){
    if (maxScore < score) {
      maxScore = score;
    }
    if (frog.alive < 0) {
      die();
    }
    this.difficulty = setting.difficulty;
  }
  
  
}
