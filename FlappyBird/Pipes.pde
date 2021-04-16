import java.util.ArrayList;
import java.util.List;

public class Pipes{
    
    private float horizontal_velocity;
    private float max_horizontal_velocity;
    private float increment_horizontal_velocity;
    
    private List<Pipe> pipes_list;
    
    private int number_of_pipes;
    private int current_number_of_pipes;
    
    private float distance_between_pipes;
    private float pipe_width;
    
    public Pipes(float horizontal_velocity, float max_horizontal_velocity, float increment_horizontal_velocity) {
        this.horizontal_velocity = horizontal_velocity;
        this.max_horizontal_velocity = max_horizontal_velocity;
        this.increment_horizontal_velocity = increment_horizontal_velocity;
        init();
    }
    
    public void init() {
        this.distance_between_pipes = displayWidth / 4;
        this.number_of_pipes = Math.round(width / distance_between_pipes) + 1;
        this.pipes_list = new ArrayList<Pipe>();
        this.current_number_of_pipes = 0;
        addNewPipe();
        this.pipe_width = pipes_list.get(0).getPipeWidth();
    }
    
    public void update() {
        updateAllPipes();
        verifyFirstPipe();
        tryToAddPipe();
    }
    
    public void updateAllPipes() {
        float new_speed = horizontal_velocity * delta;
        //println(new_speed);
        for (Pipe pipe : pipes_list) {
            if (bird.isDead() == false) 
                pipe.updateSpeed(new_speed);
            pipe.update();
        }
    }
    
    public void verifyFirstPipe() {
        if (pipes_list.size() > 0) {
            float x_position_of_first_pipe = pipes_list.get(0).getPosition().x;
            if (x_position_of_first_pipe < - pipe_width) {
                pipes_list.remove(0);
            }
        }
    }
    
    public void tryToAddPipe() {    
        if (current_number_of_pipes < number_of_pipes && calculateLastDistance() >= distance_between_pipes) {
            addNewPipe();
        }
    }
    
    public void addNewPipe() {
        println("Added new pipe");
        pipes_list.add(new Pipe(new PVector(width, 0), horizontal_velocity));
    }
    
    public float calculateLastDistance() {
        if (pipes_list.size() > 0) {
            float x_position_of_last_pipe = pipes_list.get(pipes_list.size() - 1).getPosition().x;
            return width - x_position_of_last_pipe;
        }
        return 0;
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
            float delta_horizontal_velocity = horizontal_velocity * delta;
            for (Pipe pipe : pipes_list) {
                pipe.updateSpeed(delta_horizontal_velocity);
            }
        }
    }
    
    public boolean checkCollision(PVector bird_position) {
        for (Pipe pipe : pipes_list) {
            if (pipe.checkIndividualCollision(bird_position) == true) {
                for (Pipe pipE : pipes_list) {
                    pipE.updateSpeed(0f);
                }
                return true;
            }
        }
        return false;
    }
    
    public boolean isInAnyPipe(PVector bird_position) {
        for (Pipe pipe : pipes_list) {
            if (pipe.isInPipe(bird_position) == true)
                return true;
        }
        return false;
    }
    
    public int size() {
        return pipes_list.size();
    }
    
    public float getHorizontalVelocity() {
        return horizontal_velocity * delta;
    }
    
    public float getDistanceBetweenPipes() {
        return distance_between_pipes;
    }
    
    
}