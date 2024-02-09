abstract class Explosive extends GameObject {
    boolean friendly;
    float size;
    float explosionSize;
    GameObject parent;
    Explosive(int x, int y, int targetX, int targetY, float invM, boolean friendly, float size, float explosionSize) {
        super(x, y, Utility.calculateStartingVelocity(x, y, targetX, targetY), invM);
        //super(x, y, Utility.calculateStartingVelocityWithDrag(x, y, targetX, targetY, 1 / invM, drag.k1, gravity.gravity.y, 1f, width, height), invM);
        this.friendly = friendly;
        this.size = size;
        this.explosionSize = explosionSize;
        explosives.add(this);
    }
    
    void update() {
        super.update();
        if (position.y >= levelManager.groundHeight) {
            explode();
        }
    }
    
    void destroy() {
        super.destroy();
        explosives.remove(this);
    }
    
    void explode() {
        explode(friendly);
    }
    
    void explode(boolean triggerWasFriendly) {
        if (!destroyed()) {
            destroy();
            new Explosion((int)position.x,(int)position.y, triggerWasFriendly, explosionSize);
            if (triggerWasFriendly && !this.friendly) {
                levelManager.addPoints(25);
            }
        }
    }
}