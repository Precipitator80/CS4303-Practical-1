class Asteroid extends Explosive {
    public Asteroid(int x, int y, int targetX, int targetY, float invM) {
        super(x, y, targetX, targetY, invM, false); 
    }
    
    void render() {
        stroke(enemyColour);
        fill(enemyColour);
        ellipse(position.x, position.y, 5, 5);
    }
}
