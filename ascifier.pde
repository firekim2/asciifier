import com.hamoid.*;

VideoExport videoExport;

import processing.video.*;
Movie myMovie;
int resolution = 16;
char[] ascii;
 
void setup() {
  myMovie = new Movie(this, "1.mov");
  myMovie.loop();
  size(1080,720);
  ascii = new char[256];
  String letters = " .,:;ioO$#@NSM";
  for (int i = 0; i < 256; i++) {
    int index = int(map(i, 0, 256, 0, letters.length()));
    ascii[i] = letters.charAt(index);
  }
  println(myMovie.height);
  background(0);
  fill(255);
  noStroke();
  frameRate(10);

  //Should install ffmpeg first to save file.
  //videoExport = new VideoExport(this, "output/output.mp4");
  //videoExport.startMovie();
}

void draw(){
  myMovie.loadPixels();
  background(0);
  PFont mono = createFont("Courier", resolution + 2);
  textFont(mono);
  asciify();
  //videoExport.saveFrame();
}
 
void asciify() {
  for (int y = 0; y < myMovie.height; y += resolution) {
    for (int x = 0; x < myMovie.width; x += resolution) {
      int brightness = 0;
      for ( int i = 0 ; i < resolution; i ++){
        for( int j = 0 ; j < resolution; j ++){
          color c = myMovie.get((x+i), (y + j));
          brightness += brightness(c);
        }
      }
      brightness /= resolution * resolution ;
      text(ascii[brightness], x, y);
    }
  }
}

void movieEvent(Movie m) {
  m.read(); 
}

void keyPressed() {
  if (key == 'q') {
    videoExport.endMovie();
    exit();
  }
}