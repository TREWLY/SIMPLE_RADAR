//code sua | them serial vao 
import processing.serial.*;
Serial mySerial;
String mystring = null;
String[] data;
int[] int_data;
int nl=10;
float temp;

color radar_color=#4dbd5e;
int time_interval=50;
int angle=0;
int opacity=150;
int min_degree=10;
int max_degree=170;
int background_drawn=0;
int showline=11;
int line_travel=1;
//
int count=0;
//
special_line[] ln=new special_line[180]; //tong hop cac tia quay

void setup() {
  size(680, 400);
  background(0);
  for (int i=0; i<ln.length; i++)
  {
    ln[i]=new special_line(angle);
    angle++;
  }
  //code sua | cau hinh serial
  String myport=Serial.list()[1];
  mySerial= new Serial(this,myport,9600);
}
void draw() {
  radar_background();
  scanner();
}

//code ve background cho radar
void radar_background() {
  //cau hinh co ban cho phan background
  background(0);
  strokeWeight(2);
  stroke(radar_color);
  noFill();
  translate(680/2, 400-30);
  textSize(20);
  textAlign(CENTER);
  int distance=50;
  // Draw radar arc 
  for (float i=0.0625; i<4*0.2; i+=0.2)
  {
    fill(radar_color);
    text(distance-=10, (width-width*i)/2-4, 20);
    noFill();
    arc(0, 0, (width-width*i), (width-width*i), PI, TWO_PI);
  }
  fill(radar_color);
  text("TREWLY RADAR", 0, 20);
  //draw radar line
  for (int i=0; i<=180; i+=30)
  {
    float x1 = 0;
    float y1 = 0;
    float x2 = (-width / 2) * cos(radians(i));
    float y2 = (-width / 2) * sin(radians(i));
    // Draw lines
    float textX = (-width / 2) * cos(radians(i));
    float textY = (-width / 2) * sin(radians(i));
    line(x1, y1, x2, y2);
    float angle = atan2(y2 - y1, x2 - x1)+HALF_PI;
    pushMatrix();
    translate(textX, textY);
    rotate(angle);
    textAlign(CENTER, CENTER);
    text(180-i, 0, -18);
    popMatrix();
  }
}

//ham in ra gia tri quet duoc
void scanner() {
  //lay du lieu pos va khoang cach
  while(mySerial.available()>0)
  {
     mystring=mySerial.readStringUntil(nl);
  }
  data=split(mystring, ',');
  int_data=int(data);
  showline=int_data[0];
  //detect vat can
  if(int_data[1]!=-1)
  {
    ln[showline].detect();
    ln[showline].change_length(int_data[1]);
    text("KHOANG CACH: ", -270, 15);
    text(int_data[1], -170, 15);
  }
  //xoay radar
  if(line_travel==1)                     //xu li khi quay chieu kim dong ho
  {
    for(int i=min_degree; i<=showline; i++)
    {
      ln[i].show();
    }
    for(int i=min_degree; i<=showline; i++) // lam mo
    {
      ln[i].faded();
    }
  }
  else{                                    //xu li khi quay nguoc kim dong ho
   for(int i=max_degree; i>=showline; i--)
   {
     ln[i].show();
   }
   for(int i=max_degree; i>=showline; i--)
   {
     ln[i].faded();                        // lam mo
   }
  }
  //edge collision detection
  if ((showline==max_degree && line_travel==1)  || (showline==min_degree && line_travel==-1)) //tranh loi goi du lieu bi lap lai 2 lan
  {
   line_travel*=-1;
   for(int i=10; i<=170; i++)
   {
     ln[i].reset();
   }
  }
}
