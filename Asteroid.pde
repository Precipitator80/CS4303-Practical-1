class Asteroid extends Explosive {
    float size;
    public Asteroid(int x, int y, int targetX, int targetY, float invM, float size) {
        super(x, y, targetX, targetY, invM, false, size, size * 3f);
        this.size = size;
        asteroids.add(this);
    }
    
    void destroy() {
        super.destroy();
        asteroids.remove(this);
    }
    
    void render() {
        stroke(enemyColour);
        fill(enemyColour);
        circle(position.x, position.y, size);
    }
}
