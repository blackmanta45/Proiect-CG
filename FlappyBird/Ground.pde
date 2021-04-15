public class Ground{
    private ArrayList<GroundPiece> ground_piece_list = new ArrayList<GroundPiece>();
    private float top_part_height;
    private float bottom_part_height;
    private float ground_piece_width;
    private float number_of_pieces;
    private float horizontal_velocity;
    
    public Ground() {
        init();
    }
    
    public void init() {
        top_part_height = displayHeight / 49;
        bottom_part_height = displayHeight / 12;
        ground_piece_width = bottom_part_height / 90 * 336;
        number_of_pieces = displayWidth / ground_piece_width + 2;
        fillGround();
    }
    
    public void fillGround() {
        float start = - 2;
        while(start <= number_of_pieces) {
            addOne(start * ground_piece_width);
            start ++;
        }
        println(ground_piece_list.size());
    }
    
    public void update() {
        updateLocation();
        verifyCompleteness();
    }
    
    public void updateLocation() {
        horizontal_velocity = pipes.getHorizontalVelocity();
        for (int i = 0; i < ground_piece_list.size();i++) {
            ground_piece_list.get(i).update(horizontal_velocity);
            if (ground_piece_list.get(i).needsDeletion() == true) {
                ground_piece_list.remove(i);
            }
            if (i > 1) {
                float xOffset = ground_piece_list.get(i).getPosition().x - ground_piece_list.get(i - 1).getPosition().x - ground_piece_width;
                ground_piece_list.get(i - 1).updateXoffset(xOffset);
            }
        }
    }
    
    public void verifyCompleteness() {
        if (ground_piece_list.size() < number_of_pieces) {
            addOne(ground_piece_list.get(ground_piece_list.size() - 1).getPosition().x + ground_piece_width);
        }
    }
    
    public void addOne(float x) {
        PVector top_left_corner = new PVector(x, displayHeight - bottom_part_height - top_part_height);
        PVector top_part_size = new PVector(ground_piece_width, top_part_height);
        PVector bottom_part_size = new PVector(ground_piece_width, bottom_part_height);
        ground_piece_list.add(new GroundPiece(top_left_corner, top_part_size, bottom_part_size));
    }
}