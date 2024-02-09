class Missile extends Asteroid {
    public Missile(int x, int y, PVector velocity, float invMass, float size) {
        super(x, y, velocity, invMass, size);
        explosive.explosionSound = Audio.bomberMissileExplosion;
        Audio.bomberMissile.play(1, Audio.audioPan(position.x), 0.1f);
    }
    
    void render() {
        pushMatrix();
        translate(position.x, position.y);
        rotate(atan2(velocity.y, velocity.x));
        imageMode(CENTER);
        image(Graphics.missile, 0, 0, size, size);
        popMatrix();
    }
}