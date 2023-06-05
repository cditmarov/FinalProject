public class Menu{
  public int score;
  public int maxScore;
  public int diff;
  public Frog frog;
  public Setting setting;
  
  public Menu(Frog frog){
    this.frog = frog;
  }
  
  public void newFrog(Frog frog) {
    this.frog = frog;
    score = 0;
  }
  
  public void displayMenu(){
    fill(150, 160, 170);
    rect(12, 10, 660, 158);
    rect(684, 10, 218, 158);
    
    fill(0,0,0);
    PFont f = createFont("Arial",30,true);
    textFont(f);
    text("Current Score: " + score, 30, 40);
    text("High Score: " + maxScore, 30, 80);
    
  }
  
  public void scoreUp(){
    score++;
  }
  
  public void update(){
    if (maxScore < score) {
      maxScore = score;
    }
    if (frog.alive < 0) {
      score = 0;
    }
  }
  
}
