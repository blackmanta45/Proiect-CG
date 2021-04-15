import java.util.ArrayList;
import java.util.List;

public class Pipes{
    
    private float horizontal_velocity;
    private float max_horizontal_velocity;
    private float increment_horizontal_velocity;
    
    private List<Pipe> pipesList;
    
    private int number_of_pipes;
    private int current_number_of_pipes;
    
    private float distance_between_pipes;
    private float pipeWidth;
    
    public Pipes(float horizontal_velocity, float max_horizontal_velocity, float increment_horizontal_velocity) {
        this.horizontal_velocity = horizontal_velocity;
        this.max_horizontal_velocity = max_horizontal_velocity;
        this.increment_horizontal_velocity = increment_horizontal_velocity;
        init();
    }
    
    public void init() {
        this.distance_between_pipes = 600f;
        this.number_of_pipes = Math.round(width / distance_between_pipes) + 1;
        this.pipesList = new ArrayList<Pipe>();
        this.current_number_of_pipes = 0;
        addNewPipe();
        this.pipeWidth = pipesList.get(0).getPipeWidth();
    }
    
    public void update() {
        updateAllPipes();
        verifyFirstPipe();
        tryToAddPipe();
    }
    
    public void updateAllPipes() {
        for (Pipe pipe : pipesList) {
            pipe.update();
        }
    }
    
    public boolean isInAnyPipe(PVector birdPosition) {
        for (Pipe pipe : pipesList) {
            if (pipe.isInPipe(birdPosition) == true)
                return true;
        }
        return false;
    }
    
    public float getDistanceBetweenPipes() {
        return distance_between_pipes;
    }
    
    public void updatePipesDistance() {
        if (distance_between_pipes < 700) {
            distance_between_pipes += 10;
            number_of_pipes = Math.round(width / distance_between_pipes) + 1;
        }
    }
    
    public void updatePipesSpeed() {
        if (horizontal_velocity < max_horizontal_velocity) {
            horizontal_velocity += increment_horizontal_velocity;
            for (Pipe pipe : pipesList) {
                pipe.updateSpeed(horizontal_velocity);
            }
        }
    }
    
    public void verifyFirstPipe() {
        float x_position_of_first_pipe = pipesList.get(0).getPosition().x;
        if (x_position_of_first_pipe < - pipeWidth) {
            pipesList.remove(0);
        }
    }
    
    public void tryToAddPipe() {
        if (current_number_of_pipes < number_of_pipes && calculateDistance() >= distance_between_pipes) {
            addNewPipe();
        }
    }
    
    public float calculateDistance() {
        float x_position_of_last_pipe = pipesList.get(pipesList.size() - 1).getPosition().x;
        return width - x_position_of_last_pipe;
    }
    
    public int size() {
        return pipesList.size();
    }
    
    public float getHorizontalVelocity() {
        return horizontal_velocity;
    }
    
    public boolean checkCollision(PVector positionOfBird) {
        for (Pipe pipe : pipesList) {
            if (pipe.checkIndividualCollision(positionOfBird) == true) {
                for (Pipe pipE : pipesList) {
                    pipE.setHorizontalVelocity(0f);
                }
                return true;
         }
        }
        return false;
    }
    
    public void addNewPipe() {
        pipesList.add(new Pipe(new PVector(width, 0), horizontal_velocity));
    }
}