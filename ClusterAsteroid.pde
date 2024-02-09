class ClusterAsteroid extends Asteroid {
    int targetX;
    int targetY;
    int maxFragments;
    
    double spawnTime;
    double splitTime;
    
    public ClusterAsteroid(int x, int y, int targetX, int targetY, float size, int maxFragments) {
        super(x,y,targetX,targetY,size);
        this.targetX = targetX;
        this.targetY = targetY;
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
        explosionSize /= (asteroidsToSpawn + 1);
        invMass = 10f * (size / width);
        maxFragments--;
        for (int i = 0; i < asteroidsToSpawn; i++) {
            new ClusterAsteroid((int)position.x,(int)position.y,Utility.randomXOffsetWithinBounds((int) position.x, 0.1f), targetY, size, maxFragments);
        }
        resetTime();
    }
}