public class UI {
    
    private int score;
    private Pipes pipes;
    private Bird bird;
    
    public UI(Pipes pipes, Bird bird) {
        this.pipes = pipes;
        this.bird = bird;
        init();
    }
    
    public void init() {
        score = 0;
    }
    
    public void update() {
        displayScore();
        tryToIncrement();
    }
    
    public void displayScore() {
        fill(255);
        textSize(50);
        text("SCORE: " + score, width / 2 - 100, 75);
    }
    
    public void tryToIncrement() {
        if (bird.checkIfPassed() == true) {
            score++;
            if (score % 5 == 0)
                pipes.updatePipesSpeed();
        }
    }
    
}