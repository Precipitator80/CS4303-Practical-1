public abstract class Target extends GameObject {    
    private boolean disabled = false;
    float size;
    public Target(int x, int y, float size) {
        super(x, y);
        this.size = size;
        targets.add(this);
    }
    
    boolean disabled() {
        return disabled;
    }
    
    // Disable the target and remove it from the targets list.
    void disable() {
        if (!disabled()) {
            disabled = true;
            targets.remove(this);
        }
    }
    
    // Repair the target and add it back to the targets list.
    void repair() {
        if (disabled()) {
            disabled = false;
            targets.add(this);
        }
    }
}