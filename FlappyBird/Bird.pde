public class Bird {
    
    private PVector position;
    
    private PImage img;
    
    private static final float WIDTH = 90f;
    private final float ACCELERATION =.7f;
    
    private float vertical_velocity;
    private float terminal_velocity;
    private float jump_force;
    private float rotation_angle;
    private float max_rotation_angle;
    
    private Trace trace;
    
    private boolean is_dead;
    private boolean is_jumping;
    private boolean is_inside_pipe;
    private boolean is_in_pipe;
    private boolean was_in_pipe;
    
    public Bird(PVector position) {
        this.position = position;
        init();
    }
    
    public void init() {
        img = loadImage("../Images/bird_default.png");
        vertical_velocity = 0f;
        terminal_velocity = 15f;
        jump_force = 27f;
        rotation_angle = 0f;
        trace = new Trace(.1f);
        
        is_dead = false;
        is_jumping = false;
        is_inside_pipe = false;
        is_in_pipe = false;
        was_in_pipe = false;
    }
    
    public void update() {
        die();
        traceUpdate();
        display();
        rotation();
        fall();
        jump();
        checkCollision();
    }
    
    public PVector getPosition() {
        return position;
    }
    
    public void display() {
        pushMatrix();
        translate(position.x + WIDTH / 2, position.y + WIDTH / 2);
        rotate(radians(rotation_angle));
        image(img, - WIDTH / 2, - WIDTH / 2, WIDTH, WIDTH); //Drawing the bird's image
        popMatrix();
    }
    
    public void rotation() {
        if (pipes.size() >= 1) {
            max_rotation_angle = 87f - (3 * pipes.getHorizontalVelocity());
        }
        rotation_angle = max_rotation_angle / terminal_velocity * vertical_velocity;
    }
    
    public void fall() {
        if (vertical_velocity <= terminal_velocity)
            vertical_velocity += ACCELERATION;
        position.y += vertical_velocity;
        if (vertical_velocity <= - jump_force / 2) {
            vertical_velocity = - jump_force / 2;
        }
        if (position.y > height) {
            is_dead = true;
        }
    }
    
    public boolean isDead() {
        return is_dead;
    }
    
    public void jump() {
        if (is_dead == false) {
            if (keyPressed == true) {
                if (is_jumping == false) {
                    vertical_velocity -= jump_force;
                    is_jumping = true;
                }
            }
            else {
                is_jumping = false;
            }
        }
        if (position.y <= 0) {
            position.y = 0; 
        }
    }
    
    public void die() {
        if (is_dead == true && position.y >= height) {
            // noLoop(); // Stops Program
            exit(); // Exits Program
        }
    }
    
    public void checkCollision() {
        if (is_dead == false)
            is_dead = pipes.checkCollision(position);
    }
    
    public boolean checkIfPassed() {
        if (pipes.isInAnyPipe(position) == true) {
            is_in_pipe = true;
            was_in_pipe = true;
        } else{
            is_in_pipe = false;
        }
        
        if (is_in_pipe == false && was_in_pipe == true) {
            was_in_pipe = false;
            return true;
        }
        return false;
    }
    
    public void traceUpdate() {
        trace.addPoint(new PVector(position.x + WIDTH / 2, position.y + WIDTH / 2));
        trace.update();
    }
}