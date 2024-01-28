class Bomb extends Explosive {
    public Bomb(int x, int y, int targetX, int targetY) {
        super(x, y, targetX, targetY, 1f, true, 0.025f * width, 0.15f * width);
        bombs.add(this);
    }
    
    void destroy() {
        super.destroy();
        bombs.remove(this);
    }
    
    void render() {
        stroke(playerColour);
        fill(playerColour);
        circle(position.x, position.y, size);
    }
}
