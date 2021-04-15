public class Bird {
    
    private PImage img = loadImage("../Images/bird_default.png");
    private PVector position;
    
    private static final float WIDTH = 70f;
    private final float ACCELERATION =.7f;
    private float vertical_velocity = 0f;
    private float terminal_velocity = 15f;
    private float jump_force = 27f;
    private float rotation_angle = 0f;
    private float max_rotation_angle;
    private Trace trace_head = new Trace(new PVector());
    private List<Trace> trace_list = new LinkedList<Trace>();
    public PVector score_node = new PVector(width + Pipe.WIDTH, height / 2);
    
    private boolean is_dead = false;
    private boolean is_jumping = false;
    private boolean is_inside_pipe = false;
    
    public Bird(PVector position) {
        this.position = position;
    }
    
    public void update() {
        die();
        display();
        rotation();
        fall();
        jump();
        showTrace();
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
        // noFill();
        // stroke(#FF0000);
        // strokeWeight(1);
        // rect(-35, -35, 70, 70);
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
        // for (Pipe pipe : pipes) {
        //     if (position.x + WIDTH >= pipe.getPosition().x && position.x <= pipe.getPosition().x + Pipe.WIDTH) {
        //         if (position.y <= pipe.getSpacingPosition().y || position.y + WIDTH >= pipe.getSpacingPosition().y + pipe.getSpacingHeight()) {
        //             for (Pipe pipE : pipes) {
        //                 pipE.setHorizontalVelocity(0f);
        //             }
        //             is_dead = true;
        //         }
        //     }
        // }
        // if (is_dead && position.y >= height + 100) {
        //     // noLoop(); // Stops Program
        //     exit(); // Exits Program
        // }
        if(is_dead == false)
            is_dead = pipes.checkCollision(position);
    }
    
    public void score() {
        // rect(score_node.x, score_node.y, 10, 10);
        if (position.x >= score_node.x) {
            ui.score++;
            score_node.x += pipes.getDistanceBetweenPipes();
        }
        score_node.x -= pipes.getHorizontalVelocity();
    }
    
    public void showTrace() {
        trace_head.position = new PVector(position.x - 5, position.y + WIDTH / 2);
        if (trace_list.size() >= 1) {
            if (dist(trace_head.position.x, trace_head.position.y, trace_list.get(trace_list.size() - 1).position.x, trace_list.get(trace_list.size() - 1).position.y) >= Trace.spacing) {
                trace_list.add(new Trace(new PVector(trace_head.position.x, trace_head.position.y)));
            }
        }
        else {
            trace_list.add(new Trace(new PVector(trace_head.position.x, trace_head.position.y)));
        }
        for (Trace trace : trace_list) {
            trace.display();
            if (is_dead == false) { 
                trace.move();
            }
            // trace.unreference(trace);
        }
        // println(trace_list.get(0));
    }
    
}