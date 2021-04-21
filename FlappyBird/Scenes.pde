import java.util.List;
import java.util.LinkedList;
import java.util.HashMap;

public class Scenes {
    private float horizontal_velocity;
    private float max_horizontal_velocity;  
    private float increment_horizontal_velocity;

    private HashMap<String, IScene> myMap = new HashMap<String, IScene>();
    private IScene play_scene = new PlayScene(this);
    private IScene main_menu_scene = new MainMenuScene(this);
    private IScene simulate_scene = new SimulateScene(this);

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
        initSimulateScene();
    }

    public void init(){
        horizontal_velocity = displayWidth / 420;
        max_horizontal_velocity = displayWidth / 310;
        increment_horizontal_velocity = displayWidth / 8500;
        myMap.put("play_scene", play_scene);
        myMap.put("main_menu_scene", main_menu_scene);
        myMap.put("simulate_scene", simulate_scene);
        current_scene = myMap.get("main_menu_scene");
    }

    private void initPlayScene(){
        
        Pipes pipes = new Pipes(horizontal_velocity, max_horizontal_velocity, increment_horizontal_velocity, displayHeight / 14.4f);
        PlayingGround ground = new PlayingGround(pipes);
        Bird bird = new Bird(new PVector(displayWidth * 25 / 100f, displayHeight / 2), ground.getHeight(), pipes, false, true);
        Score score = new Score(bird, pipes);
        Background background = new Background(horizontal_velocity);
        PauseMenu pause_menu = new PauseMenu(this);

        play_scene.addComponent(background);
        play_scene.addComponent(pipes);
        play_scene.addComponent(score);
        play_scene.addComponent(ground);
        play_scene.addComponent(bird);
        play_scene.addComponent(pause_menu);
    }

    private void initMainMenuScene(){
        
        MenuGround ground = new MenuGround(horizontal_velocity);
        Background background = new Background(horizontal_velocity);
        MainMenu main_menu = new MainMenu(this);

        main_menu_scene.addComponent(ground);
        main_menu_scene.addComponent(background);
        main_menu_scene.addComponent(main_menu);
    }

    private void initSimulateScene(){
        Pipes pipes = new Pipes(horizontal_velocity, max_horizontal_velocity, increment_horizontal_velocity, displayHeight / 14.4f);
        PlayingGround ground = new PlayingGround(pipes);
        BirdsWithBrain birds_with_brain = new BirdsWithBrain(pipes, ground, 500);
        Score score = new Score(birds_with_brain.getBird(), pipes);
        Background background = new Background(horizontal_velocity);
        PauseSimulateMenu pause_simulate_menu = new PauseSimulateMenu(this);
        
        simulate_scene.addComponent(background);
        simulate_scene.addComponent(pipes);
        simulate_scene.addComponent(score);
        simulate_scene.addComponent(ground);
        simulate_scene.addComponent(birds_with_brain);
        simulate_scene.addComponent(pause_simulate_menu);
    }

    public void update(){
        current_scene.update();
    }

    public void setScene(String scene_name){
        current_scene = myMap.get(scene_name);
        restartScene();
    }

    public void restartScene(){
        current_scene.restart();
    }
}