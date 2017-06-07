//import ddf.minim.analysis.*;
import ddf.minim.*;
//import processing.sound.*;

AudioPlayer             song;
Minim                   minim;

int cols, rows;
int scale = 20;
int w = 3200; 
int h = 1600;

float flying = 0;
float[][] terrain;

void setup(){
	size(1200, 675, P3D);

  minim = new Minim(this);
  
  song = minim.loadFile("shelter.mp3", 1024);
    
	cols = w / scale;
	rows = h / scale;
	terrain = new float[cols][rows];
  
}

void keyPressed(){
  if(song.isPlaying())
    song.pause();
  else
    song.play();
}

void draw() {
  
  flying -= 0.05;
    
  float yOff = flying;
  for(int y = 0; y < rows; y++){
    float xOff = song.bufferSize();
    for(int x = 0; x < cols; x++){
      float level = (song.left.level() + song.right.level())/2;
      terrain[x][y] = map(noise(xOff, yOff), 0, 1, -level*w/4, level*w/4);
        xOff+= 0.1;
    }
    yOff += 0.1;
  }
  
	background(0);
  stroke(255);
	noFill();

	translate(width/2, height/2 + 50);
	rotateX(PI/3);

	translate(-w/2, -h/2);
	for(int y = 0; y < rows - 1; y++){
		beginShape(TRIANGLE_STRIP);
		for(int x = 0; x < cols; x++){
			vertex(x*scale, y*scale, terrain[x][y]);
			vertex(x*scale, (y+1)*scale, terrain[x][y+1]);
		}
		endShape();
	}
}