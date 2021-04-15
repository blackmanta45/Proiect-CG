public class GroundPiece{
    private PVector position;
    private PVector top_part_size;
    private PVector bottom_part_size;
    
    private PImage top_part;
    private PImage bottom_part;
    
    private float x_offset;
    
    public GroundPiece(PVector position, PVector top_part_size, PVector bottom_part_size) {
        this.position = position;
        this.top_part_size = top_part_size;
        this.bottom_part_size = bottom_part_size;
        init();
    }
    
    public void init() {
        top_part = loadImage("../Images/ground_top_default.png");
        bottom_part = loadImage("../Images/ground_bottom_default.png");
    }
    
    public void update(float x_velocity) {
        display();
        move(x_velocity);
    }
    
    public void display() {
        image(top_part, position.x, position.y, top_part_size.x + x_offset, top_part_size.y);
        image(bottom_part, position.x, position.y + top_part_size.y, bottom_part_size.x + x_offset, bottom_part_size.y);
    }
    
    public void move(float amount) {
        if (bird.isDead() == false)
            position.x -= amount;
    }
    
    public boolean needsDeletion() {
        return position.x + top_part_size.x < - top_part_size.x;
    }
    
    public void updateXoffset(float newOffset) {
        x_offset = newOffset;
    }
    
    public PVector getPosition() {
        return position;
    }
}