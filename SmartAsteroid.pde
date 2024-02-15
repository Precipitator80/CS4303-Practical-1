class SmartAsteroid extends Asteroid {
    Target target;
    Explosion danger;
    float safeDistance;
    float springConstant = 0.0002f;
    boolean needRetargeting;
    public SmartAsteroid(int x, int y, PVector velocity, float invMass, float size) {
        super(x, y, velocity, invMass, size);
        image = Graphics.smartAsteroid;
        if (levelManager.state != LevelState.GAME_OVER) {
            target = levelManager.randomTarget();
            retarget();
        }
    }
    
    void update() {
        boolean evaded = evadeExplosions();
        super.update();
        if (!evaded && needRetargeting) {
            retarget();
        }
    }
    
    boolean evadeExplosions() {
        boolean evaded = false;
        for (Explosion explosion : explosions) {
            float distance = this.position.copy().sub(explosion.position).mag();
            float dangerDistance = 1.75f * (this.size / 2f + explosion.maxExtent / 2f);
            if (distance < dangerDistance) {
                danger = explosion;
                safeDistance = 4f * dangerDistance;
                springForce(this, explosion, safeDistance, springConstant);
                evaded = true;
                needRetargeting = true;
            }
        }
        return evaded;
    }
    
    //Applies the spring force to the given particle
    //-k × (magnitude of d – l0) × normal(d)
    public void springForce(Particle particle, GameObject other, float l0, float k) {
        // Calculate the vector of the spring
        PVector d = particle.position.copy();
        d.sub(other.position.copy());
        
        // Calculate force magnitude
        float magnitude = d.mag();
        magnitude = magnitude - l0;
        magnitude *= k;
        
        // Calculate the final force, apply it.
        d.normalize();
        d.mult( -magnitude);
        d.x /= width;
        d.y /= height;
        particle.addForce(d);
    }
    
    void retarget() {
        if (target != null) {
            velocity = Utility.calculateStartingVelocity((int)position.x,(int)position.y,(int) target.position.x, groundHeight);
            needRetargeting = false;
        }
    }
}