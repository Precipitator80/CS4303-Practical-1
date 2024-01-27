public class Ballista extends Target {
    int ammoRemaining = 10;
    boolean selected;
    
    public Ballista(int x, int y) {
        super(x, y);
    }
    
    void update() {
    }
    
    void fire() {
        if (ammoRemaining > 0) {
            // Spawn the particle.
            bombs.add(new Bomb((int)position.x,(int)position.y, mouseX, mouseY));
            
            // Remove ammo.
            //ammoRemaining--;
        }
    }
    
    void destroy() {
        super.destroy();
        switchBallista(true);
    }
    
    void render() {
        if (!disabled) {
            if (selected) {
                // Draw line towards mouse.
                stroke(255);
                line(position.x,position.y, mouseX, mouseY);
                
                // Draw a circle to highlight the selected ballista.
                fill(playerColour);
                circle(position.x, position.y, 15);
            } else {
                // Draw a shorter line towards the mouse.
                stroke(150);
                line(position.x,position.y, position.x + ((mouseX - position.x) * 0.5f), position.y + ((mouseY - position.y) * 0.5f));
                
                fill(playerColour);
                circle(position.x, position.y, 5);
            }
        }
        else{
            fill(backgroundColour);
            circle(position.x, position.y, 15);
        }
    }
}
