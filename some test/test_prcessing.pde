import processing.serial.*;

Serial mySerial;
String mystring = null;
int nl=10;
float temp;
String[] list ;
int[] data;
void setup() {
  String myport=Serial.list()[1];
  mySerial= new Serial(this,myport,9600);
  //het code sua
}

void draw() {
  while(mySerial.available()>0)
    {
      mystring=mySerial.readStringUntil(nl);
   }
   list=split(mystring, ',');
   data=int(list);
   println(data[1]);
}
