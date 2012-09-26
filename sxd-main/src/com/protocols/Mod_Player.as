package com.protocols
{
    import com.*;

    public class Mod_Player extends Object
    {

        public function Mod_Player()
        {
            return;
        }// end function

        public static function register(param1:Data) : void
        {
            var _loc_2:* = param1.registerDataCallback;
            Mod_Player._loc_2(Mod_Player_Base.login, param1.player.login);
            Mod_Player._loc_2(Mod_Player_Base.player_first_init, param1.player.player_first_init);
            Mod_Player._loc_2(Mod_Player_Base.get_player_info, param1.player.get_player_info);
            Mod_Player._loc_2(Mod_Player_Base.update_player_data, param1.player.update_player_data);
            Mod_Player._loc_2(Mod_Player_Base.update_player_data_for_town, param1.player.update_player_data_for_town);
            Mod_Player._loc_2(Mod_Player_Base.get_player_function, param1.player.get_player_function);
            Mod_Player._loc_2(Mod_Player_Base.sign_play_player_function, param1.player.sign_play_player_function);
            Mod_Player._loc_2(Mod_Player_Base.buy_power, param1.player.buy_power);
            Mod_Player._loc_2(Mod_Player_Base.set_player_camp, param1.player.set_player_camp);
            Mod_Player._loc_2(Mod_Player_Base.get_other_player_info, param1.player.get_other_player_info);
            Mod_Player._loc_2(Mod_Player_Base.get_buy_power_data, param1.player.get_buy_power_data);
            Mod_Player._loc_2(Mod_Player_Base.receive_player_delay_notify_message, param1.player.receive_player_delay_notify_message);
            Mod_Player._loc_2(Mod_Player_Base.validate_id_card, param1.player.validate_id_card);
            Mod_Player._loc_2(Mod_Player_Base.against_wallows_notify, param1.player.against_wallows_notify);
            Mod_Player._loc_2(Mod_Player_Base.against_wallows_info, param1.player.against_wallows_info);
            Mod_Player._loc_2(Mod_Player_Base.is_weichengnian, param1.player.is_weichengnian);
            Mod_Player._loc_2(Mod_Player_Base.server_time, param1.player.server_time);
            Mod_Player._loc_2(Mod_Player_Base.get_player_camp_salary, param1.player.get_player_camp_salary);
            Mod_Player._loc_2(Mod_Player_Base.player_get_online_gift, param1.player.player_get_online_gift);
            Mod_Player._loc_2(Mod_Player_Base.get_player_current_online_gift, param1.player.get_player_current_online_gift);
            Mod_Player._loc_2(Mod_Player_Base.get_affiche_list, param1.player.get_affiche_list);
            Mod_Player._loc_2(Mod_Player_Base.practice_notify, param1.player.practice_notify);
            Mod_Player._loc_2(Mod_Player_Base.get_practice_data, param1.player.get_practice_data);
            Mod_Player._loc_2(Mod_Player_Base.get_player_war_cd_time, param1.player.get_player_war_cd_time);
            Mod_Player._loc_2(Mod_Player_Base.get_game_assistant_info, param1.player.get_game_assistant_info);
            Mod_Player._loc_2(Mod_Player_Base.send_ingot_receive_show_vip, param1.player.send_ingot_receive_show_vip);
            Mod_Player._loc_2(Mod_Player_Base.get_warning_affiche, param1.player.get_warning_affiche);
            Mod_Player._loc_2(Mod_Player_Base.back_times, param1.player.back_times);
            Mod_Player._loc_2(Mod_Player_Base.player_info_contrast, param1.player.player_info_contrast);
            Mod_Player._loc_2(Mod_Player_Base.player_consume_alert_set_info, param1.consumeAlertSetting.player_consume_alert_set_info);
            Mod_Player._loc_2(Mod_Player_Base.player_consume_alert_set, param1.consumeAlertSetting.player_consume_alert_set);
            Mod_Player._loc_2(Mod_Player_Base.get_player_info_by_username, param1.player.get_player_info_by_username);
            Mod_Player._loc_2(Mod_Player_Base.player_follow_setting, param1.player.player_follow_setting);
            return;
        }// end function

    }
}
