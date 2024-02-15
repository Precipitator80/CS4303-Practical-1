class FloatButton extends Button {
    String optionName;
    float minValue;
    float maxValue;
    float value;
    float step;
    public FloatButton(int x, int y, String optionName, float initialValue, float minValue, float maxValue, float step) {
        super(x, y, optionName, Audio.menuSelect);
        this.optionName = optionName;
        this.minValue = minValue;
        this.maxValue = maxValue;
        this.step = step;
        value = initialValue;
    }
    
    void render() {
        text = optionName + ": " + value;
        super.render();
    }
    
    void onClick() {
        super.onClick();
        if (mouseButton == RIGHT) {
            value -= step;
            if (value < minValue) {
                value = maxValue;
            }
        }
        else{
            value += step;
            if (value > maxValue) {
                value = minValue;
            }
        }
    }
}
