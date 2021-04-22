public class NewGameText {
    private Scenes scenes;

    private PVector position;
    private PVector top_left_corner;
    private PVector size;
    
    private String text;
    
    public NewGameText(Scenes scenes) {
        this.scenes = scenes;
        init();
    }
    
    public void init() {
        position = new PVector(displayWidth / 2, displayHeight / 2 - 200);
        top_left_corner = new PVector(- 300, - 235);
        size = new PVector(600, 100);
        text = "New Game";
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
            scenes.setScene("play_scene");
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