import java.util.ArrayList;

public class Clouds {

    private ArrayList<Cloud> cloud_list;
    private int number_of_clouds;

    public Clouds(int number_of_clouds) {
        this.number_of_clouds = number_of_clouds;
        init();
    }

    public void init() {
        cloud_list = new ArrayList<Cloud>();
        for (int i=0; i<number_of_clouds; i++) {
            addCloud(new Cloud(new PVector(random(0, displayWidth), random(0, displayHeight / 2.5f)), -random(pipes.getHorizontalVelocity() - 5f, pipes.getHorizontalVelocity() - 3f)));
        }
    }

    public void update() {
        for (Cloud cloud : cloud_list) {
            cloud.update();
        }
    }

    public void addCloud(Cloud cloud) {
        cloud_list.add(cloud);
    }
}