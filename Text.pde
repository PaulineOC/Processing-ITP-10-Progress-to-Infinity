class Text {

  //Different languages arrays that must be converted into stringsList
  String [] EnglishArray = {
    "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten"
  };
  StringList English = new StringList(EnglishArray);
  String [] GermanArray = {
    "eins", "zwei", "drei", "vier", "funf", "sechs", "sieben", "acht", "neun", "zehn"
  };
  StringList German = new StringList(GermanArray);
  String [] FrenchArray = {
    "un", "deux", "trois", "quatre", "cinq", "six", "sept", "huit", "neuf", "dix"
  };
  StringList French = new StringList(FrenchArray);
  String [] HindiArray = {
    "ek", "do", "teen", "char", "panch", "chech", "saat", "aath", "nau", "das"
  };
  StringList Hindi = new StringList(HindiArray);
  String [] JapaneseArray = {
    "ichi", "ni", "san", "yon", "go", "roku", "nana", "hatchi", "kyu", "ju"
  };
  StringList Japanese = new StringList(JapaneseArray);
  String [] MandarinArray= {
    "yi", "er", "san", "si", "wu", "liu", "qi", "ba", "jiu", "shi"
  };
  StringList Mandarin = new StringList(MandarinArray);
  String [] ItalianArray = {
    "uno", "due", "tre", "quattro", "cinque", "sei", "sette", "otto", "nove", "dieci"
  };
  StringList Italian = new StringList(ItalianArray);
  String [] SpanishArray = {
    "uno", "dos", "tres", "cuatro", "cinco", "seis", "siete", "ocho", "nueve", "diez"
  };
  StringList Spanish = new StringList(SpanishArray);
  String [] RegularNumbersArray = {
    "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"
  };
  StringList RegularNumbers = new StringList(RegularNumbersArray);
  String [] BinaryArray = {
    "1", "10", "11", "100", "101", "110", "111", "1000", "1001", "1010"
  };
  StringList Binary = new StringList(BinaryArray);
  String [] SwahiliArray = {
    "moja", "mbili", "tatu", "nne", "tano", "sita", "saba", "nane", "tisa", "kumi"
  };


  PFont basic_font = loadFont("ACaslonPro-Regular-32.vlw");

  float x;
  float y;
  float velocity_x;
  float velocity_y;
  float text_height;
  float text_width;
  String words;
  int which_language;
  int index;
  int red;
  int green;
  int blue;

  //Constructor for load screen/win
  Text(String input, int fontsize) {
    x = width / 2;
    y = height / 4;
    textFont(basic_font);
    words = input;
    textSize(fontsize);
    textAlign(LEFT);
  }


  //Constructor for regular game:
  Text(int language, int number) {
    x = random(0,width+1 - text_width);
    y = random(0, height+1 - text_height);
    velocity_x = random(0,6);
    velocity_y = random(1,6);

    which_language = language;
    index = number;
  }


  void drawText() {
    fill(red, green, blue);
    String word="";
    switch(which_language) {
    case 1: 
      word = EnglishArray[index];
      break;
    case 2:
      word = GermanArray[index];
      break;
    case 3:
      word = FrenchArray[index];
      break;
    case 4:
      word = HindiArray[index];
      break;
    case 5:
      word = MandarinArray[index];
      break;
    case 6:
      word = ItalianArray[index];
      break;
    case 7:
      word = SpanishArray[index];
      break;
    case 8:
      word = RegularNumbersArray[index];
      break;
    case 9:
      word = BinaryArray[index];
      break;
    case 10:
      word = SwahiliArray[index];
      break;
    }
    text(word, x,y);
    textFont(basic_font);
    textSize(25);
    textAlign(LEFT);
    text_height = textDescent() + textAscent();
    text_width = textWidth(word);
    

  } // End of Draw

  void moveText() {
    x+= velocity_x;
    y+= velocity_y;
  }

  //MOVEMENT 
  boolean checkBoundaries() {
    boolean out_of_bounds = false;
    //Out of screen (horizontal)
    if (x>(width+(text_width))|| x < (0 - (text_width))) {
      out_of_bounds = true;
    }

    //Out of screen (vertical)
    if (y>(height+(text_height)) || y < (0 - (text_height))) {
      out_of_bounds = true;
    }
    return out_of_bounds;
  }

  void move_back_text() {
    //Will randomize the side from which the text returns
    //Will maintain the same magnitude of velocity
    /* Must figure out magnitude from original x and y velocities
     Then use magnitude to determine the new velocities 
     Use random to find new angle of reentry (radians)
     magintude SIN (theta) = y
     magnitude COS (theta) = X
     */

    float theta = random(.1*PI, .9*PI);

    float magnitude = 0;
    magnitude = sqrt((float)(Math.pow(velocity_x, 2))+(float)(Math.pow(velocity_y, 2)));
    int side = (int) random(1, 5);
    switch (side) {
      //Top
    case 1: 
      y = 0 - text_height; 
      x = width/2;
      velocity_y = (magnitude * sin(theta)); 
      velocity_x = (magnitude * cos(theta)); 
      break;

      //Bottom
    case 2:
      y = height + text_height;
      x = 450;
      velocity_y = -(magnitude * sin(theta)); 
      velocity_x = (magnitude * cos(theta));
      break;

      //Left
    case 3:
      y = 375;
      x = 0 - text_width;
      velocity_y = (magnitude * sin(theta)); 
      velocity_x = (magnitude * cos(theta));
      break;
      //Right
    case 4:
      y = 375;
      x = width + text_width;
      velocity_y = (magnitude * sin(theta)); 
      velocity_x = -(magnitude * cos(theta));
      break;
    }
  }
  

  //COLLISION

boolean check_Collision(Shape temporary) {
    boolean signal = false;

    int temp_shape_height = temporary.get_shape_Height();
    int temp_shape_width = temporary.get_shape_Width();
    float temp_x = temporary.get_X_Position()-temp_shape_width/2;
    float temp_y = temporary.get_Y_Position()-temp_shape_height/2;
    if (x < (temp_x + temp_shape_width) && (x+text_width) > (temp_x )) {   
      if (y < (temp_y + temp_shape_height) && (y+text_height) > (temp_y )) {
        signal = true;
      }
      else {
        signal = false;
      }
    }
    return signal;
  }

void set_text_color(int _red, int _green, int _blue){
  red = _red; 
  green = _green;
  blue = _blue;
}


}//End of text

