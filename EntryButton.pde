class EntryButton extends Button {
    Menu menu;
    public EntryButton(int x, int y, Menu menu) {
        super(x, y, menu.name);
        this.menu = menu;
    }
    
    void onClick() {
        menu.open();
    }
}