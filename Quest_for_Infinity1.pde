import processing.serial.*;
Serial myPort;



import processing.video.*;
Movie endMovie;


int pot1;
int pot2;
int pot3;
int converted1;
int converted2;
int converted3;


Shape player_1;
Shape player_2;
Text opening;


ArrayList<Text>player1text;
ArrayList<Text>player2text;

//OPENING:

PFont type;

//Beginning: 
boolean start;

boolean player_1_choice;
boolean player_2_choice;
int final_red1;
int final_green1;
int final_blue1;
int final_red2;
int final_green2;
int final_blue2;



//GAME
boolean game_on;
int level_count1= 9; 
int level_count2 = 1;
boolean level_start;
boolean level_start2;


//WINNING:
boolean finish;
Boolean win1;
Boolean win2;
boolean win_keys;
boolean win_reset1;
boolean win_reset2;
boolean win_text1;
boolean win_text2;



void setup() {
  size(1000, 700,P2D);

  //Beginning:
  start = true;
  game_on = false; 
  type = loadFont("Cochin-48.vlw");
  boolean player_1_choice = true;
  boolean player_2_choice = false;
  int final_red1=0;
  int final_green1=0;
  int final_blue1=0;
  int final_red2=0;
  int final_green2=0;
  int final_blue2=0;

  //Gameplay:
  level_start = false;
  level_start2 = false;
  player_1 = new Shape();
  player_1.set_Position(200,300,4);
  player_2 = new Shape();
  player_2.set_Position(800,300,-4);

  player1text = new ArrayList<Text>();
  player2text = new ArrayList<Text>();
  //Only for level 1:
  for (int i = 0;i<2;i++) {
    player1text.add(new Text((int)random(1, 11), 1));
    player1text.get(i).set_text_color(final_red1, final_green1, final_blue1);
    player2text.add(new Text((int)random(1, 11), 1));
    player2text.get(i).set_text_color(final_red2, final_green2, final_blue2);

  }


  //Winning:
  finish = false;
  win1 = false;
  win2=  false;
  win_keys = false;
  win_reset1 = false;
  win_reset2 = false;
  win_text1 = false;
  win_text2 = false;
  endMovie=  new Movie(this, "end.mov");



 //ARDUINO --> PROCESSING: 
  println(Serial.list());
  String portName = Serial.list()[5];
  myPort = new Serial(this, portName, 9600);
 myPort.readStringUntil('\n');
}//End of setup


void draw() {
  background(255);

  if (start) {
    background(255);
    fill(0);
    textFont(type, 36);
    text("Welcome to the beginning of infinity.\n Please press the '1' to begin color selection for player 1.\n Mouse click to re-orient the dial inputs.", width/10, height /4);
    
    if (player_1_choice) {
      background(255);
      text("Player 1: please select color by turning each dial. \n Press '2' to save your selection and let Player 2 choose.", width/9, height/4);
      final_red1 = converted1;
      final_green1 = converted3;
      final_blue1 = converted2;
      fill(final_red1, final_green1, final_blue1);
      rect(100, height/2, 200, 200);
    }
    else if (player_2_choice) {
      background(255);
      text("Player 2: please select your color by turning the dial.\n To begin the game press 'ENTER'", width/8, height/4);
      final_red2 = converted1;
      final_green2 = converted3;
      final_blue2 = converted2;
      fill(final_red2,final_green2, final_blue2);
      rect(700, height/2, 200, 200);
      
    }
  }

  //game start
  if (game_on) {

    //PLAYER 1 SWITCH
    switch (level_count1) {
    case 1:
      player_1.drawShape1();
       ;
      player_1.moveShape();
      if (player_1.checkBoundaries()) {
        player_1.move_back();
      }
      //TEXT
      for (int i = 0;i<player1text.size();i++) {
        player1text.get(i).set_text_color(final_red1, final_green1, final_blue1);
        player1text.get(i).drawText();
        player1text.get(i).moveText();
        if (player1text.get(i).checkBoundaries()) {
          player1text.get(i).move_back_text();
        }
        if (player1text.get(i).check_Collision(player_1)) {
          player1text.remove(i);
          i--;

          if (player1text.isEmpty()) {
            level_count1++;
            level_start = true;
          }
        }
      }

      break;
    case 2:
      player_1.drawLine();
       ;
      player_1.moveShape();
      if (player_1.checkBoundaries()) {
        player_1.move_back();
      }
      //Text
      if (level_start) {
        for (int i = 0;i<3;i++) {
          player1text.add(new Text((int)random(1, 11), 2));
        }
        for (int i = 0; i<3; i++) {
          player1text.get(i).set_text_color(final_red1, final_green1,final_blue1);
      }
        level_start = false;
      }
      for (int i = 0;i<player1text.size();i++) {
        player1text.get(i).drawText();
        player1text.get(i).moveText();
        if (player1text.get(i).checkBoundaries()) {
          player1text.get(i).move_back_text();
        }
        if (player1text.get(i).check_Collision(player_1)) {
          player1text.remove(i);
          i--;

          if (player1text.isEmpty()) {
            level_count1++;
            level_start = true;
          }
        }
      }
      break;
    case 3:
      player_1.drawShape2(3);
      player_1.moveShape();
      if (player_1.checkBoundaries()) {
        player_1.move_back();
      }
      //Text
      if (level_start) {
        for (int i = 0;i<4;i++) {
          player1text.add(new Text((int)random(1, 11), 3));
        }
        for (int i = 0; i<4; i++) {
          player1text.get(i).set_text_color(final_red1, final_green1,final_blue1);
      }
        level_start = false;
      }
      
      for (int i = 0;i<player1text.size();i++) {
        player1text.get(i).drawText();
        player1text.get(i).moveText();
        if (player1text.get(i).checkBoundaries()) {
          player1text.get(i).move_back_text();
        }
        if (player1text.get(i).check_Collision(player_1)) {
          player1text.remove(i);
          i--;

          if (player1text.isEmpty()) {
            level_count1++;
            level_start = true;
          }
        }
      }
      break;
    case 4:
      player_1.drawShape2(4);
       ;
      player_1.moveShape();
      if (player_1.checkBoundaries()) {
        player_1.move_back();
      }
      //Text
      if (level_start) {
        for (int i = 0;i<5;i++) {
          player1text.add(new Text((int)random(1, 11), 4));
        }
        for (int i = 0; i<5; i++) {
          player1text.get(i).set_text_color(final_red1, final_green1,final_blue1);
      }
        level_start = false;
      }
      for (int i = 0;i<player1text.size();i++) {
        player1text.get(i).drawText();
        player1text.get(i).moveText();
        if (player1text.get(i).checkBoundaries()) {
          player1text.get(i).move_back_text();
        }
        if (player1text.get(i).check_Collision(player_1)) {
          player1text.remove(i);
          i--;

          if (player1text.isEmpty()) {
            level_count1++;
            level_start = true;
          }
        }
      }
      break;
    case 5:
      player_1.drawShape2(5);
       ;
      player_1.moveShape();
      if (player_1.checkBoundaries()) {
        player_1.move_back();
      }
      //Text
      if (level_start) {
        for (int i = 0;i<6;i++) {
          player1text.add(new Text((int)random(1, 11), 5));
        }
        for (int i = 0; i<6; i++) {
          player1text.get(i).set_text_color(final_red1, final_green1,final_blue1);
      }
        level_start = false;
      }
      for (int i = 0;i<player1text.size();i++) {
        player1text.get(i).drawText();
        player1text.get(i).moveText();
        if (player1text.get(i).checkBoundaries()) {
          player1text.get(i).move_back_text();
        }
        if (player1text.get(i).check_Collision(player_1)) {
          player1text.remove(i);
          i--;

          if (player1text.isEmpty()) {
            level_count1++;
            level_start = true;
          }
        }
      }
      break;
    case 6:
      player_1.drawShape2(6);
       ;
      player_1.moveShape();
      if (player_1.checkBoundaries()) {
        player_1.move_back();
      }
      //Text
      if (level_start) {
        for (int i = 0;i<7;i++) {
          player1text.add(new Text((int)random(1, 11), 6));
        }
        for (int i = 0; i<7; i++) {
          player1text.get(i).set_text_color(final_red1, final_green1,final_blue1);
      }
        level_start = false;
      }
      for (int i = 0;i<player1text.size();i++) {
        player1text.get(i).drawText();
        player1text.get(i).moveText();
        if (player1text.get(i).checkBoundaries()) {
          player1text.get(i).move_back_text();
        }
        if (player1text.get(i).check_Collision(player_1)) {
          player1text.remove(i);
          i--;

          if (player1text.isEmpty()) {
            level_count1++;
            level_start = true;
          }
        }
      }
      break;
    case 7:
      player_1.drawShape2(7);
       ;
      player_1.moveShape();
      if (player_1.checkBoundaries()) {
        player_1.move_back();
      }
      //Text
      if (level_start) {
        for (int i = 0;i<8;i++) {
          player1text.add(new Text((int)random(1, 11), 7));
        }
        for (int i = 0; i<8; i++) {
          player1text.get(i).set_text_color(final_red1, final_green1,final_blue1);
      }
        level_start = false;
      }
      for (int i = 0;i<player1text.size();i++) {
        player1text.get(i).drawText();
        player1text.get(i).moveText();
        if (player1text.get(i).checkBoundaries()) {
          player1text.get(i).move_back_text();
        }
        if (player1text.get(i).check_Collision(player_1)) {
          player1text.remove(i);
          i--;

          if (player1text.isEmpty()) {
            level_count1++;
            level_start = true;
          }
        }
      }
      break;
    case 8:
      player_1.drawShape2(8);
       ;
      player_1.moveShape();
      if (player_1.checkBoundaries()) {
        player_1.move_back();
      }
      //Text
      if (level_start) {
        for (int i = 0;i<9;i++) {
          player1text.add(new Text((int)random(1, 11), 8));
        }
        for (int i = 0; i<9; i++) {
          player1text.get(i).set_text_color(final_red1, final_green1,final_blue1);
      }
        level_start = false;
      }
      for (int i = 0;i<player1text.size();i++) {
        player1text.get(i).drawText();
        player1text.get(i).moveText();
        if (player1text.get(i).checkBoundaries()) {
          player1text.get(i).move_back_text();
        }
        if (player1text.get(i).check_Collision(player_1)) {
          player1text.remove(i);
          i--;

          if (player1text.isEmpty()) {
            level_count1++;
            level_start = true;
          }
        }
      }
      break;
    case 9:
      player_1.drawShape2(9);
       
      player_1.moveShape();
      if (player_1.checkBoundaries()) {
        player_1.move_back();
      }
      //Text
      if (level_start) {
        for (int i = 0;i<10;i++) {
          player1text.add(new Text((int)random(1, 11), 9));
        }
        for (int i = 0; i<10; i++) {
          player1text.get(i).set_text_color(final_red1, final_green1,final_blue1);
      }
        level_start = false;
      }
      for (int i = 0;i<player1text.size();i++) {
        player1text.get(i).drawText();
        player1text.get(i).moveText();
        if (player1text.get(i).checkBoundaries()) {
          player1text.get(i).move_back_text();
        }
        if (player1text.get(i).check_Collision(player_1)) {
          player1text.remove(i);
          i--;

          if (player1text.isEmpty()) {
            level_count1++;
            level_start = true;
          }
        }
      }
      break;
    case 10:
      game_on = false;
      finish = true;
      win1 = true;
      win_keys = true;
      win_reset1 = true;
      break;
    } // End of player 1

    //PLAYER 2
    switch (level_count2) {
    case 1:
      player_2.drawShape1();
      player_2.moveShape();
      if (player_2.checkBoundaries()) {
        player_2.move_back();
      }
      //TEXT
      for (int i = 0;i<player2text.size();i++) {
       player2text.get(i).set_text_color(final_red2, final_green2, final_blue2);
        player2text.get(i).drawText();
        player2text.get(i).moveText();
        if (player2text.get(i).checkBoundaries()) {
          player2text.get(i).move_back_text();
        }
        if (player2text.get(i).check_Collision(player_2)) {
          player2text.remove(i);
          i--;
          if (player2text.isEmpty()) {
            level_count2++;
            level_start2 = true;
          }
        }
      }
      break;
    case 2:
      player_2.drawLine();
      player_2.moveShape();
      if (player_2.checkBoundaries()) {
        player_2.move_back();
      }
      //Text
      if (level_start2) {
        for (int i = 0;i<3;i++) {
          player2text.add(new Text((int)random(1, 11), 2));
        }
        for (int i = 0; i<3; i++) {
          player2text.get(i).set_text_color(final_red2, final_green2,final_blue2);
      }
        level_start2 = false;
      }
      for (int i = 0;i<player2text.size();i++) {
        player2text.get(i).drawText();
        player2text.get(i).moveText();
        if (player2text.get(i).checkBoundaries()) {
          player2text.get(i).move_back_text();
        }
        if (player2text.get(i).check_Collision(player_2)) {
          player2text.remove(i);
          i--;

          if (player2text.isEmpty()) {
            level_count2++;
            level_start2 = true;
          }
        }
      }
      break;
    case 3:
      player_2.drawShape2(3);
        
      player_2.moveShape();
      if (player_2.checkBoundaries()) {
        player_2.move_back();
      }
      //Text
      if (level_start2) {
        for (int i = 0;i<4;i++) {
          player2text.add(new Text((int)random(1, 11), 3));
        }
        for (int i = 0; i<4; i++) {
          player2text.get(i).set_text_color(final_red2, final_green2,final_blue2);
      }
        level_start2 = false;
      }
      for (int i = 0;i<player2text.size();i++) {
        player2text.get(i).drawText();
        player2text.get(i).moveText();
        if (player2text.get(i).checkBoundaries()) {
          player2text.get(i).move_back_text();
        }
        if (player2text.get(i).check_Collision(player_2)) {
          player2text.remove(i);
          i--;

          if (player2text.isEmpty()) {
            level_count2++;
            level_start2 = true;
          }
        }
      }
      break;
    case 4:
      player_2.drawShape2(4);
        
      player_2.moveShape();
      if (player_2.checkBoundaries()) {
        player_2.move_back();
      }
      //TEXT
      //Text
      if (level_start2) {
        for (int i = 0;i<5;i++) {
          player2text.add(new Text((int)random(1, 11), 4));
        }
        for (int i = 0; i<5; i++) {
          player2text.get(i).set_text_color(final_red2, final_green2,final_blue2);
      }
        level_start2 = false;
      }
      for (int i = 0;i<player2text.size();i++) {
        player2text.get(i).drawText();
        player2text.get(i).moveText();
        if (player2text.get(i).checkBoundaries()) {
          player2text.get(i).move_back_text();
        }
        if (player2text.get(i).check_Collision(player_2)) {
          player2text.remove(i);
          i--;

          if (player2text.isEmpty()) {
            level_count2++;
            level_start2 = true;
          }
        }
      }
      break;
    case 5:
      player_2.drawShape2(5);
        
      player_2.moveShape();
      if (player_2.checkBoundaries()) {
        player_2.move_back();
      }
      //TEXT
      //Text
      if (level_start2) {
        for (int i = 0;i<6;i++) {
          player2text.add(new Text((int)random(1, 11), 5));
        }
        for (int i = 0; i<6; i++) {
          player2text.get(i).set_text_color(final_red2, final_green2,final_blue2);
      }
        level_start2 = false;
      }
      for (int i = 0;i<player2text.size();i++) {
        player2text.get(i).drawText();
        player2text.get(i).moveText();
        if (player2text.get(i).checkBoundaries()) {
          player2text.get(i).move_back_text();
        }
        if (player2text.get(i).check_Collision(player_2)) {
          player2text.remove(i);
          i--;

          if (player2text.isEmpty()) {
            level_count2++;
            level_start2 = true;
          }
        }
      }
      break;
    case 6:
      player_2.drawShape2(6);
        
      player_2.moveShape();
      if (player_2.checkBoundaries()) {
        player_2.move_back();
      }
      //Text
      if (level_start) {
        for (int i = 0;i<7;i++) {
          player2text.add(new Text((int)random(1, 11), 6));
        }
        for (int i = 0; i<7; i++) {
          player2text.get(i).set_text_color(final_red2, final_green2,final_blue2);
      }
        level_start2 = false;
      }
      for (int i = 0;i<player2text.size();i++) {
        player2text.get(i).drawText();
        player2text.get(i).moveText();
        if (player2text.get(i).checkBoundaries()) {
          player2text.get(i).move_back_text();
        }
        if (player2text.get(i).check_Collision(player_2)) {
          player2text.remove(i);
          i--;

          if (player2text.isEmpty()) {
            level_count2++;
            level_start2 = true;
          }
        }
      }
      break;
    case 7:
      player_2.drawShape2(7);
      player_2.moveShape();
      if (player_2.checkBoundaries()) {
        player_2.move_back();
      }
      //Text
      if (level_start) {
        for (int i = 0;i<8;i++) {
          player2text.add(new Text((int)random(1, 11), 7));
        }
        for (int i = 0; i<8; i++) {
          player2text.get(i).set_text_color(final_red2, final_green2,final_blue2);
      }
        level_start2 = false;
      }
      for (int i = 0;i<player2text.size();i++) {
        player2text.get(i).drawText();
        player2text.get(i).moveText();
        if (player2text.get(i).checkBoundaries()) {
          player2text.get(i).move_back_text();
        }
        if (player2text.get(i).check_Collision(player_2)) {
          player2text.remove(i);
          i--;
          if (player2text.isEmpty()) {
            level_count2++;
            level_start2 = true;
          }
        }
      }
      break;
    case 8:
      player_2.drawShape2(8);
        
      player_2.moveShape();
      if (player_2.checkBoundaries()) {
        player_2.move_back();
      }
      //Text
      if (level_start2) {
        for (int i = 0;i<9;i++) {
          player2text.add(new Text((int)random(1, 11), 8));
        }
        for (int i = 0; i<9; i++) {
          player2text.get(i).set_text_color(final_red2, final_green2,final_blue2);
      }
        level_start2 = false;
      }
      for (int i = 0;i<player2text.size();i++) {
        player2text.get(i).drawText();
        player2text.get(i).moveText();
        if (player2text.get(i).checkBoundaries()) {
          player2text.get(i).move_back_text();
        }
        if (player2text.get(i).check_Collision(player_2)) {
          player2text.remove(i);
          i--;

          if (player2text.isEmpty()) {
            level_count2++;
            level_start2 = true;
          }
        }
      }
      break;
    case 9:
      player_2.drawShape2(9);
      player_2.moveShape();
      if (player_2.checkBoundaries()) {
        player_2.move_back();
      }
      //Text
      if (level_start2) {
        for (int i = 0;i<10;i++) {
          player2text.add(new Text((int)random(1, 11), 9));
        }
        for (int i = 0; i<10; i++) {
          player2text.get(i).set_text_color(final_red2, final_green2,final_blue2);
      }
        level_start2 = false;
      }
      for (int i = 0;i<player2text.size();i++) {
        player2text.get(i).drawText();
        player2text.get(i).moveText();
        if (player2text.get(i).checkBoundaries()) {
          player2text.get(i).move_back_text();
        }
        if (player2text.get(i).check_Collision(player_2)) {
          player2text.remove(i);
          i--;

          if (player2text.isEmpty()) {
            level_count2++;
            level_start2 = true;
          }
        }
      }
      break;
    case 10:
      game_on = false;
      finish = true;
      win2 = true;
      win_keys = true;
      win_reset2 = true;
      break;
    } // End of player 2
  }// End of game_on

  //WINNERS: 
  else if (finish) {
    //player 1 win:
    if (win1) {
      if (win_reset1) {
        player_1.win_reset();
        win_reset1 = false;
      }
      player_1.win_animation();
      if (player_1.get_win()) {
        image(endMovie, width/2, height/2);
        endMovie.play();
        textFont(type, 32);
        fill(255);
        text("To Infinity and Beyond", 500, 300);
      }
      
    }//play1win

    //player 2 win:
    
    if (win2) {
      if (win_reset2) {
        player_2.win_reset();
        win_reset1 = false;
      }
      player_2.win_animation();
      if (player_2.get_win()) {
        textFont(type, 32);
        fill(255);
        text("To Infinity and Beyond", 500, 300);
        image(endMovie, width/2, height/2);
        endMovie.play();
      }
    }//play1win
    
    
    
    
    
    
  }//end of finish
}// End of Draw



void keyPressed() {

  if (start) {
    if (key=='1'){
      player_1_choice = true;
    
    }
    if (key=='2') {
      player_1.set_color(final_red1, final_green1, final_blue1);
      player_1_choice = false;
      player_2_choice = true;
    }
    else if (key==ENTER && player_2_choice == true) {
      player_2.set_color(final_red2, final_green2, final_blue2);
      start = false;
      game_on = true;
    }
  }//end of if start


  if (win_keys==false) {

    if (key==CODED) {
      if (keyCode == UP) {
        player_1.set_y_velocity(-2);
        player_1.set_x_velocity(0);
      }
      else if (keyCode == DOWN) {
        player_1.set_y_velocity(2);
        player_1.set_x_velocity(0);
      }
      else if (keyCode == RIGHT) {
        player_1.set_x_velocity(2);
        player_1.set_y_velocity(0);
      }
      else if (keyCode == LEFT) {
        player_1.set_x_velocity(-2);
        player_1.set_y_velocity(0);
      }
    } //end of key code

    else if (key=='a') {
      player_2.set_x_velocity(-2);
      player_2.set_y_velocity(0);
    }
    else if (key=='d') {
      player_2.set_x_velocity(2);
      player_2.set_y_velocity(0);
    }
    else if (key=='w') {
      player_2.set_y_velocity(-2);
      player_2.set_x_velocity(0);
    }
    else if (key=='s') {
      player_2.set_y_velocity(2);
      player_2.set_x_velocity(0);
    }
  }
}//End of keyPress


void serialEvent(Serial _port) { //this is a callback function
  if (myPort == null) return;  //this is a hack to cover a bug where the port does not get set up in time.  
  ///this says if the port is not set up yet, bail (for now.) 
  String input = myPort.readStringUntil('\n');
  if (input != null) {  //if a '\n' character has in fact now arrived
    String [] dual_inputs = split(input, ",");
   input = input.trim();  //Take off the '\n' character
    pot1 = int(dual_inputs[0]);  //Turn it into number
    pot2 = int(dual_inputs[1]); 
    pot3 = int(dual_inputs[2]);
    converted1 = (int)map(pot1, 0, 1024, 0, 256);
   converted2 = (int)map(pot2, 0, 1024, 0, 256);
    converted3= (int)map(pot3, 0, 1024, 0, 256);
    println(converted1, converted3, converted2);
    myPort.write("Go");
  }
}//END OF KEY EVENT

void mousePressed(){
myPort.write("A");
}

void movieEvent(Movie m){
  m.read();
}


