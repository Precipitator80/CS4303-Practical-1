public class Graphics {
    String graphicsFolder = "Graphics/";
    PImage background;
    PImage city;
    PImage cityBroken;
    PImage crosshair;
    PImage cluster4;
    PImage cluster3;
    PImage cluster2;
    PImage cluster1;
    PImage asteroid;
    PImage bomber;
    PImage missile;
    PImage satellite;
    PImage ballista;
    PImage ballistaBase;
    
    public Graphics() {
        load();
    }
    
    void load() {
        background = loadImageWithFolder("Background.png");
        background.resize(width, height);
        city = loadImageWithFolder("City.png");
        cityBroken = loadImageWithFolder("CityBroken.png");
        crosshair = loadImageWithFolder("Crosshair.png");
        cluster4 = loadImageWithFolder("Cluster4.png");
        cluster3 = loadImageWithFolder("Cluster3.png");
        cluster2 = loadImageWithFolder("Cluster2.png");
        cluster1 = loadImageWithFolder("Cluster1.png");
        asteroid = loadImageWithFolder("Asteroid.png");
        bomber = loadImageWithFolder("Bomber.png");
        missile = loadImageWithFolder("Missile.png");
        satellite = loadImageWithFolder("Satellite.png");
        ballista = loadImageWithFolder("Ballista.png");
        ballistaBase = loadImageWithFolder("BallistaBase.png");
    }
    
    PImage loadImageWithFolder(String fileName) {
        return loadImage(graphicsFolder + fileName);
    }
}