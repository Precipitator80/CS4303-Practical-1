public class Audio {
    PApplet mainClass;
    String audioFolder = "Audio/";
    SoundFile alarm;
    SoundFile bigExplosion;
    SoundFile bomberMissile;
    SoundFile bomberMissileExplosion;
    SoundFile explosion;
    SoundFile fire;
    SoundFile gameOver;
    SoundFile menuBack;
    SoundFile menuSelect;
    SoundFile noAmmo;
    SoundFile satellite; // Not sure how to play this correctly.
    SoundFile win;
    
    public Audio(PApplet mainClass) {
        this.mainClass = mainClass;
        load();
    }
    
    void load() {
        alarm = loadAudioWithFolder("Alarm.mp3");
        bigExplosion = loadAudioWithFolder("BigExplosion.wav");
        bomberMissile = loadAudioWithFolder("BomberMissile.wav");
        bomberMissileExplosion = loadAudioWithFolder("BomberMissileExplosion.wav");
        explosion = loadAudioWithFolder("Explosion.wav");
        fire = loadAudioWithFolder("Fire.wav");
        gameOver = loadAudioWithFolder("GameOver.mp3");
        menuBack = loadAudioWithFolder("MenuBack.mp3");
        menuSelect = loadAudioWithFolder("MenuSelect.mp3");
        noAmmo = loadAudioWithFolder("NoAmmo.wav");
        satellite = loadAudioWithFolder("Satellite.mp3");
        win = loadAudioWithFolder("Win.mp3");
    }
    
    SoundFile loadAudioWithFolder(String fileName) {
        return new SoundFile(mainClass, audioFolder + fileName);
    }
    
    float audioPan(float xPos) {
        return(xPos - width / 2) / width;
    }
}