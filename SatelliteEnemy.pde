class SatelliteEnemy extends FlyingEnemy{
    public SatelliteEnemy(int y) {
        super(y);
    }
    
    void render() {
        stroke(enemyColour);
        fill(enemyColour);
        circle(position.x, position.y, size);
    }
}