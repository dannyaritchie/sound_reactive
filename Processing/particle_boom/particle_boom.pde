////import java.lang.Math;


Table table;
IntList beat;

int frame = 0;
int counter = 0;
int fade = 100;

int no_frames = 500;
int frame_dur = 50; // ms

int total_len_ms = no_frames*frame_dur; // total length of song in ms
float total_len_s = total_len_ms/1000;

float fps = no_frames/total_len_s;

ParticleBoom boom;


void setup() {
  
  size(800,800, P3D);
  background(0);
  colorMode(HSB,100,100,100);
  //noLoop();

  table = loadTable("data.csv", "header"); 
  beat = table.getIntList("Beat activation");
  println(table.getRowCount() + " total rows in table");
  
  boom = new ParticleBoom(width, height, beat);

}


void draw(){
  
  background(0);
  
  //int val = beat.get(frame);
  
  //boom.testing();
  //delay(500);
  boom.display(frame);
  
  frame+=1;
  println(frame);
  
  saveFrame("frames6/frame-####.png");
}
