class Utility{
    public PVector calculateStartingVelocity(int x, int y, int targetX, int targetY) {
        PVector velocity = new PVector(0, 0);
        
        // Calculate the velocity based on projectile motion.
        float av = gravity.gravity.y * OptionsMenu.gravityMultiplier.value; // Vertical acceleration.
        float sv = (y - targetY) / (float) height; // Vertical displacement.
        if (sv > 0) {        
            // Initial vertical speed.
            // v^2 =u^2 + 2aS
            // 0^2 =u^2 + 2aS
            // u = -sqrt(2aS)
            float uv= -sqrt(2 * av * sv);
            
            // Timeuntil max height.
            // v = u+at
            // at =v - u
            // t = (v- u) / a
            // t = -u/ a
            float t= -uv / av; 
            
            // Initial horizontal speed.
            // d = vt
            // v = d/t       
            float uh = (targetX - x) / (t * width);
            
            // Define the velocity from its components.
            velocity.set(uh, uv);
            
            // Account for drag. Just use a multiplier for now. Not a perfect solution, but simple.
            //velocity.mult(1.125f);
        }
        else{
            // s = ut + (1/2)at^2
            // Given u =0:
            // s = (1/2)at^2
            // t^2 = 2s/a
            // t = sqrt(2s/a)
            float t = sqrt(abs(2 * sv / av));
            
            float uh = (targetX - x) / (t * width);
            
            velocity.set(uh, 0);
        }
        if (OptionsMenu.dragMultiplier.value != 0) {
            //velocity.mult(sqrt(pow((targetY - y) / height, 2) + pow((targetX - x) / width, 2)));
            
            // Account for drag. Just use a multiplier for now. Not a perfect solution, but simple.
            velocity.mult(1.075f * OptionsMenu.dragMultiplier.value);
        }
        
        return velocity;
    }
    
    public int randomXOffsetWithinBounds(int previousX, float maxOffset) {
        return constrain(previousX + (int) random( -maxOffset * width, maxOffset * width), 0, width);
    }
    
    public void destroyIfOutOfBounds(GameObject gameObject, float size) {
        if (gameObject.position.x < 0 - size / 2) {
            gameObject.destroy();
        }   
        if (gameObject.position.x > width + size / 2) {
            gameObject.destroy();
        }
    }
    
    /*
    public static PVector calculateStartingVelocityWithDrag(int x, int y, int targetX, int targetY, float m, float k1, float g, float t, float width, float height) {
    float rx = (x - targetX) / (float) width;
    float ry = (y - targetY) / (float) height;
    
    float vx = -(k1 * rx / m);
    float vy = -(k1 * ry / m + g * t);
    
    return new PVector(vx, vy);
}
    */
}