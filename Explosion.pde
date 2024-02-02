class Explosion extends GameObject {
    double explosionDuration = 1000.0;
    color col = color(249,182,78);
    double explosionTime;
    float size;
    boolean friendly;
    public Explosion(int x, int y, boolean friendly, float size) {
        super(x,y);
        explosionTime = millis();
        this.size = size;
        
        // If not friendly, destroy any destructibles within the radius.
        this.friendly = friendly;
        if (!friendly) { // && position.y > groundHeight // Possible optimisation for later.
            Iterator<Target> iterator = targets.iterator();
            while(iterator.hasNext()) {
                Target target = iterator.next();
                float distance = this.position.copy().sub(target.position).mag();
                if (distance < (this.size / 2f + target.size / 2f)) {
                    target.disable();
                }
            }
        }
    }
    
    void update() {
        // Destroy after explosion is finished.
        double elapsed = millis() - explosionTime;
        if (elapsed > explosionDuration) {
            destroy();
        }
        
        // Check for any chain reactions.
        // If an explosive is within the explosion radius and not marked for destruction.
        Iterator<Explosive> iterator = explosives.iterator();
        while(iterator.hasNext()) {
            Explosive explosive = iterator.next();
            float distance = this.position.copy().sub(explosive.position).mag();
            if (distance < (this.size / 2f + explosive.size / 2f)) {
                explosive.explode();
                if (this.friendly && !explosive.friendly) {
                    levelManager.addPoints(25);
                }
            }
        }
    }
    
    void render() {
        stroke(col);
        fill(col);
        circle(position.x, position.y, size);
    }
}
