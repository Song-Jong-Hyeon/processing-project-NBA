class TeamLogo{
  PImage logo;
  int logo_h=100;
  int logo_w=100;
  float x, y;
  float interval_x=50;
  float interval_y=50;
  String[] name;
  String abbrev;
  ArrayList<Player> Player_list_in_team = new ArrayList<Player>();
  int idx;
  TeamLogo(String s, String a, int j) {
    name=split(s, ' ');
    abbrev=a;
    idx=j;
    logo = loadImage("logos/"+join(name, ' ')+".png");
    logo.resize(logo_w, logo_h);
    x=(logo_w+interval_x)*(idx%x_placement_num)+(width-x_placement_num*(logo_w+interval_x)+interval_x)/2;
    y=(logo_h+interval_y)*(idx/x_placement_num)+80;
    
    for (int i=0; i<Player_num; i++) {
      ArrayList<Player> x=hm.get(Player_list.get(i));
      for(int k=0; k<x.size(); k++){
        Player p=x.get(k);  
        if ("2019 - 2020".equals(p.season) && p.abbrev.equals(abbrev) && p.stage.equals("Regular_Season")) {
          Player_list_in_team.add(p);
          break;
        }
      }
    }
    TextBoxs.add(new TextBox(Player_list_in_team, abbrev, idx, x, y));
  }
  void display() {
    if (mouseover()) {
      noStroke();
      fill(0, 0, 0, 50);
      rect(x, y, 100, 100, 10);
    } 
    image(logo, x, y);

    textAlign(CENTER);
    textFont(TeamNamef);
    fill(255);
    if (name.length==3)
      text(name[0]+name[1], x+logo_w/2, y+logo_h+15);
    else
      text(name[0], x+logo_w/2, y+logo_h+12);
    text(name[name.length-1], x+logo_w/2, y+logo_h+35);
  }
  boolean mouseover() {
    if (mouseX>=x && mouseX<=x+logo_w && mouseY>=y && mouseY<=y+logo_h)
      return true;
    else
      return false;
  }
}
