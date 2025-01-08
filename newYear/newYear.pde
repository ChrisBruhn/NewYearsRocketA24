import processing.sound.*; // importer lydbibliotek

SoundFile fireRocket; 
SoundFile multiRocket;
SoundFile singleRocket;


int listSize = 20;
Rocket[] rocketBattery = new Rocket[listSize];


void setup() {

  size(1200, 800);
  background (0);
  for (int i =0; i<rocketBattery.length; i++) {
    rocketBattery[i] = new MyRocket();
  }
  
  fireRocket = new SoundFile(this, "start.mp3");
  multiRocket = new SoundFile(this, "multiRaket.mp3");
  singleRocket = new SoundFile(this, "raket1.mp3");
  
  // for at undgå at den bliver afspillet 60x i sek
  fireRocket.play(); // Afspil startlyd når raketten begynder at bevæge sig
}

void draw() {
  background (0);
  
  for (int i =0; i<rocketBattery.length; i++) {
  rocketBattery[i].display();
  rocketBattery[i].move();
  }
  
}
