class special_line{
  float x1=0,x2,y1=0,y2;
  int opacity_inline=opacity;
  color line_color=radar_color;
  int angle;
  special_line(int angle)
  {
    x2 = (-width / 2) * cos(radians(angle));
    y2 = (-width / 2) * sin(radians(angle));
    this.angle=angle;
  }
  void show()
  {  
    strokeWeight(6);
    stroke(line_color, opacity_inline);
    line(x1, y1, x2, y2);
  }
  void faded()
  {
    opacity_inline-=1;
  }
  void reset()
  {
    opacity_inline=opacity;
    line_color=radar_color;
    x2 = (-width / 2) * cos(radians(angle));
    y2 = (-width / 2) * sin(radians(angle));
  } 
  void detect()
  {
    line_color=#D04848;
  }
  void change_length(int dis)
  {
    if(dis>40)
    {
      return;
    }
    x2 = (-dis * 7) * cos(radians(angle))-39;
    y2 = (-dis * 7) * sin(radians(angle))-39;
  }
}
