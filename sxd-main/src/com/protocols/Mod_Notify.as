package com.protocols
{
    import com.*;

    public class Mod_Notify extends Object
    {

        public function Mod_Notify()
        {
            return;
        }// end function

        public static function register(param1:Data) : void
        {
            param1.registerDataCallback(Mod_Notify_Base.mission_award, param1.notify.mission_award);
            param1.registerDataCallback(Mod_Notify_Base.pk_award, param1.notify.pk_award);
            param1.registerDataCallback(Mod_Notify_Base.complete_reel_production, param1.notify.complete_reel_production);
            param1.registerDataCallback(Mod_Notify_Base.disband_faction_notify, param1.notify.disband_faction_notify);
            param1.registerDataCallback(Mod_Notify_Base.kickout_member_notify, param1.notify.kickout_member_notify);
            param1.registerDataCallback(Mod_Notify_Base.role_num_notify, param1.notify.role_num_notify);
            param1.registerDataCallback(Mod_Notify_Base.new_research_notify, param1.notify.new_research_notify);
            param1.registerDataCallback(Mod_Notify_Base.new_partners_notify, param1.notify.new_partners_notify);
            param1.registerDataCallback(Mod_Notify_Base.update_player_super_gift, param1.notify.update_player_super_gift);
            param1.registerDataCallback(Mod_Notify_Base.notify_get_good_fate, param1.notify.notify_get_good_fate);
            param1.registerDataCallback(Mod_Notify_Base.change_equip, param1.notify.change_equip);
            param1.registerDataCallback(Mod_Notify_Base.update_lucky_shop_item, param1.notify.update_lucky_shop_item);
            param1.registerDataCallback(Mod_Notify_Base.buy_good_stuff_in_lucky_shop, param1.notify.buy_good_stuff_in_lucky_shop);
            param1.registerDataCallback(Mod_Notify_Base.notify_player_mission_practice_status, param1.notify.notify_player_mission_practice_status);
            param1.registerDataCallback(Mod_Notify_Base.player_take_bible, param1.notify.player_take_bible);
            param1.registerDataCallback(Mod_Notify_Base.player_take_bible_berobbed, param1.notify.player_take_bible_berobbed);
            param1.registerDataCallback(Mod_Notify_Base.game_timer, param1.notify.game_timer);
            param1.registerDataCallback(Mod_Notify_Base.send_flower, param1.notify.send_flower);
            param1.registerDataCallback(Mod_Notify_Base.pass_tower, param1.notify.pass_tower);
            param1.registerDataCallback(Mod_Notify_Base.update_rulai_status, param1.notify.update_rulai_status);
            param1.registerDataCallback(Mod_Notify_Base.roll_cake, param1.notify.roll_cake);
            param1.registerDataCallback(Mod_Notify_Base.update_server_war_step, param1.notify.update_server_war_step);
            param1.registerDataCallback(Mod_Notify_Base.have_new_server_war_report, param1.notify.have_new_server_war_report);
            param1.registerDataCallback(Mod_Notify_Base.server_war_winner, param1.notify.server_war_winner);
            param1.registerDataCallback(Mod_Notify_Base.server_faction_war_winner, param1.notify.server_faction_war_winner);
            param1.registerDataCallback(Mod_Notify_Base.world_war_top_login, param1.notify.world_war_top_login);
            param1.registerDataCallback(Mod_Notify_Base.zodiac_entry_notify, param1.notify.zodiac_entry_notify);
            param1.registerDataCallback(Mod_Notify_Base.get_pet_animal_exp, param1.notify.get_pet_animal_exp);
            param1.registerDataCallback(Mod_Notify_Base.study_stunt_notify, param1.notify.study_stunt_notify);
            param1.registerDataCallback(Mod_Notify_Base.flower_week_number_one, param1.notify.flower_week_number_one);
            param1.registerDataCallback(Mod_Notify_Base.cat_hunt_golden_box, param1.notify.cat_hunt_golden_box);
            param1.registerDataCallback(Mod_Notify_Base.update_world_faction_war_step, param1.notify.update_world_faction_war_step);
            param1.registerDataCallback(Mod_Notify_Base.update_world_faction_war_team, param1.notify.update_world_faction_war_team);
            param1.registerDataCallback(Mod_Notify_Base.world_faction_war_winner, param1.notify.world_faction_war_winner);
            param1.registerDataCallback(Mod_Notify_Base.have_new_world_faction_war_report, param1.notify.have_new_world_faction_war_report);
            param1.registerDataCallback(Mod_Notify_Base.week_ranking, param1.notify.week_ranking);
            param1.registerDataCallback(Mod_Notify_Base.special_notify, param1.notify.special_notify);
            param1.registerDataCallback(Mod_Notify_Base.find_immortal_five_notify, param1.notify.find_immortal_five_notify);
            param1.registerDataCallback(Mod_Notify_Base.exchange_hu_lu_wa_notify, param1.notify.exchange_hu_lu_wa_notify);
            param1.registerDataCallback(Mod_Notify_Base.unlock_special_partner, param1.notify.unlock_special_partner);
            param1.registerDataCallback(Mod_Notify_Base.world_top_war_gift_has_white_tiger, param1.notify.world_top_war_gift_has_white_tiger);
            param1.registerDataCallback(Mod_Notify_Base.lucky_wheel_award_seven_medicine_reel, param1.notify.lucky_wheel_award_seven_medicine_reel);
            param1.registerDataCallback(Mod_Notify_Base.update_server_faction_war_step, param1.notify.update_server_faction_war_step);
            param1.registerDataCallback(Mod_Notify_Base.have_new_server_faction_war_report, param1.notify.have_new_server_faction_war_report);
            return;
        }// end function

    }
}
