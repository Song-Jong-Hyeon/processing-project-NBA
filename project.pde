import java.util.Map;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
HashMap<String, ArrayList> hm = new HashMap<String, ArrayList>();
ArrayList<TeamLogo> Teams = new ArrayList<TeamLogo>();
ArrayList<TextBox> TextBoxs = new ArrayList<TextBox>();
Table player_regular_data;
Table Teams_data;
PFont Titlef, TeamNamef, PlayerNamef, button_sidef, seasonf, explanef, mynamef;
PFont buttonf, Profilef, helpf, graph_titlef, graph_mouseoverf, graphf;
PImage basketball_court;
int Team_num = 30, Player_num;
StringList Player_list = new StringList();
int x_placement_num = 6;
int now_showing_Player_list=-1;
int sort_type=0;
float origin=60;
PlayerPage player_page;
Button PPG_up = new Button(20, 40+origin, 30, 30, #F4F9F9, "PPG dec",0);
Button FG_up = new Button(20, 80+origin, 30, 30, #CCF2F4, "FG% dec",2);
Button MP_up = new Button(20, 120+origin, 30, 30, #A4EBF3, "MP dec",4);
Button PPG_down = new Button(20, 160+origin, 30, 30, #BEDCFA, "PPG inc",1);
Button FG_down = new Button(20, 200+origin, 30, 30, #98ACF8, "FG% inc",3);
Button MP_down = new Button(20, 240+origin, 30, 30, #B088F9, "MP inc",5);
String sort_by="";

void settings() {
  size(1280, 840);
}
void setup() {
  // setup playes data -----start
  player_regular_data = loadTable("data.csv", "header");
  Teams_data = loadTable("nba_team.tsv", "header");
  Player p;
  ArrayList<Player> x;
  for (int i=0; i<player_regular_data.getRowCount(); i++) {
    p = new Player(i);
    String name = player_regular_data.getString(i, "Player");  
    if (hm.containsKey(name))
      hm.get(name).add(p);
    else {
      x = new ArrayList<Player>();
      x.add(p);
      hm.put(name, x);
      Player_num++;
      Player_list.append(name);
    }
  }

  // setup players data -----end
  // setup logo data -----start
  for (int i=0; i<Team_num; i++) {
    TeamLogo a = new TeamLogo(Teams_data.getString(i, "TeamName"), Teams_data.getString(i, "abbreviation"), i);
    Teams.add(a);
  }
  //setup logo data -----end
  //setup text, background -----start
  basketball_court = loadImage("background_3.jpg");
  basketball_court.resize(width, height);
  
  Titlef=createFont("Serif.bolditalic", 72);
  mynamef=createFont("THE수수깡", 20);
  TeamNamef=createFont("Headline R", 15);
  explanef=createFont("THE수수깡", 28);
  button_sidef=createFont("THE수수깡", 32);
  PlayerNamef=createFont("SansSerif.plain", 20);
  seasonf=createFont("SansSerif.bold", 16);
  buttonf=createFont("SansSerif.bolditalic", 20);
  helpf=createFont("SansSerif.plain", 16);
  Profilef=createFont("SansSerif.plain", 20);
  graph_titlef=createFont("Headline R", 24);
  graphf=createFont("Calibri", 16);
  graph_mouseoverf=createFont("Calibri", 20);
  //setup text,background -----end

  //setup newpage -----start
  player_page = new PlayerPage();
  runSketch(new String[] {"PlayerPage"}, player_page);
  player_page.getSurface().setVisible(false);
  player_page.noLoop();
  //setup newpage -----end
  
}

void draw() {
  background(basketball_court);
  textFont(Titlef);
  fill(#DEEEEA);
  textAlign(CENTER);
  text("NBA Player Analysis", width/2, 60);
  textFont(mynamef);
  fill(0);
  text("Made by J.H.S", width-60, 20);
  for (int i=0; i<Team_num; i++) {
    Teams.get(i).display();
  }
  for (int i=0; i<Team_num; i++) {
    if (TextBoxs.get(i).show) {
      TextBoxs.get(i).display();
    }
  }
  textFont(explanef);
  textAlign(LEFT);
  fill(0);
  text("Sort by..", 20, 20+origin);
  PPG_up.display();
  PPG_down.display();
  FG_up.display();
  FG_down.display();
  MP_up.display();
  MP_down.display();
}

void mousePressed() {
  for (int i=0; i<Team_num; i++) {
    TextBox tmp = TextBoxs.get(i);
    if (Teams.get(i).mouseover()) {
      if (flag(i)) {
        tmp.turn_show();
        if (now_showing_Player_list==i)
          now_showing_Player_list=-1;
        else
          now_showing_Player_list=i;
      } else if (now_showing_Player_list!=-1 && !TextBoxs.get(now_showing_Player_list).mouseover()) {
        for (int j=0; j<Team_num; j++) {
          if (flag(j)) {
            TextBoxs.get(j).turn_show();
            break;
          }
        }
        tmp.turn_show();
      }
    }
    if (tmp.show==true) {
      if (tmp.leftbutton_mouseover()==true && tmp.season>=2000) {
        tmp.season--;
        tmp.update_list();
      }
      if (tmp.rightbutton_mouseover()==true && tmp.season<2019) {
        tmp.season++;
        tmp.update_list();
      }
      for (int j=0; j<min(10, tmp.name_list.size()); j++) {
        if (tmp.mouseover_on_text(tmp.x+5, tmp.y+50+tmp.row_interval*(j+1), j)) {
          PImage player_img, team_img;
          player_img=loadImage("players/"+tmp.name_list.get(j).name+".png");
          if (player_img==null)
            player_img=loadImage("players/logoman.png");
          team_img = loadImage("logos/"+tmp.name_list.get(j).Team+".png");
          player_page.called_page(tmp.name_list.get(j).name, tmp.season, player_img, team_img);
          player_page.getSurface().setVisible(true);
          player_page.loop();
        }
      }
    }
  }
  if (PPG_up.mouseover()) {
    sort_type=0;
    for (int i=0; i<TextBoxs.size(); i++)
      TextBoxs.get(i).sort_decreasing_by_PPG();
  } else if (PPG_down.mouseover()) {
    sort_type=1;
    for (int i=0; i<TextBoxs.size(); i++)
      TextBoxs.get(i).sort_increasing_by_PPG();
  } else if (FG_up.mouseover()) {
    sort_type=2;
    for (int i=0; i<TextBoxs.size(); i++)
      TextBoxs.get(i).sort_decreasing_by_FG();
  } else if (FG_down.mouseover()) {
    sort_type=3;
    for (int i=0; i<TextBoxs.size(); i++)
      TextBoxs.get(i).sort_increasing_by_FG();
  } else if (MP_up.mouseover()) {
    sort_type=4;
    for (int i=0; i<TextBoxs.size(); i++)
      TextBoxs.get(i).sort_decreasing_by_MP();
  } else if (MP_down.mouseover()) {
    sort_type=5;
    for (int i=0; i<TextBoxs.size(); i++)
      TextBoxs.get(i).sort_increasing_by_MP();
  }
}

boolean flag(int i) {
  if ((now_showing_Player_list==-1 || TextBoxs.get(i).show==true))
    return true;
  else
    return false;
}

void change_season_player_page(Player p) {
  PImage x = loadImage("logos/"+p.Team+".png");
  x.resize(120, 120);
  player_page.team_img=x;
}
