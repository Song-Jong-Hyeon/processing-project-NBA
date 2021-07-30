class Player {
  String season;
  String Team;
  String abbrev;
  String stage;
  String name;
  float Game_Played;
  float total_played_time;
  float field_goals_made;
  float field_goal_attempts;
  float three_point_made;
  float three_point_attempts;
  float freethrow_made;
  float freethrow_attempts;
  float turnover;
  float fouls;
  float rebounds;
  float steals;
  float blocks;
  float points;
  float avg_play_time, field_goal_percentage, three_point_percentage, freethrow_percentage;
  Player(int i) {
    name = player_regular_data.getString(i, "Player");
    season = player_regular_data.getString(i, "Season");
    abbrev = player_regular_data.getString(i, "Team");
    for(int j=0; j<Team_num; j++){
      if(Teams_data.getString(j, "abbreviation").equals(abbrev)){
        Team=Teams_data.getString(j,"TeamName");
        break;
      }
    }
    stage = player_regular_data.getString(i, "Stage");
    Game_Played = player_regular_data.getFloat(i, "GP");
    total_played_time = player_regular_data.getFloat(i, "MIN");
    field_goals_made = player_regular_data.getFloat(i, "FGM");
    field_goal_attempts = player_regular_data.getFloat(i, "FGA");
    three_point_made = player_regular_data.getFloat(i, "3PM");
    three_point_attempts = player_regular_data.getFloat(i, "3PA"); 
    freethrow_made = player_regular_data.getFloat(i, "FTM");
    freethrow_attempts = player_regular_data.getFloat(i, "FTA");
    turnover = player_regular_data.getFloat(i, "TOV");
    fouls = player_regular_data.getFloat(i, "PF");
    rebounds = player_regular_data.getFloat(i, "REB");
    steals = player_regular_data.getFloat(i, "STL");
    blocks = player_regular_data.getFloat(i, "BLK");
    points = player_regular_data.getFloat(i, "PTS");
    avg_play_time = total_played_time/Game_Played;
    field_goal_percentage = field_goals_made/field_goal_attempts;
    three_point_percentage = three_point_made/three_point_attempts;
    freethrow_percentage = freethrow_made/freethrow_attempts;
    
    if(three_point_attempts==0)
      three_point_percentage=0;
    if(freethrow_attempts==0)
      freethrow_percentage=0;
  }

  String get_season() {
    return season;
  }
}
