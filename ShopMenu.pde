class ShopMenu extends Menu {    
    int moneySpent;
    ShopListing extraAmmo;
    ShopListing explosionSize;
    
    public ShopMenu() {
        super("Shop");
    }
    
    void initialise() {
        extraAmmo = new ShopListing((int) this.position.x,(int) this.position.y, "Extra Ammo", 100);
        menuItems.add(extraAmmo);
        
        explosionSize = new ShopListing((int) this.position.x,(int) this.position.y, "Explosion Size", 150);
        menuItems.add(explosionSize);
    }
    
    void resetListings() {
        moneySpent = 0;
        for (UIItem menuItem : menuItems) {
           ((ShopListing)menuItem).reset();
        }
    }
    
    int totalMoneyEarned() {
        return(int)(OptionsMenu.creditsMultiplier.value * levelManager.score / 10);
    }
    
    int moneyAvailable() {
        return totalMoneyEarned() - moneySpent;
    }
    
    void render() {
        if (enabled()) {
            extraText = " (Credits: " + moneyAvailable() + ")";
            super.render();
        }
    }
}
