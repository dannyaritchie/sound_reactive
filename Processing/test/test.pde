////import java.lang.Math;


Table table;
IntList column;

int frame = 0;
int counter = 0;
int fade = 100;

int no_frames = 500;
int frame_dur = 50; // ms

int total_len_ms = no_frames*frame_dur; // total length of song in ms
float total_len_s = total_len_ms/1000;

float fps = no_frames/total_len_s;


void setup() {
  
  size(800,800);
  background(0);

  table = loadTable("data.csv", "header");
  
  column = table.getIntList("Beat activation");

  println(table.getRowCount() + " total rows in table");

  for (TableRow row : table.rows()) {

    String beat = row.getString("Beat activation");

    println(beat);
  }

}

void draw(){
  
  background(0);
  
  int val = column.get(frame);
  
  println(fade);
  stroke(255);
  fill(200,0,0);
  circle(400,400,fade);
  
  if (val == 1){
    counter+=1;
    println(val);
    stroke(255);
    fill(255);
    if (counter == 0 || counter%8 == 0){
      fade = 100;
    } 
    stroke(255);
    fill(255);
    circle(400,400,100);
  }
  
  fade+=5;
  
  //delay(100);
  frame+=1;
  
  //println(fps);
  
  saveFrame("frames6/frame-####.png");
  
}
