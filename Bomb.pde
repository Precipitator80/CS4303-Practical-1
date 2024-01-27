class Bomb extends Explosive {
    public Bomb(int x, int y, int targetX, int targetY) {
        super(x, y, targetX, targetY, 1f, playerColour, true); 
    }
}
