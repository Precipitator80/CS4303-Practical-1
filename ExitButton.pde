public class ExitButton extends Button {
    Menu menu;
    public ExitButton(int x, int y, Menu menu) {
        super(x, y, "Exit");
        this.menu = menu;
    }
    
    void onClick() {
        menu.hide();
    }
}