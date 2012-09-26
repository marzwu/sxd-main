package com.protocols
{
    import com.*;

    public class Mod_BeelzebubTrials extends Object
    {

        public function Mod_BeelzebubTrials()
        {
            return;
        }// end function

        public static function register(param1:Data) : void
        {
            param1.registerDataCallback(Mod_BeelzebubTrials_Base.get_beelzebub_trials_open_time, param1.beelzebubtrials.get_beelzebub_trials_open_time);
            param1.registerDataCallback(Mod_BeelzebubTrials_Base.open_beelzebub_trials, param1.beelzebubtrials.open_beelzebub_trials);
            param1.registerDataCallback(Mod_BeelzebubTrials_Base.get_beelzebub_trials_team_list, param1.beelzebubtrials.get_beelzebub_trials_team_list);
            param1.registerDataCallback(Mod_BeelzebubTrials_Base.create_beelzebub_trials_team, param1.beelzebubtrials.create_beelzebub_trials_team);
            param1.registerDataCallback(Mod_BeelzebubTrials_Base.join_beelzebub_trials_team, param1.beelzebubtrials.join_beelzebub_trials_team);
            param1.registerDataCallback(Mod_BeelzebubTrials_Base.notify, param1.beelzebubtrials.notify);
            param1.registerDataCallback(Mod_BeelzebubTrials_Base.notify_new_team, param1.beelzebubtrials.notify_new_team);
            param1.registerDataCallback(Mod_BeelzebubTrials_Base.notify_drop_team, param1.beelzebubtrials.notify_drop_team);
            param1.registerDataCallback(Mod_BeelzebubTrials_Base.notify_update_member_number, param1.beelzebubtrials.notify_update_member_number);
            param1.registerDataCallback(Mod_BeelzebubTrials_Base.get_player_can_challenge_list, param1.beelzebubtrials.get_player_can_challenge_list);
            param1.registerDataCallback(Mod_BeelzebubTrials_Base.get_player_team_info, param1.beelzebubtrials.getPlayerTeamInfo);
            param1.registerDataCallback(Mod_BeelzebubTrials_Base.choose_helper_role, param1.beelzebubtrials.chooseelperRole);
            param1.registerDataCallback(Mod_BeelzebubTrials_Base.get_helper_role_list, param1.beelzebubtrials.getHelperRoleList);
            param1.registerDataCallback(Mod_BeelzebubTrials_Base.get_war_result, param1.beelzebubtrials.get_war_result);
            param1.registerDataCallback(Mod_BeelzebubTrials_Base.exit_beelzebub_trials_team, param1.beelzebubtrials.exitTeam);
            param1.registerDataCallback(Mod_BeelzebubTrials_Base.kicked_out_member, param1.beelzebubtrials.kicked_out_member);
            return;
        }// end function

    }
}
