class LevelManager extends GameObject {
    public LevelManager() {
        super(0,0);
    }
    
    // Variables with their starting values initialised.
    int wave = 1;
    int score = 0;
    int asteroidCount = 5;
    
    // During the wave, spawn some initial asteroids and then wait to spawn more until the full count has been exhausted.
    void update() {
        
    }
    
    void render() {
        // Show the score.
        fill(255);
        textSize(width / 25);
        text("Score: " + score, width / 100, width / 25);
    }
}
