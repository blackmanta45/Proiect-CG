import java.util.ArrayList;

public class Background implements IComponent{
    private float horizontal_velocity;

    // private PImage sky_img;
    // private PVector sky_position;

    private Clouds clouds;

    public Background(float horizontal_velocity) {
        this.horizontal_velocity = horizontal_velocity;
        init();
    }

    public void init() {
        // sky_img = loadImage("../Images/sky3.png");
        // sky_position = new PVector(0, 0);

        clouds = new Clouds(3, horizontal_velocity);

    }

    public boolean update() {
        // image(sky_img, sky_position.x, sky_position.y, displayWidth, displayHeight);

        clouds.update();
        return true;
    }

    public void stop(){
        clouds.stop();
    }
}