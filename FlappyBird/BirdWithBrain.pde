public class BirdWithBrain{
    private NeuralNetwork brain;
    private Bird bird;
    private Pipes pipes;
    private boolean is_displayed;
    private PlayingGround ground;

    private ArrayList<Double> input;
    private ArrayList<Double> output;

    private float[] inputs = new float[5];

    private double internal_score;
    private double fitness;

    public BirdWithBrain(Pipes pipes, PlayingGround ground, boolean is_displayed){
        this.pipes = pipes;
        this.ground = ground;
        this.is_displayed = is_displayed;
        internal_score = 0;
        brain = new NeuralNetwork(5,8,2);
        createBird();
    }

    public BirdWithBrain(Pipes pipes, PlayingGround ground, boolean is_displayed, NeuralNetwork brain){
        this.pipes = pipes;
        this.ground = ground;
        this.is_displayed = is_displayed;
        this.brain = brain.copy();
        internal_score = 0;
        createBird();
    }

    public void think(){
        input = new ArrayList<Double>();
        Pipe next_pipe = pipes.findNextPipe();
        float bird_y_position = (float) bird.getPosition().y / displayHeight;
        float bird_y_vert_vel = (float) bird.getVerticalVelocity() / 15;
        float pipe_x_position = (float) next_pipe.getPosition().x / displayWidth;
        float pipe_hole_y_top = (float) next_pipe.getSpacingPosition().y / displayHeight;
        float pipe_hole_y_bottom = (float) pipe_hole_y_top + next_pipe.getSpacingHeight() / displayHeight;

        inputs[0] = bird_y_position;
        inputs[1] = bird_y_vert_vel;
        inputs[2] = pipe_x_position;
        inputs[3] = pipe_hole_y_top;
        inputs[4] = pipe_hole_y_bottom;

        float[] guess = brain.feedForward(inputs);
        if (guess[0] > guess[1]){
            bird.jump();
        }
    }

    public void createBird(){
        bird = new Bird(new PVector(displayWidth * 25 / 100f, displayHeight / 2), ground.getHeight(), pipes, true, is_displayed);
    }
    
    public void mutate(float value){
        brain.mutate(value);
    }

    public boolean isDead(){
        return bird.isDead();
    }

    public void update(){
        internal_score += 1;
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