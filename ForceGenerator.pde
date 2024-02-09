/*
* A force generator can be asked to add forces to
* one or more particles.
*/
abstract class ForceGenerator {
    void updateForce(Particle p) {
        p.addForce(calculateForce(p));
    }
    
    abstract PVector calculateForce(Particle p);
}
