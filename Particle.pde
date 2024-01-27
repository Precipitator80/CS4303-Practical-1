// a representation of a point mass
abstract class Particle extends Destructible {
    
    //Vectors to hold pos, vel
    //I'm allowing public access to keep things snappy.
    public PVector velocity;
    
    //Vector to accumulate forces prior to integration
    private PVector forceAccumulator; 
    
    //Store inverse mass to allow simulation of infinite mass
    public float invMass;
    
    //If you do need the mass, here it is:
    public float getMass() {return 1 / invMass;}
    
    color col;
    
    Particle(int x, int y, float xVel, float yVel, float invM, color col) {
        super(x,y);
        velocity = new PVector(xVel, yVel);
        forceAccumulator = new PVector(0, 0);
        invMass = invM;    
        this.col = col;
        
        forceRegistry.add(this, gravity) ;
        forceRegistry.add(this, drag) ;
    }
    
    // Add a force to the accumulator.
    void addForce(PVector force) {
        forceAccumulator.add(force);
    }
    
    // Update motion.
    void integrate() {
        // If infinite mass, we don't integrate
        if (invMass <= 0f) return;
        
        // Update position - Normalise velocity over screen space and add the result to the position.
        PVector normalisedVelocity = new PVector(velocity.x * width, velocity.y * height);
        position.add(normalisedVelocity);
        
        // Update acceleration - Get the force applied and multiply it by the inverse mass to get acceleration.
        forceAccumulator.mult(invMass);
        
        // Update velocity - Add the acceleration to the current velocity value.
        velocity.add(forceAccumulator);
        
        // Clear the force accumulator.
        forceAccumulator.x = 0;
        forceAccumulator.y = 0;
         
        // Destroy the particle if it goes out of bounds horizontally.
        if (position.x < 0) {
            destroy();
        }   
        if (position.x > width) {
            destroy();
        }
    }
    
    void update() {
        if(!destroyed){
          integrate();
        }
    }
    
    // For now just render all particles the same. Should be made abstract later.
    void render() {
      if(!destroyed){
        stroke(col);
        fill(col);
        ellipse(position.x, position.y, 5, 5);
      }
    }
}
