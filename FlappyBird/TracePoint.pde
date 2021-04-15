public class TracePoint {

    private PVector lastPosition;
    private PVector currentPosition;
    
    private float radius;
    private float time;
    private float stroke_weight_value;
    private float offset = stroke_weight_value;
    
    public TracePoint(PVector lastPosition, PVector currentPosition) {
        this.lastPosition = lastPosition;
        this.currentPosition = currentPosition;
        init();
    }

    public void init() {
        radius = 15f;
        time = 0f;
        stroke_weight_value = 20f;
        offset = stroke_weight_value / 10;
    }

    public PVector getPosition() {
        return currentPosition;
    }

    public void display() {
        time = (time % 1000) + 4f;
        stroke(255, 255-time);
        strokeWeight(stroke_weight_value);
        line(lastPosition.x, lastPosition.y, currentPosition.x - offset, currentPosition.y - offset);
        radius -= .1f;
        if (radius <= 0f) {
            radius = 0f;
        }
    }

    public void move() {
        currentPosition.x -= pipes.getHorizontalVelocity();
    }

    public boolean needsDeletion() {
        return time > 255;
    }
}