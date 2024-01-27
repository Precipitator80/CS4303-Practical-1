abstract class Explosive extends Particle {
    boolean friendly;
    Explosive(int x, int y, int targetX, int targetY, float invM, color col, boolean friendly) {
        super(x, y, Utility.calculateStartingVelocity(x, y, targetX, targetY, gravity.gravity.y, width, height), invM, col);
        this.friendly = friendly;
    }
    
    void update() {
        super.update();
        if (!destroyed) {
            if (position.y > groundHeight) {
                explode();
            }
        }
    }
    
    // Explode the particle.
    void explode() {
        //Take into account whether this particle is friendly or not.
        
        //Destroy after explosion is finished.
        destroy();
    }
}
