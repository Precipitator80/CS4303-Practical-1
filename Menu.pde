class Menu extends GameObject {
    String name;
    Button entryButton;
    Button exitButton;
    
    private boolean enabled;
    int w;
    int h;
    int buttonCentreOffset;
    
    public Menu(String name, int entryButtonX, int entryButtonY) {
        super(width / 2, height / 2);
        this.name = name;
        w = 3 * width / 4;
        h = 3 * height / 4;
        buttonCentreOffset = height / 16;
        entryButton = new EntryButton(entryButtonX, entryButtonY, this);
        exitButton = new ExitButton(width / 2, h + buttonCentreOffset, this);
    }
    
    void update() {
        
    }
    
    void render() {
        if (enabled) {
            stroke(strokeColour);
            fill(fillColour);
            rectMode(CENTER);
            rect(position.x, position.y, w, h);
        }
    }
    
    boolean enabled() {
        return enabled;
    }
    
    void open() {
        exitButton.enabled = true;
        this.enabled = true;
        entryButton.enabled = false;
    }
    
    void close() {
        exitButton.enabled = false;
        this.enabled = false;
        entryButton.enabled = true;
    }
}
