public class BirdWithBrain{
    private NeuralNetwork brain;
    private Bird bird;
    private Pipes pipes;
    private PlayingGround ground;

    private ArrayList<Double> input;
    private ArrayList<Double> output;

    private double internal_score;
    private double fitness;

    public BirdWithBrain(Pipes pipes, PlayingGround ground){
        this.pipes = pipes;
        this.ground = ground;
        internal_score = 0;
        brain = new NeuralNetwork(5,8,2);
        createBird();
    }

    public BirdWithBrain(Pipes pipes, PlayingGround ground, NeuralNetwork brain){
        this.pipes = pipes;
        this.ground = ground;
        internal_score = 0;
        this.brain = brain.copy();
        createBird();
    }

    public void think(){
        input = new ArrayList<Double>();
        Pipe next_pipe = pipes.findNextPipe();
        double bird_y_position = (double) bird.getPosition().y / displayHeight;
        double bird_y_vert_vel = (double) bird.getVerticalVelocity() / 15;
        double pipe_x_position = (double) next_pipe.getPosition().x / displayWidth;
        double pipe_hole_y_top = (double) next_pipe.getSpacingPosition().y / displayHeight;
        double pipe_hole_y_bottom = (double) pipe_hole_y_top + next_pipe.getSpacingHeight() / displayHeight;

        input.add(bird_y_position);
        input.add(bird_y_vert_vel);
        input.add(pipe_x_position);
        input.add(pipe_hole_y_top);
        input.add(pipe_hole_y_bottom);

        output = brain.predict(input);
        // println("OUTPUT 1: " + output.get(0));
        // println("OUTPUT 2: " + output.get(1));
        if(output.get(0) > output.get(1)){
            bird.jump();
        }
    }

    public void createBird(){
        bird = new Bird(new PVector(displayWidth * 25 / 100f, displayHeight / 2), ground.getHeight(), pipes, true, true);
    }
    
    public void mutate(float value){
        brain.mutate((double)value);
    }

    public boolean isDead(){
        return bird.isDead();
    }

    public void update(){
        internal_score += 1;
        // println(internal_score);
        bird.update();
    }

    public void pause(){
        bird.pause();
    }

    public double getInternalScore(){
        return this.internal_score;
    }

    public void setFitness(double fitness){
        this.fitness = fitness;
    }

    public double getFitness(){
        return fitness;
    }

    public NeuralNetwork getBrain(){
        return this.brain;
    }

    public Bird getInternalBird(){
        return this.bird;
    }

}