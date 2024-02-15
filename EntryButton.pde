class EntryButton extends Button {
    Menu menu;
    public EntryButton(int x, int y, Menu menu) {
        super(x, y, menu.text, Audio.menuSelect);
        this.menu = menu;
    }
    
    void onClick() {
        super.onClick();
        menu.show();
    }
}