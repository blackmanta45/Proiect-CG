public class UI {

    public int score;

    public UI() {
        score = 0;
    }

    public void displayScore() {
        fill(255);
        textSize(50);
        text("SCORE: " + score, width/2 - 100, 75);
    }
}