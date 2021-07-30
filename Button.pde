class Button {
  float x, y;
  float w, h;
  color col;
  String message;
  int idx;
  Button(float par_x, float par_y, float par_w, float par_h, color par_col, String s, int i) {
    x=par_x;
    y=par_y;
    w=par_w;
    h=par_h;
    col=par_col;
    message=s;
    idx=i;
  }

  void display() {
    noStroke();
    textFont(button_sidef);
    textAlign(LEFT, TOP);
    if (mouseover() || idx==sort_type) {
      stroke(0);
      strokeWeight(2);
      fill(col);
      text(message, x+w+5, y);
    }
    else{
      fill(0);
      text(message, x+w+5, y);
    }
    fill(col);
    rect(x, y, w, h);
    
  }

  boolean mouseover() {
    if (mouseX>=x && mouseX<=x+w && mouseY>=y && mouseY<=y+h) {
      return true;
    } else {
      return false;
    }
  }
}
