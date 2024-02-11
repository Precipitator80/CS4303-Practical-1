class ShopMenu extends Menu {    
    int moneySpent;
    ShopListing extraAmmo;
    
    public ShopMenu() {
        super("Shop");
    }
    
    void initialise() {
        extraAmmo = new ShopListing((int) this.position.x,(int)this.position.y, "Extra Ammo", 100);
        menuItems.add(extraAmmo);
    }
    
    void resetListings() {
        moneySpent = 0;
        for (UIItem menuItem : menuItems) {
           ((ShopListing)menuItem).reset();
        }
    }
    
    int totalMoneyEarned() {
        return levelManager.score / 10;
    }
}
