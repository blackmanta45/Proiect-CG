import java.util.ArrayList;
import java.util.List;

public class Pipes implements IComponent{
    
    private float start_horizontal_velocity;
    private float max_horizontal_velocity;
    private float increment_horizontal_velocity;
    private float bird_width;
    
    private List<Pipe> pipes_list;
    
    private int number_of_pipes;
    private int current_number_of_pipes;
    
    private float distance_between_pipes;
    private float pipe_width;
    private float horizontal_velocity;
    private float distance_travelled;
    
    public Pipes(float start_horizontal_velocity, float max_horizontal_velocity, float increment_horizontal_velocity, float bird_width) {
        this.start_horizontal_velocity = start_horizontal_velocity;
        this.max_horizontal_velocity = max_horizontal_velocity;
        this.increment_horizontal_velocity = increment_horizontal_velocity;
        this.bird_width = bird_width;
        init();
    }
    
    public void init() {
        horizontal_velocity = start_horizontal_velocity;
        this.distance_travelled = 0;
        this.distance_between_pipes = displayWidth / 4;
        this.number_of_pipes = Math.round(width / distance_between_pipes) + 1;
        this.current_number_of_pipes = 0;
        this.pipes_list = new ArrayList<Pipe>();
        addNewPipe();
        this.pipe_width = pipes_list.get(0).getPipeWidth();
    }
    
    public boolean update() {
        updateAllPipes();
        verifyFirstPipe();
        tryToAddPipe();
        return true;
    }
    
    public void pause() {
        horizontal_velocity = horizontal_velocity == 0 ? start_horizontal_velocity : 0;
    }
    
    public void updateAllPipes() {
        float new_speed = horizontal_velocity * delta;
        distance_travelled += new_speed;
        for (Pipe pipe : pipes_list) {
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
        pipes_list.add(new Pipe(new PVector(width, 0), horizontal_velocity, bird_width));
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
    
    public Pipe findNextPipe() {
        float bird_x_position = displayWidth * 25 / 100f;
        for (Pipe pipe : pipes_list) {
            if (bird_x_position < pipe.getPosition().x + pipe.getPipeWidth())
                return pipe;
        }
        return null;
    }
    
    public boolean checkCollision(PVector bird_position) {
        return findNextPipe().checkIndividualCollision(bird_position);
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
    
    public float getFlatHorizontalVelocity() {
        return horizontal_velocity;
    }

    public float getDistanceTravelled(){
        return distance_travelled;
    }
    
}