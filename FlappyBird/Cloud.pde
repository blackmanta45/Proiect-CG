public class Cloud {

    private PImage cloud_img;
    private PVector position;
    private float horizontal_velocity;

    public Cloud(PVector position, float horizontal_velocity) {
        this.position = position;
        this.horizontal_velocity = horizontal_velocity;
        init();
    }

    public void init() {
        cloud_img = loadImage("../Images/cloud.png");
    }

    public void update() {
        display();
        move();
        respawn();
    }

    public void display() {
        image(cloud_img, position.x, position.y, cloud_img.width, cloud_img.height);
    }

    public void move() {
        position.x -= horizontal_velocity;
    }

    public void respawn() {
        if (position.x + cloud_img.width <= 0f) {
            position.x += displayWidth + cloud_img.width;
            position.y = random(0, displayHeight / 2.5f);
        }
    }
}