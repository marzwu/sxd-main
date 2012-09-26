package com.views
{
    import com.assist.server.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;

    public class BeelzebubTrialsView extends Base implements IView
    {
        private var _isCreateFirst:Boolean = true;
        private var _canChallengeList:Array;
        private var _beelzebubtrials:IBeelzebubTrials;
        private var _playerNickName:String;
        public var openType:int = 1;
        public var isOpen:Boolean;
        private var _createBeelzebubId:int = 0;
        private var _beelzebudId:int = 0;
        private var _joinTeamId:int = 0;
        private var _missionId:int = 0;
        private var _isCall:Boolean = false;
        private var _limit:int = 2;
        private var _playerTeamId:int = 0;

        public function BeelzebubTrialsView()
        {
            return;
        }// end function

        public function createTeam(param1:int, param2:int) : void
        {
            this._data.call(Mod_BeelzebubTrials_Base.create_beelzebub_trials_team, this.createteamcallback, [param1, param2]);
            return;
        }// end function

        public function getTeamlist(param1:int, param2:int) : void
        {
            this._data.call(Mod_BeelzebubTrials_Base.get_beelzebub_trials_team_list, this.getteamlistcallback, [param1, param2]);
            return;
        }// end function

        public function joinTeamForChat(param1:int, param2:int) : void
        {
            this._joinTeamId = param1;
            this._missionId = param2;
            this.joinTeam(param1);
            return;
        }// end function

        public function joinTeam(param1:int) : void
        {
            this._data.call(Mod_BeelzebubTrials_Base.join_beelzebub_trials_team, this.joinTeamCallBack, [param1]);
            return;
        }// end function

        public function openBeelzebubTrials() : void
        {
            this._data.call(Mod_BeelzebubTrials_Base.open_beelzebub_trials, this.openBeelzebubTrialsCallBack, []);
            return;
        }// end function

        public function closeBeelzebubTrials() : void
        {
            this._data.call(Mod_BeelzebubTrials_Base.close_beelzebub_trials, new Function(), []);
            return;
        }// end function

        private function exitTeam() : void
        {
            this._data.call(Mod_BeelzebubTrials_Base.exit_beelzebub_trials_team, this.exitTeamCallBack, []);
            return;
        }// end function

        public function challengeList() : void
        {
            this._data.call(Mod_BeelzebubTrials_Base.get_player_can_challenge_list, this.canChallengeListCallBack, []);
            return;
        }// end function

        private function openBeelzebubTrialsCallBack() : void
        {
            loadAssets("BeelzebubTrials", this.render, BeelzebubTrialsViewLang.LoadAssets);
            return;
        }// end function

        private function getteamlistcallback() : void
        {
            var _loc_4:Object = null;
            var _loc_1:* = _ctrl.beelzebubTrials.getteamlist;
            var _loc_2:* = new Array();
            var _loc_3:* = new Array();
            if (_loc_1 != null)
            {
                for each (_loc_4 in _loc_1)
                {
                    
                    if (_loc_4["leader_faction_id"] == _ctrl.beelzebubTrials.leaderFactionId || this._playerTeamId == _loc_4["team_id"])
                    {
                        _loc_3.push(_loc_4);
                    }
                    if (_loc_4["leader_faction_id"] == _ctrl.beelzebubTrials.leaderFactionId || _loc_4["limit_condition"] != Mod_BeelzebubTrials_Base.SAME_GANG)
                    {
                        _loc_2.push(_loc_4);
                    }
                }
            }
            if (this._limit == Mod_BeelzebubTrials_Base.SAME_GANG)
            {
                this._beelzebubtrials.teamlist = _loc_3;
            }
            else
            {
                this._beelzebubtrials.teamlist = _loc_2;
            }
            this._isCall = false;
            return;
        }// end function

        private function createteamcallback() : void
        {
            var _loc_1:* = _ctrl.beelzebubTrials.createteamResult;
            if (_loc_1 == Mod_BeelzebubTrials_Base.SUCCESS)
            {
                _view.beelzebubTrialsMap.gotoBossTown(TownType.getId(TownType.MoWangShiLian), this._createBeelzebubId);
                this.close();
            }
            else
            {
                this.renderMsg(_loc_1);
            }
            this._isCall = false;
            return;
        }// end function

        private function joinTeamCallBack() : void
        {
            var _loc_1:* = _ctrl.beelzebubTrials.joinTeamResult;
            if (_loc_1 == Mod_BeelzebubTrials_Base.SUCCESS)
            {
                _view.beelzebubTrialsMap.gotoBossTown(TownType.getId(TownType.MoWangShiLian), this._missionId);
                if (this._beelzebubtrials)
                {
                    this._beelzebubtrials.teamId = this._joinTeamId;
                }
                this._playerTeamId = this._joinTeamId;
                this.close();
            }
            else
            {
                this.renderMsg(_loc_1);
            }
            this._isCall = false;
            return;
        }// end function

        private function newTeamCallBack() : void
        {
            if (this.inStage == false)
            {
                return;
            }
            var _loc_1:* = _ctrl.beelzebubTrials.newTeamList;
            if (_loc_1.length == 0)
            {
                return;
            }
            this.addNewTeam(_loc_1);
            return;
        }// end function

        private function addNewTeam(param1:Array) : void
        {
            var _loc_2:* = param1.pop();
            this._beelzebubtrials.newTeam = _loc_2;
            if (param1.length != 0)
            {
                this.addNewTeam(param1);
            }
            return;
        }// end function

        private function dropTeamCallBack() : void
        {
            if (this.inStage == false)
            {
                return;
            }
            this._beelzebubtrials.dropTeamID = _ctrl.beelzebubTrials.drapTeam;
            return;
        }// end function

        private function updateMemberNumber() : void
        {
            if (this.inStage == false)
            {
                return;
            }
            this._beelzebubtrials.teamMemberNum = _ctrl.beelzebubTrials.updatemember;
            return;
        }// end function

        public function notifyHandle(param1:int) : void
        {
            if (param1 == Mod_BeelzebubTrials_Base.LEADER_DISSOLVE || Mod_BeelzebubTrials_Base.KICK_OUT_TEAM || param1 == Mod_BeelzebubTrials_Base.STOP_BEELZEBUB_TRAILS)
            {
                this.openType = 1;
                if (this._beelzebubtrials != null)
                {
                    this._beelzebubtrials.teamId = 0;
                }
                this._playerTeamId = 0;
                if (this.inStage)
                {
                    this.close();
                }
            }
            return;
        }// end function

        private function exitTeamCallBack() : void
        {
            var _loc_1:* = _ctrl.beelzebubTrials.exitFlag;
            if (_loc_1 == Mod_BeelzebubTrials_Base.SUCCESS)
            {
                this._beelzebubtrials.teamId = 0;
            }
            else
            {
                this.renderMsg(_loc_1);
            }
            return;
        }// end function

        private function renderMsg(param1:int) : void
        {
            switch(param1)
            {
                case Mod_BeelzebubTrials_Base.START_BEELZEBUB_TRAILS:
                {
                    _view.showTip(BeelzebubTrialsViewLang.StartBeelzebubTrials);
                    break;
                }
                case Mod_BeelzebubTrials_Base.STOP_BEELZEBUB_TRAILS:
                {
                    _view.showTip(BeelzebubTrialsViewLang.StopBeelzebubTrials);
                    break;
                }
                case Mod_BeelzebubTrials_Base.INVALID_BEELZEBUB_TRIALS_ID:
                {
                    _view.showTip(BeelzebubTrialsViewLang.InvalidId);
                    break;
                }
                case Mod_BeelzebubTrials_Base.FULL_TEAM_NUMBER:
                {
                    _view.showTip(BeelzebubTrialsViewLang.FullTeamNumber);
                    break;
                }
                case Mod_BeelzebubTrials_Base.FAILED:
                {
                    _view.showTip(BeelzebubTrialsViewLang.Failed);
                    break;
                }
                case Mod_BeelzebubTrials_Base.FULL_MEMBER:
                {
                    _view.showTip(BeelzebubTrialsViewLang.FullMember);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function canChallengeListCallBack() : void
        {
            this._canChallengeList = _ctrl.beelzebubTrials.canChallengeList;
            return;
        }// end function

        public function get canChallengeList() : Array
        {
            return this._canChallengeList;
        }// end function

        public function show() : void
        {
            if (_view.tower.inStageWithTip)
            {
                return;
            }
            if (_view.campWar.inStageWithTip)
            {
                return;
            }
            if (_view.heroesWar.inStageWithTip)
            {
                return;
            }
            if (_view.missionPractice.inStageWithTip)
            {
                return;
            }
            if (_view.heroPractice.inStageWithTip)
            {
                return;
            }
            if (_view.getPeach.inStageWithTip)
            {
                return;
            }
            this.openBeelzebubTrials();
            return;
        }// end function

        public function clear() : void
        {
            _data.cancelPatch(Mod_BeelzebubTrials_Base.notify_new_team);
            _data.cancelPatch(Mod_BeelzebubTrials_Base.notify_drop_team);
            _data.cancelPatch(Mod_BeelzebubTrials_Base.notify_update_member_number);
            return;
        }// end function

        public function close() : void
        {
            this._isCall = false;
            this.clear();
            if (this._beelzebubtrials)
            {
                this._beelzebubtrials.clear();
            }
            _popup.closeView(this);
            this.closeBeelzebubTrials();
            return;
        }// end function

        private function render() : void
        {
            if (this._beelzebubtrials == null)
            {
                this._beelzebubtrials = _view.getAssetsObject("BeelzebubTrials", "BeelzebubTrials") as IBeelzebubTrials;
                this._beelzebubtrials.tip = _view.tip.iTip;
                this._beelzebubtrials.drag = _view.drag.iDrag;
            }
            this.openType = this._view.beelzebubTrialsMap.inStage == true ? (2) : (1);
            this._beelzebubtrials.getOpenUI(this.openType);
            _popup.addView(this, this._beelzebubtrials.content);
            _view.center(sign, this._beelzebubtrials.content);
            this._beelzebubtrials.teamId = this._playerTeamId;
            this._beelzebubtrials.challengeTimes = _ctrl.beelzebubTrials.chanchallengetimes;
            if (this.openType == 1)
            {
                this._beelzebubtrials.createganglimit = Mod_BeelzebubTrials_Base.NOT_LIMIT;
                this._beelzebubtrials.createbeelzebublist = _ctrl.beelzebubTrials.createBeelzebublist;
            }
            this._beelzebubtrials.nickname = _ctrl.player.nickname;
            this._beelzebubtrials.leaderFactionId = _ctrl.beelzebubTrials.leaderFactionId;
            this._beelzebubtrials.joinbeelzebublist = _ctrl.beelzebubTrials.joinBeelzebubList;
            this._beelzebubtrials.conditionCurrent = Mod_BeelzebubTrials_Base.ALL_RECORD;
            this._limit = 2;
            this._beelzebubtrials.onJoin = function (param1:int, param2:int) : void
            {
                if (_isCall)
                {
                    return;
                }
                _isCall = true;
                _joinTeamId = param1;
                _missionId = param2;
                joinTeam(param1);
                return;
            }// end function
            ;
            this._beelzebubtrials.onGetTeamList = function (param1:int, param2:int) : void
            {
                if (_isCall)
                {
                    return;
                }
                _limit = param2;
                _beelzebudId = param1;
                getTeamlist(param1, param2);
                return;
            }// end function
            ;
            this._beelzebubtrials.onExitTeam = function () : void
            {
                exitTeam();
                return;
            }// end function
            ;
            this._beelzebubtrials.onClose = function () : void
            {
                close();
                return;
            }// end function
            ;
            this._beelzebubtrials.onCreateTeam = function (param1:int, param2:int) : void
            {
                if (_isCall)
                {
                    return;
                }
                _isCall = true;
                _createBeelzebubId = param1;
                createTeam(param1, param2);
                return;
            }// end function
            ;
            _data.patch(Mod_BeelzebubTrials_Base.notify_new_team, this.newTeamCallBack);
            _data.patch(Mod_BeelzebubTrials_Base.notify_drop_team, this.dropTeamCallBack);
            _data.patch(Mod_BeelzebubTrials_Base.notify_update_member_number, this.updateMemberNumber);
            this.challengeList();
            this.getTeamlist(0, Mod_BeelzebubTrials_Base.ALL_RECORD);
            return;
        }// end function

        public function set playerTeamId(param1:int) : void
        {
            this._playerTeamId = param1;
            return;
        }// end function

    }
}
