public class Ground implements IComponent{
    private Pipes pipes;
    
    private ArrayList<GroundPiece> ground_piece_list;
    private float top_part_height;
    private float bottom_part_height;
    private float ground_piece_width;
    private float horizontal_velocity;
    private float bottom_part_y;
    private float top_part_y;
    private int number_of_pieces;

    private PImage bottom_image = loadImage("../Images/ground_bottom_default.png");
    
    public Ground(Pipes pipes) {
        this.pipes = pipes;
        init();
    }
    
    public void init() {
        ground_piece_list = new ArrayList<GroundPiece>();
        top_part_height = displayHeight / 49;
        bottom_part_height = displayHeight / 12;
        ground_piece_width = bottom_part_height / 90 * 6720;
        number_of_pieces = Math.round(displayWidth / ground_piece_width) + 2;
        bottom_part_y = displayHeight - bottom_part_height;
        top_part_y = displayHeight - top_part_height - bottom_part_height;
        fillGroundTop();
    }
    
    public void fillGroundTop() {
        int i = 0;
        while(i < number_of_pieces) {
            addOne(i);
            i++;
        }
    }

    public void fillGroundBottom(){
        image(bottom_image, 0, bottom_part_y, ground_piece_width, bottom_part_height);
    }
    
    public boolean update() {
        updateLocation();
        fillGroundBottom();
        return true;
    }

    public void stop(){

    }
    
    public void updateLocation() {
        horizontal_velocity = pipes.getHorizontalVelocity();
        
        if(ground_piece_list.get(0).needsDeletion() == true)
            swap(0, ground_piece_list.size() - 1);

        ground_piece_list.get(0).update(horizontal_velocity);

        for(int i = 1; i < ground_piece_list.size(); i++){
            ground_piece_list.get(i).setPosition(new PVector(ground_piece_list.get(i - 1).getPosition().x + ground_piece_width, top_part_y));
            ground_piece_list.get(i).display();
        }
    }

    public void swap(int index1, int index2){
        GroundPiece aux = ground_piece_list.get(index1);
        ground_piece_list.set(index1, ground_piece_list.get(index2));
        ground_piece_list.set(index2, aux);
    }
    
    public void addOne(int i) {
        float x = i * ground_piece_width;
        PVector top_left_corner = new PVector(x, displayHeight - bottom_part_height - top_part_height);
        PVector top_part_size = new PVector(ground_piece_width, top_part_height);
        ground_piece_list.add(new GroundPiece(top_left_corner, top_part_size));
    }
    
    public float getHeight() {
        return top_part_height + bottom_part_height;
    }
}