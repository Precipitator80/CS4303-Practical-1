abstract class Button extends UIItem  {
    public boolean mouseOver;
    
    public Button(int x, int y, String text) {
        super(x,y,text);
        buttons.add(this);
    }
    
    void destroy() {
        super.destroy();
        buttons.remove(this);
    }
    
    abstract void onClick();
    
    void update() {
        if (enabled() && mouseX >= position.x - w / 2  && mouseX <= position.x + w / 2 && 
            mouseY >= position.y - h / 2 && mouseY <= position.y + h / 2) {
            mouseOver = true;
        } else{
            mouseOver = false;
        }
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
}
