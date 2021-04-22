public class MainMenu implements IComponent{
    private float text_size;
    private Scenes scenes;

    private NewGameText new_game_text;
    private SimulateText simulate_text;
    private QuitText quit_text;

    public MainMenu(Scenes scenes){
        this.scenes = scenes;
        init();
    }

    public void init(){
        text_size = displayWidth/26;
        new_game_text = new NewGameText(scenes);
        simulate_text = new SimulateText(scenes);
        quit_text = new QuitText(scenes);
    }

    public boolean update(){
        textAlign(CENTER, CENTER);
        textSize(text_size);
        new_game_text.update();
        simulate_text.update();
        quit_text.update();
        textAlign(LEFT, LEFT);
        fill(255);
        return true;
    }

    public void pause(){}
}