package com.protocols
{
    import com.*;

    public class Mod_TakeBible extends Object
    {

        public function Mod_TakeBible()
        {
            return;
        }// end function

        public static function register(param1:Data) : void
        {
            param1.registerDataCallback(Mod_TakeBible_Base.open_take_bible, param1.takeBible.open_take_bible);
            param1.registerDataCallback(Mod_TakeBible_Base.close_take_bible, param1.takeBible.close_take_bible);
            param1.registerDataCallback(Mod_TakeBible_Base.get_take_bible_info, param1.takeBible.get_take_bible_info);
            param1.registerDataCallback(Mod_TakeBible_Base.apply_friend, param1.takeBible.apply_friend);
            param1.registerDataCallback(Mod_TakeBible_Base.cancel_apply_friend, param1.takeBible.cancel_apply_friend);
            param1.registerDataCallback(Mod_TakeBible_Base.approve_apply, param1.takeBible.approve_apply);
            param1.registerDataCallback(Mod_TakeBible_Base.reject_apply, param1.takeBible.reject_apply);
            param1.registerDataCallback(Mod_TakeBible_Base.buy_protection, param1.takeBible.buy_protection);
            param1.registerDataCallback(Mod_TakeBible_Base.refresh, param1.takeBible.refresh);
            param1.registerDataCallback(Mod_TakeBible_Base.get_player_take_bible, param1.takeBible.get_player_take_bible);
            param1.registerDataCallback(Mod_TakeBible_Base.start_take_bible, param1.takeBible.start_take_bible);
            param1.registerDataCallback(Mod_TakeBible_Base.rob, param1.takeBible.rob);
            param1.registerDataCallback(Mod_TakeBible_Base.notify, param1.takeBible.notify);
            param1.registerDataCallback(Mod_TakeBible_Base.notify_global, param1.takeBible.notify_global);
            param1.registerDataCallback(Mod_TakeBible_Base.quickly, param1.takeBible.quickly);
            param1.registerDataCallback(Mod_TakeBible_Base.get_take_bible_updata_data, param1.takeBible.get_take_bible_updata_data);
            param1.registerDataCallback(Mod_TakeBible_Base.get_rob_take_bible_cd_time, param1.takeBible.get_rob_take_bible_cd_time);
            param1.registerDataCallback(Mod_TakeBible_Base.clear_rob_take_bible_cd_time, param1.takeBible.clear_rob_take_bible_cd_time);
            param1.registerDataCallback(Mod_TakeBible_Base.buy_bless, param1.takeBible.buy_bless);
            param1.registerDataCallback(Mod_TakeBible_Base.call_rulai, param1.takeBible.call_rulai);
            param1.registerDataCallback(Mod_TakeBible_Base.get_rulai_open_time, param1.takeBible.get_rulai_open_time);
            param1.registerDataCallback(Mod_TakeBible_Base.take_bible_info, param1.takeBible.take_bible_info);
            param1.registerDataCallback(Mod_TakeBible_Base.open_call_rulai, param1.takeBible.open_call_rulai);
            param1.registerDataCallback(Mod_TakeBible_Base.notify_call_rulai, param1.takeBible.notify_call_rulai);
            return;
        }// end function

    }
}
