class Asteroid extends Particle {
    float size;
    public Asteroid(int x, int y, int targetX, int targetY, float size) {
        super(x, y, targetX, targetY, 10f * (size / width), false, size, size * 3f);
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
