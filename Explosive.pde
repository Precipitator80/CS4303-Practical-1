abstract class Explosive extends Particle {
    boolean friendly;
    float size;
    float explosionSize;
    Explosive(int x, int y, int targetX, int targetY, float invM, boolean friendly, float size, float explosionSize) {
        super(x, y, Utility.calculateStartingVelocity(x, y, targetX, targetY, gravity.gravity.y, width, height), invM);
        //super(x, y, Utility.calculateStartingVelocityWithDrag(x, y, targetX, targetY, 1 / invM, drag.k1, gravity.gravity.y, 1f, width, height), invM);
        this.friendly = friendly;
        this.size = size;
        this.explosionSize = explosionSize;
        explosives.add(this);
    }
    
    void update() {
        super.update();
        if (position.y > levelManager.groundHeight) {
            explode();
        }
        else{
            // Check for any collisions with other explosives.
            // If an explosive is within the explosion radius and not marked for destruction.
            Iterator<Explosive> iterator = explosives.iterator();
            while(iterator.hasNext()) {
                Explosive explosive = iterator.next();
                if (explosive != this) {
                    float distance = this.position.copy().sub(explosive.position).mag();
                    if (distance < (this.size / 2f + explosive.size / 2f)) {
                        boolean triggerWasFriendly = this.friendly || explosive.friendly;
                        this.explode(triggerWasFriendly);
                        explosive.explode(triggerWasFriendly);
                    }
                }
            }
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