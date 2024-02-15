class IntButton extends Button {
    String optionName;
    int minValue;
    int maxValue;
    int value;
    public IntButton(int x, int y, String optionName, int initialValue, int minValue, int maxValue) {
        super(x, y, optionName, Audio.menuSelect);
        this.optionName = optionName;
        this.minValue = minValue;
        this.maxValue = maxValue;
        value = initialValue;
    }
    
    void render() {
        text = optionName + ": " + value;
        super.render();
    }
    
    void onClick() {
        super.onClick();
        if (mouseButton == RIGHT) {
            value--;
            if (value < minValue) {
                value = maxValue;
            }
        }
        else{
            value++;
            if (value > maxValue) {
                value = minValue;
            }
        }
    }
}
