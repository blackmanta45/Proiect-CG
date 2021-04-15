public class Pipe {
    
    private PVector position;
    private float horizontal_velocity;
    
    private PImage img;
    private PVector hole_position;
    
    
    private final int reduce_hitbox_percentage = 10;
    private final int pipe_width_percentage = 21;
    private final float pipe_width = displayWidth / pipe_width_percentage;
    
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
        hole_position.y = random(100, displayHeight - hole_size - displayHeight / 8.5);
        upper_pipe_size = hole_position.y;
        lower_pipe_size = height - (hole_position.y + hole_size);
    }
    
    public void update() {
        display();
        move();
    }
    
    public void display() {
        fill(#00FF00);
        stroke(0);
        strokeWeight(4);
        rect(position.x, 0, pipe_width, upper_pipe_size);
        rect(position.x, hole_position.y + hole_size, pipe_width, lower_pipe_size);
    }
    
    public void move() {
        position.x -= horizontal_velocity;
    }
    
    public boolean checkIndividualCollision(PVector bird_position) {
        boolean is_in_pipe = isInPipe(bird_position);
        boolean is_not_in_hole = bird_position.y + Bird.WIDTH * reduce_hitbox_percentage / 100 <= hole_position.y || bird_position.y + Bird.WIDTH * (100 - reduce_hitbox_percentage) / 100 >= hole_position.y + hole_size;
        return is_in_pipe && is_not_in_hole;
    }
    
    public boolean isInPipe(PVector bird_position) {
        return bird_position.x + Bird.WIDTH * (100 - reduce_hitbox_percentage) / 100 >= position.x && bird_position.x + reduce_hitbox_percentage / 100 <= position.x + pipe_width;
    }
    
    public void updateSpeed(float new_horizontal_velocity) {
        horizontal_velocity = new_horizontal_velocity;
    }
    
    public float getPipeWidth() {
        return pipe_width;
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
    
    public float getHorizontalVelocity() {
        return horizontal_velocity;
    }
    
}