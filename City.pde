public class City extends Target {
    public City(int x, int y) {
        super(x, y, 0.075f * height);
    }
    
    void update() {
    }
    
    void render() {
        if (!disabled()) {
            fill(playerColour);
        }
        else{
            fill(backgroundColour);
        }
        circle(position.x, position.y, size);
    }
}
