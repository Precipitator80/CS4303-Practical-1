class Asteroid extends Particle {
    Explosive explosive;
    
    public Asteroid(int x, int y, PVector velocity, float invMass, float size) {
        super(x, y, velocity, invMass, size);
        asteroids.add(this);
        
        // Add an explosive component.
        explosive = new Explosive(this, false, size, size * 3f, false);
    }
    
    void destroy() {
        if (!destroyed()) {
            super.destroy();
            asteroids.remove(this);
            explosive.destroy();
        }
    }
    
    void render() {
        stroke(enemyColour);
        fill(enemyColour);
        circle(position.x, position.y, size);
    }
}
