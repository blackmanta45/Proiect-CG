import java.util.List;
import java.util.LinkedList;

public class PlayScene implements IScene{
    private Scenes scenes;
    
    private List<IComponent> components;
    private boolean continueUpdate = true;
    
    public PlayScene(Scenes scenes) {
        this.scenes = scenes;
        components = new LinkedList<IComponent>();
    }

    public void addComponent(IComponent component) {
        components.add(component);
    }
    
    public List<IComponent> getComponents() {
        return components;
    }
    
    public void update() {
        restartCondition();
        for (IComponent component : components) {
            if(component.update() == false && continueUpdate == true){
                continueUpdate = false;
            }
            if(continueUpdate == false){
                component.stop();
            }
        }
    }

    private void restartCondition(){
        if(keyPressed == true){
            if(key == 'r'){
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