class Bomb extends Explosive {
    public Bomb(int x, int y, int targetX, int targetY) {
        super(x, y, targetX, targetY, 1f, true); 
    }
    
    void render() {
        stroke(playerColour);
        fill(playerColour);
        ellipse(position.x, position.y, 5, 5);
    }
}
