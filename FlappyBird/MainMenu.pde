public class MainMenu implements IComponent{
    private float text_size;
    private float distance_between_texts;
    private HashMap<PVector, String> texts;

    private NewGameText new_game_text;
    private SimulateText simulate_text;
    private QuitText quit_text;

    public MainMenu(){
        init();
    }

    public void init(){
        texts = new HashMap<PVector, String>();
        text_size = 100;
        distance_between_texts = text_size + 20;
        new_game_text = new NewGameText();
        simulate_text = new SimulateText();
        quit_text = new QuitText();
        texts.put(new PVector(displayWidth/2, displayHeight/2 - 200), "New Game");
        texts.put(new PVector(displayWidth/2, displayHeight/2), "Simulate");
        texts.put(new PVector(displayWidth/2, displayHeight/2 + 200), "Quit");
    }

    public boolean update(){
        // pushMatrix();
        // noFill();
        // translate(displayWidth/2, displayHeight/2);
        // stroke(#FFA500);
        // rect(-300,-235, 600, 100);
        // rect(-250,-35, 500, 100);
        // rect(-120, 165, 240, 100);
        // popMatrix();

        textAlign(CENTER, CENTER);
        textSize(text_size);
        new_game_text.update();
        simulate_text.update();
        quit_text.update();
        textAlign(LEFT, LEFT);
        fill(255);
        return true;
    }

    public void stop(){

    }
}