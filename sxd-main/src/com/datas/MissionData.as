package com.datas
{
    import com.assist.*;
    import com.assist.data.mission.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.info.*;
    import com.lang.client.com.datas.*;
    import com.protocols.*;
    import flash.utils.*;

    public class MissionData extends Base
    {
        private var _sectionsList:Array;
        private var _warData:WarData;
        private var _warStatus:int;
        private var _worship:int;
        public var warAura:int;
        private var _heroMissionList:Array;
        private var _buyHeroChallenge:Array;
        private var _strategyList:Array;
        private var _masterMonsterId:int;
        private var _strategyWarData:ByteArray;
        public var result:int;
        public var missionId:int;
        public var isPass:Boolean;
        public var missionLock:int = 0;
        public var monsterLock:int = 0;
        public var rank:Object;
        public var awardList:Array;
        public var pickupAward:int;
        public var itemObj:Object;
        public var fetchItemObj:Object;

        public function MissionData()
        {
            this._strategyList = [];
            this.rank = {};
            this.awardList = [];
            this.itemObj = {id:0, type:0, mcType:1};
            this.fetchItemObj = {id:0, amout:0, result:0};
            return;
        }// end function

        public function get sectionsList() : Array
        {
            return this._sectionsList;
        }// end function

        public function get warData() : WarData
        {
            return this._warData;
        }// end function

        public function get warStatus() : int
        {
            return this._warStatus;
        }// end function

        public function get worship() : int
        {
            return this._worship;
        }// end function

        public function get getHeroMissionList() : Array
        {
            return this._heroMissionList;
        }// end function

        public function get buyHeroChallenge() : Array
        {
            return this._buyHeroChallenge;
        }// end function

        public function get strategyList() : Array
        {
            return this._strategyList;
        }// end function

        public function get masterMonsterId() : int
        {
            return this._masterMonsterId;
        }// end function

        public function get strategyWarData() : ByteArray
        {
            return this._strategyWarData;
        }// end function

        public function get_sections(param1:Array) : void
        {
            this._sectionsList = param1[0];
            return;
        }// end function

        public function get_hero_mission_list(param1:Array) : void
        {
            this._heroMissionList = param1[0];
            return;
        }// end function

        public function buy_hero_challenge(param1:Array) : void
        {
            this._buyHeroChallenge = param1;
            return;
        }// end function

        public function enter_mission(param1:Array) : void
        {
            this.result = param1[0];
            if (this.result != Mod_Mission_Base.SUCCESS)
            {
                return;
            }
            this.missionId = param1[1];
            this.isPass = param1[3];
            this.missionLock = param1[4];
            this.monsterLock = param1[5];
            return;
        }// end function

        public function fight_monster(param1:Array) : void
        {
            this._warStatus = param1[param1.length - 3];
            this._warData = new WarData();
            if (this.warStatus == Mod_Mission_Base.SUCCESS)
            {
                this._warData.format(param1);
            }
            this._worship = param1[param1.length - 2];
            this.warAura = param1[(param1.length - 1)];
            return;
        }// end function

        public function rank_mission(param1:Array) : void
        {
            var _loc_2:Array = null;
            var _loc_3:Object = null;
            this.rank.score = param1[0];
            this.rank.full_score = param1[1];
            this.rank.score_flag = param1[2];
            this.rank.attack_score = param1[3];
            this.rank.defense_score = param1[4];
            this.rank.award_experience = param1[5];
            this.rank.award_skill = param1[6];
            this.rank.name = _data.player.playerInfo.name;
            this.rank.url = _data.player.playerInfo.fullHeadUrl;
            this.rank.list = [];
            for each (_loc_2 in param1[7])
            {
                
                _loc_3 = {};
                _loc_3.color = RoleType.getRoleColorById(_loc_2[0]);
                _loc_3.name = RoleType.getRoleName(_loc_2[0]);
                _loc_3.exp = _loc_2[1];
                _loc_3.url = URI.iconsUrl + RoleType.getRoleSign(_loc_2[0]) + ".png";
                _loc_3.roleColor = RoleType.getRoleColorById(_loc_2[0]);
                this.rank.list.push(_loc_3);
            }
            this.rank.worship = null;
            if (param1[8] > 0)
            {
                this.rank.worship = {name:HtmlText.yellow2(MissionDataLang.MarsExp), exp:HtmlText.yellow2(MissionDataLang.Exp + " +" + param1[8] + "%"), url:URI.iconsUrl + "WorShip.png"};
            }
            return;
        }// end function

        public function open_box(param1:Array) : void
        {
            var _loc_7:Object = null;
            var _loc_8:Array = null;
            var _loc_9:ItemInfo = null;
            var _loc_2:* = param1[0];
            var _loc_3:* = param1[1];
            var _loc_4:* = param1[3];
            param1 = param1[2];
            var _loc_5:int = 0;
            var _loc_6:int = 0;
            this.awardList = [];
            if (param1[0] is Array)
            {
                _loc_8 = param1[0];
                _loc_9 = new ItemInfo();
                _loc_9.parseSee(_loc_8[0]);
                _loc_7 = {};
                _loc_7.num = _loc_8.pop();
                _loc_7.name = htmlFormat(_loc_9.name, 13, _loc_9.color);
                _loc_7.url = _loc_9.basic.getImgUrl(0);
                _loc_7.tip = _loc_9.getTipsSprite1("", "");
                this.awardList.push(_loc_7);
            }
            if (_loc_2 > 0)
            {
                _loc_7 = {};
                _loc_7.num = _loc_2;
                _loc_7.name = htmlFormat(MissionDataLang.Ingot, 13, 16764006);
                _loc_7.url = URI.goodsIconUrl + "99998.png";
                this.awardList.push(_loc_7);
            }
            if (_loc_3 > 0)
            {
                _loc_7 = {};
                _loc_7.num = _loc_3;
                _loc_7.name = htmlFormat(MissionDataLang.Coin, 13, 16777215);
                _loc_7.url = URI.goodsIconUrl + "99999.png";
                this.awardList.push(_loc_7);
                if (_loc_4 > 0)
                {
                    _loc_7.name = _loc_7.name + "\n" + htmlFormat(MissionDataLang.Blessing + _loc_4 + "%", 12, 52224);
                }
            }
            return;
        }// end function

        public function pickup_award(param1:Array) : void
        {
            this.pickupAward = param1[0];
            return;
        }// end function

        public function sign_play_mission_video(param1:Array) : void
        {
            return;
        }// end function

        public function get_monster_strategy_list(param1:Array) : void
        {
            var _loc_2:int = 0;
            while (_loc_2 > 0)
            {
                
                _loc_2 = _loc_2 - 1;
                param1[1][_loc_2][0] = _data.player.removeNickNameSuffix(param1[1][_loc_2][0]);
            }
            this._masterMonsterId = param1[0];
            this._strategyList = param1[1];
            return;
        }// end function

        public function get_player_war_report(param1:ByteArray) : void
        {
            this._strategyWarData = param1;
            return;
        }// end function

        public function random_item(param1:Array) : void
        {
            this.itemObj = {id:0, type:0, mcType:1};
            this.itemObj.type = param1[0];
            this.itemObj.id = param1[1];
            switch(this.itemObj.type)
            {
                case Mod_Mission_Base.COIN:
                {
                    this.itemObj.mcType = 1;
                    break;
                }
                case Mod_Mission_Base.SKILL:
                {
                    this.itemObj.mcType = 2;
                    break;
                }
                case Mod_Mission_Base.INGOT:
                {
                    this.itemObj.mcType = 3;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function fetch_random_item(param1:Array) : void
        {
            this.fetchItemObj.result = param1[0];
            this.fetchItemObj.id = param1[1];
            this.fetchItemObj.amout = param1[2];
            return;
        }// end function

    }
}
