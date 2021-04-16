public class Pipe {
    
    private PVector position;
    private float horizontal_velocity;
    
    private PImage top_part;
    private PImage bottom_part;
    private PVector hole_position;
    
    
    private final int reduce_hitbox_percentage = 10;
    private final int pipe_width_percentage = 16;
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
        top_part = loadImage("../Images/pipe_default.png");
        bottom_part = loadImage("../Images/pipe_default.png");
        hole_size = random(displayHeight / 4.2f, displayHeight / 3.75f);
        hole_position.y = random(100, displayHeight - hole_size - displayHeight / 5.1);
        println(hole_position.y);
        upper_pipe_size = hole_position.y;
        lower_pipe_size = height - (hole_position.y + hole_size);
    }
    
    public void update() {
        display();
        move();
    }
    
    public void display() {
        // Top Image
        pushMatrix();
        translate(0, displayHeight);
        scale(1,-1);
        image(top_part, position.x, displayHeight - hole_position.y, pipe_width, bottom_part.height);
        translate(0, -displayHeight);
        popMatrix();

        // Bottom Image
        image(bottom_part, position.x, hole_position.y + hole_size, pipe_width, bottom_part.height);
    }
    
    public void move() {
        if (bird.isDead() == false) {
            position.x -= horizontal_velocity;
        }
    }
    
    public boolean checkIndividualCollision(PVector bird_position) {
        boolean is_in_pipe = isInPipe(bird_position);
        boolean is_not_in_hole = bird_position.y + bird.getBirdWidth() * reduce_hitbox_percentage / 100 <= hole_position.y || bird_position.y + bird.getBirdWidth() * (100 - reduce_hitbox_percentage) / 100 >= hole_position.y + hole_size;
        return is_in_pipe && is_not_in_hole;
    }
    
    public boolean isInPipe(PVector bird_position) {
        return bird_position.x + bird.getBirdWidth() * (100 - reduce_hitbox_percentage) / 100 >= position.x && bird_position.x + reduce_hitbox_percentage / 100 <= position.x + pipe_width;
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