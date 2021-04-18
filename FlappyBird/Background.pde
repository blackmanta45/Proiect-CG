import java.util.ArrayList;

public class Background {

    // private PImage sky_img;
    // private PVector sky_position;

    private Clouds clouds;

    public Background() {
        init();
    }

    public void init() {
        // sky_img = loadImage("../Images/sky3.png");
        // sky_position = new PVector(0, 0);

        clouds = new Clouds(3);

    }

    public void update() {
        // image(sky_img, sky_position.x, sky_position.y, displayWidth, displayHeight);

        clouds.update();
    }
}