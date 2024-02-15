class Bomb extends Particle {
    Explosive explosive;
    boolean nuclear;
    
    public Bomb(int x, int y, PVector velocity, boolean nuclear) {
        this(x, y, velocity, 1f, 0.035f * height, nuclear);
    }
    
    public Bomb(int x, int y, PVector velocity, float invMass, float size, boolean nuclear) {
        super(x, y, velocity, invMass, size);
        bombs.add(this);
        
        Audio.fire.play(1, Audio.audioPan(position.x), 0.25f);
        
        // Add an explosive component.
        explosive = new Explosive(this, true, size, size * 3f * (1f + 0.1f * ShopMenu.explosionSize.timesBought), true, Audio.explosion);
        this.nuclear = nuclear;
        
        if (nuclear) {
            float nuclearSizeMultiplier = 1.5f;
            float nuclearExplosionSizeMultiplier = 5f;
            size *= nuclearSizeMultiplier;
            explosive.size *= nuclearSizeMultiplier;
            explosive.explosionSize *= nuclearExplosionSizeMultiplier;
            explosive.explosionSound = Audio.bigExplosion;
        }
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
        if (nuclear) {
            image(Graphics.nuclearBomb, 0, 0, 2.14f * size, size);
        }
        else{
            image(Graphics.missile, 0, 0, size, size);
        }
        popMatrix();
    }
}
