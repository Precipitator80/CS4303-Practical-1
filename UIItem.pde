abstract class UIItem extends GameObject {
    protected String text;
    protected String extraText;
    protected int textSize;
    protected int textXOffset;
    protected int textYOffset;
    protected int w;
    protected int h;
    private boolean enabled;
    
    public UIItem(int x, int y, String text) {
        this(x, y, text.length() * width / 40, height / 10, text);
    }
    
    public UIItem(int x, int y, int w, int h, String text) {
        super(x,y);
        this.w = w;
        this.h = h;
        this.text = text;
        this.extraText = "";
        this.textSize = defaultTextSize();
    }
    
    void place(int x, int y, int w, int h) {
        place(x,y,w,h,defaultTextSize());
    }
    
    void place(int x, int y, int w, int h, int textSize) {
        position.x = x;
        position.y = y;
        this.w = w;
        this.h = h;
        this.textSize = textSize;
    }
    
    int defaultTextSize() {
        return 4 * h / 5;
    }
    
    void update() {
        
    }
    
    void render() {
        if (enabled()) {
            fill(strokeColour);
            textAlign(CENTER, CENTER);
            textSize(textSize);
            text(text + extraText, position.x + textXOffset, position.y + textYOffset);
        }
    }
    
    void show() {
        enabled = true;
    }
    
    void hide() {
        enabled = false;
    }
    
    boolean enabled() {
        return enabled;
    }
}