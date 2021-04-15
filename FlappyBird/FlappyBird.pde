import java.util.List;
import java.util.LinkedList;

Scene playScene = new Scene();
Scene menuScene = new Scene();
Scene diedScene = new Scene();
Scene settingsScene = new Scene();
Scene customizeMenuScene = new Scene();
Scene customizeBirdScene = new Scene();
Scene customizePipeScene = new Scene();

Bird bird;
Pipes pipes;
UI ui;

void setup() 
{
    size(1500, 1000);
    smooth(8);
    frameRate(60);
    surface.setTitle("Saggy Bird");

    float horizontal_velocity = 6f;
    float max_horizontal_velocity = 8f;  
    float increment_horizontal_velocity = .2f ;

    bird = new Bird(new PVector(width/2 - 300, 300));
    pipes = new Pipes(horizontal_velocity, max_horizontal_velocity, increment_horizontal_velocity);
    ui = new UI();
    
}

void draw()
{
    background(100);

    pipes.update();

    bird.update();

    ui.displayScore();

    //println(frameRate + " fps");
}