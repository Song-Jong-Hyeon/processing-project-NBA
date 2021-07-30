class TextBox {
  ArrayList<Player> name_list;
  float x, y;
  float TextBoxw=400;
  float TextBoxh=350;
  float pointing_x1, pointing_x2, pointing_y1, pointing_y2;
  int idx;
  boolean show=false;
  float leftbutton_x, leftbutton_y;
  float rightbutton_x, rightbutton_y;
  float buttonw=20, buttonh=20;
  float input_x, input_y;
  float inputw=150, inputh=20;
  int season=2019;
  String abbrev;
  float row_interval=25;
  TextBox(ArrayList<Player> s, String par_teamname, int j, float par_x, float par_y) {
    name_list=s;
    idx=j;
    x=par_x;
    y=par_y;
    abbrev=par_teamname;
    Sorting_decreasing_PPG sort_by_decreasing_PPG = new Sorting_decreasing_PPG();
    Collections.sort(name_list, sort_by_decreasing_PPG);
  }

  void display() {
    stroke(0);
    fill(#DFDFDF);
    rect(x, y, TextBoxw, TextBoxh);
    noStroke();
    triangle(pointing_x1, pointing_y1, pointing_x2, pointing_y1, pointing_x2, pointing_y2);
    stroke(0);
    line(pointing_x1, pointing_y1, pointing_x2, pointing_y1);
    line(pointing_x1, pointing_y1, pointing_x2, pointing_y2);
    fill(0);
    textAlign(LEFT);
    textFont(PlayerNamef);
    if (name_list.size()==0) {
      text("No data in this season", x+30, y+150);
    }
    boolean flag=true;
    for (int i=0; i<min(10, name_list.size()); i++) {
      if (mouseover_on_text(x+5, y+50+row_interval*(i+1), i)) {
        fill(200, 0, 0);
        cursor(HAND);
        flag=false;
      }
      String str="";
      if (sort_type==0 || sort_type==1)
        str=String.format("%.2f", name_list.get(i).points/name_list.get(i).Game_Played);
      else if (sort_type==2 || sort_type==3)
        str=String.format("%.2f", name_list.get(i).field_goal_percentage*100)+"%";
      else if (sort_type==4 || sort_type==5)
        str=String.format("%.2f", name_list.get(i).avg_play_time)+"min";

      text((i+1)+"."+name_list.get(i).name+" ("+str+")", x+5, y+50+row_interval*(i+1));
    }
    if (flag==true)
      cursor(ARROW);
    drawbutton();
  }

  void drawbutton() {
    noStroke();
    if (leftbutton_mouseover())
      fill(180);
    else
      fill(255, 255, 255, 0);
    rect(leftbutton_x, leftbutton_y, buttonw, buttonh);
    if (rightbutton_mouseover())
      fill(180);
    else
      fill(255, 255, 255, 0);
    rect(rightbutton_x, rightbutton_y, buttonw, buttonh);
    fill(0);
    stroke(0);
    strokeWeight(3);
    line(leftbutton_x+5, leftbutton_y+buttonh/2, leftbutton_x+buttonw/2, leftbutton_y+buttonh*0.2);
    line(leftbutton_x+5, leftbutton_y+buttonh/2, leftbutton_x+buttonw/2, leftbutton_y+buttonh*0.8);
    line(rightbutton_x+15, rightbutton_y+buttonh/2, rightbutton_x+buttonw/2, rightbutton_y+buttonh*0.2);
    line(rightbutton_x+15, rightbutton_y+buttonh/2, rightbutton_x+buttonw/2, rightbutton_y+buttonh*0.8);
    fill(255);
    rect(input_x, input_y, inputw, inputh);

    textAlign(CENTER);
    textFont(seasonf);
    fill(0);
    text(season+" - "+(season+1), input_x+inputw/2, input_y+inputh/2+6);
  }

  void turn_show() {
    show=!show;
    if (mouseX+TextBoxw>width) {
      x=mouseX-TextBoxw-20;
      pointing_x1=mouseX;
      pointing_x2=mouseX-25;
    } else {
      x=mouseX+20;
      pointing_x1=mouseX;
      pointing_x2=mouseX+25;
    }
    if (mouseY+TextBoxh>height) {
      y=mouseY-TextBoxh;
      pointing_y1=mouseY;
      pointing_y2=mouseY-20;
    } else {
      y=mouseY;
      pointing_y1=mouseY;
      pointing_y2=mouseY+20;
    }
    input_x=x+TextBoxw/2-inputw/2;
    input_y=y+10;
    leftbutton_x=input_x-buttonw*2;
    leftbutton_y=y+10;
    rightbutton_x=input_x+inputw+buttonw;
    rightbutton_y=y+10;

    season=2019;
  }
  boolean leftbutton_mouseover() {
    if (mouseX>=leftbutton_x && mouseX<=leftbutton_x+buttonw && mouseY>=leftbutton_y && mouseY<=leftbutton_y+buttonh)
      return true;
    else
      return false;
  }
  boolean rightbutton_mouseover() {
    if (mouseX>=rightbutton_x && mouseX<=rightbutton_x+buttonw && mouseY>=rightbutton_y && mouseY<=rightbutton_y+buttonh)
      return true;
    else
      return false;
  }

  boolean mouseover_on_text(float par_x, float par_y, int idx) {
    fill(0);
    //rect(par_x,par_y,par_x+name_list.get(idx).length(),20);
    if (mouseX>par_x && mouseX<par_x+name_list.get(idx).name.length()*18 && mouseY>par_y-20 && mouseY<par_y)
      return true;
    else
      return false;
  }

  boolean mouseover_on_input() {
    if (mouseX>input_x && mouseX<input_x+inputw && mouseY>input_y && mouseY<input_y+inputh)
      return true;
    else
      return false;
  }

  boolean mouseover() {
    if (mouseX>x && mouseX<x+TextBoxw && mouseY>y &&mouseY<y+TextBoxh)
      return true;
    else
      return false;
  }
  void update_list() {
    name_list.clear();
    for (int i=0; i<Player_num; i++) {
      ArrayList<Player> x=hm.get(Player_list.get(i));
      for (int j=0; j<x.size(); j++) {
        Player p=x.get(j);  
        if ((season+" - "+(season+1)).equals(p.season) && p.abbrev.equals(abbrev) && p.stage.equals("Regular_Season")) {
          name_list.add(p);
          break;
        }
      }
    }
    switch(sort_type) {
      case 0:
        sort_decreasing_by_PPG();
        break;
      case 1:
        sort_increasing_by_PPG();
        break;
      case 2:
        sort_decreasing_by_FG();
        break;
      case 3:
        sort_increasing_by_FG();
        break;
      case 4:
        sort_decreasing_by_MP();
        break;
      case 5:
        sort_increasing_by_MP();
        break;
    }
  }

  void sort_decreasing_by_PPG() {
    Sorting_decreasing_PPG x = new Sorting_decreasing_PPG();
    Collections.sort(name_list, x);
  }
  void sort_increasing_by_PPG() {
    Sorting_increasing_PPG x = new Sorting_increasing_PPG();
    Collections.sort(name_list, x);
  }
  void sort_decreasing_by_FG() {
    Sorting_decreasing_FG x = new Sorting_decreasing_FG();
    Collections.sort(name_list, x);
  }
  void sort_increasing_by_FG() {
    Sorting_increasing_FG x = new Sorting_increasing_FG();
    Collections.sort(name_list, x);
  }
  void sort_decreasing_by_MP() {
    Sorting_decreasing_MP x = new Sorting_decreasing_MP();
    Collections.sort(name_list, x);
  }
  void sort_increasing_by_MP() {
    Sorting_increasing_MP x = new Sorting_increasing_MP();
    Collections.sort(name_list, x);
  }
}

class Sorting_decreasing_PPG implements Comparator<Player> {
  @Override
    public int compare(Player arg0, Player arg1) {
    float cmp0 = arg0.points/arg0.Game_Played;
    float cmp1 = arg1.points/arg1.Game_Played;

    if (cmp0 == cmp1) return 0;
    else if (cmp0 < cmp1) return 1;
    else return -1;
  }
}

class Sorting_increasing_PPG implements Comparator<Player> {
  @Override
    public int compare(Player arg0, Player arg1) {
    float cmp0 = arg0.points/arg0.Game_Played;
    float cmp1 = arg1.points/arg1.Game_Played;

    if (cmp0 == cmp1) return 0;
    else if (cmp0 > cmp1) return 1;
    else return -1;
  }
}
class Sorting_decreasing_FG implements Comparator<Player> {
  @Override
    public int compare(Player arg0, Player arg1) {
    float cmp0 = arg0.field_goal_percentage;
    float cmp1 = arg1.field_goal_percentage;

    if (cmp0 == cmp1) return 0;
    else if (cmp0 < cmp1) return 1;
    else return -1;
  }
}
class Sorting_increasing_FG implements Comparator<Player> {
  @Override
    public int compare(Player arg0, Player arg1) {
    float cmp0 = arg0.field_goal_percentage;
    float cmp1 = arg1.field_goal_percentage;

    if (cmp0 == cmp1) return 0;
    else if (cmp0 > cmp1) return 1;
    else return -1;
  }
}
class Sorting_decreasing_MP implements Comparator<Player> {
  @Override
    public int compare(Player arg0, Player arg1) {
    float cmp0 = arg0.avg_play_time;
    float cmp1 = arg1.avg_play_time;

    if (cmp0 == cmp1) return 0;
    else if (cmp0 < cmp1) return 1;
    else return -1;
  }
}
class Sorting_increasing_MP implements Comparator<Player> {
  @Override
    public int compare(Player arg0, Player arg1) {
    float cmp0 = arg0.avg_play_time;
    float cmp1 = arg1.avg_play_time;

    if (cmp0 == cmp1) return 0;
    else if (cmp0 > cmp1) return 1;
    else return -1;
  }
}
