public class Trace {

    private PVector position;
    private float radius = 15f;
    public static final float spacing = 20f;
    private float time = 0f;

    public Trace(PVector position) {
        this.position = position;
    }

    public void display() {
        time = (time % 1000) + 4f;
        fill(#FFFFFF, 255 - time);
        noStroke();
        ellipse(position.x, position.y, radius, radius);
        radius -= .1f;
        if (radius <= 0f) {
            radius = 0f;
        }
    }

    public void move() {
        position.x -= pipes.get(0).getHorizontalVelocity();
    }

    public void unreference(Trace obj) {
        if (obj.position.x <= 0) {
            obj = null;
        }
    }
}