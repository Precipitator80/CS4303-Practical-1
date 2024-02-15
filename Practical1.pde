// IDEAS FOR VARIATION:
// HAVE UPGRADE SYSTEM BETWEEN WAVES - Put it as a button in the corner rather than forcing it open.
// START SETTINGS
import processing.sound.*;
import java.util.LinkedList;
import java.util.concurrent.LinkedTransferQueue;

//// Final values
final color BLUE = color(40, 170, 250);
final color fillColour = BLUE;
final color strokeColour = color(255);

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
final Drag drag = new Drag(0.0015f, 0f); // Linear Drag

public final LinkedTransferQueue<GameObject> enemies = new LinkedTransferQueue<GameObject>();
public final LinkedTransferQueue<Bomb> bombs = new LinkedTransferQueue<Bomb>();
public final LinkedTransferQueue<Explosive> explosives = new LinkedTransferQueue<Explosive>();
public final LinkedTransferQueue<Explosion> explosions = new LinkedTransferQueue<Explosion>();
public final LinkedTransferQueue<GameObject> gameObjects = new LinkedTransferQueue<GameObject>();
public final LinkedTransferQueue<Target> targets = new LinkedTransferQueue<Target>();
public final LinkedTransferQueue<Button> buttons = new LinkedTransferQueue<Button>();

//// Late initialisation.
Audio Audio;
Graphics Graphics;
OptionsMenu OptionsMenu;
LevelManager levelManager;
ShopMenu ShopMenu;

int groundHeight;

// Update manager
double previous;
double lag;
double ms_per_update;


void setup() {
    // Set the screen size.
    // 1:1
    //size(200, 200);
    //size(500, 500);
    //size(720, 720);
    //size(1000,1000);
    
    // 16:9
    //size(720, 405);
    //size(1280, 720);
    
    // 21:9
    //size(1680, 720);
    
    fullScreen();
    
    // Initialise the update timer.    
    previous = millis();
    lag = 0.0;
    ms_per_update = 1000.0 / frameRate;
    
    // Load all assets.
    Audio = new Audio(this);
    Graphics = new Graphics();
    
    // Initialise the options menu.
    OptionsMenu = new OptionsMenu();
    OptionsMenu.entryButton.show();
    
    // Create a level manager.
    levelManager = new LevelManager();
    levelManager.initialSetup();
    
    // Initialise the shop.
    ShopMenu = new ShopMenu();
    
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
