class ShopListing extends UIItem {
    int basePrice;
    int timesBought;
    int currentPrice;
    
    ShopButton buyButton;
    ShopButton sellButton;
    
    public ShopListing(int x, int y, String text, int basePrice) {
        super(x,y,text);
        buyButton = new ShopButton(x + w, y, this, true);
        sellButton = new ShopButton(x - w, y, this, false);
        this.basePrice = basePrice;
        reset();
    }
    
    void render() {
        if (enabled()) {
            extraText = " (Bought:  " + timesBought + ". Price: " + currentPrice + ")";
            super.render();
        }
    }
    
    void buy() {
        if (ShopMenu.moneySpent + currentPrice < ShopMenu.totalMoneyEarned()) {
            ShopMenu.moneySpent += currentPrice;
            timesBought++;
            updateCurrentPrice();
            Audio.menuSelect.play(1, 0.2f);
        }
        else{
            Audio.noAmmo.play(1, 0.3f);
        }
    }
    
    void sell() {
        if (timesBought > 0) {
            timesBought--;
            updateCurrentPrice();
            ShopMenu.moneySpent -= currentPrice;
            Audio.menuSelect.play(1, 0.2f);
        }
        else{
            Audio.noAmmo.play(1, 0.3f);
        }
    }
    
    void updateCurrentPrice() {
        currentPrice = roundUp(basePrice + basePrice / 2 * timesBought, 5);
    }
    
    // Rounding Up To The Nearest Hundred - rgettman - https://stackoverflow.com/questions/18407634/rounding-up-to-the-nearest-hundred - Accessed 11.02.2024
    int roundUp(int numberToRound, int numberToRoundTo) {
        return((numberToRound + numberToRoundTo - 1) / numberToRoundTo) * numberToRoundTo;
    }
    
    void reset() {
        timesBought = 0;
        currentPrice = basePrice;
    }
    
    void place(int x, int y, int w, int h, int textSize) {
        super.place(x, y,(4 * w) / 5, h, 3 * textSize / 4);
        buyButton.place(x + (9 * w) / 20, y, w / 10, h, textSize);
        sellButton.place(x - (9 * w) / 20, y, w / 10, h, textSize);
    }
    
    void show() {
        super.show();
        buyButton.show();
        sellButton.show();
    }
    
    void hide() {
        super.hide();
        buyButton.hide();
        sellButton.hide();
    }
}