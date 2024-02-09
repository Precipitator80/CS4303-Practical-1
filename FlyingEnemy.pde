abstract class FlyingEnemy extends GameObject {
    int directionMultiplier;
    float targetSpeed;
    int targetHeight;
    public FlyingEnemy(int y) {
        super(0, y, 0, 0, 1f, false, 0.025f * width, 0.15f * width);
        directionMultiplier = (position.x == 0) ? 1 : - 1;
        targetHeight = y;
        targetSpeed = 0.0001f;
    }
    
    void update() {
        super.update();
        updatePositionManually();
    }
    
    void updatePositionManually() {
        position = new PVector(position.x + targetSpeed, targetHeight);
    }
}