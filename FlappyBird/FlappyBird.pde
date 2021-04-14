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
List<Pipe> pipes;
UI ui;

void setup() 
{
    size(1500, 1000);
    smooth(8);
    frameRate(60);
    surface.setTitle("Saggy Bird");

    bird = new Bird(new PVector(width/2 - 300, 300));
    pipes = new LinkedList<Pipe>();
    ui = new UI();

    pipes.add(new Pipe(new PVector(width, 0)));
    for (int i=1; i<pipes.get(0).number_of_pipes; i++) {
        pipes.add(new Pipe(new PVector((width) + (Pipe.distance_between_pipes * i), 0)));
    }
    
}

void draw()
{
    background(0);

    bird.update();

    for (Pipe pipe : pipes) {
        pipe.update();
    }

    ui.displayScore();

    println(frameRate + " fps");
}