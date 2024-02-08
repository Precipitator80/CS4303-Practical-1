abstract class Button extends GameObject {
    private int w;
    private int h;
    private String text;
    public boolean mouseOver;
    
    public Button(int x, int y, String text) {
        super(x,y);
        w = width / 5;
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
        if (mouseX >= position.x - w / 2  && mouseX <= position.x + w / 2 && 
            mouseY >= position.y - h / 2 && mouseY <= position.y + h / 2) {
            mouseOver = true;
        } else{
            mouseOver = false;
        }
    }
    
    void render() {
        fill(playerColour);
        rectMode(CENTER);
        rect(position.x, position.y, w, h);
        
        fill(backgroundColour);
        textAlign(CENTER, CENTER);
        text(text, position.x, position.y);
    }
}
