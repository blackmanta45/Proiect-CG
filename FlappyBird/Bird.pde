public class Bird implements IComponent{
    
    private PVector start_position;
    private float ground_height;
    private Pipes pipes;
    private boolean is_in_simulation;

    private PVector position;
    private PVector restart_text_position;
    
    private PImage img;
    
    private final float bird_width = displayHeight / 14.4f;
    private final float ACCELERATION = .7f;
    
    private float vertical_velocity;
    private float max_vertical_velocity;
    private float jump_force;
    private float rotation_angle;
    private float max_rotation_angle;
    
    private Trace trace;
    
    private boolean is_dead;
    private boolean is_jumping;
    private boolean is_inside_pipe;
    private boolean is_in_pipe;
    private boolean was_in_pipe;
    
    public Bird(PVector start_position, float ground_height, Pipes pipes, boolean is_in_simulation) {
        this.start_position = start_position;
        this.ground_height = ground_height;
        this.pipes = pipes;
        this.is_in_simulation = is_in_simulation;
        init();
    }
    
    public void init() {
        position = new PVector(start_position.x, start_position.y);
        print(start_position.y);
        img = loadImage("../Images/bird_default.png");
        vertical_velocity = 0f;
        jump_force = displayHeight / 50f;
        max_vertical_velocity = jump_force / 2.2;
        rotation_angle = 0f;
        trace = new Trace(.1f, this, pipes);
        restart_text_position = new PVector(displayWidth/2 - 420, displayHeight - ground_height/2);

        is_dead = false;
        is_jumping = false;
        is_inside_pipe = false;
        is_in_pipe = false;
        was_in_pipe = false;
    }
    
    public boolean update() {
        traceUpdate();
        display();
        rotation();
        fall();
        jump();
        checkCollision();
        die();
        return !is_dead;
    }
    
    public void stop(){}
    
    public void restart(){
        is_dead = false;
        position = start_position;
        vertical_velocity = 0;
        rotation_angle = 0;
    }

    public void die() {
        if(is_dead == true && is_in_simulation == false){
            fill(255);
            textSize(100);
            text("Press R to restart!", restart_text_position.x, restart_text_position.y);
        }
    }
    
    public void traceUpdate() {
        trace.addPoint(new PVector(position.x + bird_width / 2, position.y + bird_width / 2));
        trace.update();
    }
    
    public void display() {
        pushMatrix();
        translate(position.x + bird_width / 2, position.y + bird_width / 2);
        rotate(radians(rotation_angle));
        image(img, - bird_width / 2, - bird_width / 2, bird_width, bird_width); //Drawing the bird's image
        popMatrix();
    }
    
    public void rotation() {
        if (isDead() == false) {
            if (pipes.size() >= 1) {
                max_rotation_angle = 87f - (3 * pipes.getHorizontalVelocity());
            }
            rotation_angle = max_rotation_angle / max_vertical_velocity * vertical_velocity;
        }
    }
    
    public void fall() {
        if (vertical_velocity <= max_vertical_velocity) //max fall
            vertical_velocity += ACCELERATION * delta;
        
        if (vertical_velocity <= - jump_force / 2)  //max rise
            vertical_velocity = - jump_force / 2;
        
        if (position.y + bird_width < displayHeight - ground_height) {
            position.y += vertical_velocity * delta;
        }
        else {
            is_dead = true;
        }
    }
    
    public boolean isDead() {
        return is_dead;
    }
    
    public void jump() {
        // if(keyPressed == true)
        //     vertical_velocity -= jump_force * delta;
        if (is_dead == false) {
            if (keyPressed == true && key == ' ') {
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
    
    public PVector getPosition() {
        return this.position;
    }
    
    public float getBirdWidth() {
        return bird_width;
    }
}