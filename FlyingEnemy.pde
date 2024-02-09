abstract class FlyingEnemy extends GameObject {
    float size;
    int directionMultiplier;
    PVector velocity;
    float minFireTime;
    float maxFireTime;
    
    float timeFired;
    float fireTime;
    public FlyingEnemy(int y, float minFireTime, float maxFireTime) {
        super((int)random(2) * width, y);
        size = 0.1f * height;
        directionMultiplier = (position.x == 0) ? 1 : - 1;
        velocity = new PVector(0.0015f * width * directionMultiplier, 0f);
        
        this.minFireTime = minFireTime;
        this.maxFireTime = maxFireTime;
        
        // Add an explosive component.
        new Explosive(this, false, size, size * 3f, false);
        resetTime();
    }
    
    void update() {
        position.add(velocity);
        
        double elapsed = millis() - timeFired;
        if (elapsed > fireTime) {
            fire();
            resetTime();
        }
        
        Utility.destroyIfOutOfBounds(this, 2f * size);
    }
    
    void resetTime() {
        timeFired = millis();
        fireTime = random(minFireTime, maxFireTime);
    }
    
    abstract void fire();
}
