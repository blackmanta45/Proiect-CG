public interface IScene {

    public void addComponent(IComponent component);
    
    public List<IComponent> getComponents();
    
    public void update();

    public void restart();
}