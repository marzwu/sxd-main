package com.assist.view.info
{
    import com.*;
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.map.*;
    import com.assist.view.toolbar.*;
    import com.lang.client.com.assist.view.info.*;

    public class BossInfo extends MonsterInfo
    {
        public var mapId:int = 0;
        public var bossId:int = 0;
        public var htmlName:String = "";
        public var lv:int = 0;
        public var state:int = 0;
        public var auto:int = 0;
        public var robotTip:String = "";
        public var infoMsg:String = "";
        public var canSet:int = 0;
        public var setList:Array;
        public var time:int;
        public var life:int;
        public var lifeMax:int;
        public var guwu:int = 0;
        public var resetCount:int = 5;
        public var recordList:Array;
        public var worldTips:String = "";
        public var chatTips:String = "";
        public var hurtList:Array;
        public var fuhuoList:Array;
        public var tmpHurt:int = 0;
        public static var BossQingTianMu:int = 1;
        public static var BossChiYanShou:int = 2;
        public static var BossDaoBaTu:int = 3;

        public function BossInfo(param1:String) : void
        {
            this.setList = [];
            this.recordList = [];
            this.hurtList = [];
            this.fuhuoList = [];
            this.sign = param1;
            if (MonsterType.BossQingTianMu == param1)
            {
                this.mapId = 10;
                name = BossInfoLang.BossName1;
                this.bossId = BossQingTianMu;
            }
            else if (MonsterType.BossChiYanShou == param1)
            {
                this.mapId = 11;
                name = BossInfoLang.BossName2;
                this.bossId = BossChiYanShou;
            }
            else if (MonsterType.BossDaoBaTu == param1)
            {
                this.mapId = 12;
                name = BossInfoLang.BossName3;
                this.bossId = BossDaoBaTu;
            }
            return;
        }// end function

        public function get resetIngot() : int
        {
            return (6 - this.resetCount) * 5;
        }// end function

        public function updateBossHurt(param1:int, param2:int) : void
        {
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            var _loc_6:int = 0;
            this.hurtList = [];
            var _loc_3:int = 0;
            if (param1 == 1)
            {
                if (this.tmpHurt == 0)
                {
                    _loc_3 = (Math.random() * 1800 + 2000) * param2;
                }
                else
                {
                    _loc_3 = this.tmpHurt * (0.5 + Math.random() * 0.5) * param2;
                }
            }
            else
            {
                _loc_3 = this.life - param1;
                this.tmpHurt = _loc_3 / param2;
                if (_loc_3 < 0)
                {
                    _loc_3 = this.life;
                }
            }
            if (_loc_3 > 0)
            {
                _loc_3 = _loc_3 >> 1;
                param2 = param2 > 30 ? (30) : (param2);
                _loc_4 = int(_loc_3 / param2);
                _loc_5 = _loc_4;
                _loc_6 = _loc_4;
                while (param2 > 0)
                {
                    
                    param2 = param2 - 1;
                    if (param2 == 0)
                    {
                        this.hurtList.push(_loc_4 + _loc_6);
                        continue;
                    }
                    _loc_5 = _loc_6 * Math.random();
                    _loc_6 = _loc_6 + _loc_4 - _loc_5;
                    this.hurtList.push(_loc_4 + _loc_5);
                }
            }
            this.life = param1;
            return;
        }// end function

        public function updateRankList(param1:Array) : void
        {
            var _loc_4:Object = null;
            var _loc_2:* = param1.shift();
            var _loc_3:Object = {};
            if (_loc_2[2] == 0)
            {
                _loc_3.msg = BossInfoLang.BossUnHurt;
            }
            else
            {
                _loc_3.p = Number(100 * _loc_2[2] / this.lifeMax).toFixed(2);
                _loc_3.msg = Lang.sprintf(BossInfoLang.BossHurt2, _loc_2[2], _loc_3.p);
            }
            this.recordList = [_loc_3];
            var _loc_5:int = 0;
            for each (_loc_2 in param1)
            {
                
                if (_loc_2[2] > 0)
                {
                    _loc_4 = {};
                    _loc_4.p = Number(100 * _loc_2[2] / this.lifeMax).toFixed(2);
                    _loc_4.msg = Lang.sprintf(BossInfoLang.BossHurt1, _loc_2[2], _loc_4.p);
                    _loc_4.name = ++_loc_5 + "." + this.removeNickNameSuffixEx(_loc_2[1]);
                    this.recordList.push(_loc_4);
                }
            }
            return;
        }// end function

        public function updateOpenTip(param1:int) : void
        {
            var _loc_2:String = "";
            this.worldTips = "";
            this.chatTips = _loc_2;
            this.resetCount = 5;
            this.worldTips = htmlFormat(name, 25, 16711680);
            this.state = param1;
            if (param1 == 0)
            {
                if (MonsterType.BossDaoBaTu == sign)
                {
                    this.worldTips = Lang.sprintf(BossInfoLang.FactionBossWillOpen, this.worldTips);
                }
                else
                {
                    this.worldTips = Lang.sprintf(BossInfoLang.WorldBossWillOpen, this.worldTips);
                }
            }
            else if (MonsterType.BossDaoBaTu == sign)
            {
                this.worldTips = Lang.sprintf(BossInfoLang.FactionBossOpen, this.worldTips);
            }
            else
            {
                this.worldTips = Lang.sprintf(BossInfoLang.WorldBossOpen, this.worldTips);
            }
            this.worldTips = htmlFormat(this.worldTips, 25, 16773632, true);
            return;
        }// end function

        public function updateKillTip(param1:Array, param2:int, param3:String, param4:int) : void
        {
            this.state = 3;
            this.worldTips = htmlFormat(name, 25, 16711680);
            if (MonsterType.BossDaoBaTu == sign)
            {
                this.worldTips = Lang.sprintf(BossInfoLang.UserKillFactionBoss, param3, this.worldTips);
            }
            else
            {
                this.worldTips = Lang.sprintf(BossInfoLang.UserKillWorldBoss, param3, this.worldTips);
            }
            this.worldTips = htmlFormat(this.worldTips, 25, 16773632, true);
            this.updateKillRank(param1, param2, param3, param4);
            return;
        }// end function

        public function updateCloseTip(param1:Array) : void
        {
            this.state = 2;
            this.worldTips = htmlFormat(name, 25, 16711680);
            if (MonsterType.BossDaoBaTu == sign)
            {
                this.worldTips = Lang.sprintf(BossInfoLang.FactionBossOver, this.worldTips);
            }
            else
            {
                this.worldTips = Lang.sprintf(BossInfoLang.WorldBossOver, this.worldTips);
            }
            this.worldTips = htmlFormat(this.worldTips, 25, 16773632, true);
            this.updateKillRank(param1);
            return;
        }// end function

        private function updateKillRank(param1:Array, param2:int = 0, param3:String = "", param4:int = 0) : void
        {
            var _loc_8:Array = null;
            this.chatTips = "";
            if (param1.length == 0)
            {
                return;
            }
            var _loc_5:Array = [BossInfoLang.Num5, BossInfoLang.Num4, BossInfoLang.Num3, BossInfoLang.Num2, BossInfoLang.Num1];
            var _loc_6:Array = [];
            var _loc_7:Array = [];
            for each (_loc_8 in param1)
            {
                
                var _loc_11:* = this.getLinkPlayer(_loc_8[0], _loc_8[1]);
                this.chatTips = this.getLinkPlayer(_loc_8[0], _loc_8[1]);
                _loc_7.push(_loc_11);
                _loc_6.push(Lang.sprintf(_loc_5.pop(), this.chatTips, Number(100 * _loc_8[2] / this.lifeMax).toFixed(3)));
            }
            if (MonsterType.BossDaoBaTu == sign)
            {
                this.chatTips = Lang.sprintf(BossInfoLang.FactionBossWarChat, "<font color=\'#fff200\'>", "</font>", name) + "\n" + _loc_6.join("\n");
            }
            else
            {
                this.chatTips = Lang.sprintf(BossInfoLang.BossWarChat, "<font color=\'#fff200\'>", "</font>", name) + "\n" + _loc_6.join("\n");
            }
            if (param2 != 0)
            {
                this.chatTips = this.chatTips + "\n" + Lang.sprintf(BossInfoLang.BossWarAward, _loc_7.join("、"));
                this.chatTips = this.chatTips + "\n" + Lang.sprintf(BossInfoLang.BossWarKill, this.getLinkPlayer(param2, param3), name, param4);
            }
            return;
        }// end function

        private function getLinkPlayer(param1:int, param2:String) : String
        {
            var _loc_3:* = TextLinkType.Player + "_" + param1 + "_" + param2;
            return "<font color=\"#fff200\"><a href=\"event:" + _loc_3 + "\"><u>" + this.removeNickNameSuffixEx(param2) + "</u></a></font>";
        }// end function

        private function getLinkItem(param1:int, param2:int = 1) : String
        {
            var _loc_3:* = ItemType.getItemColor(param1).toString(16);
            var _loc_4:* = ItemType.getName(param1);
            var _loc_5:* = TextLinkType.Item + "_" + param1 + "_" + param2;
            return "<font color=\"#" + _loc_3 + "\"><a href=\"event:" + _loc_5 + "\"><u>" + _loc_4 + "</u></a></font>";
        }// end function

        private function removeNickNameSuffixEx(param1:String) : String
        {
            if (MapStatic.removeNickNameSuffix == null)
            {
                return param1;
            }
            return MapStatic.removeNickNameSuffix(param1);
        }// end function

        public static function getBossNameById(param1:int) : String
        {
            var _loc_2:* = BossInfoLang.BossName1;
            switch(param1)
            {
                case BossQingTianMu:
                {
                    _loc_2 = BossInfoLang.BossName1;
                    break;
                }
                case BossChiYanShou:
                {
                    _loc_2 = BossInfoLang.BossName2;
                    break;
                }
                case BossDaoBaTu:
                {
                    _loc_2 = BossInfoLang.BossName3;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

    }
}
