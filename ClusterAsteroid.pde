class ClusterAsteroid extends Asteroid {
    int maxFragments;
    
    double spawnTime;
    double splitTime;
    
    public ClusterAsteroid(int x, int y, PVector velocity, float invMass, float size, int maxFragments) {
        super(x, y, velocity, invMass, size);
        this.maxFragments = maxFragments;
        resetTime();
    }
    
    void resetTime() {        
        spawnTime = millis();
        splitTime = random(levelManager.minSplitTime, levelManager.maxSplitTime);
    }
    
    void update() {
        super.update();
        if (maxFragments > 0) {
            double elapsed = millis() - spawnTime;
            if (elapsed > splitTime) {
                spawnCluster();
            }
        }
    }
    
    void spawnCluster() {
        int asteroidsToSpawn = (int)random(1,maxFragments);
        size /= (asteroidsToSpawn + 1);
        explosive.explosionSize /= (asteroidsToSpawn + 1);
        invMass *= (asteroidsToSpawn + 1);
        maxFragments--;
        for (int i = 0; i < asteroidsToSpawn; i++) {
            float randomVelocityChange = random(0.0005f, 0.002f) * ((int)random(2) == 0 ? 1 : - 1);
            new ClusterAsteroid((int)position.x,(int)position.y, velocity.copy().add(new PVector(randomVelocityChange, 0f)), invMass, size, maxFragments);
        }
        resetTime();
    }
}
