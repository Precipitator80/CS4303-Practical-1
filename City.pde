public class City extends Target {
    public City(int x, int y) {
        super(x, y, 0.1f * height);
    }
    
    void update() {
    }
    
    void render() {
        imageMode(CENTER);
        if (!disabled()) {
            image(Graphics.city, position.x, position.y, 1.61f * size, size);
        }
        else{
            image(Graphics.cityBroken, position.x, position.y, 1.61f * size, size);
        }
    }
}
