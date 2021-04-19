import java.util.List;
import java.util.LinkedList;
import java.util.HashMap;

public class Scenes {
    private HashMap<String, Scene> myMap = new HashMap<String, Scene>();
    private Scene playScene = new Scene();
    private Scene menuScene = new Scene();
    private Scene diedScene = new Scene();
    private Scene settingsScene = new Scene();
    private Scene customizeMenuScene = new Scene();
    private Scene customizeBirdScene = new Scene();
    private Scene customizePipeScene = new Scene();
    
    public Scenes() {
        initPlayScene();
    }

    private void initPlayScene(){
        float horizontal_velocity = displayWidth / 420;
        float max_horizontal_velocity = displayWidth / 310;  
        float increment_horizontal_velocity = displayWidth / 8500;
        
        Pipes pipes = new Pipes(horizontal_velocity, max_horizontal_velocity, increment_horizontal_velocity, displayHeight / 14.4f);
        Ground ground = new Ground(pipes);
        Bird bird = new Bird(new PVector(displayWidth * 25 / 100f, displayHeight / 2), ground.getHeight(), pipes, false);
        Score score = new Score(bird, pipes);
        Background background = new Background(pipes);

        playScene.addComponent(background);
        playScene.addComponent(pipes);
        playScene.addComponent(score);
        playScene.addComponent(ground);
        playScene.addComponent(bird);
    }

    public void update(){
        playScene.update();
        if(keyPressed == true){
            if(key == 'r'){
                playScene.restart();
            }
        }
    }
    
    
}