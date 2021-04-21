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
        for (int i = 0; i < components.size(); i++) {
            if(components.get(i).update() == false){
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

    public void restart(){
        for (IComponent component : components) {
            component.init();
        }
        continueUpdate = true;
    }
}