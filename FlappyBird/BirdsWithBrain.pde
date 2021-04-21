public class BirdsWithBrain implements IComponent{
    private Pipes pipes;
    private PlayingGround ground;
    private int number_of_birds;

    private int generation;
    
    private double max_score = 0;

    private ArrayList<BirdWithBrain> alive_birds;
    private ArrayList<BirdWithBrain> dead_birds;
    private Pipe next_pipe;
    
    
    public BirdsWithBrain(Pipes pipes, PlayingGround ground, int number_of_birds) {
        this.pipes = pipes;
        this.ground = ground;
        this.number_of_birds = number_of_birds;
        resetSimulation();
    }
    
    public void init() {
        generation++;
        nextGeneration();
    }
    
    public void generateBirds() {
        for (int i = 0; i < number_of_birds;i++) {
            alive_birds.add(new BirdWithBrain(pipes, ground));
        }
    }
    
    public boolean update() {
        deltaDivider = 8;
        text("Generation: " + generation, 20, 120);
        for(int i = 0; i < alive_birds.size(); i++){
            BirdWithBrain bird = alive_birds.get(i);
            bird.think();
            bird.update();
            if(bird.isDead() == true){
                dead_birds.add(alive_birds.get(i));
                alive_birds.remove(i);
                i--;
            }
        }
        return alive_birds.size() > 0;
    }

    public void calculateFitness(){
        double sum = 0;
        for(BirdWithBrain bird : dead_birds){
            sum += (double)bird.getInternalScore();
        }
        for(BirdWithBrain bird : dead_birds){
            bird.setFitness(bird.getInternalScore() / sum);
        }
    }

    public void nextGeneration(){
        if(dead_birds.size() > 0){
            for(int i = 0; i < number_of_birds; i++){
                alive_birds.add(null);
            }
            calculateFitness();
            for(int i = 0; i < number_of_birds; i++){
                alive_birds.set(i, pickOne());
            }
            dead_birds.clear();
        }
    }

    public BirdWithBrain pickOne(){
        int index = 0;
        float r = random(1);
        while (r > 0 && index < dead_birds.size()) {
            r -= dead_birds.get(index).getFitness();
            index++;
        }
        index--;
        BirdWithBrain parent = dead_birds.get(index);
        BirdWithBrain child = new BirdWithBrain(pipes, ground, parent.getBrain());
        child.mutate(0.01);
        return child;
    }

    public void resetSimulation(){
        generation = 0;
        dead_birds = new ArrayList<BirdWithBrain>();
        alive_birds = new ArrayList<BirdWithBrain>();
        generateBirds();
    }

    public void overwriteGenerationNumber(int x){
        this.generation = x;
    }

    public void pause(){
        for (BirdWithBrain bird : alive_birds) {
            bird.pause();
        }
    }

    public Bird getBird(){
        return alive_birds.get(0).getInternalBird();
    }
}