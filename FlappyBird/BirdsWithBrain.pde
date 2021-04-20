public class BirdsWithBrain implements IComponent{
    private Pipes pipes;
    private PlayingGround ground;
    private int number_of_birds;
    
    private double [] fitness;
    private double max_score = 0;

    private ArrayList<Double> current_data;
    private ArrayList<Bird> birds_list;
    private ArrayList<ArrayList<ArrayList<Double>>> input;
    private ArrayList<ArrayList<ArrayList<Double>>> output;
    private ArrayList<NeuralNetwork> neuralNetwork = new ArrayList<NeuralNetwork>();
    private NeuralNetwork best_network;

    private double bird_y_position;
    private double pipe_x_position;
    private double pipe_hole_y_top;
    private double pipe_hole_y_bottom;
    private Pipe next_pipe;
    
    
    public BirdsWithBrain(Pipes pipes, PlayingGround ground, int number_of_birds) {
        this.pipes = pipes;
        this.ground = ground;
        this.number_of_birds = number_of_birds;
        for(int i = 0; i<number_of_birds;i++){
            neuralNetwork.add(new NeuralNetwork(4,5,1));
        }
        init();
    }
    
    public void init() {
        neuralNetwork.clear();
        for(int i = 0; i<number_of_birds;i++){
            neuralNetwork.add(new NeuralNetwork(4,5,1));
        }
        if(input != null)
            trainBirds();
        birds_list = new ArrayList<Bird>();
        input = new ArrayList<ArrayList<ArrayList<Double>>>();
        output = new ArrayList<ArrayList<ArrayList<Double>>>();
        generateBirds();
        print(" MAX SCORE :" + max_score);
    }
    
    public void generateBirds() {
        for (int i = 0; i < number_of_birds;i++) {
            input.add(new ArrayList<ArrayList<Double>>());
            input.add(new ArrayList<ArrayList<Double>>());
            birds_list.add(new Bird(new PVector(displayWidth * 25 / 100f, displayHeight / 2), ground.getHeight(), pipes, true, true));
        }
    }
    
    public boolean update() {
        for(int i = 0; i < birds_list.size(); i++){
            Bird bird = birds_list.get(i);
            if(bird.isDead() == true){
                if(pipes.getDistanceTravelled() > max_score){
                    max_score = pipes.getDistanceTravelled();
                    best_network = new NeuralNetwork(neuralNetwork.get(i));
                }
                birds_list.remove(i);
                i--;
            }else{
                next_pipe = pipes.findNextPipe();
                bird_y_position = (double) floor(bird.getPosition().y);
                pipe_x_position = (double) floor(next_pipe.getPosition().x);
                pipe_hole_y_top = (double) floor(next_pipe.getSpacingPosition().y);
                pipe_hole_y_bottom = (double) pipe_hole_y_top + floor(next_pipe.getSpacingHeight());
                // println("bird x pos: " + bird_y_position);
                // println("pipe x pos: " + pipe_x_position);
                // println("pipe y top: " + pipe_hole_y_top);
                // println("pipe y bot: " + pipe_hole_y_bottom);

                ArrayList<ArrayList<Double>> bird_input_set = input.get(i * 2);
                ArrayList<ArrayList<Double>> bird_output_set = input.get(i * 2 + 1);

                bird_input_set.add(new ArrayList<Double>());
                bird_output_set.add(new ArrayList<Double>());
                
                ArrayList<Double> current_iteration = bird_input_set.get(bird_input_set.size() - 1);
                current_iteration.add(bird_y_position);
                current_iteration.add(pipe_x_position);
                current_iteration.add(pipe_hole_y_top);
                current_iteration.add(pipe_hole_y_bottom);
                
                // double top_slope = pipe_hole_y_top + next_pipe.getSpacingHeight()/2;

                bird_output_set.get(bird_output_set.size() - 1).add((double)floor(random(2)));
                // println("Brd output size" + bird_output_set.get(bird_output_set.size() - 1).get(0));

                current_data = new ArrayList<Double>();
                current_data.add(bird_y_position);
                current_data.add(pipe_x_position);
                current_data.add(pipe_hole_y_top);
                current_data.add(pipe_hole_y_bottom);

                // double[] output = {bird_y_position, pipe_x_position, pipe_hole_y_top, pipe_hole_y_bottom};
                // double[][] input = {{bird_y_position, pipe_x_position, pipe_hole_y_top, pipe_hole_y_bottom}};
                // double[][] Y = {{max_score}};
                // neuralNetwork.fit(input, Y, 5);
                double prediction = neuralNetwork.get(i).predict(current_data).get(0);
                //println(prediction);
                if(prediction > 0.5)
                    bird.jump();
            }
            bird.update();
        }
        return birds_list.size() > 0;
    }

    public void trainBirds(){
        // normalizeBySum();

        if(best_network != null){
            for(int i = 0; i < number_of_birds / 10; i++){
                neuralNetwork.set(floor(random(number_of_birds)), new NeuralNetwork(best_network));
            }
        }
        for(int i = 0; i < number_of_birds; i++){
            ArrayList<ArrayList<Double>> bird_input_set = input.get(i * 2);
            ArrayList<ArrayList<Double>> bird_output_set = input.get(i * 2 + 1);
            if(bird_input_set.isEmpty() == false)
                neuralNetwork.get(i).fit(bird_input_set, bird_output_set, 500);
        }
    }

    private void normalizeBySum(){
        double sum = 0;
        for(int i = 0; i < number_of_birds; i++){
            ArrayList<ArrayList<Double>> bird_output_set = input.get(i * 2 + 1);
            for(ArrayList<Double> value : bird_output_set){
                sum += value.get(0);
            }
        }
        for(int i = 0; i < number_of_birds; i++){
            ArrayList<ArrayList<Double>> bird_output_set = input.get(i * 2 + 1);
            //println("AAAAAAAAAAAA" + bird_output_set.size());
            for(ArrayList<Double> value : bird_output_set){
                value.set(0, value.get(0)/sum);
                println(value.get(0));
            }
        }
    }

    public void pause(){
        for (Bird bird : birds_list) {
            bird.pause();
        }
    }

    public Bird getBird(){
        return birds_list.get(0);
    }
}