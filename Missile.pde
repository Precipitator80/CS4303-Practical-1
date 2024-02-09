class Missile extends Asteroid {
    public Missile(int x, int y, PVector velocity, float invMass, float size) {
        super(x, y, velocity, invMass, size);
    }
    
    void render() {
        float angle = atan2(mouseY - position.y, mouseX - position.x);
        pushMatrix();
        translate(position.x, position.y);
        rotate(atan2(velocity.y, velocity.x));
        imageMode(CENTER);
        image(missile, 0, 0, size, size);
        popMatrix();
    }
}