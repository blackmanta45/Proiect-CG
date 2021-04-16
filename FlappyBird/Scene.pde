import java.util.List;
import java.util.LinkedList;

public class Scene {
    
    private List<Component> components;
    
    public Scene() {
        components = new LinkedList<Component>();
    }
    
    public void addComponent(Component component) {
        components.add(component);
    }
    
    public List<Component> getComponents() {
        return components;
    }
    
    public void loadComponents() {
        
    }  
    
    public void unloadComponents() {
        
    }
    
    public void display() {
        for (Component component : components) {
            // component.display();
        }
    }
}