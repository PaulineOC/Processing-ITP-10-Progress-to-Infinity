class Shape {
  float x;
  float y;
  int velocity_x;
  int velocity_y;
  int radius; 
  float new_x;
  float new_y;
  int magnitude = 2;
  int shape_height = radius * 2;
  int shape_width = radius * 2; 
  int red;
  int green;
  int blue;
  
  PShape player;

  //Stages of Win:
  boolean win = false;


  //Constructor: 
  Shape() {
    velocity_x = 4;
    velocity_y=0;
    radius = 60;
    shape_height = radius * 2;
    shape_width = radius * 2;
  }
  void drawShape1() {
    fill(red,green,blue);
    ellipse(x, y, 8, 8);
  }
void drawLine(){
  fill(red, green, blue);
  line(x-(radius/2), y,x+(2 * radius),y);
  ellipse(x,y, 2,2);
}
  void drawShape2(int number_of_sides) {
    FloatList new_x_coords;
    new_x_coords = new FloatList();
    FloatList new_y_coords;
    new_y_coords = new FloatList();
    float angle = 0;

//FILL ARRAY WITH VERTEXES 
    for (int i=0;i<number_of_sides; i++) {
      new_x = cos(angle) * radius;
      new_y = sin(angle) * radius;
      new_x_coords.append(new_x);
      new_y_coords.append(new_y);
      angle+= ((2*PI)/(number_of_sides));
    }
    
    player = createShape();
    player.beginShape();
    for (int i = 0; i<new_x_coords.size(); i++){
    player.vertex(new_x_coords.get(i), new_y_coords.get(i));}
    player.endShape();
    player.setStroke(color(0));
    player.setFill((color(red,green,blue)));
    shapeMode(CENTER);
    shape(player, x, y);

  } //End of drawing shape again


  //Set velocity:
  void set_x_velocity(int direction ) {
    velocity_x = direction * magnitude;
  }

  void set_y_velocity(int direction ) {
    velocity_y = direction * magnitude;
  }

  void set_magnitude(int potentiometer_input) {
    magnitude = potentiometer_input;
  }

  //MOVEMENT
  void moveShape() {
    x+= velocity_x;
    y+= velocity_y;
  }


  boolean checkBoundaries() {
    boolean out_of_bounds = false;
    //Out of screen (horizontal)
    if (x>(width+(shape_width))|| x < (0 - (shape_width))) {
      out_of_bounds = true;
    }

    //Out of screen (vertical)
    if (y>(height+(shape_height)) || y < (0 - (shape_height))) {
      out_of_bounds = true;
    }
    return out_of_bounds;
  }
  void move_back() {
    if (y < 0 - shape_height) {
      y = height;
    }
    else if (y > height+shape_height) {
      y = 0;
    }

    else if (x < 0 - shape_width) {
      x = width;
    }
    else if (x>width+shape_width) {
      x = 0;
    }
  }

  //Getters:
  float get_X_Position() {
    return x;
  }
  float get_Y_Position() {
    return y;
  }
  int get_shape_Height() {
    return shape_height;
  }

  int get_shape_Width() {
    return shape_width;
  }

  boolean get_win() {
    return win;
  }

  //Setters: 
  void set_Position(float x, float y, int x_v) {
    this.x  = x;
    this.y =y;
    this.velocity_x = x_v;
  }

void set_color(int _red, int _green, int _blue){
  red = _red;
  green = _green;
  blue = _blue;
}
  //WINNER:
  void win_reset() {
    x = 0+shape_width;
    y = height / 2;
    velocity_x = 2;
    velocity_y = 0;
  }

  void drawCircle() {
    fill(red, green, blue);
    ellipse(x, y, radius*2, radius*2);
  }

  void win_animation() {
    if (x < width / 5) {
      this.drawShape2(10);
      this.moveShape();
    }

    else if (x < (2*(width / 5)) && x >= (width / 5)) {
      this.drawShape2(14);
      this.moveShape();
    }

    else if (x < (3*(width / 5)) && x >= (2*width) / 5) {
      this.drawShape2(18);
      this.moveShape();
    }

    else if (x < (4*(width / 5)) && x >= (3*width) / 5) {
      this.drawShape2(22);
      this.moveShape();
    }
    else if (x < width && x >=  (4*(width / 5))) {
      this.drawCircle();
      this.moveShape();
      if (x == width - 60) {
        velocity_x=0;
        if (radius< 1010) {
          radius+=10;
        }
        else if (radius == 1010) {
          win = true;
        }//end of win sign
      }//side of screen
    }//end of last else-if
  }//win animation
}//End of class

