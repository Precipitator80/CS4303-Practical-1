class BomberEnemy extends FlyingEnemy{
    public BomberEnemy() {
        super((int)(0.3f * height), 4000f, 6000f);
    }
    
    void render() {
        pushMatrix();
        translate(position.x, position.y);
        imageMode(CENTER);
        scale(directionMultiplier, 1);
        image(bomber, 0, 0,  2f * size, size);
        popMatrix();
    }
    
    void fire() {
        int x = (int) position.x;
        int y = (int) position.y;
        float size = this.size / 2f;
        for (int i = 0; i < 2; i++) {
            Target target = levelManager.randomTarget();
            PVector velocity = Utility.calculateStartingVelocity(x, y,(int) target.position.x, groundHeight);
            new Missile(x, y, velocity, 2.5f, size);
        }
    }
}
