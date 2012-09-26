package com.protocols
{
    import com.*;

    public class Mod_Mission extends Object
    {

        public function Mod_Mission()
        {
            return;
        }// end function

        public static function register(param1:Data) : void
        {
            param1.registerDataCallback(Mod_Mission_Base.get_sections, param1.mission.get_sections);
            param1.registerDataCallback(Mod_Mission_Base.enter_mission, param1.mission.enter_mission);
            param1.registerDataCallback(Mod_Mission_Base.fight_monster, param1.mission.fight_monster);
            param1.registerDataCallback(Mod_Mission_Base.rank_mission, param1.mission.rank_mission);
            param1.registerDataCallback(Mod_Mission_Base.open_box, param1.mission.open_box);
            param1.registerDataCallback(Mod_Mission_Base.pickup_award, param1.mission.pickup_award);
            param1.registerDataCallback(Mod_Mission_Base.sign_play_mission_video, param1.mission.pickup_award);
            param1.registerDataCallback(Mod_Mission_Base.get_monster_strategy_list, param1.mission.get_monster_strategy_list);
            param1.registerDataCallback(Mod_Mission_Base.get_player_war_report, param1.mission.get_player_war_report, true);
            param1.registerDataCallback(Mod_Mission_Base.random_item, param1.mission.random_item);
            param1.registerDataCallback(Mod_Mission_Base.fetch_random_item, param1.mission.fetch_random_item);
            return;
        }// end function

    }
}
