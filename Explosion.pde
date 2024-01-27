class Explosion extends GameObject {
    double explosionTime;
    double explosionDuration = 1000.0;
    color col = color(249,182,78);
    public Explosion(int x, int y, boolean friendly) {
        super(x,y);
        explosionTime = millis();
        
        // If not friendly, destroy any destructibles within the radius.
        if (!friendly && position.y > groundHeight) {
            
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
    }
    
    void render() {
        stroke(col);
        fill(col);
        ellipse(position.x, position.y, 15, 15);
    }
}