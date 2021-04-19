import java.util.List;
import java.util.LinkedList;

public class Scene {
    
    private List<IComponent> components;
    private boolean continueUpdate = true;
    
    public Scene() {
        components = new LinkedList<IComponent>();
    }

    public void addComponent(IComponent component) {
        components.add(component);
    }
    
    public List<IComponent> getComponents() {
        return components;
    }
    
    public void loadComponents() {
        
    }  
    
    public void unloadComponents() {
        
    }
    
    public void update() {
        for (IComponent component : components) {
            if(component.update() == false && continueUpdate == true){
                continueUpdate = false;
            }
            if(continueUpdate == false){
                component.stop();
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