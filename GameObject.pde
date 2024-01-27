abstract class GameObject {
    public PVector position;
    private boolean destroyed = false;
    public GameObject(int x, int y) {
        this.position = new PVector(x,y);
        gameObjects.add(this);
    }
    
    public void destroy() {
        destroyed = true;
    }
    public boolean destroyed() {
        return destroyed;
    }
    
    abstract void update();
    abstract void render();
}