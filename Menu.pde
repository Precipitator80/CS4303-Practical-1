import java.util.List;

abstract class Menu extends UIItem {
    protected List<UIItem> menuItems;
    Button entryButton;
    Button exitButton;
    
    public Menu(String name) {
        this(name,(4 * width) / 5,height / 10);
    }
    
    public Menu(String name, int entryButtonX, int entryButtonY) {
        super(width / 2, height / 2,(3 * width) / 4,(3 * height) / 4, name);
        textSize = defaultTextSize();
        entryButton = new EntryButton(entryButtonX, entryButtonY, this);
        exitButton = new ExitButton((int)position.x,(int)position.y, this);
        
        // Initialise menu items.
        menuItems = new ArrayList<UIItem>();
        initialise();
        menuItems.add(exitButton);
        
        // Place menu items.
        int itemWidth = (19 * w) / 20;
        int itemHeight = h / (menuItems.size() + 2); // Make space for the menu title (+1) and some padding between each item (+1).
        textSize = exitButton.textSize;
        textYOffset = -h / 2 + itemHeight / 2;
        // Place each item offset from the top of the menu by its index, using its height plus extra padding.
        for (int i = 0; i < menuItems.size();i++) {
            menuItems.get(i).place((int)position.x,(int)position.y + textYOffset + (i + 1) * (itemHeight + itemHeight / (menuItems.size() + 1)), itemWidth, itemHeight, textSize);
        }
    }
    
    abstract void initialise();
    
    void update() {
        
    }
    
    void render() {
        if (enabled()) {
            stroke(strokeColour);
            fill(fillColour);
            rectMode(CENTER);
            rect(position.x, position.y, w, h);
            super.render();
        }
    }
    
    void show() {
        super.show();
        exitButton.show();
        entryButton.hide();
        for (UIItem menuItem : menuItems) {
            menuItem.show();
        }
    }
    
    void hide() {
        super.hide();
        exitButton.hide();
        entryButton.show();
        for (UIItem menuItem : menuItems) {
            menuItem.hide();
        }
    }
}
