import java.util.List;
import java.util.LinkedList;

int fps = 1000;
float deltaTime = 0;
float previousTime = 0;
float deltaDivider = 1.8e1;
float delta;

Scenes scenes;

void setup() 
{
    fullScreen();
    smooth(8);
    frameRate(fps);
    surface.setTitle("Saggy Bird");

    scenes = new Scenes();

    previousTime = millis();
}

void draw()
{
    deltaTime = millis() - previousTime;
    previousTime = millis();
    
    delta = deltaTime / deltaDivider;
    
    background(#87CEFA);

    scenes.update();

    textSize(50);
    text(frameRate + " fps", 20, 50);
}