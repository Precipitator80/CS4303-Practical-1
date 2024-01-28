public abstract class Target extends GameObject {    
    private boolean disabled = false;
    float size;
    public Target(int x, int y, float size) {
        super(x, y);
        this.size = size;
        targets.add(this);
    }
    
    void disable() {
        if (!disabled()) {
            disabled = true;
            targets.remove(this);
        }
    }
    boolean disabled() {
        return disabled;
    }
}