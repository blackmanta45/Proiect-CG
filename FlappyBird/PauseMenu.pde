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
        // texts.put(new PVector(displayWidth/2, displayHeight/2 - 200), "New Game");
        // texts.put(new PVector(displayWidth/2, displayHeight/2), "Simulate");
        // texts.put(new PVector(displayWidth/2, displayHeight/2 + 200), "Quit");
    }

    public boolean update(){
        // pushMatrix();
        // noFill();
        // translate(displayWidth/2, displayHeight/2);
        // stroke(#FFA500);
        // rect(-300,-235, 600, 100);
        // rect(-450,-35, 900, 100);
        // rect(-120, 165, 240, 100);
        // popMatrix();

        
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

    public void stop(){}

    public void pause(){
        is_paused = is_paused == true ? false : true;
    }

    public void resume(){}
}