import java.util.List;
import java.util.LinkedList;

public class MainMenuScene implements IScene{
    private Scenes scenes;

    private List<IComponent> components;
    
    public MainMenuScene(Scenes scenes) {
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
        for (IComponent component : components) {
            component.update();
        }
    }

    public void restart(){
        for (IComponent component : components) {
            component.init();
        }
    }
}