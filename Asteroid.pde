class Asteroid extends Particle {
    Explosive explosive;
    PImage image;
    
    public Asteroid(int x, int y, PVector velocity, float invMass, float size) {
        super(x, y, velocity, invMass, size);
        asteroids.add(this);
        
        // Add an explosive component.
        explosive = new Explosive(this, false, size, size * 2f, false, Audio.explosion);
        image = Graphics.asteroid;
    }
    
    void destroy() {
        if (!destroyed()) {
            super.destroy();
            asteroids.remove(this);
            explosive.destroy();
        }
    }
    
    void render() {
        pushMatrix();
        translate(position.x, position.y);
        rotate(frameCount / - 30.0);
        imageMode(CENTER);
        image(image, 0, 0, size, size);
        popMatrix();
    }
}
