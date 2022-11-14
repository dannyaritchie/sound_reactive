
// Class for an effect where particles expand and contract in beat to the music
// some parameter ideas:
// number of particles
// centre sphere size
// rotation speed
// how evenly distributed the particles are

// When there is a beat, then expand over the next x frames.  Then over the remaining frames until the next beat, slowly contract. 

// Will have to give the object instance the beat IntList when it is created, so we can calculate spacings between beats
// For all effect classes, we want the .display() method to only take the current frame as input

class ParticleBoom{
  
  int min_radius = 100; // radius when all particles are contracted
  int no_particles = 700; // number of points
  float[] max_extend = new float[no_particles]; // each particle will be assign a max_extent to determine the max distance it can move out
  float[] x_position = new float[no_particles];
  float extender; // extender will move the particles outwards and inwards in time with the sound
  int screen_width;
  int screen_height;
  float x_sphere_centre;
  float y_sphere_centre;
  float z_sphere_centre = 0;
  int sphere_radius = 50;
  int extend;
  float[] expansion_percent;
  PVector[] displacement_vectors = new PVector[no_particles];
  
  int[] dist_from_1;
  int[] dist_to_1;
  
  int counter = 0;
  
  ParticleBoom(int wide, int high, IntList beat){
    screen_width = wide;
    screen_height = high;
    
    x_sphere_centre = screen_width/2;
    y_sphere_centre = screen_height/2;

    extend = screen_height/3;
    
    for (int i=0; i<no_particles; i++){
      max_extend[i] = random(0,extend);
    }
    
    PVector centre = new PVector(x_sphere_centre, y_sphere_centre, z_sphere_centre);
    
    for (int i=0; i<no_particles; i++){
      float x = random(-1,1);
      float y = random(-1,1);
      float z = random(-1,1);
      PVector displacement = new PVector(x,y,z);
      displacement.setMag(sphere_radius);
      displacement_vectors[i] = displacement;
    }

    

    // create array that tells us for each frame how many frame from the last 1
    dist_from_1 = new int[beat.size()];
    for (int i=0; i<beat.size(); i++){
      int value = beat.get(i);
      if (value==1){
        dist_from_1[i] = 0;
      }
      else if(value==0){
        counter = 0;
        for (int j=0; j<i; j++){ // j should equal length of stuff before i
          int check = beat.get(i-j);
          if (check == 1){ // we have reached the last 1; counter will tell us how many steps back we have gone to find a 1
            dist_from_1[i] = counter; 
            break;
          } 
          counter+=1;
        }  
      }
    }
    
    // create array that tells us for each frame how many frame until the next 1
    dist_to_1 = new int[beat.size()];
    for (int i=0; i<beat.size(); i++){
      int value = beat.get(i);
      if (value==1){
        dist_to_1[i] = 0;
      }
      else if(value==0){
        counter = 0;
        for (int j=0; j<beat.size()-i; j++){
          int check = beat.get(i+j);
          if (check == 1){ // we have reached the last 1; counter will tell us how many steps back we have gone to find a 1
            dist_to_1[i] = counter; 
            break;
          }
          counter+=1;
        }  
      }
    }
    
    int max_dist_from = 3;
    expansion_percent = new float[beat.size()];
    //int max_dist_to = max(dist_to_1);
    int max_dist_to_for_beat = 0;
    for (int i=0; i<beat.size(); i++){
      int value = beat.get(i);
      int dist_to = dist_to_1[i];
      int dist_from = dist_from_1[i];
      if (value == 1){
        expansion_percent[i] = 0;
      }
      else {
        if (dist_from == 0 || dist_to == 0){
          expansion_percent[i] = 0;
        }
        else if (dist_from <= max_dist_from){  
          expansion_percent[i] = map(dist_from,0,max_dist_from,0,1);
        }
        else if (dist_from == max_dist_from+1){
          max_dist_to_for_beat = dist_to;
          expansion_percent[i] = map(dist_to,0,max_dist_to_for_beat,0,1);
        }
        else {
          expansion_percent[i] = map(dist_to,0,max_dist_to_for_beat,0,1);
        }
        
      }

    }
    
  }
  
  
  void testing(){
    println("Dist_from_1:");
    println(dist_from_1);
    println("Dist_to_1:");
    println(dist_to_1);
    print("Expansion_percent");
    for (int i=0; i<expansion_percent.length; i++){
      println(expansion_percent[i]);
    }

  }
  
  void display(int frame){
    
    
    
    // have xyz PVector for displacement of point from the centre of the circle.
    // all displacement vectors will simply have the same magnitude.  
    // then any given point is given by position vector of the centre + displacement vector
    // to generate displacement vector, choose any random x, y, z float between -1 and 1 and then adjust the vector magnitude to equal the sphere radius
    
    
    for (int i=0; i<no_particles; i++){
      PVector displacement = displacement_vectors[i];
      displacement.setMag(sphere_radius+(max_extend[i]*expansion_percent[frame]));
      //float x = x_sphere_centre + displacement.x;
      //float y = y_sphere_centre + displacement.y;
      //float z = z_sphere_centre + displacement.z;

      pushMatrix();
      translate(x_sphere_centre, y_sphere_centre, z_sphere_centre);
      rotateY(map(frame,0,500,0,2*PI));
      rotateX(map(frame,0,500,0,PI));
      translate(displacement.x, displacement.y, displacement.z);
      noStroke();
      fill(map(i,0,no_particles,0,100),200,200);
      sphere(2);
      popMatrix();
      
    }
    
  }
  
}
