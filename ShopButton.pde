class ShopButton extends Button {
    ShopListing shopListing;
    boolean isBuyButton;
    public ShopButton(int x, int y, ShopListing shopListing, boolean isBuyButton) {
        super(x, y, isBuyButton ? "+" : "-");
        this.shopListing = shopListing;
        this.isBuyButton = isBuyButton;
    }
    
    void onClick() {
        if (isBuyButton) {
            shopListing.buy();
        }
        else{
            shopListing.sell();
        }
    }
}
