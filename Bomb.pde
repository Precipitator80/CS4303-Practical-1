class Bomb extends Particle {
    Explosive explosive;
    
    public Bomb(int x, int y, PVector velocity) {
        this(x, y, velocity, 1f, 0.035f * height);
    }
    
    public Bomb(int x, int y, PVector velocity, float invMass, float size) {
        super(x, y, velocity, invMass, size);
        bombs.add(this);
        
        // Add an explosive component.
        explosive = new Explosive(this, true, size, size * 3f, true);
    }
    
    void destroy() {
        if (!destroyed()) {
            super.destroy();
            bombs.remove(this);
            explosive.destroy();
        }
    }
    
    void render() {
        pushMatrix();
        translate(position.x, position.y);
        rotate(atan2(velocity.y, velocity.x));
        imageMode(CENTER);
        image(missile, 0, 0, size, size);
        popMatrix();
    }
}
