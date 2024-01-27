public class City extends Target {
    public City(int x, int y) {
        super(x, y);
    }
    
    void update() {
    }
    
    void render() {
        if (!disabled) {
            fill(playerColour);
        }
        else{
            fill(backgroundColour);
        }
        circle(position.x, position.y, 15);
    }
}
