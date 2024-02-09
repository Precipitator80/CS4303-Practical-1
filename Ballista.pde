public class Ballista extends Target {
    int ammoRemaining;
    boolean selected;
    
    public Ballista(int x, int y, int ammoRemaining) {
        super(x, y, 0.075f * height);
        this.ammoRemaining = ammoRemaining;
    }
    
    void update() {
    }
    
    void fire() {
        if (ammoRemaining > 0) {
            // Spawn the particle.
            PVector velocity = Utility.calculateStartingVelocity((int)position.x,(int)position.y, mouseX, mouseY);
            new Bomb((int)position.x,(int)position.y, velocity);
            
            // Remove ammo.
            if (levelManager.state == LevelState.LEVEL) {
                ammoRemaining--;
                
                if (ammoRemaining <= 0) {
                    levelManager.switchBallista(true);
                }
            }
        }
    }
    
    // Set ammo to 0 and switch ballista if this was the one selected.
    void disable() {
        if (!disabled()) {
            super.disable();
            ammoRemaining = 0;
            if (selected) {
                levelManager.switchBallista(true);
            }
        }
    }
    
    void render() {
        if (!disabled()) {
            if (selected) {
                // Draw line towards mouse.
                stroke(255);
                line(position.x,position.y, mouseX, mouseY);
                
                // Draw a circle to highlight the selected ballista.
                fill(playerColour);
                circle(position.x, position.y, size);
            } else {
                // Draw a shorter line towards the mouse.
                stroke(150);
                line(position.x,position.y, position.x + ((mouseX - position.x) * 0.5f), position.y + ((mouseY - position.y) * 0.5f));
                
                fill(playerColour);
                circle(position.x, position.y, size / 3);
            }
            
            // Show the ammo remaining when in a round and infinity otherwise.
            String textToShow;
            switch(levelManager.state) {
                case POST_LEVEL:
                    case LEVEL:
                    textToShow = Integer.toString(ammoRemaining);
                    break;
                default:
                textToShow = "∞";
            }
            
            // To show selected, draw a circle around the turret with transparent shape but player colour  outline.
            
            textAlign(CENTER);
            fill(255);
            textSize(height / 25);
            text(textToShow, position.x, position.y + height / 15);
            
            // Show the base and launcher.
            image(ballistaBase, position.x, position.y, size, size);
            pushMatrix();
            translate(position.x, position.y);
            rotate(atan2(mouseY - position.y, mouseX - position.x));
            imageMode(CENTER);
            image(ballista, 0, 0, size, 0.44f * size);
            popMatrix();
            
        }
        else{
            // Show only the base with a grey tint.
            tint(64);
            image(ballistaBase, position.x, position.y, size, size);
            tint(255);
        }
    }
}