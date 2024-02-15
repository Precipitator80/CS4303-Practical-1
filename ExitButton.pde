public class ExitButton extends Button {
    Menu menu;
    public ExitButton(int x, int y, Menu menu) {
        super(x, y, "Exit", Audio.menuBack);
        this.menu = menu;
    }
    
    void onClick() {
        super.onClick();
        menu.hide();
    }
}