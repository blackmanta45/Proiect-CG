public class Pipe {

    private PImage img;
    private PVector position;
    private PVector spacing_position;

    public static final int distance_between_pipes = 550;
    private int number_of_pipes = width / distance_between_pipes + 1;

    private float horizontal_velocity = 10f; 
    private float max_horizontal_velocity = horizontal_velocity + 1f;
    private float spacing_height = 275f;
    public static final float WIDTH = 120f;
    private float upper_height;
    private float lower_height;

    public Pipe(PVector position) {
        this.position = position;
        spacing_position = new PVector();
        spacing_position.y = random(100, height - spacing_height - 100);
        upper_height = spacing_position.y;
        lower_height = height - (spacing_position.y + spacing_height);
    }

    public void update() {
        display();
        move();
        respawn();
        // increaseSpeed();
    }

    public PVector getPosition() {
        return position;
    }

    public PVector getSpacingPosition() {
        return spacing_position;
    }

    public float getSpacingHeight() {
        return spacing_height;
    }

    public void setHorizontalVelocity(float horizontal_velocity) {
        this.horizontal_velocity = horizontal_velocity;
    }

    public float getHorizontalVelocity() {
        return horizontal_velocity;
    }

    public void display() {
        noFill();
        stroke(#FF00FF);
        strokeWeight(3);
        rect(position.x, 0, WIDTH, upper_height);
        rect(position.x, spacing_position.y + spacing_height, WIDTH, lower_height);
    }

    public void move() {
        position.x -= horizontal_velocity;
    }

    public void respawn() {
        if (position.x + WIDTH <= 0) {
            position.x += number_of_pipes * distance_between_pipes;
            spacing_position.y = random(100, height - spacing_height - 100);
            upper_height = spacing_position.y;
            lower_height = height - (spacing_position.y + spacing_height);
        }
    }

    public void increaseSpeed() {
        println(horizontal_velocity);
        if (ui.score % 5 == 0) { // !!!
            horizontal_velocity += .1f;
        }
        if (horizontal_velocity >= max_horizontal_velocity) {
            horizontal_velocity = max_horizontal_velocity;
        }
    }
}