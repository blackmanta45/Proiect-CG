public class PauseSimulateMenu implements IComponent{
    private float text_size;
    private Scenes scenes;
    private BirdsWithBrain birds_with_brain;

    private RestartSimulationText restart_simulation_text;
    private BackToMainMenuText back_to_main_menu_text;
    private QuitText quit_text;

    private boolean is_paused;

    public PauseSimulateMenu(Scenes scenes, BirdsWithBrain birds_with_brain){
        this.scenes = scenes;
        this.birds_with_brain = birds_with_brain;
        init();
    }

    public void init(){
        text_size = displayWidth/26;
        restart_simulation_text = new RestartSimulationText(scenes);
        back_to_main_menu_text = new BackToMainMenuText(scenes);
        quit_text = new QuitText(scenes);
        is_paused = false;
    }

    public boolean update(){
        if(is_paused == true){
            textAlign(CENTER, CENTER);
            textSize(text_size);
            quit_text.update();
            if(restart_simulation_text.update() == true){
                birds_with_brain.resetSimulation();
                birds_with_brain.overwriteGenerationNumber(1);
            }
            if(back_to_main_menu_text.update() == true){
                birds_with_brain.resetSimulation();
            }
            textAlign(LEFT, LEFT);
        }
        fill(255);
        return true;
    }

    public void stop(){}

    public void pause(){
        is_paused = is_paused == true ? false : true;
    }

    public void resume(){}
}