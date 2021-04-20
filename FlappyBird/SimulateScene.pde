import java.util.List;
import java.util.LinkedList;

public class SimulateScene implements IScene{
    private Scenes scenes;
    
    private List<IComponent> components;
    private boolean continueUpdate;
    private float time_of_last_key;
    
    public SimulateScene(Scenes scenes) {
        this.scenes = scenes;
        components = new LinkedList<IComponent>();
        continueUpdate = true;
    }

    public void addComponent(IComponent component) {
        components.add(component);
    }
    
    public List<IComponent> getComponents() {
        return components;
    }
    
    public void update() {
        pauseCondition();
        for (IComponent component : components) {
            if(component.update() == false){
                restart();
            }
        }
    }

    private void pauseCondition(){
        float current_key_time = millis();
        if(keyPressed == true && continueUpdate == true){
            if(key == ESC && current_key_time - time_of_last_key > 1000){
                time_of_last_key = current_key_time;
                pause();
            }
        }
    }

    public void pause(){
        for (IComponent component : components) {
            component.pause();
        }
    }

    private void restartCondition(){
        float current_key_time = millis();
        if(keyPressed == true){
            if(key == 'r' && current_key_time - time_of_last_key > 1000){
                time_of_last_key = current_key_time;
                restart();
            }
        }
    }

    public void restart(){
        for (IComponent component : components) {
            component.init();
        }
        continueUpdate = true;
    }
}