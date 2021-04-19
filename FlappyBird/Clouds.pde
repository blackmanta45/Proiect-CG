import java.util.ArrayList;

public class Clouds {
    private int number_of_clouds_per_level;
    private Pipes pipes;

    private ArrayList<ArrayList<Cloud>> cloud_list;
    private int max_z = 3;
    private float slope;

    public Clouds(int number_of_clouds_per_level, Pipes pipes) {
        this.number_of_clouds_per_level = number_of_clouds_per_level;
        this.pipes = pipes;
        init();
    }

    public void init() {
        slope = .5f / 2;
        cloud_list = new ArrayList<ArrayList<Cloud>>();
        for (float z=0; z<max_z; z++) {
            cloud_list.add(new ArrayList<Cloud>());
            for (int j=0; j<number_of_clouds_per_level; j++) {
                addCloud(z);
            }
        }
    }

    public void update() {
        for (ArrayList<Cloud> cloud_list_z : cloud_list) {
            for (Cloud cloud : cloud_list_z) {
                cloud.update();
            }
        }
    }

    public void stop (){
        for (ArrayList<Cloud> cloud_list_z : cloud_list) {
            for (Cloud cloud : cloud_list_z) {
                cloud.stop();
            }
        }
    }

    public void addCloud(float z) {
        PVector cloud_position = new PVector(random(0, displayWidth), random(0, displayHeight / 2.5f));
        float cloud_speed = random(pipes.getFlatHorizontalVelocity() - (max_z - 1 - z)*2, pipes.getFlatHorizontalVelocity() + z * 2);
        Cloud cloud = new Cloud(cloud_position, cloud_speed, z, slope);
        cloud_list.get((int)z).add(cloud);
    }
}