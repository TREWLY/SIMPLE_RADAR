#include <Servo.h>

int servo_pin = 9;
int pos = 10;
int speed = 1;
Servo myservo;

const int trig = 8;
const int echo = 7;
unsigned long thoigian;
int khoangcach;

//send uart data


void setup() {
  Serial.begin(9600);
  myservo.attach(servo_pin);
  pinMode(trig, OUTPUT);
  pinMode(echo, INPUT);
}

void radar_move() {
  myservo.write(pos);
  pos = pos + speed;
  if (pos == 10 || pos == 170) {
    speed = speed * (-1);
  }
}

void loop() {
  digitalWrite(trig, LOW);
  delayMicroseconds(2);
  digitalWrite(trig, HIGH);
  delayMicroseconds(10);
  digitalWrite(trig, LOW);

  thoigian = pulseIn(echo, HIGH,14000); //do duoc khoang cach gioi han la 85cm
  khoangcach = (thoigian * 0.0343) / 2;

  Serial.print(pos);
  Serial.print(',');
  if (khoangcach < 800 && khoangcach !=0 ) {
    Serial.print(khoangcach);
    Serial.println(',');
  }else{
    Serial.print(-1);
    Serial.println(',');
  }
  radar_move(); 
  //Serial.println(pos);
  //radar_move(); // Adjust delay according to your needs
  delay(40);
}
