package com.datas
{
    import com.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.info.*;
    import com.haloer.data.*;
    import com.lang.client.com.datas.*;
    import flash.utils.*;

    public class WorldBossData extends Base
    {
        public var result:int = 0;
        public var warStatus:int;
        public var warData:Array;
        public var awards:Array;
        public var combatBuff:int = 0;
        public var bossList:Array;
        public var nowBoss:BossInfo;
        public var notifyBoss:BossInfo;
        private var weekNow:Array;
        private var weekNext:Array;
        private var week:Array;
        public var lowHealthBossId:int = 0;

        public function WorldBossData() : void
        {
            this.bossList = [];
            this.weekNow = [WorldBossDataLang.Week7Now, WorldBossDataLang.Week1Now, WorldBossDataLang.Week2Now, WorldBossDataLang.Week3Now, WorldBossDataLang.Week4Now, WorldBossDataLang.Week5Now, WorldBossDataLang.Week6Now, WorldBossDataLang.Week7Now];
            this.weekNext = [WorldBossDataLang.Week7Next, WorldBossDataLang.Week1Next, WorldBossDataLang.Week2Next, WorldBossDataLang.Week3Next, WorldBossDataLang.Week4Next, WorldBossDataLang.Week5Next, WorldBossDataLang.Week6Next, WorldBossDataLang.Week7Next];
            this.week = [WorldBossDataLang.Week7, WorldBossDataLang.Week1, WorldBossDataLang.Week2, WorldBossDataLang.Week3, WorldBossDataLang.Week4, WorldBossDataLang.Week5, WorldBossDataLang.Week6, WorldBossDataLang.Week7];
            this.bossList[BossInfo.BossQingTianMu] = new BossInfo(MonsterType.BossQingTianMu);
            this.bossList[BossInfo.BossChiYanShou] = new BossInfo(MonsterType.BossChiYanShou);
            this.bossList[BossInfo.BossDaoBaTu] = new BossInfo(MonsterType.BossDaoBaTu);
            return;
        }// end function

        public function get_world_boss_list(param1:Array) : void
        {
            var _loc_2:Array = null;
            var _loc_3:BossInfo = null;
            for each (_loc_2 in param1[0])
            {
                
                _loc_3 = this.bossList[_loc_2[0]];
                oObject.list(_loc_2, _loc_3, ["bossId", "mapId", "lv", "state", "canSet"]);
                _loc_3.htmlName = "<b>" + HtmlText.format(Lang.sprintf(WorldBossDataLang.Lv, _loc_3.name, _loc_3.lv), HtmlText.Orange, 14) + "</b>";
                if (_loc_3.bossId == BossInfo.BossDaoBaTu)
                {
                    if (_loc_3.state == 5)
                    {
                        _loc_3.infoMsg = WorldBossDataLang.BossWarTwo;
                    }
                    else
                    {
                        _loc_3.infoMsg = Lang.sprintf(WorldBossDataLang.FactionBossWarTime, this.getDateMsg(_loc_2[5] * 1000, _loc_2[7]));
                    }
                    continue;
                }
                _loc_3.auto = _loc_2[8];
                _loc_3.infoMsg = HtmlText.white(Lang.sprintf(WorldBossDataLang.WorldBossWarTime, this.timeFormat_HM(_loc_2[5])));
                _loc_3.infoMsg = _loc_3.infoMsg + "\n" + HtmlText.format(Lang.sprintf(WorldBossDataLang.BossKillAdd, _loc_3.name), 10315052);
                _loc_3.robotTip = WorldBossDataLang.RobotTip;
                if (_loc_2[9] != 0)
                {
                    _loc_3.robotTip = _loc_3.robotTip + "\n" + Lang.sprintf(WorldBossDataLang.RobotTip2, HtmlText.yellow2(_loc_2[9] + WorldBossDataLang.Coin), HtmlText.yellow2(_loc_2[10] + WorldBossDataLang.Fame));
                }
                _loc_3.robotTip = HtmlText.white(_loc_3.robotTip);
            }
            return;
        }// end function

        private function getDateMsg(param1:Number, param2:int = 0) : String
        {
            var _loc_3:* = new Date();
            _loc_3.setTime(param1);
            var _loc_4:String = "";
            if (param2 == 0)
            {
                _loc_4 = this.weekNow[_loc_3.day];
            }
            else if (param2 == 1)
            {
                _loc_4 = this.weekNext[_loc_3.day];
            }
            else
            {
                _loc_4 = this.week[_loc_3.day];
            }
            var _loc_5:* = (_loc_3.hours < 10 ? ("0" + _loc_3.hours) : (_loc_3.hours)).toString();
            var _loc_6:* = (_loc_3.minutes < 10 ? ("0" + _loc_3.minutes) : (_loc_3.minutes)).toString();
            return _loc_4 + " " + _loc_5 + ":" + _loc_6;
        }// end function

        public function timeFormat_HM(param1:int) : String
        {
            if (param1 <= 0)
            {
                return "00:00";
            }
            var _loc_2:* = param1 / 60;
            param1 = param1 % 60;
            var _loc_3:* = _loc_2 / 60;
            _loc_2 = _loc_2 % 60;
            return (_loc_3 > 9 ? (_loc_3) : ("0" + _loc_3)) + ":" + (_loc_2 > 9 ? (_loc_2) : ("0" + _loc_2));
        }// end function

        public function get_world_boss_data(param1:Array) : void
        {
            var _loc_2:* = this.bossList[param1[0]];
            oObject.list(param1, _loc_2, ["bossId", "id", "state", "mapId", "x", "y", "time", "lv", "life", "lifeMax"]);
            _loc_2.time = getTimer() + _loc_2.time * 1000;
            return;
        }// end function

        public function get_defeat_record_list(param1:Array) : void
        {
            if (this.nowBoss == null)
            {
                return;
            }
            this.nowBoss.updateRankList(param1[1]);
            return;
        }// end function

        public function clear_death_cd(param1:Array) : void
        {
            this.result = param1[0];
            return;
        }// end function

        public function reset_death_cd(param1:Array) : void
        {
            this.player_death_cd([0, _data.player.playerId, param1[0]]);
            return;
        }// end function

        public function fight_world_boss(param1:Array) : void
        {
            this.warStatus = param1[1];
            this.warData = param1[2];
            this.awards = param1[3];
            this.combatBuff = param1[4];
            return;
        }// end function

        public function super_reborn(param1:Array) : void
        {
            this.result = param1[1];
            return;
        }// end function

        public function strengthen_combat(param1:Array) : void
        {
            this.result = param1[2];
            return;
        }// end function

        public function call_world_boss(param1:Array) : void
        {
            this.result = param1[0];
            return;
        }// end function

        public function hurt_world_boss(param1:Array) : void
        {
            var _loc_2:* = this.bossList[param1[0]];
            _loc_2.updateBossHurt(param1[1], param1[2]);
            return;
        }// end function

        public function close_world_boss(param1:Array) : void
        {
            this.notifyBoss = this.bossList[param1[0]];
            this.notifyBoss.lifeMax = param1[2];
            this.notifyBoss.updateCloseTip(param1[3]);
            return;
        }// end function

        public function open_world_boss(param1:Array) : void
        {
            this.notifyBoss = this.bossList[param1[0]];
            this.notifyBoss.updateOpenTip(param1[2]);
            return;
        }// end function

        public function defeat_world_boss(param1:Array) : void
        {
            this.notifyBoss = this.bossList[param1[0]];
            this.notifyBoss.lifeMax = param1[5];
            this.notifyBoss.lv = param1[2];
            this.notifyBoss.updateKillTip(param1[7], param1[3], param1[4], param1[6]);
            return;
        }// end function

        public function player_death_cd(param1:Array) : void
        {
            if (this.nowBoss == null)
            {
                return;
            }
            var _loc_2:Object = {};
            _loc_2.id = param1[1];
            _loc_2.time = param1[2];
            if (_loc_2.time > 0)
            {
                _loc_2.time = getTimer() + 500 + _loc_2.time * 1000;
            }
            this.nowBoss.fuhuoList.push(_loc_2);
            return;
        }// end function

        public function update_world_boss_position(param1:Array) : void
        {
            if (this.nowBoss == null)
            {
                return;
            }
            this.nowBoss.x = param1[0];
            this.nowBoss.y = param1[1];
            return;
        }// end function

        public function player_world_boss_buff(param1:Array) : void
        {
            var _loc_2:* = this.bossList[param1[0]];
            _loc_2.guwu = param1[1];
            _loc_2.resetCount = param1[2];
            return;
        }// end function

        public function select_faction_boss_time(param1:Array) : void
        {
            this.result = param1[2];
            if (this.result != -1)
            {
                this.notifyBoss = this.bossList[param1[0]];
                this.notifyBoss.chatTips = Lang.sprintf(WorldBossDataLang.SetOpenTime, HtmlText.yellow2(this.getDateMsg(this.result * 1000)));
            }
            return;
        }// end function

        public function faction_boss_time_list(param1:Array) : void
        {
            var _loc_2:Object = null;
            var _loc_3:Array = null;
            this.notifyBoss = this.bossList[param1[0]];
            this.notifyBoss.setList = [];
            for each (_loc_3 in param1[2])
            {
                
                var _loc_6:* = {};
                _loc_2 = {};
                this.notifyBoss.setList.push(_loc_6);
                _loc_2.type_id = _loc_3[0];
                _loc_2.selected = _loc_3[1];
                _loc_2.expired = _loc_3[3];
                _loc_2.msgWeek = this.getDateMsg(_loc_3[2] * 1000, 3) + " " + WorldBossDataLang.Open;
                _loc_2.msgWeekNow = this.getDateMsg(_loc_3[2] * 1000, 0) + " " + WorldBossDataLang.Open;
                _loc_2.msgWeekNext = this.getDateMsg(_loc_3[2] * 1000, 1) + " " + WorldBossDataLang.Open;
                _loc_2.isnext = param1[1];
            }
            return;
        }// end function

        public function set_robot(param1:Array) : void
        {
            this.result = param1[0];
            return;
        }// end function

        public function worldBossLowHealth(param1:Array) : void
        {
            this.lowHealthBossId = param1[0];
            return;
        }// end function

    }
}
