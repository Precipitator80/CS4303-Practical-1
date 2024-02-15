abstract class Button extends UIItem  {
    public boolean mouseOver;
    SoundFile clickSound;
    
    public Button(int x, int y, String text, SoundFile clickSound) {
        super(x,y,text);
        this.clickSound = clickSound;
        buttons.add(this);
    }
    
    void destroy() {
        super.destroy();
        buttons.remove(this);
    }
    
    void onClick() {
        clickSound.play(1, 0.2f);
    }
    
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
