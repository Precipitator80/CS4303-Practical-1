class Bomb extends Particle {
    Explosive explosive;
    
    public Bomb(int x, int y, PVector velocity) {
        this(x, y, velocity, 1f, 0.035f * height);
    }
    
    public Bomb(int x, int y, PVector velocity, float invMass, float size) {
        super(x, y, velocity, invMass, size);
        bombs.add(this);
        
        Audio.fire.play(1, Audio.audioPan(position.x), 0.25f);
        
        // Add an explosive component.
        explosive = new Explosive(this, true, size, size * 3f * (1f + 0.1f * ShopMenu.explosionSize.timesBought), true, Audio.explosion);
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
        image(Graphics.missile, 0, 0, size, size);
        popMatrix();
    }
}
