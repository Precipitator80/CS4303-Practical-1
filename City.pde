public class City extends Target {
    public City(int x, int y) {
        super(x, y, 0.1f * height);
    }
    
    void update() {
    }
    
    void render() {
        imageMode(CENTER);
        if (!disabled()) {
            fill(playerColour);
            image(city, position.x, position.y, 1.61f * size, size);
        }
        else{
            fill(backgroundColour);
            image(cityBroken, position.x, position.y, 1.61f * size, size);
        }
        //circle(position.x, position.y, size);
    }
}
