public class Pipe {
    
    private PVector position;
    private float horizontal_velocity;
    
    private PImage img;
    private PVector hole_position;
    
    
    private final int reduceHitboxPercentage = 10;
    private final int pipeWidthPercentage = 21;
    private final float pipeWidth = displayWidth / pipeWidthPercentage;
    
    private float hole_size;
    private float upper_pipe_size;
    private float lower_pipe_size;
    
    public Pipe(PVector position, float horizontal_velocity) {
        this.position = position;
        this.horizontal_velocity = horizontal_velocity;
        init();
    }
    
    public void init() {
        hole_position = new PVector();
        hole_size = random(250, 350);
        hole_position.y = random(100, height - hole_size - 100);
        upper_pipe_size = hole_position.y;
        lower_pipe_size = height - (hole_position.y + hole_size);
    }
    
    public void update() {
        display();
        move();
    }
    
    public PVector getPosition() {
        return position;
    }
    
    public PVector getSpacingPosition() {
        return hole_position;
    }
    
    public float getSpacingHeight() {
        return hole_size;
    }
    
    public void setHorizontalVelocity(float horizontal_velocity) {
        this.horizontal_velocity = horizontal_velocity;
    }
    
    public float getHorizontalVelocity() {
        return horizontal_velocity;
    }
    
    public void display() {
        fill(#00FF00);
        stroke(0);
        strokeWeight(4);
        rect(position.x, 0, pipeWidth, upper_pipe_size);
        rect(position.x, hole_position.y + hole_size, pipeWidth, lower_pipe_size);
    }
    
    public void move() {
        position.x -= horizontal_velocity;
    }
    
    public boolean checkIndividualCollision(PVector birdPosition) {
        boolean isInPipe = isInPipe(birdPosition);
        boolean isNotInHole = birdPosition.y + Bird.WIDTH * reduceHitboxPercentage / 100 <= hole_position.y || birdPosition.y + Bird.WIDTH * (100 - reduceHitboxPercentage) / 100 >= hole_position.y + hole_size;
        return isInPipe && isNotInHole;
    }
    
    public boolean isInPipe(PVector birdPosition) {
        return birdPosition.x + Bird.WIDTH * (100 - reduceHitboxPercentage) / 100 >= position.x && birdPosition.x + reduceHitboxPercentage / 100 <= position.x + pipeWidth;
    }
    
    public void updateSpeed(float new_horizontal_velocity) {
        horizontal_velocity = new_horizontal_velocity;
    }
    
    public float getPipeWidth() {
        return pipeWidth;
    }
}