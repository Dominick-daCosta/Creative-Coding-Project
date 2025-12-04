ArrayList<WeatherCircle> circles = new ArrayList<WeatherCircle>();

PFont font;

void setup() {
  fullScreen();
  background(0);
  textAlign(CENTER);
  font = createFont("Comic Sans MS", 30);
  
  // CREATES OBJECTS BASED ON CLASS
 
  circles.add(new WeatherCircle("Sun", width*0.2, height/2, 30, 15, 11));
  circles.add(new WeatherCircle("Rain", width*0.4, height/2, 76, 52, 13));
  circles.add(new WeatherCircle("Fog", width*0.6, height/2, 90, 101, 8));
  circles.add(new WeatherCircle("Overcast", width*0.8, height/2, 180, 128, 40));
}


void draw() {
  background(0);

  //For every Weather Circle which is called 'c' inside the list circles."
  for (WeatherCircle c : circles) {
    
    c.display();
    c.move();
    c.checkWallCollision ();
    
    //STOPS COLLISION
    
    for (WeatherCircle other : circles) {
      if (c != other) {
        c.checkCollisionOther(other);
      }
    }
  }
}


void mousePressed() {
  for (WeatherCircle c : circles) {
    c.checkPressed();
  }
}

void mouseDragged() {
  for (WeatherCircle c : circles) {
    c.drag();
  }
}

void mouseReleased() {
  for (WeatherCircle c : circles) {
    c.release();
  }
}
