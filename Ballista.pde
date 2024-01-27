public class Ballista extends Destructible {
    int ammoRemaining = 10;
    
    public Ballista(int x, int y) {
        super(x, y);
    }
    
    void update() {
    }
    
    void fire() {
        if (!destroyed && ammoRemaining > 0) {
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
    
    void render(boolean selected) {
        if (!destroyed) {
            if (selected) {
                // Draw line towards mouse.
                stroke(255);
                line(position.x,position.y, mouseX, mouseY);
                
                // Draw a circle to highlight the selected ballista.
                fill(50,50, 150,150);
                circle(position.x, position.y, 15);
                
                /*
                // Parabola test
                int a =1;
                int b =10;
                int c =-100;
                float scaleX = 0.1;
                beginShape(LINES);
                for (int i = -400; i <= 400;i++){
                float x= i * scaleX;
                int y =(int) -(a*x*x +b*x + c);
                vertex(i, y);
            }
                endShape();
                */
            } else {
                // Draw a shorter line towards the mouse.
                stroke(150);
                line(position.x,position.y, position.x + ((mouseX - position.x) * 0.5f), position.y + ((mouseY - position.y) * 0.5f));
            }
        }
    }
}
