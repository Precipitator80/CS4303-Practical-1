class IntButton extends Button {
    String optionName;
    int minValue;
    int maxValue;
    int value;
    public IntButton(int x, int y, String optionName, int initialValue, int minValue, int maxValue) {
        super(x, y, optionName);
        this.optionName = optionName;
        this.minValue = minValue;
        this.maxValue = maxValue;
        value = initialValue;
    }
    
    void render() {
        super.render();
        text = optionName + ": " + value;
    }
    
    void onClick() {
        value++;
        if (value > maxValue) {
            value = minValue;
        }
    }
}
