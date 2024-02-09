class Explosive extends GameObject {
    GameObject parent;
    boolean friendly;
    float size;
    float explosionSize;
    boolean checkCollisions;
    Explosive(GameObject parent, boolean friendly, float size, float explosionSize, boolean checkCollisions) {
        super((int)parent.position.x,(int)parent.position.y);
        this.parent = parent;
        this.position = parent.position;
        this.friendly = friendly;
        this.size = size;
        this.explosionSize = explosionSize;
        this.checkCollisions = checkCollisions;
        explosives.add(this);
    }
    
    void update() {
        if (position.y >= groundHeight) {
            explode();
        }
        
        if (checkCollisions) {
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
    
    void render() {
        
    }
    
    void destroy() {
        if (!destroyed()) {
            super.destroy();
            explosives.remove(this);
            parent.destroy();
        }
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
