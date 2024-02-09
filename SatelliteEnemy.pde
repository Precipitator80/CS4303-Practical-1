class SatelliteEnemy extends FlyingEnemy{
    public SatelliteEnemy() {
        super((int)(0.1f * height), 2000f, 5000f);
    }
    
    void render() {
        stroke(enemyColour);
        fill(enemyColour);
        circle(position.x, position.y, size);
    }
    
    void fire() {
        int x = (int) position.x;
        int y = (int) position.y;
        PVector velocity = new PVector(random(0.0005f, 0.001f), 0f);
        float size = this.size / 2f;
        new Asteroid(x, y, velocity, 2.5f, size);
        new Asteroid(x, y, velocity.copy().mult( -1f), 2.5f, size);
    }
}
