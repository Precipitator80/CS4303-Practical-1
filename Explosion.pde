class Explosion extends GameObject {
    double explosionDuration = 750.0;
    color col = color(249,182,78);
    double explosionTime;
    float maxExtent;
    float size;
    boolean friendly;
    public Explosion(int x, int y, boolean friendly, float size, SoundFile explosionSound) {
        super(x,y);
        float startSizeFactor = 0.25f;
        explosionTime = millis() - startSizeFactor * explosionDuration;
        this.maxExtent = size;
        
        // If not friendly, destroy any destructibles within the radius.
        this.friendly = friendly;
        if (!friendly) { // && position.y > groundHeight // Possible optimisation for later.
            Iterator<Target> iterator = targets.iterator();
            while(iterator.hasNext()) {
                Target target = iterator.next();
                float distance = this.position.copy().sub(target.position).mag();
                if (distance < ((this.maxExtent * 0.75f) / 2f + target.size / 2f)) {
                    target.disable();
                }
            }
        }
        
        // Play explosions with half pan and reduced volume.
        explosionSound.play(1, Audio.audioPan(position.x), 0.1f);
        
        explosions.add(this);
    }
    
    
    void destroy() {
        if (!destroyed()) {
            super.destroy();
            explosions.remove(this);
        }
    }
    
    void update() {
        // Destroy after explosion is finished.
        double elapsed = millis() - explosionTime;
        this.size = (1f - (abs((float)(explosionDuration - elapsed)) / (float) explosionDuration)) * maxExtent;
        if (elapsed > 2f * explosionDuration) {
            destroy();
        }
        
        // Check for any chain reactions.
        // If an explosive is within the explosion radius and not marked for destruction.
        Iterator<Explosive> iterator = explosives.iterator();
        while(iterator.hasNext()) {
            Explosive explosive = iterator.next();
            float distance = this.position.copy().sub(explosive.position).mag();
            if (distance < (this.size / 2f + explosive.size / 2f)) {
                explosive.explode(friendly);
            }
        }
    }
    
    void render() {
        stroke(0,0,0,0);
        fill(col);
        circle(position.x, position.y, size);
    }
}
