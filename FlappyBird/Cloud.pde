public class Cloud {
    
    private PVector position;
    private float start_horizontal_velocity;
    private float z;
    private float slope;
    
    private float horizontal_velocity;
    private float ratio;
    private PImage cloud_img;
    
    private boolean is_paused;
    
    public Cloud(PVector position, float start_horizontal_velocity, float z, float slope) {
        this.position = position;
        this.start_horizontal_velocity = start_horizontal_velocity;
        this.z = z;
        this.slope = slope;
        init();
    }
    
    public void init() {
        horizontal_velocity = start_horizontal_velocity;
        cloud_img = loadImage("../Images/cloud.png");
        ratio = 0.5f + z * slope;
        is_paused = false;
    }
    
    public void update() {
        display();
        if(is_paused == false){
            move();
            respawn();
        }
    }

    public void pause(){
        is_paused = is_paused == true ? false : true;
    }
    
    public void display() {
        image(cloud_img, position.x, position.y, cloud_img.width * ratio, cloud_img.height * ratio);
    }
    
    public void move() {
        position.x -= horizontal_velocity * delta;
    }
    
    public void respawn() {
        if (position.x + cloud_img.width * ratio <= 0f) {
            position.x += displayWidth + cloud_img.width * ratio;
            position.y = random(0, displayHeight / 2.5f);
        }
    }

}