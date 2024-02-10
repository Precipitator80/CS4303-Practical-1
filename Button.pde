abstract class Button extends GameObject {
    private int w;
    private int h;
    protected String text;
    public boolean mouseOver;
    public boolean enabled;
    
    public Button(int x, int y, String text) {
        super(x,y);
        w = text.length() * width / 40;
        h = height / 10;
        this.text = text;
        buttons.add(this);
    }
    
    void destroy() {
        super.destroy();
        buttons.remove(this);
    }
    
    abstract void onClick();
    
    void update() {
        if (enabled && mouseX >= position.x - w / 2  && mouseX <= position.x + w / 2 && 
            mouseY >= position.y - h / 2 && mouseY <= position.y + h / 2) {
            mouseOver = true;
        } else{
            mouseOver = false;
        }
    }
    
    void render() {
        if (enabled) {
            stroke(strokeColour);
            fill(fillColour);
            rectMode(CENTER);
            rect(position.x, position.y, w, h);
            
            fill(strokeColour);
            textAlign(CENTER, CENTER);
            text(text, position.x, position.y);
        }
    }
}
