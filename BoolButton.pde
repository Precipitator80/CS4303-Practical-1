class BoolButton extends Button {
    String optionName;
    boolean value;
    public BoolButton(int x, int y, String optionName, boolean initialValue) {
        super(x, y, optionName, Audio.menuSelect);
        this.optionName = optionName;
        value = initialValue;
    }
    
    void render() {
        super.render();
        text = optionName + ": " + valueChar();
    }
    
    char valueChar() {
        return value ? '✓' : 'x';
    }
    
    void onClick() {
        super.onClick();
        value = !value;
    }
}
