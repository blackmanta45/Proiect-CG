import java.util.List;
import java.util.LinkedList;

// Scene playScene = new Scene();
// Scene menuScene = new Scene();
// Scene diedScene = new Scene();
// Scene settingsScene = new Scene();
// Scene customizeMenuScene = new Scene();
// Scene customizeBirdScene = new Scene();
// Scene customizePipeScene = new Scene();

Bird bird;
Pipes pipes;
Score score;
Ground ground;

Background bg;

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
    
    float horizontal_velocity = displayWidth / 420;
    float max_horizontal_velocity = displayWidth / 310;  
    float increment_horizontal_velocity = displayWidth / 8500;

    bird = new Bird(new PVector(displayWidth * 25 / 100f, displayHeight / 2));

    pipes = new Pipes(horizontal_velocity, max_horizontal_velocity, increment_horizontal_velocity);

    score = new Score(pipes, bird);
    
    ground = new Ground();
    
    bg = new Background();

    previousTime = millis();
}

void draw()
{
    deltaTime = millis() - previousTime;
    previousTime = millis();
    
    delta = deltaTime / deltaDivider;
    
    background(100);
    bg.update();

    pipes.update();
    
    ground.update();
    
    bird.update();
    
    score.update();

    textSize(50);
    text(frameRate + " fps", 20, 50);
}