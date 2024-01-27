abstract class Explosive extends Particle {
    boolean friendly;
    Explosive(int x, int y, int targetX, int targetY, float invM,  boolean friendly) {
        super(x, y, Utility.calculateStartingVelocity(x, y, targetX, targetY, gravity.gravity.y, width, height), invM);
        this.friendly = friendly;
    }
    
    void update() {
        super.update();
        if (position.y > groundHeight) {
            explode();
        }
    }
    
    void explode() {
        if (!destroyed()) {
            destroy();
            new Explosion((int)position.x,(int)position.y, friendly);
        }
    }
}