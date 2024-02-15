class ShopButton extends Button {
    ShopListing shopListing;
    boolean isBuyButton;
    public ShopButton(int x, int y, ShopListing shopListing, boolean isBuyButton) {
        super(x, y, isBuyButton ? "+" : "-", Audio.menuSelect);
        this.shopListing = shopListing;
        this.isBuyButton = isBuyButton;
    }
    
    void onClick() {
        // Play audio in shop listing instead.
        if (isBuyButton) {
            shopListing.buy();
        }
        else{
            shopListing.sell();
        }
    }
}
