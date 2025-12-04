// CREATES CLASS

class WeatherCircle {
  
  float x, y;
  float vx, vy; 
  String label;
  int valHappy, valSad, valSensual;
  int totalLines;
  boolean isDragging = false;
  float radius;
  float size;
  

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  // CONSTRUCTOR FOR OBJECTS
  WeatherCircle(String name, float startX, float startY, int happy, int sad, int sensual) {
    label = name;
    x = startX;
    y = startY;
    vx = random(-3, 3);
    vy = random(-3, 3);
    valHappy = happy;
    valSad = sad;
    valSensual = sensual;
    totalLines = happy + sad + sensual;
    size = map(totalLines, 0, 400, 50, 200);
    radius = size * 1.41;
  }
  
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  
  
  // DRAWS THE CIRCLE
  
  void display() {
    
    // Creates a bubble of rules so it is able to move folowing the mouse, idk how it really works but it does
    pushMatrix();
    translate(x, y);
    
    
    float angleStep = TWO_PI / totalLines; 
    
    for (int i = 0; i < totalLines; i++) {
      
      // Determine Color
      if (i < valHappy) {
        stroke(#ffee00); // Yellow
        
      } else if (i < valHappy + valSad) {
        stroke(#0055ff); // Blue
        
      } else {
        stroke(#ff0000); // Red)
      }
      
      strokeWeight(0.5);
      line(0, 0, size, size); 
      rotate(angleStep);  
    }
    
   
    fill(0);
    textFont(font);
    text(label, 0, 10);
    
    // Closes the bubble
    popMatrix();
    
  }
 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
  
  
  // BOUNCING
  
  void move() {
    if (!isDragging) {
      x = x + vx;
      y = y + vy;
      
      //Makes them slow down over time so they dont keep bouncing
      vx *= 0.9;
      vy *= 0.9;
    }
  }
  
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  
  
  // CLICK AND DRAG FUNCTIONS
  
  void checkPressed() {
    if (dist(mouseX, mouseY, x, y) < radius) {
      isDragging = true;
    }
  }
  
  void drag() {
    if (isDragging) {
      vx = mouseX - pmouseX;
      vy = mouseY - pmouseY;
      
      x = mouseX;
      y = mouseY;
    }
  }
  
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
 
 //COLLISIONS
 
  void checkCollisionOther(WeatherCircle other) {
    
    float distanceX = other.x - x;
    float distanceY = other.y - y;
    float distance = sqrt(distanceX*distanceX + distanceY*distanceY);
    float minDistance = radius + radius;

    if (distance < minDistance) { 
      
      //Calculations to know what angle to bounce
      float angle = atan2(distanceY, distanceX);
      float targetX = x + cos(angle) * minDistance;
      float targetY = y + sin(angle) * minDistance;
      
      // 2. Move them apart slightly so they don't get stuck (Spring effect)
      float ax = (targetX - other.x) * 0.05;
      float ay = (targetY - other.y) * 0.05;
      
      
      vx = vx - ax;
      vy =  vy - ay;
      other.vx = other.vx + ax;
      other.vy = other.vy + ay;
      
      // 3. ADD BOUNCE (Damping)
      // This simulates energy loss. 0.5 is like a beanbag, 0.9 is like a superball.
      vx *= 0.9;
      vy *= 0.9;
    }
  }
  
void checkWallCollision() {
    // RIGHT WALL
    if (x > width - radius) {
      x = width - radius;
      vx *= -1; // Reverse horizontal direction
    }
    // LEFT WALL
    else if (x < radius) {
      x = radius;
      vx *= -1; 
    }
    // BOTTOM WALL
    if (y > height - radius) {
      y = height - radius;
      vy *= -1; // Reverse vertical direction
    }
    // TOP WALL
    else if (y < radius) {
      y = radius;
      vy *= -1; 
    }
  }
  
  void release() {
    isDragging = false;
  }
}
