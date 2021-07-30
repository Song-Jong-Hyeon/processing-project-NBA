class PlayerPage extends PApplet {
  color profile_col=#C6FFC1;
  Button exit = new Button(1150, 20, 100, 40, color(255, 51, 153), 24, 32, "exit");
  Button help = new Button(1045, 20, 100, 40, color(80, 188, 223), 24, 32, "help");
  Button left_button = new Button(10.5, 780, 60, 30, profile_col, 28, 28, "<");
  Button right_button = new Button(300, 780, 60, 30, profile_col, 28, 28, ">");
  Button regular_season = new Button(1100, 150, 120, 30, #93329E, 16, 16, "regular season");
  Button playoff = new Button(1100, 182, 120, 30, #1EAE98, 18, 18, "playoff");
  Profile profile;
  String Player_name="";
  boolean profile_exist=false;
  boolean help_box_exist=false;
  float helpbox_x, helpbox_y, helpboxw=220, helpboxh=400;
  PImage player_img, team_img;
  int now_season=0;
  void settings() {
    size(1280, 840);
  }

  void setup() {
    background(basketball_court);
  }

  void called_page(String s, int season, PImage k, PImage l) {
    Player_name=s;
    profile = new Profile(hm.get(Player_name), season);
    profile_exist=true;
    player_img=k;
    player_img.resize(312, 228);
    team_img=l;
    team_img.resize(120,120);
    now_season=0;
  }

  void draw() {
    background(basketball_court);
    textAlign(CENTER);
    textFont(Titlef);
    fill(#DEEEEA);
    text(Player_name, width/2, 80);
    if (profile_exist)
      profile.display();
    
    if (left_button.mouseover())
      left_button.col=color(180);
    else
      left_button.col=left_button.org_col;

    if (right_button.mouseover())
      right_button.col=color(180);
    else
      right_button.col=right_button.org_col;
    left_button.display(false);
    right_button.display(false);

    if (now_season==1)
      regular_season.col=color(180);
    else
      regular_season.col=regular_season.org_col;
    if (now_season==-1)
      playoff.col=color(180);
    else
      playoff.col=playoff.org_col;
      
    if(regular_season.mouseover())
      regular_season.display(true);
    else
      regular_season.display(false);
    if(playoff.mouseover())
      playoff.display(true);
    else
      playoff.display(false);
    
    exit.display(true);
    help.display(true);
    if (help_box_exist) {
      display_helpbox();
    }
  }

  void mousePressed() {
    if (exit.mouseover()) {
      stop_page();
    }
    if (help.mouseover()) {
      help_box_exist=!help_box_exist;
      helpbox_x=mouseX-helpboxw;
      helpbox_y=mouseY;
    }
    if (left_button.mouseover()) {
      profile.change_season(2);
    }
    if (right_button.mouseover()) {
      profile.change_season(1);
    }
    if (regular_season.mouseover()) {
      if (now_season==1)
        now_season=0;
      else
        now_season=1;
    }
    if (playoff.mouseover()) {
      if (now_season==-1)
        now_season=0;
      else
        now_season=-1;
    }
    for (int i=2; i<=8; i++) {
      if (profile.mouseover_on_text(i)) {
        profile.graph_type=i-2;
      }
    }
  }

  void stop_page() {
    help_box_exist=false;
    getSurface().setVisible(false);
    noLoop();
  }

  void display_helpbox() {
    fill(255, 212, 0);
    stroke(0);
    rect(helpbox_x, helpbox_y, helpboxw, helpboxh);
    textFont(helpf);
    textAlign(LEFT);
    fill(0);
    int idx=2;
    text("GP : played game", helpbox_x+5, helpbox_y+17*idx++);
    text("MP : minutes played ", helpbox_x+5, helpbox_y+17*idx++);
    text("per game", helpbox_x+50, helpbox_y+17*idx++);
    text("FG% : field goal %", helpbox_x+5, helpbox_y+17*idx++);
    text("3P% : 3points shot % ", helpbox_x+5, helpbox_y+17*idx++);
    text("FT% : free throw % ", helpbox_x+5, helpbox_y+17*idx++);
    text("STL : steals total", helpbox_x+5, helpbox_y+17*idx++);
    text("SPG : steals per game", helpbox_x+5, helpbox_y+17*idx++);
    text("BLK : blocks total ", helpbox_x+5, helpbox_y+17*idx++);
    text("BPG : blocks per game ", helpbox_x+5, helpbox_y+17*idx++);
    text("PTS : total points", helpbox_x+5, helpbox_y+17*idx++);
    text("PPG : points per game", helpbox_x+5, helpbox_y+17*idx++);
    text("REB : rebounds total", helpbox_x+5, helpbox_y+17*idx++);
    text("RPG : rebounds per game", helpbox_x+5, helpbox_y+17*idx++);
    text("PF : personal fouls", helpbox_x+5, helpbox_y+17*idx++);
    text("TOV : turnover total", helpbox_x+5, helpbox_y+17*idx++);
  }


  class Button {
    float button_x, button_y;
    float buttonw, buttonh;
    color col,org_col;
    String content;
    float small_font, big_font;
    Button(float par_x, float par_y, float w, float h, color par_col, float small_s, float big_s, String s) {
      button_x=par_x;
      button_y=par_y;
      buttonw=w;
      buttonh=h;
      org_col=par_col;
      col=org_col;
      content=s;
      small_font=small_s;
      big_font=big_s;
    }

    void display(boolean strok) {
      fill(col);
      if (strok)
        stroke(0);
      else
        noStroke();
      rect(button_x, button_y, buttonw, buttonh);
      textAlign(CENTER, BOTTOM);
      textFont(buttonf);
      fill(0);
      if (mouseover()) {
        textSize(big_font);
        text(content, button_x+buttonw/2, button_y+buttonh/2+big_font/2);
      } else {
        textSize(small_font);
        text(content, button_x+buttonw/2, button_y+buttonh/2+small_font/2);
      }
    }

    boolean mouseover() {
      if (mouseX>=button_x && mouseX<=button_x+buttonw && mouseY>=button_y && mouseY<=button_y+buttonh)
        return true;
      else
        return false;
    }
  }

  class Profile {
    ArrayList<Player> player_data;
    ArrayList<Player> player_data_regular_season = new ArrayList<Player>();
    ArrayList<Player> player_data_playoff = new ArrayList<Player>();
    Player p;
    int idx, season;
    int wrong_season=0;
    float image_x=10, image_y=150;
    float profile_x=10, profile_y=height/2, profilew=350, profileh=400;
    int row_idx=1;
    float graph_x=370, graph_y=120, graphw=880, graphh=700;
    String first_season_regular_season, last_season_regular_season;
    String first_season_playoff, last_season_playoff;
    String[] message = new String[17];
    boolean now_showing_graph=false;
    int graph_type=5;
    float graph_rect_interval=100;
    Profile(ArrayList<Player> x, int a) {
      player_data=x;
      season=a;
      for (int i=0; i<player_data.size(); i++) {
        Player now_p=player_data.get(i);
        if (now_p.season.equals(season+" - "+(season+1))) {
          season=a;
          idx=i;
        }
        if (now_p.stage.equals("Playoffs"))
          player_data_playoff.add(now_p);
        else
          player_data_regular_season.add(now_p);
      }
      p = player_data.get(idx);
      if (player_data_regular_season.size()>0) {
        first_season_regular_season=player_data_regular_season.get(0).season;
        last_season_regular_season=player_data_regular_season.get(player_data_regular_season.size()-1).season;
      }
      if (player_data_playoff.size()>0) {
        first_season_playoff=player_data_playoff.get(0).season;
        last_season_playoff=player_data_playoff.get(player_data_playoff.size()-1).season;
      }
    }

    void display() {
      fill(#DEEEEA);
      rect(image_x, image_y, player_img.width+30, player_img.height);
      image(player_img, image_x+15, image_y);
      if(team_img!=null)
        image(team_img, 20,20);
      fill(profile_col);
      rect(profile_x, profile_y, profilew, profileh);
      textFont(Profilef);
      textAlign(LEFT);
      fill(0);
      //profile -----start
      message[0]=p.season+" "+p.stage;
      message[1]="Team : "+p.Team;
      message[2]="GP : "+round(p.Game_Played);
      message[3]="MP : "+String.format("%.2f", p.avg_play_time)+"min";
      message[4]="FG % : "+String.format("%.2f", p.field_goal_percentage*100)+"%";
      message[5]="3P % : "+String.format("%.2f", p.three_point_percentage*100)+"%";
      message[6]="FT % : "+String.format("%.2f", p.freethrow_percentage*100)+"%";
      message[7]="PTS/PPG : "+round(p.points)+" / "+String.format("%.2f", p.points/p.Game_Played);
      message[8]="REB/RPG : "+round(p.rebounds)+" / "+String.format("%.2f", p.rebounds/p.Game_Played);
      message[9]="STL/SPG : "+round(p.steals)+" / "+String.format("%.2f", p.steals/p.Game_Played);
      message[10]="BLK/BPG : "+round(p.blocks)+" / "+String.format("%.2f", p.blocks/p.Game_Played);
      message[11]="PF : "+round(p.fouls);
      message[12]="TOV : "+round(p.turnover);
      boolean x=false;
      // profile -----end
      // mouseover -----start
      for (int row_idx=0; row_idx<13; row_idx++) {
        if (mouseover_on_text(row_idx) && row_idx>=2 && row_idx<=8) {
          fill(255, 0, 0);
          x=true;
          cursor(HAND);
        } else
          fill(0);
        text(message[row_idx], profile_x+15, profile_y+20*(row_idx+2));
      }
      //mouseover -----end
      //now graph type check red -----start
      if (x==false) {
        cursor(ARROW);
        for (int row_idx=0; row_idx<13; row_idx++) {
          if (graph_type==row_idx-2) {
            fill(profile_col);
            noStroke();
            rect(profile_x+15, profile_y+20*(row_idx+1), profilew-30, 20);
            fill(255, 0, 0);
            text(message[row_idx], profile_x+15, profile_y+20*(row_idx+2));
            stroke(0);
          }
        }
      }
      //now graph type check red -----end
      rectMode(CORNER);
      row_idx=1;
      graph_display(graph_type);
    }

    void graph_display(int type) {
      pushMatrix();
      translate(graph_x+50, graph_y+graphh-30);
      fill(#FFFFC7);
      rect(-50, -graphh+50, graphw, graphh-20);
      stroke(0);
      strokeWeight(3);
      line(0, 0, 0, -graphh+graph_rect_interval); //y-axis
      line(0, -graphh+graph_rect_interval, -10, -graphh+graph_rect_interval+10);
      line(0, -graphh+graph_rect_interval, 10, -graphh+graph_rect_interval+10);
      line(0, 0, graphw-70, 0); //x-axis
      line(graphw-70, 0, graphw-80, 10);
      line(graphw-70, 0, graphw-80, -10);

      //graph title ---start
      textAlign(CENTER);
      textFont(graph_titlef);
      fill(0);
      switch(type) { 
      case 1: // played_time
        text("Played time per season", graphw/2, -graphh+graph_rect_interval-20);
        break;
      case 2: // field_goal_percentage
        text("Average field goal %", graphw/2, -graphh+graph_rect_interval-20);
        break;
      case 3: // three_point_percentage
        text("Average three point %", graphw/2, -graphh+graph_rect_interval-20);
        break;
      case 4: // freethrow_point_percentage
        text("Average freethrow %", graphw/2, -graphh+graph_rect_interval-20);
        break;
      case 5: // points_per_game
        text("Average points per game", graphw/2, -graphh+graph_rect_interval-20);
        break;
      case 6: // rebounds_per_game
        text("Average rebounds per game", graphw/2, -graphh+graph_rect_interval-20);
        break;
      default: // game_played
        text("Average game played", graphw/2, -graphh+graph_rect_interval-20);
      }
      //graph title -----end


      //graph -----start
      float x, y, max_value=0, px=0, py=0;
      float x2=0, y2=0, px2=0, py2=0;
      Float[] data=new Float[player_data_regular_season.size()];
      Float[] data2 = new Float[player_data_playoff.size()];
      if (player_data_regular_season.size()==0) {
        fill(0);
        textAlign(CENTER);
        textFont(graphf);
        text("No data", graphw/2, -graphh+graph_rect_interval+graphh/2);
        popMatrix();
        strokeWeight(1);
        return;
      }
      int j=0;
      for (int i=0; i<data.length; i++) {
        if (data.length>1)
          x = map((i+1), 1, data.length, 30, graphw-120);
        else
          x = graphw/2;
        switch(type) {
        case 1: // avg_played_time
          max_value=48;
          data[i]=player_data_regular_season.get(i).avg_play_time;
          break;
        case 2: // field_goal_percentage
          max_value=80;
          data[i]=player_data_regular_season.get(i).field_goal_percentage*100;
          break;
        case 3: // three_point_percentage
          max_value=80;
          data[i]=player_data_regular_season.get(i).three_point_percentage*100;
          break;
        case 4: // freethrow_point_percentage
          max_value=100;
          data[i]=player_data_regular_season.get(i).freethrow_percentage*100;
          break;
        case 5: // points_per_game
          max_value=50;
          data[i]=player_data_regular_season.get(i).points/player_data_regular_season.get(i).Game_Played;
          break;
        case 6: // rebounds_per_game
          max_value=20;
          data[i]=player_data_regular_season.get(i).rebounds/player_data_regular_season.get(i).Game_Played;
          break;
        default: // game_played
          max_value=90;
          data[i]=player_data_regular_season.get(i).Game_Played;
        }
        y = map(data[i], 0, max_value, 0, -graphh+graph_rect_interval);
        if (now_season==0 || now_season==-1) {
          fill(regular_season.col);
          stroke(regular_season.col);
          ellipseMode(CENTER);
          circle(x, y, 10);
          if (i==0) {
            px=x;
            py=y;
          }
          line(px, py, x, y);
          px=x;
          py=y;
        }
        fill(0);
        textAlign(CENTER);
        textFont(graphf);
        text(split(player_data_regular_season.get(i).season, '-')[0], x, 20);

        //playoff graph ---start
        if (player_data_playoff.size()>j && player_data_playoff.get(j).season.equals(player_data_regular_season.get(i).season)) {

          switch(type) {
          case 1: // avg_played_time
            data2[j]=player_data_playoff.get(j).avg_play_time;
            break;
          case 2: // field_goal_percentage
            data2[j]=player_data_playoff.get(j).field_goal_percentage*100;
            break;
          case 3: // three_point_percentage
            data2[j]=player_data_playoff.get(j).three_point_percentage*100;
            break;
          case 4: // freethrow_point_percentage
            data2[j]=player_data_playoff.get(j).freethrow_percentage*100;
            break;
          case 5: // points_per_game
            data2[j]=player_data_playoff.get(j).points/player_data_playoff.get(j).Game_Played;
            break;
          case 6: // rebounds_per_game
            data2[j]=player_data_playoff.get(j).rebounds/player_data_playoff.get(j).Game_Played;
            break;
          default: // game_played
            data2[j]=player_data_playoff.get(j).Game_Played;
          }
          x2=x;
          y2 = map(data2[j], 0, max_value, 0, -graphh+graph_rect_interval);
          if (now_season==0 || now_season==1) {
            fill(playoff.col);
            stroke(playoff.col);
            ellipseMode(CENTER);
            circle(x2, y2, 10);
            if (j>0)
              line(px2, py2, x2, y2);
            px2=x2;
            py2=y2;
          }
          j++;
        }
        //playoff graph -----end
      }
      //mouseover state -----start
      j=0;
      for (int i=0; i<data.length; i++) {
        if (data.length>1)
          x = map((i+1), 1, data.length, 30, graphw-120);
        else
          x = graphw/2;
        y = map(data[i], 0, max_value, 0, -graphh+graph_rect_interval);
        if (player_data_playoff.size()>j && player_data_playoff.get(j).season.equals(player_data_regular_season.get(i).season)) {
          x2 = x;
          y2 = map(data2[j], 0, max_value, 0, -graphh+graph_rect_interval);
          j++;
        }
        textFont(graph_mouseoverf);
        if (mouseover_on_circle((graph_x+50)+x, (graph_y+graphh-30)+y, 10) && now_season!=1) {
          stroke(regular_season.col);
          fill(regular_season.col);
          circle(x, y, 20);
          fill(0);
          if (type==0)
            text(round(data[i]), x, y-20);
          else if(type==2 || type==3 || type==4)
            text(String.format("%.2f", data[i])+"%", x, y-20);
          else
            text(String.format("%.2f", data[i]), x, y-20);
        }
        if (mouseover_on_circle((graph_x+50)+x2, (graph_y+graphh-30)+y2, 10) && j>0 && now_season!=-1) {
          fill(playoff.col);
          stroke(playoff.col);
          circle(x2, y2, 20);
          fill(0);
          if (type==0)
            text(round(data2[j-1]), x2, y2-20);
          else if(type==2 || type==3 || type==4)
            text(String.format("%.2f", data2[j-1])+"%", x2, y2-20);
          else
            text(String.format("%.2f", data2[j-1]), x2, y2-20);
        }
      }
      //mouseover state -----end
      for (int i=0; i<=round(max_value)/10; i++) {
        float axis_y=map(i, 0, max_value/10, 0, -graphh+graph_rect_interval);
        textFont(graphf);
        fill(0);
        text(i*10, -20, axis_y);
      }
      //graph -----end
      if (type==2 || type==3 || type==4)
        text("(%)", -20, -graphh+graph_rect_interval-30);
      

      popMatrix();
      strokeWeight(1);
    }

    void change_season(int com) {
      if (com==1) {
        if (idx<player_data.size()-1) {
          idx++;
          p=player_data.get(idx);
          wrong_season=0;
          change_season_player_page(p);
        } else {
          wrong_season=1;
        }
      } else if (com==2) {
        if (idx>0) {
          wrong_season=0;
          idx--;
          p=player_data.get(idx);
          change_season_player_page(p);
        } else
          wrong_season=-1;
      }
    }
    boolean mouseover_on_text(int idx) {
      if (mouseX>profile_x && mouseX<profile_x+profilew && mouseY>20+profile_y+20*idx && mouseY<20+profile_y+20*(idx+1))
        return true;
      else
        return false;
    }
    boolean mouseover_on_circle(float x, float y, float r) {
      if (dist(mouseX, mouseY, x, y)<=r)
        return true;
      else
        return false;
    }
  }
}
