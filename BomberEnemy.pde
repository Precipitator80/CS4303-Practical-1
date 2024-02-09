class BomberEnemy extends FlyingEnemy{
    public BomberEnemy() {
        super((int)(0.3f * height), 4000f, 6000f);
    }
    
    void render() {
        stroke(enemyColour);
        fill(enemyColour);
        circle(position.x, position.y, size);
    }
    
    void fire() {
        int x = (int) position.x;
        int y = (int) position.y;
        float size = this.size / 2f;
        for (int i = 0; i < 2; i++) {
            Target target = levelManager.randomTarget();
            PVector velocity = Utility.calculateStartingVelocity(x, y,(int) target.position.x,(int) target.position.y);
            new Asteroid(x, y, velocity, 2.5f, size);
        }
    }
}
