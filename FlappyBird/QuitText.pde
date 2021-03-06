public class QuitText {
    private Scenes scenes;

    private PVector position;
    private PVector top_left_corner;
    private PVector size;
    
    private String text;
    
    public QuitText(Scenes scenes) {
        this.scenes = scenes;
        init();
    }
    
    public void init() {
        position = new PVector(displayWidth / 2, displayHeight / 2 + 200);
        top_left_corner = new PVector( -120, 165);
        size = new PVector(240, 100);
        text = "Quit";
    }
    
    public boolean update() {
        boolean is_hovering = isHovering();
        if (is_hovering == true)
            fill(255);
        else
            fill(0);
        text(text, position.x, position.y);
        if (mousePressed == true && is_hovering == true && millis() - last_click_time > 500){
            last_click_time = millis();
            exit();
            return true;
        }
        return false;
    }
    
    public boolean isHovering() {
        if (mouseX - displayWidth / 2 >= top_left_corner.x && mouseX - displayWidth / 2 <= top_left_corner.x + size.x && 
            mouseY - displayHeight / 2 >= top_left_corner.y && mouseY - displayHeight / 2 <= top_left_corner.y + size.y) {
            return true;
        } else {
            return false;
        }
        
    }
}