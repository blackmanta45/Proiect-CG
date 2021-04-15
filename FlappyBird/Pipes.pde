import java.util.ArrayList;
import java.util.List;

public class Pipes{
    private List<Pipe> pipesList;
    private int number_of_pipes;
    private int current_number_of_pipes;
    private int distance_between_pipes;
    

    public Pipes(){
        this.distance_between_pipes = 600;
        this.number_of_pipes = width / distance_between_pipes + 1;
        this.pipesList = new ArrayList<Pipe>();
        this.current_number_of_pipes = 0;
        init();
    }

    public void init(){
        addNewPipe();
    }

    public void update(){
        updateAllPipes();
        verifyFirstPipe();
        tryToAddPipe();
    }

    public void updateAllPipes(){
        for(Pipe pipe : pipesList){
            pipe.update();
        }
    }

    public float getDistanceBetweenPipes(){
        return distance_between_pipes;
    }

    public void updatePipesDistance(){
        if(distance_between_pipes < 700){
            distance_between_pipes += 10;
            number_of_pipes = width / distance_between_pipes + 1;
        }
    }

    public void updatePipesSpeed(){
        for(Pipe pipe : pipesList){
            pipe.increaseSpeed();
        }
    }

    public void verifyFirstPipe() {
        float x_position_of_first_pipe = pipesList.get(0).getPosition().x;
        if (x_position_of_first_pipe < -Pipe.WIDTH){
            //pipesList.get(0) = null;
            pipesList.remove(0);
        }
    }

    public void tryToAddPipe(){
        if(current_number_of_pipes < number_of_pipes && calculateDistance() > distance_between_pipes){
            addNewPipe();
        }
    }

    public float calculateDistance(){
        float x_position_of_last_pipe = pipesList.get(pipesList.size() - 1).getPosition().x;
        return width - x_position_of_last_pipe;
    }

    public int size(){
        return pipesList.size();
    }

    public float getHorizontalVelocity(){
        if(pipesList.size() > 0)
            return pipesList.get(0).getHorizontalVelocity();
        return 0;
    }

    public boolean checkCollision(PVector positionOfBird){
        for(Pipe pipe : pipesList){
           if(pipe.checkIndividualCollision(positionOfBird) == true){
                for (Pipe pipE : pipesList) {
                    pipE.setHorizontalVelocity(0f);
                }
                return true;
           }
        }
        return false;
    }

    public void addNewPipe(){
        println("Added new pipe");
        pipesList.add(new Pipe(new PVector(width, 0)));
    }
}