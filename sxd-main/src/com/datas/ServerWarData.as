package com.datas
{
    import com.*;
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.info.*;
    import com.haloer.data.*;
    import com.haloer.display.*;
    import com.lang.client.com.datas.*;
    import com.protocols.*;
    import flash.display.*;

    public class ServerWarData extends Base
    {
        public var info:ServerWarInfo;
        public var result:int = 0;
        public var signupState:int = 0;
        public var dieoutTip:String = "";
        public var dieoutWarList:Array;

        public function ServerWarData() : void
        {
            this.info = new ServerWarInfo();
            this.dieoutWarList = [];
            return;
        }// end function

        public function get_race_step(param1:Array) : void
        {
            var _loc_2:Object = null;
            var _loc_3:Array = null;
            this.info.removeNickNameSuffix = _data.player.removeNickNameSuffix;
            _loc_2 = {};
            oObject.list(param1, _loc_2, ["race_type", "race_step", "player_step", "war_round", "player_number", "time_list", "cup_race_time_step", "apply_id", "group", "level_step", "war_zone", "server_list"]);
            this.info.playerName = _data.player.removeNickNameSuffix(_data.player.nickname);
            this.info.warType = _loc_2.race_type;
            this.info.stateServer = _loc_2.race_step;
            this.info.statePlayer = _loc_2.player_step;
            this.info.playerId = _loc_2.apply_id;
            this.info.groupPlayer = _loc_2.group;
            this.info.zoneName = _loc_2.war_zone;
            this.info.roundTimeInterval = _loc_2.cup_race_time_step;
            if (this.info.groupCup == Mod_ServerWar_Base.GROUP_NULL)
            {
                this.info.groupCup = _loc_2.group;
            }
            for each (_loc_3 in _loc_2.time_list)
            {
                
                this.info.roundTimeList[_loc_3[0]] = _loc_3[1];
            }
            this.info.serverNameList = [];
            for each (_loc_3 in _loc_2.server_list)
            {
                
                this.info.serverNameList.push(_loc_3.join(" "));
            }
            this.dieoutTip = "";
            if (_loc_2.race_step == Mod_ServerWar_Base.SERVER_WAR_TIANBANG)
            {
                this.dieoutTip = Lang.sprintf(ServerWarDataLang.TianBangRoundIdx, _loc_2.war_round, _loc_2.player_number);
                this.dieoutTip = HtmlText.green(this.dieoutTip);
            }
            else if (_loc_2.race_step == Mod_ServerWar_Base.SERVER_WAR_DIBANG)
            {
                this.dieoutTip = Lang.sprintf(ServerWarDataLang.DiBangRoundIdx, _loc_2.war_round, _loc_2.player_number);
                this.dieoutTip = HtmlText.green(this.dieoutTip);
            }
            return;
        }// end function

        public function get_standings(param1:Array) : void
        {
            var _loc_4:Array = null;
            var _loc_5:Object = null;
            this.info.stateServer = param1[0];
            this.info.groupCup = param1[3];
            var _loc_2:String = "";
            this.dieoutTip = "";
            if (param1[0] == Mod_ServerWar_Base.SERVER_WAR_TIANBANG)
            {
                _loc_2 = ServerWarDataLang.TianBangRound;
                this.dieoutTip = Lang.sprintf(ServerWarDataLang.TianBangRoundIdx, param1[1], param1[2]);
            }
            else if (param1[0] == Mod_ServerWar_Base.SERVER_WAR_DIBANG)
            {
                _loc_2 = ServerWarDataLang.DiBangRound;
                this.dieoutTip = Lang.sprintf(ServerWarDataLang.DiBangRoundIdx, param1[1], param1[2]);
            }
            if (this.dieoutTip != "")
            {
                if (param1[4] == 1)
                {
                    this.dieoutTip = HtmlText.green(ServerWarDataLang.Into32) + this.dieoutTip;
                    _loc_2 = ServerWarDataLang.TianBangRound;
                }
                else if (param1[4] == 2)
                {
                    this.dieoutTip = HtmlText.red(this.dieoutTip + ServerWarDataLang.Out);
                }
                this.dieoutTip = HtmlText.green(this.dieoutTip);
                if (this.info.groupCup == Mod_ServerWar_Base.GROUP_TIAN_BANG && this.info.warType == Mod_ServerWar_Base.RACE_TYPE_STAGE_RACE)
                {
                    _loc_2 = ServerWarDataLang.TianBangRound;
                    this.dieoutTip = HtmlText.green(ServerWarDataLang.Into32) + this.dieoutTip;
                }
            }
            this.dieoutWarList = [];
            if (param1[5].length == 0)
            {
                return;
            }
            param1[5].sortOn("3", Array.NUMERIC);
            var _loc_3:int = 0;
            for each (_loc_4 in param1[5])
            {
                
                _loc_5 = {};
                _loc_5.idx = Lang.sprintf(_loc_2, ++_loc_3);
                _loc_5.name = _data.player.removeNickNameSuffix(_loc_4[1]);
                _loc_5.name = this.linkText(_loc_5.name, ["player", _loc_4[0], _loc_5.name]);
                if (_loc_4[2] == 1)
                {
                    _loc_5.mark = HtmlText.white("1:0");
                    _loc_5.win = HtmlText.white(this.linkText(ServerWarDataLang.Win, ["war", _loc_4[3], _loc_4[4]]));
                }
                else
                {
                    _loc_5.mark = HtmlText.red("0:1");
                    _loc_5.win = HtmlText.red(this.linkText(ServerWarDataLang.NoWin, ["war", _loc_4[3], _loc_4[4]]));
                }
                this.dieoutWarList.unshift(_loc_5);
            }
            return;
        }// end function

        public function apply(param1:Array) : void
        {
            this.signupState = param1[0];
            return;
        }// end function

        public function get_race_list(param1:Array) : void
        {
            var _loc_5:Array = null;
            var _loc_6:Array = null;
            var _loc_7:Array = null;
            var _loc_8:Object = null;
            var _loc_9:Object = null;
            var _loc_10:Array = null;
            var _loc_11:Array = null;
            var _loc_12:int = 0;
            var _loc_2:Object = {};
            oObject.list(param1, _loc_2, ["group", "level", "player_list", "current_war_result", "top_16", "top_8", "top_4", "top_2", "top_1", "can_bet_coin_list"]);
            this.info.groupCup = _loc_2.group;
            this.info.setCupRoundWar(_loc_2.current_war_result);
            this.info.setCupCanBet(_loc_2.can_bet_coin_list);
            var _loc_3:Array = [null];
            var _loc_4:Array = [];
            for each (_loc_5 in _loc_2.player_list)
            {
                
                _loc_7 = ["player_id", "player_nickname", "role_id", "attack_power", "fame", "level", "stage_name", "view_server_name", "bet_coin", "role_list", "pet_name", "pet_level", "pet_step"];
                _loc_8 = {};
                _loc_9 = {};
                oObject.list(_loc_5.slice(0, 13), _loc_8, _loc_7);
                oObject.list(_loc_5.slice(13, 26), _loc_9, _loc_7);
                _loc_8.headUrl = URI.iconsUrl + RoleType.getRoleSign(_loc_8.role_id) + ".png";
                _loc_9.headUrl = URI.iconsUrl + RoleType.getRoleSign(_loc_9.role_id) + ".png";
                _loc_8.role_list.sort(Array.NUMERIC | Array.DESCENDING);
                _loc_9.role_list.sort(Array.NUMERIC | Array.DESCENDING);
                _loc_10 = [];
                _loc_11 = [];
                _loc_12 = 0;
                for each (_loc_12 in _loc_8.role_list)
                {
                    
                    if (_loc_12 > 6)
                    {
                        _loc_10.push(this.getRoleIcon(_loc_12));
                    }
                }
                for each (_loc_12 in _loc_9.role_list)
                {
                    
                    if (_loc_12 > 6)
                    {
                        _loc_11.push(this.getRoleIcon(_loc_12));
                    }
                }
                _loc_8.role_list = _loc_10;
                _loc_9.role_list = _loc_11;
                this.info.getUserData(_loc_8.player_id).initData(_loc_8);
                this.info.getUserData(_loc_9.player_id).initData(_loc_9);
                _loc_3.push([_loc_8.player_id, _loc_9.player_id]);
                if (_loc_8.player_id != 0)
                {
                    _loc_4.push(_loc_8.player_id);
                }
                if (_loc_9.player_id != 0)
                {
                    _loc_4.push(_loc_9.player_id);
                }
            }
            this.info.groupList = _loc_3;
            _loc_6 = this.info.stateServer != Mod_ServerWar_Base.SERVER_WAR_1_COMPLETE ? ([0]) : ([_loc_2.top_1]);
            this.info.setRoundWin(this.mergerArray(_loc_2.top_16), this.mergerArray(_loc_2.top_8), this.mergerArray(_loc_2.top_4), this.mergerArray(_loc_2.top_2), _loc_6, _loc_4);
            return;
        }// end function

        private function mergerArray(param1:Array) : Array
        {
            var _loc_3:int = 0;
            var _loc_2:Array = [];
            for each (_loc_3 in param1)
            {
                
                _loc_2.push(_loc_3);
            }
            return _loc_2;
        }// end function

        private function getRoleIcon(param1:int) : Sprite
        {
            var _loc_2:DisplayObject = null;
            var _loc_3:* = new Sprite();
            _loc_3.addChild(new Image(URI.iconsMiniUrl + "Icon1.png"));
            var _loc_4:* = new Image(URI.iconsMiniUrl + RoleType.getRoleSign(param1) + ".png");
            _loc_2 = new Image(URI.iconsMiniUrl + RoleType.getRoleSign(param1) + ".png");
            _loc_3.addChild(_loc_4);
            _loc_2.x = 2;
            _loc_2.y = 2;
            var _loc_4:* = new Image(URI.iconsMiniUrl + "Icon2.png");
            _loc_2 = new Image(URI.iconsMiniUrl + "Icon2.png");
            _loc_3.addChild(_loc_4);
            _loc_2.x = 2;
            _loc_2.y = 2;
            return _loc_3;
        }// end function

        public function get_war_result_list(param1:Array) : void
        {
            param1[0].sortOn("3", Array.NUMERIC | Array.DESCENDING);
            this.info.pushRecordSee(param1[0]);
            return;
        }// end function

        public function get_race_standings(param1:Array) : void
        {
            var _loc_6:Array = null;
            var _loc_7:Array = null;
            this.info.resetRecord();
            var _loc_2:String = "";
            var _loc_3:int = 0;
            var _loc_4:Array = [];
            var _loc_5:Array = [];
            for each (_loc_6 in param1[0])
            {
                
                _loc_6[2] = _data.player.removeNickNameSuffix(_loc_6[2]);
                for each (_loc_7 in _loc_6[3])
                {
                    
                    switch(_loc_6[0])
                    {
                        case Mod_ServerWar_Base.SERVER_WAR_16:
                        {
                            this.info.pushRecord(16, _loc_6[1], _loc_6[2], _loc_7[0], _loc_7[1], _loc_7[2], this.info.getSerStateName(_loc_6[0], _loc_6[4]));
                            break;
                        }
                        case Mod_ServerWar_Base.SERVER_WAR_8:
                        {
                            this.info.pushRecord(8, _loc_6[1], _loc_6[2], _loc_7[0], _loc_7[1], _loc_7[2], this.info.getSerStateName(_loc_6[0], _loc_6[4]));
                            break;
                        }
                        case Mod_ServerWar_Base.SERVER_WAR_4:
                        {
                            this.info.pushRecord(4, _loc_6[1], _loc_6[2], _loc_7[0], _loc_7[1], _loc_7[2], this.info.getSerStateName(_loc_6[0], _loc_6[4]));
                            break;
                        }
                        case Mod_ServerWar_Base.SERVER_WAR_2:
                        {
                            this.info.pushRecord(2, _loc_6[1], _loc_6[2], _loc_7[0], _loc_7[1], _loc_7[2], this.info.getSerStateName(_loc_6[0], _loc_6[4]));
                            break;
                        }
                        case Mod_ServerWar_Base.SERVER_WAR_1:
                        {
                            this.info.pushRecord(1, _loc_6[1], _loc_6[2], _loc_7[0], _loc_7[1], _loc_7[2], this.info.getSerStateName(_loc_6[0], _loc_6[4]));
                            break;
                        }
                        case Mod_ServerWar_Base.SERVER_WAR_TIANBANG:
                        {
                            _loc_4.push([0, _loc_6[1], _loc_6[2], _loc_7[0], _loc_7[1], _loc_7[2], this.info.getSerStateName(_loc_6[0], _loc_6[4])]);
                            break;
                        }
                        case Mod_ServerWar_Base.SERVER_WAR_DIBANG:
                        {
                            _loc_5.push([0, _loc_6[1], _loc_6[2], _loc_7[0], _loc_7[1], _loc_7[2], this.info.getSerStateName(_loc_6[0], _loc_6[4])]);
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                }
            }
            _loc_4.sortOn("4", Array.NUMERIC | Array.DESCENDING);
            _loc_5.sortOn("4", Array.NUMERIC | Array.DESCENDING);
            _loc_3 = _loc_5.length;
            for each (_loc_6 in _loc_5)
            {
                
                this.info.pushRecord(_loc_6[0], _loc_6[1], _loc_6[2], _loc_6[3], _loc_6[4], _loc_6[5], _loc_6[6] + Lang.sprintf(ServerWarDataLang.RoundIdx, _loc_3));
                _loc_3 = _loc_3 - 1;
            }
            _loc_3 = _loc_4.length;
            for each (_loc_6 in _loc_4)
            {
                
                this.info.pushRecord(_loc_6[0], _loc_6[1], _loc_6[2], _loc_6[3], _loc_6[4], _loc_6[5], _loc_6[6] + Lang.sprintf(ServerWarDataLang.RoundIdx, _loc_3));
                _loc_3 = _loc_3 - 1;
            }
            return;
        }// end function

        public function bet(param1:Array) : void
        {
            this.result = param1[0];
            return;
        }// end function

        public function get_player_bet(param1:Array) : void
        {
            this.info.setCupGuessList(param1[0]);
            return;
        }// end function

        public function get_bet_coin_rank(param1:Array) : void
        {
            this.info.setBetRank(param1[0]);
            return;
        }// end function

        private function linkText(param1:String, param2:Array) : String
        {
            if (this.info.warType == Mod_ServerWar_Base.RACE_TYPE_STAGE_RACE && param2[0] == "player")
            {
                return param1;
            }
            return "<u><a href=\'event:" + param2.join("_") + "\'>" + param1 + "</a></u>";
        }// end function

    }
}
