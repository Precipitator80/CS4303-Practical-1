class OptionsMenu extends Menu {
    public BoolButton hybridControlScheme;
    public IntButton numberOfBallistas;
    public IntButton startingAmmo;
    public BoolButton infiniteAmmo;
    public IntButton numberOfCities;
    public FloatButton creditsMultiplier;
    public FloatButton gravityMultiplier;
    public FloatButton dragMultiplier;
    public FloatButton asteroidSpawnCountMultiplier;
    public FloatButton enemySpawnRateMultiplier;
    public FloatButton asteroidVariantChanceMultiplier;
    public FloatButton flyingEnemySpawnCountMultiplier;
    
    public OptionsMenu() {
        super("Options");
    }
    
    void initialise() {
        hybridControlScheme = new BoolButton((int)position.x,(int)position.y, "Hybrid Bomb Explosion Order", true);
        menuItems.add(hybridControlScheme);
        
        numberOfBallistas = new IntButton((int)position.x,(int)position.y, "Ballista Count", 3, 1, 6);
        menuItems.add(numberOfBallistas);
        
        startingAmmo = new IntButton((int)position.x,(int)position.y, "Starting Ammo", 10, 1, 20);
        menuItems.add(startingAmmo);
        
        infiniteAmmo = new BoolButton((int)position.x,(int)position.y, "Infinite Ammo", false);
        menuItems.add(infiniteAmmo);
        
        numberOfCities = new IntButton((int)position.x,(int)position.y, "City Count", 6, 1, 10);
        menuItems.add(numberOfCities);
        
        creditsMultiplier = new FloatButton((int)position.x,(int)position.y, "Credits Multiplier", 1f, 0f, 10f, 0.5f);
        menuItems.add(creditsMultiplier);
        
        gravityMultiplier = new FloatButton((int)position.x,(int)position.y, "Gravity Multiplier", 1f, 0f, 10f, 0.25f);
        menuItems.add(gravityMultiplier);
        
        dragMultiplier = new FloatButton((int)position.x,(int)position.y, "Drag Multiplier", 1f, 0f, 10f, 0.25f); 
        menuItems.add(dragMultiplier);
        
        asteroidSpawnCountMultiplier = new FloatButton((int)position.x,(int)position.y, "Asteroid Spawn Count Multiplier", 1f, 0.25f, 10f, 0.25f);
        menuItems.add(asteroidSpawnCountMultiplier);
        
        enemySpawnRateMultiplier = new FloatButton((int)position.x,(int)position.y, "Enemy Spawn Rate Multiplier", 1f, 0.25f, 10f, 0.25f);
        menuItems.add(enemySpawnRateMultiplier);
        
        asteroidVariantChanceMultiplier = new FloatButton((int)position.x,(int)position.y, "Asteroid Variant Chance Multiplier", 1f, 0f, 10f, 0.25f);
        menuItems.add(asteroidVariantChanceMultiplier);
        
        flyingEnemySpawnCountMultiplier = new FloatButton((int)position.x,(int)position.y, "Flying Enemy Spawn Count Multiplier", 1f, 0f, 10f, 0.25f);
        menuItems.add(flyingEnemySpawnCountMultiplier);
    }
    
    void hide() {
        super.hide();
        levelManager.initialSetup();
    }
}
