import java.util.ArrayList;

public class Background implements IComponent{
    private float horizontal_velocity;

    private Clouds clouds;

    public Background(float horizontal_velocity) {
        this.horizontal_velocity = horizontal_velocity;
        init();
    }

    public void init() {
        clouds = new Clouds(3, horizontal_velocity);
    }

    public boolean update() {
        clouds.update();
        return true;
    }

    public void pause(){
        clouds.pause();
    }
}