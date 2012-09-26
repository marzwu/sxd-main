package com.protocols
{
    import com.haloer.utils.*;

    public class Mod_Notify_Base extends Object
    {
        public static const COINS:int = 0;
        public static const ITEM:int = 1;
        public static const ROLE:int = 2;
        public static const FAME:int = 3;
        public static const TANG_SENG:int = 4;
        public static const FACTION:int = 5;
        public static const CHANGE_MONEY:int = 6;
        public static const RULAI_OPEN_FOR_CALL:int = 7;
        public static const RULAI_CLOSE:int = 8;
        public static const RULAI_OPEN:int = 9;
        public static const STATE_POINT_LV:int = 10;
        public static const mission_award:Object = {module:148, action:162, request:[], response:[Utils.IntUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil]};
        public static const pk_award:Object = {module:148, action:229, request:[], response:[Utils.IntUtil, Utils.StringUtil, Utils.ByteUtil, Utils.IntUtil, Utils.IntUtil]};
        public static const complete_reel_production:Object = {module:148, action:139, request:[], response:[Utils.IntUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.IntUtil]};
        public static const role_num_notify:Object = {module:148, action:39, request:[], response:[Utils.IntUtil]};
        public static const new_research_notify:Object = {module:148, action:87, request:[], response:[[Utils.IntUtil, Utils.StringUtil]]};
        public static const new_partners_notify:Object = {module:148, action:177, request:[], response:[Utils.IntUtil]};
        public static const notify_get_good_fate:Object = {module:148, action:36, request:[], response:[Utils.IntUtil, Utils.StringUtil, Utils.ShortUtil]};
        public static const notify_player_mission_practice_status:Object = {module:148, action:63, request:[], response:[Utils.IntUtil, Utils.ByteUtil]};
        public static const update_player_super_gift:Object = {module:148, action:86, request:[], response:[[Utils.IntUtil, Utils.IntUtil, Utils.IntUtil, Utils.StringUtil]]};
        public static const change_equip:Object = {module:148, action:149, request:[], response:[Utils.IntUtil, Utils.IntUtil]};
        public static const update_lucky_shop_item:Object = {module:148, action:137, request:[], response:[Utils.IntUtil]};
        public static const buy_good_stuff_in_lucky_shop:Object = {module:148, action:79, request:[], response:[Utils.IntUtil, Utils.StringUtil, Utils.IntUtil]};
        public static const disband_faction_notify:Object = {module:148, action:96, request:[], response:[Utils.IntUtil]};
        public static const kickout_member_notify:Object = {module:148, action:181, request:[], response:[Utils.IntUtil]};
        public static const player_take_bible:Object = {module:148, action:117, request:[], response:[Utils.StringUtil, Utils.ByteUtil]};
        public static const player_take_bible_berobbed:Object = {module:148, action:77, request:[], response:[Utils.StringUtil, Utils.StringUtil, Utils.ByteUtil]};
        public static const game_timer:Object = {module:148, action:61, request:[], response:[Utils.ByteUtil]};
        public static const send_flower:Object = {module:148, action:118, request:[], response:[Utils.StringUtil, Utils.StringUtil, Utils.IntUtil, Utils.IntUtil, Utils.ByteUtil]};
        public static const pass_tower:Object = {module:148, action:100, request:[], response:[Utils.StringUtil, Utils.ByteUtil, Utils.ByteUtil]};
        public static const update_rulai_status:Object = {module:148, action:163, request:[], response:[Utils.ByteUtil, [Utils.IntUtil, Utils.StringUtil], Utils.IntUtil, Utils.ShortUtil]};
        public static const roll_cake:Object = {module:148, action:220, request:[], response:[Utils.IntUtil, Utils.StringUtil, Utils.ByteUtil]};
        public static const update_server_war_step:Object = {module:148, action:206, request:[], response:[Utils.ByteUtil]};
        public static const have_new_server_war_report:Object = {module:148, action:236, request:[], response:[Utils.ByteUtil]};
        public static const server_war_winner:Object = {module:148, action:146, request:[], response:[Utils.ByteUtil, Utils.StringUtil, Utils.StringUtil, Utils.StringUtil]};
        public static const world_war_top_login:Object = {module:148, action:11, request:[], response:[Utils.StringUtil]};
        public static const zodiac_entry_notify:Object = {module:148, action:179, request:[], response:[Utils.StringUtil, Utils.ByteUtil]};
        public static const get_pet_animal_exp:Object = {module:148, action:109, request:[], response:[Utils.StringUtil]};
        public static const study_stunt_notify:Object = {module:148, action:183, request:[], response:[Utils.StringUtil, Utils.ShortUtil]};
        public static const flower_week_number_one:Object = {module:148, action:214, request:[], response:[Utils.StringUtil]};
        public static const cat_hunt_golden_box:Object = {module:148, action:161, request:[], response:[Utils.StringUtil, Utils.IntUtil, Utils.IntUtil]};
        public static const update_world_faction_war_step:Object = {module:148, action:65, request:[], response:[Utils.ByteUtil]};
        public static const update_world_faction_war_team:Object = {module:148, action:115, request:[], response:[Utils.ByteUtil]};
        public static const world_faction_war_winner:Object = {module:148, action:133, request:[], response:[Utils.StringUtil, Utils.StringUtil, Utils.StringUtil]};
        public static const have_new_world_faction_war_report:Object = {module:148, action:211, request:[], response:[Utils.ByteUtil]};
        public static const week_ranking:Object = {module:148, action:158, request:[], response:[Utils.ByteUtil, Utils.StringUtil]};
        public static const special_notify:Object = {module:148, action:225, request:[], response:[Utils.ByteUtil]};
        public static const find_immortal_five_notify:Object = {module:148, action:127, request:[], response:[Utils.IntUtil, Utils.StringUtil, Utils.ByteUtil]};
        public static const exchange_hu_lu_wa_notify:Object = {module:148, action:197, request:[], response:[Utils.IntUtil, Utils.StringUtil]};
        public static const unlock_special_partner:Object = {module:148, action:26, request:[], response:[[Utils.IntUtil]]};
        public static const world_top_war_gift_has_white_tiger:Object = {module:148, action:218, request:[], response:[Utils.IntUtil, Utils.StringUtil]};
        public static const lucky_wheel_award_seven_medicine_reel:Object = {module:148, action:81, request:[], response:[Utils.IntUtil, Utils.StringUtil, Utils.IntUtil]};
        public static const update_server_faction_war_step:Object = {module:148, action:170, request:[], response:[Utils.ByteUtil]};
        public static const have_new_server_faction_war_report:Object = {module:148, action:37, request:[], response:[Utils.ByteUtil]};
        public static const server_faction_war_winner:Object = {module:148, action:187, request:[], response:[Utils.StringUtil]};
        public static const Actions:Array = ["mission_award", "pk_award", "complete_reel_production", "role_num_notify", "new_research_notify", "new_partners_notify", "notify_get_good_fate", "notify_player_mission_practice_status", "update_player_super_gift", "change_equip", "update_lucky_shop_item", "buy_good_stuff_in_lucky_shop", "disband_faction_notify", "kickout_member_notify", "player_take_bible", "player_take_bible_berobbed", "game_timer", "send_flower", "pass_tower", "update_rulai_status", "roll_cake", "update_server_war_step", "have_new_server_war_report", "server_war_winner", "world_war_top_login", "zodiac_entry_notify", "get_pet_animal_exp", "study_stunt_notify", "flower_week_number_one", "cat_hunt_golden_box", "update_world_faction_war_step", "update_world_faction_war_team", "world_faction_war_winner", "have_new_world_faction_war_report", "week_ranking", "special_notify", "find_immortal_five_notify", "exchange_hu_lu_wa_notify", "unlock_special_partner", "world_top_war_gift_has_white_tiger", "lucky_wheel_award_seven_medicine_reel", "update_server_faction_war_step", "have_new_server_faction_war_report", "server_faction_war_winner"];

        public function Mod_Notify_Base()
        {
            return;
        }// end function

    }
}
