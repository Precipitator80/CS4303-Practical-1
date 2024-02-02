class LevelManager {
    // Setup variables
    int groundHeight;
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
    
    // Ballistas
    Ballista[] ballistas;
    int numberOfBallistas = 3;
    int ballistaBaseAmmo = 10;
    int selectedBallista;
    
    // Cities
    City[] cities;
    int numberOfCities = 6;
    
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
    
    void render() {
        // Background
        background(0);
        
        // Backdrop - Fill the background and draw a line for the ground.
        stroke(backgroundColour);
        fill(backgroundColour);
        rect(0, groundHeight, width, height);
        
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
        // Set the ground height.
        groundHeight = (int)(0.95f * height);
        
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
        
        for (Ballista ballista : ballistas) {
            ballista.repair();
            ballista.ammoRemaining = ballistaBaseAmmo;
        }
        for (City city : cities) {
            city.repair();
        }
        
        wave++;
        asteroidCount = 3 + 2 * wave;
        minSpawnDelta = 500;
        maxSpawnDelta = 4000;
        asteroidsSpawned = 0;
        
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
                GameObject target = selectRandomTarget();
                new Asteroid((int)random(0, width), 0,(int)target.position.x,(int)target.position.y, random(0.5f, 10f), width * random(0.025f, 0.05f));
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
    
    GameObject selectRandomTarget() {
        //return targets.get(int(random(targets.size())));
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
                    bomb.explode();
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
