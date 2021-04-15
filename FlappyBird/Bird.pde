public class Bird {
    
    private PVector position;
    
    private PImage img;

    private PVector score_node;
    
    private static final float WIDTH = 70f;
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
        score_node = new PVector(width + Pipe.WIDTH, height / 2);

        is_dead = false;
        is_jumping = false;
        is_inside_pipe = false;
    }

    public void update() {
        die();
        traceUpdate();
        display();
        rotation();
        fall();
        jump();
        score();
        checkCollision();
    }

    public PVector getPosition() {
        return position;
    }
    
    public void display() {
        pushMatrix();
        translate(position.x + WIDTH / 2, position.y + WIDTH / 2);
        rotate(radians(rotation_angle));
        image(img, - WIDTH / 2 - 10, - WIDTH / 2 - 10, WIDTH + 20, WIDTH + 20); //Drawing the bird's image
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
    
    public void die(){
        if (is_dead == true && position.y >= height) {
            // noLoop(); // Stops Program
            exit(); // Exits Program
        }
    }

    public void checkCollision() {
        if(is_dead == false)
            is_dead = pipes.checkCollision(position);
    }
    
    public void score() {
        rect(score_node.x, score_node.y, 10, 10);
        if (position.x >= score_node.x) {
            ui.score++;
            if(ui.score % 5 == 0){
                pipes.updatePipesSpeed();
            }
            score_node.x += pipes.getDistanceBetweenPipes();
        }
        if (is_dead == false) {
            score_node.x -= pipes.getHorizontalVelocity();
        }
    }
    
    public void traceUpdate() {
        trace.addPoint(new PVector(position.x + WIDTH/2, position.y + WIDTH/2));
        trace.update();
    }
}