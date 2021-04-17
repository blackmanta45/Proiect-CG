public class TracePoint {
    
    private PVector last_position;
    private PVector current_position;
    
    private float slope; 
    private float output;
    private float stroke_weight_value = 20f;
    
    public TracePoint(PVector last_position, PVector current_position, float slope) {
        this.last_position = last_position;
        this.current_position = current_position;
        this.slope = slope;
        init();
    }
    
    public void init() {
    }
    
    public PVector getPosition() {
        return current_position;
    }
    
    public void display() {
        stroke(255, slope * current_position.x);
        strokeWeight(stroke_weight_value);
        line(last_position.x, last_position.y, current_position.x, current_position.y);
    }
    
    public void move() {
        current_position.x -= pipes.getHorizontalVelocity();
    }
    
    public boolean needsDeletion() {
        return current_position.x < stroke_weight_value / 2;
    }
}