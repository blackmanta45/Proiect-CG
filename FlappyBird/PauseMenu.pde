public class PauseMenu implements IComponent{
    private float text_size;
    private Scenes scenes;

    private NewGameText new_game_text;
    private BackToMainMenuText back_to_main_menu_text;
    private QuitText quit_text;

    private boolean is_paused;
    public PauseMenu(Scenes scenes){
        this.scenes = scenes;
        init();
    }

    public void init(){
        text_size = displayWidth/26;
        new_game_text = new NewGameText(scenes);
        back_to_main_menu_text = new BackToMainMenuText(scenes);
        quit_text = new QuitText(scenes);
        is_paused = false;
    }

    public boolean update(){
        if(is_paused == true){
            textAlign(CENTER, CENTER);
            textSize(text_size);
            new_game_text.update();
            back_to_main_menu_text.update();
            quit_text.update();
            textAlign(LEFT, LEFT);
        }
        fill(255);
        return true;
    }

    public void pause(){
        is_paused = is_paused == true ? false : true;
    }
}