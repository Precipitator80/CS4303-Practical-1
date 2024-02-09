abstract class FlyingEnemy extends GameObject {
    float size;
    PVector velocity;
    public FlyingEnemy(int y) {
        super((int)random(2) * width, y);
        size = 0.05f * height;
        int directionMultiplier = (position.x == 0) ? 1 : - 1;
        velocity = new PVector(0.0015f * width * directionMultiplier, 0f);
        
        // Add an explosive component.
        new Explosive(this, false, size, size * 3f, false);
    }
    
    void update() {
        position.add(velocity);
    }
}
