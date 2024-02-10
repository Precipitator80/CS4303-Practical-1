import java.util.List;

class OptionsMenu extends Menu {
    private List<Button> optionButtons;
    public BoolButton hybridControlScheme;
    public IntButton numberOfBallistas;
    public IntButton startingAmmo;
    public BoolButton infiniteAmmo;
    public IntButton numberOfCities;
    public OptionsMenu() {
        super("Options",(int)(0.8f * width),(int)(0.1f * height));
        optionButtons = new ArrayList<Button>();
        int offset = -h / 2 + buttonCentreOffset;
        int offsetIncrement = h / 6;
        hybridControlScheme = new BoolButton((int) this.position.x,(int)(this.position.y + offset), "Hybrid Bomb Explosion Order", true);
        optionButtons.add(hybridControlScheme);
        offset += offsetIncrement;
        numberOfBallistas = new IntButton((int) this.position.x,(int)(this.position.y + offset), "Ballista Count", 3, 1, 6);
        optionButtons.add(numberOfBallistas);
        offset += offsetIncrement;
        startingAmmo = new IntButton((int) this.position.x,(int)(this.position.y + offset), "Starting Ammo", 10, 1, 20);
        optionButtons.add(startingAmmo);
        offset += offsetIncrement;
        infiniteAmmo = new BoolButton((int) this.position.x,(int)(this.position.y + offset), "Infinite Ammo", false);
        optionButtons.add(infiniteAmmo);
        offset += offsetIncrement;
        numberOfCities = new IntButton((int) this.position.x,(int)(this.position.y + offset), "City Count", 6, 1, 10);
        optionButtons.add(numberOfCities);
    }
    
    void open() {
        super.open();
        for (Button button : optionButtons) {
            button.enabled = true;
        }
    }
    
    void close() {
        super.close();
        for (Button button : optionButtons) {
            button.enabled = false;
        }
        levelManager.initialSetup();
    }
}
