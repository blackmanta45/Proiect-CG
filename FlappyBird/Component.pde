public class Component {

    private Object obj;
    private PVector position;

    public Component(PVector position) {
        this.position = position;
    }

    public void setComponent(Object obj) {
        this.obj = obj;
    }

    public Object getComponent() {
        return obj;
    }
}