class ClusterAsteroid extends Asteroid {
    int clusterSize;
    
    double spawnTime;
    double splitTime;
    
    public ClusterAsteroid(int x, int y, PVector velocity, float invMass, float size, int clusterSize) {
        super(x, y, velocity, invMass, size);
        this.clusterSize = constrain(clusterSize, 1, 4);
        resetTime();
    }
    
    void resetTime() {        
        spawnTime = millis();
        splitTime = random(levelManager.minSplitTime, levelManager.maxSplitTime);
        switch(clusterSize) {
            case 4:
                image = cluster4;
                break;
            case 2:
                image = cluster2;
                break;
            case 1:
                image = cluster1;
                break;
            default:
            image = cluster3;
        }
    }
    
    void update() {
        super.update();
        if (clusterSize > 1) {
            double elapsed = millis() - spawnTime;
            if (elapsed > splitTime) {
                spawnCluster();
            }
        }
    }
    
    void spawnCluster() {
        size /= 2;
        explosive.explosionSize /= 2;
        invMass *= 2;
        clusterSize--;
        float randomVelocityChange = random(0.0005f, 0.002f) * ((int)random(2) == 0 ? 1 : - 1);
        new ClusterAsteroid((int)position.x,(int)position.y, velocity.copy().add(new PVector(randomVelocityChange, 0f)), invMass, size, clusterSize);
        resetTime();
    }
}
