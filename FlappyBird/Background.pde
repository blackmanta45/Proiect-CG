import java.util.ArrayList;

public class Background implements IComponent{
    private Bird bird;
    private Pipes pipes;

    // private PImage sky_img;
    // private PVector sky_position;

    private Clouds clouds;

    public Background(Pipes pipes) {
        this.bird = bird;
        this.pipes = pipes;
        init();
    }

    public void init() {
        // sky_img = loadImage("../Images/sky3.png");
        // sky_position = new PVector(0, 0);

        clouds = new Clouds(3, pipes);

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