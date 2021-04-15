import java.util.ArrayList;

public class Trace {
    
    private float spacing;
    
    private PVector lastPoint;
    private ArrayList<TracePoint> traceList;
    
    public Trace(float spacing) {
        this.spacing = spacing;
        init();
    }
    
    public void init() {
        traceList = new ArrayList<TracePoint>();
    }
    
    public void update() {
        checkFirstElement();
        for (TracePoint point : traceList) {
            if (bird.is_dead == false) {
                point.move();
            }
            point.display();
        }
        lastPoint = traceList.get(traceList.size() - 1).getPosition();
    }
    
    public void addPoint(PVector pointPosition) {
        if (verify(pointPosition) == true) {
            TracePoint point = new TracePoint(lastPoint, pointPosition);
            traceList.add(point);
        }
    }
    
    public boolean verify(PVector pointPosition) {
        float distance;
        if (traceList.size() >= 1) {
            distance = dist(lastPoint.x, lastPoint.y, pointPosition.x, pointPosition.y);
            return distance >= spacing;
        }
        lastPoint = pointPosition;
        return true;    
    }
    
    public void checkFirstElement() {
        if (traceList.get(0).needsDeletion() == true) {
            traceList.remove(0);
        }
    }
}