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
Ground ground;

int fps = 1000;
float deltaTime = 0;
float previousTime = 0;
float deltaDivider = 1.8e1;
float delta;

void setup() 
{
    fullScreen();
    smooth(8);
    frameRate(fps);
    surface.setTitle("Saggy Bird");
    
    float horizontal_velocity = 6f;
    float max_horizontal_velocity = 8f;  
    float increment_horizontal_velocity =.2f;
    
    bird = new Bird(new PVector(displayWidth * 25 / 100f, displayHeight / 2));
    pipes = new Pipes(horizontal_velocity, max_horizontal_velocity, increment_horizontal_velocity);
    ui = new UI(pipes, bird);
    ground = new Ground();

    previousTime = millis();
}

void draw()
{
    deltaTime = millis() - previousTime;
    previousTime = millis();
    
    delta = deltaTime / deltaDivider;
    
    background(100);
    
    pipes.update();
    
    bird.update();
    
    ui.update();

    ground.update();
    
    println(frameRate + " fps");
}