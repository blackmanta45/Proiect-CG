import java.util.ArrayList;

public class Clouds {

    private ArrayList<ArrayList<Cloud>> cloud_list;
    private int max_z = 3;
    private int number_of_clouds_per_level;
    private float slope;

    public Clouds(int number_of_clouds_per_level) {
        this.number_of_clouds_per_level = number_of_clouds_per_level;
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

    public void addCloud(float z) {
        Cloud cloud = new Cloud(new PVector(random(0, displayWidth), random(0, displayHeight / 2.5f)), random(pipes.getFlatHorizontalVelocity() - (max_z - 1 - z)*2, pipes.getFlatHorizontalVelocity() + z * 2), z, slope);
        cloud_list.get((int)z).add(cloud);
    }
}