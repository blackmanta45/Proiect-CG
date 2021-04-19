import java.util.List;
import java.util.LinkedList;
import java.util.HashMap;

public class Scenes {
    private float horizontal_velocity;
    private float max_horizontal_velocity;  
    private float increment_horizontal_velocity;

    private HashMap<Integer, IScene> myMap = new HashMap<Integer, IScene>();
    private IScene play_scene = new PlayScene(this);
    private IScene main_menu_scene = new MainMenuScene(this);

    private IScene current_scene;
    // private IScene diedScene = new Scene();
    // private IScene settingsScene = new Scene();
    // private IScene customizeMenuScene = new Scene();
    // private IScene customizeBirdScene = new Scene();
    // private IScene customizePipeScene = new Scene();
    
    public Scenes() {
        init();
        initPlayScene();
        initMainMenuScene();
    }

    public void init(){
        horizontal_velocity = displayWidth / 420;
        max_horizontal_velocity = displayWidth / 310;
        increment_horizontal_velocity = displayWidth / 8500;
        current_scene = play_scene;
    }

    private void initPlayScene(){
        
        Pipes pipes = new Pipes(horizontal_velocity, max_horizontal_velocity, increment_horizontal_velocity, displayHeight / 14.4f);
        PlayingGround ground = new PlayingGround(pipes);
        Bird bird = new Bird(new PVector(displayWidth * 25 / 100f, displayHeight / 2), ground.getHeight(), pipes, false);
        Score score = new Score(bird, pipes);
        Background background = new Background(horizontal_velocity);

        play_scene.addComponent(background);
        play_scene.addComponent(pipes);
        play_scene.addComponent(score);
        play_scene.addComponent(ground);
        play_scene.addComponent(bird);
    }

    private void initMainMenuScene(){
        
        MenuGround ground = new MenuGround(horizontal_velocity);
        Background background = new Background(horizontal_velocity);
        MainMenu main_menu = new MainMenu();

        main_menu_scene.addComponent(ground);
        main_menu_scene.addComponent(background);
        main_menu_scene.addComponent(main_menu);
    }

    public void update(){
        current_scene.update();
    }

    public void setScene(IScene scene){
        current_scene = scene;
    }
    
    
}