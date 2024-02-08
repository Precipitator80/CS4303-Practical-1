class Bomb extends Explosive {
    public Bomb(int x, int y, int targetX, int targetY) {
        super(x, y, targetX, targetY, 1f, true, 0.025f * width, 0.15f * width);
        bombs.add(this);
    }
    
    void destroy() {
        super.destroy();
        bombs.remove(this);
    }
    
    void update() {
        super.update();
        
        // Check for any collisions with other explosives.
        // If an explosive is within the explosion radius and not marked for destruction.
        Iterator<Explosive> iterator = explosives.iterator();
        while(iterator.hasNext()) {
            Explosive explosive = iterator.next();
            if (explosive != this) {
                float distance = this.position.copy().sub(explosive.position).mag();
                if (distance < (this.size / 2f + explosive.size / 2f)) {
                    boolean triggerWasFriendly = this.friendly || explosive.friendly;
                    this.explode(triggerWasFriendly);
                    explosive.explode(triggerWasFriendly);
                }
            }
        }
    }
    
    void render() {
        stroke(playerColour);
        fill(playerColour);
        circle(position.x, position.y, size);
    }
}
