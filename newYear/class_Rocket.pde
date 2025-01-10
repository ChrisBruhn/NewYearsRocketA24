class Rocket{
  // attributter
  int diameter = 5; // diameter

  PVector pos;
  float angle = random(radians(-30), radians(30)); // Begræns vinklen til mellem -30 og 30 grader

  float xSpeed = random(0.05, 1.5); // Tilfældig vandret hastighed
  float ySpeed = random (-2.8, -1.5); // lodret hastighed som skal tilpasses skærmstørrelsen
  PVector velocity = new PVector(xSpeed, ySpeed);

  // farver til eksplosion RGB og opauqe værdi alfa
  int r=int(random(256));
  int g=int(random(256));
  int b=int(random(256));
  int alfa=255;

  //PVector velocity = new PVector(cos(angle), -2 + sin(angle));
  float minHeight = height-(height/4); // Minimumshøjde
  boolean exploded = false;

  // lyd
  boolean soundPayed = false; // bruges til lyd

  // konstruktør
  Rocket() {
    pos = new PVector(random(10, 80), height); // Startposition tilfældigt langs bunden
  }

  // metoder
  void playExplodingSound() {
    if (!soundPayed ) {
      singleRocket.play();
      soundPayed = true;
    }
  }

  void display() {
    if (!exploded) {
      circle(pos.x, pos.y, diameter);
    } else {
      playExplodingSound(); // afspil lyd

      
      explode(); // Tegn eksplosion i nedarvningen!
      
      
    }
  }

  void move() {
    // for at variere højden
    float yspeed = random(0.0001, 0.01);
    float xspeed = random(0.00001, 0.0005); // Begræns den vandrette hastighed

    if (!exploded) {

      pos.add(velocity);
      velocity.y += yspeed;
      velocity.x += xspeed;
      checkExplosion();
    }
  }

  void checkExplosion() {
    // Tjek om raketten er på vej nedad og har nået minimumshøjden
    if ((velocity.y > 0 || pos.x > width - 20 || pos.x < 20) && pos.y < minHeight) {
      exploded = true;
    }
  }

  void explode() {} // metode til overwirte
   
  
}


/**********************************************/

class MyRocket extends Rocket{
    @Override
  void explode() {
    // Tilføj eventuelle yderligere eksplosionseffekter her
  diameter+=1;
  alfa-=1;
    fill(r, g, b, alfa);
    ellipse(pos.x, pos.y, diameter * 2, diameter * 2);
    noStroke()
    
  ;  }
}
/**********************************************/

class Marc755c extends Rocket {
  // Attributter til stjerneeffekt
  int numStars = 10; // Antal stjerner i eksplosionen
  float[] starSizes = new float[numStars];
  PVector[] starPositions = new PVector[numStars];
  
  Marc755c() {
    // Initialiser tilfældige stjernestørrelser og positioner relativt til rakettens position
    for (int i = 0; i < numStars; i++) {
      starSizes[i] = random(5, 15);
      float angle = random(TWO_PI);
      float radius = random(10, 50);
      starPositions[i] = new PVector(cos(angle) * radius, sin(angle) * radius);
    }
  }

  @Override
  void explode() {
    // Eksplosionslogik for stjerner
    for (int i = 0; i < numStars; i++) {
      float expansionSpeed = random(0.1, 1.5);
      starPositions[i].x *= 1 + expansionSpeed * 0.01;
      starPositions[i].y *= 1 + expansionSpeed * 0.01;

      // Tegn hver stjerne
      float starX = pos.x + starPositions[i].x;
      float starY = pos.y + starPositions[i].y;

      fill(r, g, b, alfa);
      noStroke();
      beginShape();
      for (int j = 0; j < 5; j++) {
        float angle = radians(j * 72);
        float x = cos(angle) * starSizes[i] + starX;
        float y = sin(angle) * starSizes[i] + starY;
        vertex(x, y);
        angle += radians(36);
        x = cos(angle) * (starSizes[i] / 2) + starX;
        y = sin(angle) * (starSizes[i] / 2) + starY;
        vertex(x, y);
      }
      endShape(CLOSE);
    }
    
    // Reducer alfa for fade-out effekt
    alfa -= 1;
  }
}
