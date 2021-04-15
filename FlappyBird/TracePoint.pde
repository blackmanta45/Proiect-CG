public class TracePoint {
    
    private PVector last_position;
    private PVector current_position;
    
    private float radius;
    private float time;
    private float stroke_weight_value;
    private float offset;
    
    private float slope; 
    private float output;
    
    public TracePoint(PVector last_position, PVector current_position) {
        this.last_position = last_position;
        this.current_position = current_position;
        init();
    }
    
    public void init() {
        slope = 255 / bird.getPosition().x;
        time = 0f;
        stroke_weight_value = 20f;
        offset = stroke_weight_value / 10;
    }
    
    public PVector getPosition() {
        return current_position;
    }
    
    public void display() {
        stroke(255, slope * current_position.x);
        strokeWeight(stroke_weight_value);
        line(last_position.x, last_position.y, current_position.x - offset, current_position.y - offset);
    }
    
    public void move() {
        current_position.x -= pipes.getHorizontalVelocity();
    }
    
    public boolean needsDeletion() {
        return current_position.x < stroke_weight_value / 2;
    }
}