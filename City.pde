public class City extends Destructible{
  public City(int x, int y) {
      super(x,y);
  }
  
  void render(){
    if(!destroyed){
        // Draw a circle to highlight the selected ballista.
        fill(playerColour);
    }
    else{
        fill(backgroundColour);
    }
    circle(position.x, position.y, 15);
  }
}
