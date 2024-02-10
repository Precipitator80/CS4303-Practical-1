class LevelManager {
    // Setup variables
    boolean initialSetup = false;
    
    // Level parameters
    LevelState state = LevelState.WELCOME;
    int wave = 0;
    private int score = 0;
    
    // Asteroid spawn timers
    int asteroidCount;
    float minSpawnDelta;
    float maxSpawnDelta;
    double lastSpawn;
    float asteroidTimer;
    int asteroidsSpawned;
    
    // Cluster asteroids
    float clusterChance;
    float minSplitTime;
    float maxSplitTime;
    int clusterSize;
    
    // Ballistas
    Ballista[] ballistas;
    int numberOfBallistas = 3;
    int ballistaBaseAmmo = 10;
    int selectedBallista;
    
    // Cities
    City[] cities;
    int numberOfCities = 6;
    int freeCitiesUsed;
    
    //// General functions.
    void update() {
        forceRegistry.updateForces();
        
        // Update all GameObjects.
        Iterator<GameObject> iterator = gameObjects.iterator();
        while(iterator.hasNext()) {
            GameObject gameObject = iterator.next();
            gameObject.update();
            if (gameObject.destroyed()) {
                iterator.remove();
            }
        }
        
        switch(state) {
            case WELCOME:
                if (!initialSetup) {
                    initialSetup();
                }
                break;
            case PRE_LEVEL:
                setupLevel();
                break;
            case LEVEL:
                levelUpdate();
                break;
        }
    }
    
    int Y_AXIS = 1;
    int X_AXIS = 2;
    color b1, b2, c1, c2;
    
    void setGradient(int x, int y, float w, float h, color c1, color c2, int axis) {
        
        noFill();
        
        if (axis == Y_AXIS) {  // Top to bottom gradient
            for (int i = y; i <= y + h; i++) {
                float inter = map(i, y, y + h, 0, 1);
                color c = lerpColor(c1, c2, inter);
                stroke(c);
                line(x, i,x + w, i);
            }
        }  
        else if (axis == X_AXIS) {  // Left to right gradient
            for (int i = x; i <= x + w; i++) {
                float inter = map(i, x, x + w, 0, 1);
                color c = lerpColor(c1, c2, inter);
                stroke(c);
                line(i, y,i, y + h);
            }
        }
    }
    
    void render() {
        // Background
        background(Graphics.background);
        
        // Foreground
        // Render all GameObjects.
        Iterator<GameObject> iterator = gameObjects.iterator();
        while(iterator.hasNext()) {
            iterator.next().render();
        }
        
        // Show the score.
        textAlign(LEFT);
        fill(255);
        textSize(width / 25);
        text("Score: " + score + "\nWave: " + wave, width / 100, width / 25);
        
        textAlign(CENTER);
        switch(state) {
            case WELCOME:
                text("Welcome to Asteroid Command!\nPress enter to start the game.", width / 2, height / 2 - width / 25);
                break;
            case POST_LEVEL:
                text("Wave " + wave + " completed!\nPress enter to continue.", width / 2, height / 2 - width / 25);
                break;
            case GAME_OVER:
                text("Game over!\nPress enter to restart.", width / 2, height / 2 - width / 25);
                break;
            
        }
    }
    
    //// State: WELCOME
    void initialSetup() {
        // Place ballistas on the screen and select the middle one.
        ballistas = new Ballista[numberOfBallistas];
        for (int i = 0; i < ballistas.length; i++) {
            int xOffset = (int)(0.1f * width);
            int x = ballistas.length > 1 ? i * ((width - xOffset) / (ballistas.length - 1)) + xOffset / 2 : width / 2; 
            int y = (int)(0.9f * height);
            ballistas[i] = new Ballista(x, y, ballistaBaseAmmo);
        }
        selectedBallista = ballistas.length / 2;
        ballistas[selectedBallista].selected = true;
        
        // Spawn cities.
        cities = new City[numberOfCities];
        int pots = ballistas.length > 1 ? ballistas.length - 1 : 2;
        int citiesPerPot = ceil((float) cities.length / pots);
        int cityIndex = 0;
        if (ballistas.length > 1) {
            int potWidth = (int)(ballistas[1].position.x - ballistas[0].position.x);
            for (int potIndex = 0; potIndex < pots; potIndex++) {
                for (int subIndex = 0; subIndex < citiesPerPot && cityIndex < cities.length; subIndex++) {
                    int x = (int) ballistas[potIndex].position.x + (subIndex + 1) * potWidth / (citiesPerPot + 1);
                    cities[cityIndex++] = new City(x,(int)(height * random(0.9f, 0.95f)));
                }
            }
        }
        else{
            int potWidth = (int)(width / 2);
            for (int potIndex = 0; potIndex < pots; potIndex++) {
                for (int subIndex = 0; subIndex < citiesPerPot && cityIndex < cities.length; subIndex++) {
                    int x = (int) ballistas[0].position.x + ((subIndex + 1) * potWidth / (citiesPerPot + 1)) * (potIndex % 2 == 0 ? - 1 : 1);
                    cities[cityIndex++] = new City(x,(int)(height * random(0.9f, 0.95f)));
                }
            }
        }
        
        new OptionsButton((int)(0.8f * width),(int)(0.1f * height));
        
        new BomberEnemy();
        new SatelliteEnemy();
        
        initialSetup = true;
    }
    
    //// State: PRE_LEVEL
    void setupLevel() {
        for (Asteroid asteroid : asteroids) {
            asteroid.destroy();
        }
        for (Bomb bomb : bombs) {
            bomb.destroy();
        }
        for (Explosion explosion : explosions) {
            explosion.destroy();
        }
        
        for (Ballista ballista : ballistas) {
            ballista.repair();
            ballista.ammoRemaining = ballistaBaseAmmo;
        }
        
        if (wave == 0) {
            for (City city : cities) {
                city.repair();
            }
        }
        else{
            int freeCitiesEarned = score / 10000;
            for (City city : cities) {
                if (freeCitiesUsed - freeCitiesEarned > 0 && city.disabled()) {
                    city.repair();
                    freeCitiesUsed++;
                }
            }
        }
        
        wave++;
        asteroidCount = 3 + 2 * wave;
        minSpawnDelta = 500;
        maxSpawnDelta = 4000;
        asteroidsSpawned = 0;
        clusterChance = (wave / 2 - 1) * 0.05f;
        //clusterChance = 1f;
        minSplitTime = constrain(15000f / wave, 1000f, 4000f);
        //minSplitTime = constrain(1500f / wave, 100f, 400f);
        maxSplitTime = minSplitTime + 2000f;
        clusterSize = constrain(1 + (int)(wave * 0.2f), 2, 4);
        
        spawnAsteroids(3);       
        
        // Update the state.
        state = LevelState.LEVEL;
    }
    
    //// State: LEVEL
    void levelUpdate() {
        double elapsed = millis() - lastSpawn;
        if (elapsed > asteroidTimer && asteroidsSpawned < asteroidCount) {
            spawnAsteroids(1);
        }
        
        if (asteroidsSpawned >= asteroidCount && asteroids.isEmpty()) {
            finishWave();
        }
        
        if (citiesLeft() <= 0) {
            state = LevelState.GAME_OVER;
        }
    }
    
    void spawnAsteroids(int asteroidsToSpawn) {
        if (targets.size() > 0) {
            for (int i = 0; i < asteroidsToSpawn; i++) {
                int x = (int)random(0, width);
                int y = 0;
                PVector velocity = new PVector(random( -0.001f, 0.001f), random(0.001f, 0.005f));
                float size = height * random(0.05f, 0.075f);
                if (random(1) < clusterChance) {    
                    new ClusterAsteroid(x, y, velocity, 10f, size, clusterSize);
                }
                else{
                    new Asteroid(x, y, velocity, 5f, size);
                }
                asteroidsSpawned++;
            }
            lastSpawn = millis();
            asteroidTimer = random(minSpawnDelta, maxSpawnDelta);
        }
    }
    
    int citiesLeft() {
        int citiesLeft = 0;
        for (City city : cities) {
            if (!city.disabled()) {
                citiesLeft++;
            }
        }
        return citiesLeft;
    }
    
    void finishWave() {
        for (Ballista ballista : ballistas) {
            if (!ballista.disabled()) {
                addPoints(ballista.ammoRemaining * 5);
            }
        }
        for (City city : cities) {
            if (!city.disabled()) {
                addPoints(100);
            }
        }
        state = LevelState.POST_LEVEL;
    }
    
    Target randomTarget() {
        int randomIndex = int(random(targets.size()));
        Iterator<Target> iterator = targets.iterator();
        while(iterator.hasNext()) {
            Target target = iterator.next();
            if (randomIndex == 0) {
                return target;
            }
            randomIndex--;
        }
        return targets.peek();
    }
    
    //// State: GAME_OVER
    void resetParameters() {
        wave = 0;
        score = 0;
    }
    
    //// Other Functions
    public void switchBallista(boolean ascending) {
        int change = ascending ? 1 :- 1; // Increment / decrement.  
        //Keep switching ballistas until finding one that is not disabled.
        for (int attempt = 0; attempt < ballistas.length; attempt++) {
            ballistas[selectedBallista].selected = false;
            
            // Increment or decrement the index.
            selectedBallista += change;
            
            // Clamp the index.
            if (selectedBallista < 0) {
                selectedBallista = ballistas.length - 1; 
            }
            else if (selectedBallista >= ballistas.length) {
                selectedBallista = 0; 
            }
            
            ballistas[selectedBallista].selected = true;
            
            // Break out of the loop if the selected ballista is not disabled.
            if (!ballistas[selectedBallista].disabled()) {
                break;
            }   
        }
    }
    
    public void addPoints(int points) {
        int multiplier = constrain((wave + 1) / 2, 1, 6);
        score += points * multiplier;
    }
    
    //// Input / Output Functions    
    void mouseReleased() {
        boolean pressedButton = false;
        Iterator<Button> iterator = buttons.iterator();
        while(iterator.hasNext()) {
            Button button = iterator.next();
            if (button.mouseOver) {
                button.onClick();
                pressedButton = true;
            }
        }
        
        if (!pressedButton) {
            ballistas[selectedBallista].fire();
        }
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
                // Explode a bomb.
                // If the mouse is not at the edge of the screen, explode the bomb closest to the mouse.
                // Else, explode the earliest bomb fired.
                if (!bombs.isEmpty()) {
                    Bomb bomb = bombs.peek();
                    float closestDistance = Float.MAX_VALUE;
                    if (!mouseAtEdge()) {
                        Iterator<Bomb> iterator = bombs.iterator();
                        while(iterator.hasNext()) {
                            Bomb potentialBomb = iterator.next();
                            float distance = potentialBomb.position.copy().sub(new PVector(mouseX, mouseY)).mag();
                            if (distance < closestDistance) {
                                bomb = potentialBomb;
                                closestDistance = distance;
                            }
                        }
                    }
                    bomb.explosive.explode();
                }
                break;
            case ENTER:
                switch(state) {
                    case GAME_OVER:
                    resetParameters();
                    case WELCOME:
                    case POST_LEVEL:
                    state = LevelState.PRE_LEVEL;
                    break;   
            }
            break;
        }
    }
    
    boolean mouseAtEdge() {
        return mouseX < 0.05f * width || mouseX > 0.95f * width || mouseY < 0.05f * height || mouseY > 0.95f * height;
    }
}
