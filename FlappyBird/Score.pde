public class Score implements IComponent{
    private float time_since_restart;
    private int score;
    private Pipes pipes;
    private Bird bird;

    private float textSize;
    private PVector position;
    
    public Score(Bird bird, Pipes pipes) {
        this.bird = bird;
        this.pipes = pipes;
        init();
    }
    
    public void init() {
        score = 0;
        textSize = displayHeight / 14f;
        position = new PVector();
        position.x = displayWidth / 2 - textSize / 2;
        position.y = textSize;
        time_since_restart = millis();
    }
    
    public boolean update() {
        displayScore();
        tryToIncrement();
        return true;
    }

    public void pause(){}
    
    public void displayScore() {
        fill(255);
        textSize(textSize);
        text(score, position.x, position.y);
        
    }
    
    public void tryToIncrement() {
        if (bird.checkIfPassed() == true && millis() - time_since_restart > 500) {
            score++;
            if (score % 5 == 0)
                pipes.updatePipesSpeed();
        }
    }
    
}