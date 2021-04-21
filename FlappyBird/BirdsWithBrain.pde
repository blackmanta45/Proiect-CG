public class BirdsWithBrain implements IComponent{
    private Pipes pipes;
    private PlayingGround ground;
    private int number_of_birds;
    
    private double max_score = 0;

    private ArrayList<BirdWithBrain> birds_list;
    private ArrayList<BirdWithBrain> deleted_birds;
    private Pipe next_pipe;
    
    
    public BirdsWithBrain(Pipes pipes, PlayingGround ground, int number_of_birds) {
        deltaDivider = 8;
        this.pipes = pipes;
        this.ground = ground;
        deleted_birds = new ArrayList<BirdWithBrain>();
        this.number_of_birds = number_of_birds;
        birds_list = new ArrayList<BirdWithBrain>();
        generateBirds();
        init();
    }
    
    public void init() {
        nextGeneration();
        // print(" MAX SCORE :" + max_score);
    }
    
    public void generateBirds() {
        for (int i = 0; i < number_of_birds;i++) {
            birds_list.add(new BirdWithBrain(pipes, ground));
        }
    }
    
    public boolean update() {
        for(int i = 0; i < birds_list.size(); i++){
            BirdWithBrain bird = birds_list.get(i);
            bird.think();
            bird.update();
            if(bird.isDead() == true){
                deleted_birds.add(birds_list.get(i));
                birds_list.remove(i);
                i--;
            }
        }
        return birds_list.size() > 0;
    }

    public void calculateFitness(){
        double sum = 0;
        for(BirdWithBrain bird : deleted_birds){
            sum += (double)bird.getInternalScore();
        }
        // println(sum);
        for(BirdWithBrain bird : deleted_birds){
            bird.setFitness(bird.getInternalScore() / sum);
            // println((double)bird.getFitness());
        }
    }

    public void nextGeneration(){
        if(deleted_birds.size() > 0){
            for(int i = 0; i < number_of_birds; i++){
                birds_list.add(null);
            }
            calculateFitness();
            for(int i = 0; i < number_of_birds; i++){
                birds_list.set(i, pickOne());
            }
            deleted_birds.clear();
        }
    }

    public BirdWithBrain pickOne(){
        int index = 0;
        float r = random(1);
        while (r > 0 && index < deleted_birds.size()) {
            r -= deleted_birds.get(index).getFitness();
            index++;
        }
        index--;
        println(index);
        BirdWithBrain parent = deleted_birds.get(index);
        BirdWithBrain child = new BirdWithBrain(pipes, ground, parent.getBrain());
        child.mutate(0.1);
        return child;
    }


    public void pause(){
        for (BirdWithBrain bird : birds_list) {
            bird.pause();
        }
    }

    public Bird getBird(){
        return birds_list.get(0).getInternalBird();
    }
}