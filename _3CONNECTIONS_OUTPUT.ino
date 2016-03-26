void setup(){
  Serial.begin(9600);
}

void loop(){
  int  force= analogRead(5);
  int fire = analogRead(3);
  int go = analogRead(0);
  
  
  if (Serial.available() > 0){
  Serial.read();
  Serial.print(force);  //notice I did not say println
  Serial.print(","); //using the comma as a delimiter
  Serial.print(fire); //send out the second thing
  Serial.print(","); //easier to unpack later with this deimiter
  Serial.print(go); //send out the second thing
  Serial.print(","); //easier to unpack later with this deimiter
  Serial.print('\n');  //instead I more explcitly send the linefeed character
}
}
