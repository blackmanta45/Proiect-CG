import java.util.ArrayList;

public class Trace {
    
    private float spacing;
    private Bird bird;
    private Pipes pipes;
    
    private PVector last_point;
    private float slope;
    private float bird_x_position;
    private ArrayList<TracePoint> trace_list;
    
    public Trace(float spacing, Bird bird, Pipes pipes) {
        this.spacing = spacing;
        this.bird = bird;
        this.pipes = pipes;
        init();
    }
    
    public void init() {
        slope = 255 / bird_x_position;
        bird_x_position = bird.getPosition().x;
        trace_list = new ArrayList<TracePoint>();
    }
    
    public void update() {
        checkFirstElement();
        displayAndMove();
        last_point = trace_list.get(trace_list.size() - 1).getPosition();
    }
    
    public void checkFirstElement() {
        if (trace_list.get(0).needsDeletion() == true) {
            trace_list.remove(0);
        }
    }
    
    public void displayAndMove() {
        for (TracePoint point : trace_list) {
            if (bird.is_dead == false) {
                point.move();
            }
            point.display();
        }
    }
    
    public void addPoint(PVector point_position) {
        if (verify(point_position) == true) {
            TracePoint point = new TracePoint(last_point, point_position, slope, pipes);
            trace_list.add(point);
        }
    }
    
    public boolean verify(PVector point_position) {
        float distance;
        if (trace_list.size() >= 1) {
            distance = dist(last_point.x, last_point.y, point_position.x, point_position.y);
            return distance >= spacing;
        }
        last_point = point_position;
        return true;    
    }
    
}