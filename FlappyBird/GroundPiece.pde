public class GroundPiece{
    
    private PVector position;
    private PVector top_part_size;
    
    private PImage top_part;
    
    public GroundPiece(PVector position, PVector top_part_size) {
        this.position = position;
        this.top_part_size = top_part_size;
        init();
    }
    
    public void init() {
        top_part = loadImage("../Images/ground_top_default.png");
    }
    
    public void update(float x_velocity) {
        display();
        move(x_velocity);
    }
    
    public void display() {
        image(top_part, position.x, position.y, top_part_size.x, top_part_size.y);
    }
    
    public void move(float x_velocity) {
        position.x -= x_velocity;
    }
    
    public boolean needsDeletion() {
        return position.x + top_part_size.x < 0;
    }

    public PVector getPosition() {
        return position;
    }
    public void setPosition(PVector new_position){
        this.position = new_position;
    }
}