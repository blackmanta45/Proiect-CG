public class Cloud {
    
    private PVector position;
    private float horizontal_velocity;
    private float z;
    private float slope;
    
    private float ratio;
    private PImage cloud_img;
    
    public Cloud(PVector position, float horizontal_velocity, float z, float slope) {
        this.position = position;
        this.horizontal_velocity = horizontal_velocity;
        this.z = z;
        this.slope = slope;
        init();
    }
    
    public void init() {
        cloud_img = loadImage("../Images/cloud.png");
        ratio = 0.5f + z * slope;
    }
    
    public void update() {
        display();
        move();
        respawn();
    }
    
    public void stop(){
        horizontal_velocity = 0;
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