public class Score {
    
    private int score;
    private Pipes pipes;
    private Bird bird;

    private float textSize;
    private PVector position;
    
    public Score(Pipes pipes, Bird bird) {
        this.pipes = pipes;
        this.bird = bird;
        init();
    }
    
    public void init() {
        score = 0;
        textSize = displayHeight / 14f;
        position = new PVector();
        position.x = displayWidth / 2 - textSize / 2;
        position.y = textSize;
    }
    
    public void update() {
        displayScore();
        tryToIncrement();
    }
    
    public void displayScore() {
        fill(255);
        textSize(textSize);
        text(score, position.x, position.y);
        
    }
    
    public void tryToIncrement() {
        if (bird.checkIfPassed() == true) {
            score++;
            if (score % 5 == 0)
                pipes.updatePipesSpeed();
        }
    }
    
}