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
            image(city, position.x, position.y, size * aspectRatio, size);
        }
        else{
            fill(backgroundColour);
            image(cityBroken, position.x, position.y, size * aspectRatio, size);
        }
        //circle(position.x, position.y, size);
    }
}
