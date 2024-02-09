// IDEAS FOR VARIATION:
// HAVE UPGRADE SYSTEM BETWEEN WAVES - Put it as a button in the corner rather than forcing it open.
// START SETTINGS

import java.util.LinkedList;
import java.util.concurrent.LinkedTransferQueue;

//// Final values
final color RED = color(255,45,50);
final color GREEN = color(155,200,100);
final color BLUE = color(45,60,190);

//// Early initialisation.
// Force registry
// Holds all the force generators and the particles they apply to
final ForceRegistry forceRegistry = new ForceRegistry();

//Create a gravitational force
//final Gravity gravity = new Gravity(new PVector(0f,.0001f)); // More realistic
final Gravity gravity = new Gravity(new PVector(0f,.00005f));


// Utility class with additional methods.
final Utility Utility = new Utility();

//Create a drag force
//NB Increase k1, k2 to see an effect
//final Drag drag = new Drag(0.003f, 0.003f); // Quadratic Drag
final Drag drag = new Drag(0.003f, 0f); // Linear Drag

color backgroundColour = RED;
color playerColour = BLUE;
color enemyColour = GREEN;

public final LinkedTransferQueue<Asteroid> asteroids = new LinkedTransferQueue<Asteroid>();
public final LinkedTransferQueue<Bomb> bombs = new LinkedTransferQueue<Bomb>();
public final LinkedTransferQueue<Explosive> explosives = new LinkedTransferQueue<Explosive>();
public final LinkedTransferQueue<Explosion> explosions = new LinkedTransferQueue<Explosion>();
public final LinkedTransferQueue<GameObject> gameObjects = new LinkedTransferQueue<GameObject>();
public final LinkedTransferQueue<Target> targets = new LinkedTransferQueue<Target>();
public final LinkedTransferQueue<Button> buttons = new LinkedTransferQueue<Button>();

//// Late initialisation.
LevelManager levelManager;
int groundHeight;

// Update manager
double previous;
double lag;
double ms_per_update;

String graphicsFolder = "Graphics/";
float aspectRatio;
PImage background;
PImage city;
PImage cityBroken;
PImage cluster4;
PImage cluster3;
PImage cluster2;
PImage cluster1;
PImage asteroid;
PImage bomber;
PImage missile;

void setup() {
    // Set the screen size.
    // 1:1
    //size(200, 200);
    //size(500, 500);
    //size(1000,1000);
    
    // 16:9
    //size(720, 405);
    size(1280, 720);
    aspectRatio = (float) width / height;
    
    // Initialise the update timer.    
    previous = millis();
    lag = 0.0;
    ms_per_update = 1000.0 / frameRate;
    
    // Create a level manager.
    levelManager = new LevelManager();
    
    // bg = loadImage("CityTest.jpg");
    // bg.resize(width, height);
    
    background = loadImage(graphicsFolder + "Background.png");
    background.resize(width, height);
    city = loadImage(graphicsFolder + "City.png");
    cityBroken = loadImage(graphicsFolder + "CityBroken.png");
    cluster4 = loadImage(graphicsFolder + "Cluster4.png");
    cluster3 = loadImage(graphicsFolder + "Cluster3.png");
    cluster2 = loadImage(graphicsFolder + "Cluster2.png");
    cluster1 = loadImage(graphicsFolder + "Cluster1.png");
    asteroid = loadImage(graphicsFolder + "Asteroid.png");
    bomber = loadImage(graphicsFolder + "Bomber.png");
    missile = loadImage(graphicsFolder + "Missile.png");
    
    // Set the ground height.
    groundHeight = (int)(0.95f * height);
}

void draw() {
    double current = millis();
    double elapsed = current - previous;
    previous = current;
    lag += elapsed;
    while(lag >= ms_per_update) {
        update();
        lag -= ms_per_update;
    }
    render();
}

void update() {
    levelManager.update();
}

void render() {
    levelManager.render();
}

void mouseReleased() {
    levelManager.mouseReleased();
}

void keyPressed() {
    levelManager.keyPressed();
}