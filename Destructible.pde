public abstract class Destructible{
    public PVector position;
    public boolean destroyed = false;
    
    public Destructible(int x, int y) {
        this.position = new PVector(x,y);
    }
    
    void destroy() {
        destroyed = true;
        // Spawn explosion
    }
}
