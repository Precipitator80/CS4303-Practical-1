// IDEAS FOR VARIATION:
// HAVE UPGRADE SYSTEM BETWEEN WAVES
// START SETTINGS

import java.util.LinkedList;

//// Final values
final color RED = color(255,45,50);
final color GREEN = color(155,200,100);
final color BLUE = color(45,60,190);

//// Early initialisation.
// Force registry
// Holds all the force generators and the particles they apply to
final ForceRegistry forceRegistry = new ForceRegistry();

//Create a gravitational force
Gravity gravity = new Gravity(new PVector(0f,.0001f));

//Create a drag force
//NB Increase k1, k2 to see an effect 
//Drag drag = new Drag(10, 10) ;
Drag drag = new Drag(0.003f, 0.003f);

int NO_BALLISTAS = 3;
int NO_CITIES = 6;
color backgroundColour = RED;
color playerColour = BLUE;
color enemyColour = GREEN;

//// Late initialisation.
LinkedList<Bomb> bombs;
LinkedList<Asteroid> asteroids;
Ballista[] ballistas;
City[] cities;
int selectedBallista;
int groundHeight;

// Update manager
double previous;
double lag;
double ms_per_update;

// initialise screen and particle array
void setup() {
    //size(200, 200) ;
    size(500, 500);
    //size(1700,1000);
    
    //Static graphics.
    groundHeight = (int)(0.95f * height); // Draw a line for the ground.
    
    
    //Initialise a list to hold bombs. 
    bombs = new LinkedList<Bomb>();
    
    //Place ballistas on the screen and select the middle one.
    ballistas = new Ballista[NO_BALLISTAS];
    for (int i = 0; i < ballistas.length; i++) {
        int xOffset = (int)(0.1f * width);
        int x = ballistas.length > 1 ? i * ((width - xOffset) / (ballistas.length - 1)) + xOffset / 2 : width / 2; 
        int y = (int)(0.9f * height);
        ballistas[i] = new Ballista(x, y);
    }
    selectedBallista = ballistas.length / 2;
    
    cities = new City[NO_CITIES];
    int pots = ballistas.length > 1 ? ballistas.length - 1 : 2;
    int citiesPerPot = ceil((float) cities.length / pots);
    int cityIndex = 0;
    if (ballistas.length > 1) {
        int potWidth = (int)(ballistas[1].position.x - ballistas[0].position.x);
        for (int potIndex = 0; potIndex < pots; potIndex++) {
            for (int subIndex = 0; subIndex < citiesPerPot && cityIndex < cities.length; subIndex++) {
                int x = (int) ballistas[potIndex].position.x + (subIndex + 1) * potWidth / (citiesPerPot + 1);
                cities[cityIndex++] = new City(x, groundHeight);
            }
        }
    }
    else{
        int potWidth = (int)(width / 2);
        for (int potIndex = 0; potIndex < pots; potIndex++) {
            for (int subIndex = 0; subIndex < citiesPerPot && cityIndex < cities.length; subIndex++) {
                int x = (int) ballistas[0].position.x + ((subIndex + 1) * potWidth / (citiesPerPot + 1)) * (potIndex % 2 == 0 ? - 1 : 1);
                cities[cityIndex++] = new City(x, groundHeight);
            }
        }
    }
    
    asteroids = new LinkedList<Asteroid>();
    
    previous = millis();
    lag = 0.0;
    ms_per_update = 1000.0 / frameRate;
}

Destructible selectRandomTarget() {
    int randomTarget = int(random(ballistas.length + cities.length));
    //print("Random target is " + randomTarget + "\n");
    if (randomTarget >= ballistas.length) {
        randomTarget -= ballistas.length;
        //print("Returning city: " + randomTarget + "\n");
        return cities[randomTarget];
    }
    else{
        //print("Returning ballista: " + randomTarget + "\n");
        return ballistas[randomTarget];
    }
}

// update bombs,render.
void draw() {
    double current = millis();
    double elapsed = current - previous;
    previous = current;
    lag += elapsed;
    
    //Update once per frame.
    while(lag >= ms_per_update) {
        update();
        lag -= ms_per_update;
    }
    // update();
    render();
}

void update() {
    forceRegistry.updateForces();
    Iterator<Bomb> bombIterator = bombs.iterator();
    while(bombIterator.hasNext()) {
        Bomb bomb = bombIterator.next();
        
        if (bomb.destroyed) {
            bombIterator.remove(); 
        }
        else{
            bomb.update();
        }
    }
    
    for (int i = 0; i < ballistas.length; i++) {
        ballistas[i].update();
    }
    
    // Keep spawning asteroids to fill the maximum (placeholder code to test targeting).
    for (int i = asteroids.size(); i < NO_BALLISTAS + NO_CITIES; i++) {
        Destructible target = selectRandomTarget();
        asteroids.add(new Asteroid((int)random(0, width), 0,(int)target.position.x,(int)target.position.y, random(0.5f, 10f)));
    }
    
    Iterator<Asteroid> asteroidIterator = asteroids.iterator();
    while(asteroidIterator.hasNext()) {
        Asteroid asteroid = asteroidIterator.next();
        
        if (asteroid.destroyed) {
            asteroidIterator.remove(); 
        }
        else{
            asteroid.update();
        }
    }    
}


void render() {
    //Background
    background(0);
    
    //Backdrop
    stroke(backgroundColour);
    fill(backgroundColour);
    rect(0, groundHeight, width, height);
    
    //Foreground
    Iterator<Bomb> bombIterator = bombs.iterator();
    while(bombIterator.hasNext()) {
        bombIterator.next().render(); 
    }
    for (int i = 0; i < ballistas.length; i++) {
        ballistas[i].render(i == selectedBallista);
    }
    for (int i = 0; i < cities.length; i++) {
        cities[i].render(); 
    }
    Iterator<Asteroid> asteroidIterator = asteroids.iterator();
    while(asteroidIterator.hasNext()) {
        asteroidIterator.next().render(); 
    }
}

void mouseReleased() {
    ballistas[selectedBallista].fire();
}

void keyPressed() {
    switch(key) {
        case 'z':
            switchBallista(false);
            break;
        case 'x':
            switchBallista(true);
            break;
        case 'c':
            ballistas[selectedBallista].destroy();
            break;
        case ' ':
            //bombs.peek().destroy();
            if (!bombs.isEmpty()) {
                bombs.peek().destroy();
            }
            break;
    }
}

void switchBallista(boolean ascending) {
    int change = ascending ? 1 : - 1; // Increment / decrement.  
    //Keep switching ballistas until finding one that is not disabled.
    for (int attempt = 0; attempt < ballistas.length; attempt++) {
        // Increment or decrement the index.
        selectedBallista += change;
        
        // Clamp the index.
        if (selectedBallista < 0) {
            selectedBallista = ballistas.length - 1; 
        }
        else if (selectedBallista >= ballistas.length) {
            selectedBallista = 0; 
        }
        
        // Break out of the loop if the selected ballista is not disabled.
        if (!ballistas[selectedBallista].destroyed) {
            break;
        }   
    }
}
