package com.views.map
{
    import com.*;
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.controls.*;
    import com.assist.view.info.*;
    import com.assist.view.interfaces.map.*;
    import com.assist.view.sound.*;
    import com.controllers.*;
    import com.lang.client.com.views.*;
    import com.lang.client.com.views.toolbar.*;
    import com.protocols.*;
    import com.views.*;
    import flash.display.*;
    import flash.utils.*;

    public class MapViewBase extends Base implements IView
    {
        protected var _id:int = 0;
        protected var _info:MapInfo;
        protected var _content:Sprite;
        protected var _mapBase:IMap;
        protected var _playerInfo:PlayerInfo;
        protected var _loadTips:Array;
        private var townCache:Object;
        private var missionCache:Object;
        public static const Town:uint = 0;
        public static const Mission:uint = 1;
        public static const WorldBoss:uint = 2;
        public static const FactionWar:uint = 3;
        public static const HuZhongJie:uint = 4;
        public static const BeelzebubTrials:uint = 5;
        public static const NineRegions:uint = 6;
        public static const DianFengDuiJue:uint = 7;

        public function MapViewBase()
        {
            this._content = new Sprite();
            this.townCache = {};
            this.missionCache = {};
            this._loadTips = [MapViewBaseLang.loadTip1, MapViewBaseLang.loadTip2, MapViewBaseLang.loadTip3];
            return;
        }// end function

        public function show() : void
        {
            return;
        }// end function

        public function close() : void
        {
            return;
        }// end function

        public function get content() : Sprite
        {
            return this._content;
        }// end function

        protected function get ctrlMap() : TownController
        {
            return _ctrl.town;
        }// end function

        protected function get ctrlPlayer() : PlayerController
        {
            return _ctrl.player;
        }// end function

        protected function get ctrlNotify() : NotifyController
        {
            return _ctrl.notify;
        }// end function

        override public function get inStage() : Boolean
        {
            return this._mapBase && this._mapBase.content.stage != null;
        }// end function

        protected function showProgress(param1:int, param2:int, param3:int, param4:String) : void
        {
            _view.initLoading.loading(param2 + "", param3, param2, param1, param4);
            return;
        }// end function

        public function clear() : void
        {
            _popup.closeAll();
            _ctrl.town.clearPlayer();
            _view.otherHead.close();
            _view.toolbar.miniMap.content.visible = false;
            SoundManage.playBgSound("");
            _data.cancelPatch(Mod_Town_Base.move_to);
            _data.cancelPatch(Mod_Town_Base.player_follow_role_change);
            _data.cancelPatch(Mod_Player_Base.update_player_data_for_town);
            _data.cancelPatch(Mod_Player_Base.practice_notify);
            _data.cancelPatch(Mod_Achievement_Base.fate_achievement_completed);
            _data.cancelPatch(Mod_Town_Base.move_to);
            _data.cancelPatch(Mod_Town_Base.player_follow_role_change);
            _data.cancelPatch(Mod_Player_Base.update_player_data_for_town);
            _data.cancelPatch(Mod_Town_Base.player_follow_setting_change);
            _data.cancelPatch(Mod_Player_Base.practice_notify);
            _data.cancelPatch(Mod_Notify_Base.change_equip);
            _data.cancelPatch(Mod_Town_Base.enter_town);
            _data.cancelPatch(Mod_Town_Base.leave_town);
            this.closePractice(true);
            this._mapBase.clear();
            if (this._content.parent)
            {
                this._content.parent.removeChild(this._content);
            }
            return;
        }// end function

        public function gotoLastMap(param1:int = 1) : void
        {
            if (param1 == AlertButtonType.Yes)
            {
                _view.townMap.gotoTownAtId(this.ctrlPlayer.jihuisuoId || this.ctrlPlayer.townMapId);
            }
            return;
        }// end function

        public function stopPlayerRun() : void
        {
            if (this.inStage == false)
            {
                return;
            }
            this._mapBase.stopRun(true);
            return;
        }// end function

        public function showTextEffect(param1:String, param2:uint) : void
        {
            if (_view.war.inStage || _view.missionPractice.inStage || _view.heroPractice.inStage)
            {
                return;
            }
            this._mapBase.showTextEffect(param1, param2);
            return;
        }// end function

        public function showLevelUp() : void
        {
            if (this.inStage == false)
            {
                return;
            }
            this._mapBase.showLevelUp();
            return;
        }// end function

        public function showQuestOk() : void
        {
            if (this.inStage == false)
            {
                return;
            }
            this._mapBase.showQuestOk();
            return;
        }// end function

        public function showQuestAdd() : void
        {
            if (this.inStage == false)
            {
                return;
            }
            this._mapBase.showQuestAdd();
            return;
        }// end function

        public function showAchievement() : void
        {
            if (this.inStage == false)
            {
                return;
            }
            this._mapBase.showEffort();
            return;
        }// end function

        public function updatePlayerBody() : void
        {
            if (this.inStage == false)
            {
                return;
            }
            this._mapBase.updateBodyUrl(this._playerInfo.id);
            return;
        }// end function

        public function playerSay(param1:int, param2, param3:int) : void
        {
            if (this.inStage == false)
            {
                return;
            }
            this._mapBase.playerSay(param1, param2, param3);
            return;
        }// end function

        protected function update_player_data_for_town_back() : void
        {
            var _loc_2:Object = null;
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            var _loc_6:PlayerInfo = null;
            if (this.inStage == false)
            {
                return;
            }
            var _loc_1:* = this.ctrlPlayer.updatePlayerDataForTownList;
            for each (_loc_2 in _loc_1)
            {
                
                _loc_3 = _loc_2.id;
                _loc_4 = _loc_2.type;
                _loc_5 = _loc_2.value;
                _loc_6 = this.ctrlMap.getPlayerInfo(_loc_3);
                if (_loc_4 == Mod_Player_Base.PLAYER_TRANSPORT)
                {
                    this._mapBase.updateBodyUrl(_loc_3);
                    continue;
                }
                if (_loc_4 == Mod_Player_Base.PLAYER_AVATAR)
                {
                    this._mapBase.updateBodyUrl(_loc_3);
                }
            }
            return;
        }// end function

        protected function practice_notify_back() : void
        {
            var _loc_2:PlayerInfo = null;
            var _loc_1:* = this.ctrlPlayer.practiceChangeList;
            this.ctrlPlayer.practiceChangeList = [];
            for each (_loc_2 in _loc_1)
            {
                
                if (_loc_2.isMine)
                {
                    this._mapBase.updatePracticePanel();
                    continue;
                }
                this._mapBase.updateBodyUrl(_loc_2.id);
            }
            return;
        }// end function

        protected function get_practice_data() : void
        {
            if (this._playerInfo.practice != Mod_Town_Base.ON_PRACTICE)
            {
                return;
            }
            _data.call(Mod_Player_Base.get_practice_data, this.get_practice_data_back, [], false);
            return;
        }// end function

        protected function get_practice_data_back() : void
        {
            this._mapBase.updatePracticePanel();
            return;
        }// end function

        public function startPractice() : void
        {
            if (this.inStage == false)
            {
                return;
            }
            if (_view.missionPractice.isBatton || _view.heroPractice.isBatton)
            {
                _view.showTip(MapViewBaseLang.PracticeTip1);
            }
            else if (this._mapBase.inMove == true)
            {
                _view.showTip(MapViewBaseLang.PracticeTip2);
            }
            else
            {
                this._playerInfo.practice = Mod_Town_Base.ON_PRACTICE;
                this._playerInfo.practiceExp = 0;
                this._mapBase.updatePracticePanel();
                _data.call(Mod_Player_Base.start_practice, null, []);
                this.get_practice_data();
            }
            return;
        }// end function

        public function closePractice(param1:Boolean) : void
        {
            if (this._playerInfo && this._playerInfo.practice == Mod_Town_Base.ON_PRACTICE)
            {
                this._playerInfo.practice = Mod_Town_Base.OFF_PRACTICE;
                this._playerInfo.practiceExp = 0;
                this._mapBase.updatePracticePanel();
                if (param1)
                {
                    _data.call(Mod_Player_Base.cancel_practice, null, []);
                }
            }
            return;
        }// end function

        protected function onCancelPraceice() : void
        {
            this.closePractice(true);
            _data.call(Mod_Player_Base.sign_finished_practice, null, []);
            this._playerInfo.practice = Mod_Town_Base.OFF_PRACTICE;
            this._playerInfo.practiceExp = 0;
            return;
        }// end function

        protected function onPracticeAction(param1:int) : void
        {
            _view.friendMessage.additionalHeight = param1;
            return;
        }// end function

        protected function enterMapComplete() : void
        {
            this.get_practice_data();
            this._mapBase.onCancelPraceice = this.onCancelPraceice;
            this._mapBase.onGoonPraceice = this.startPractice;
            this._mapBase.onPracticeAction = this.onPracticeAction;
            _data.patch(Mod_Town_Base.leave_town, this.leave_town_back);
            _data.patch(Mod_Town_Base.move_to, this.move_to_back);
            _data.patch(Mod_Town_Base.player_follow_role_change, this.player_follow_role_change_back);
            _data.patch(Mod_Achievement_Base.fate_achievement_completed, this.fate_achievement_completed_back);
            _data.patch(Mod_Player_Base.update_player_data_for_town, this.update_player_data_for_town_back);
            _data.patch(Mod_Town_Base.enter_town, this.get_players_back);
            _data.patch(Mod_Town_Base.player_follow_setting_change, this.followSettingChange);
            _data.patch(Mod_Player_Base.practice_notify, this.practice_notify_back);
            _data.patch(Mod_Notify_Base.change_equip, this.change_equip_back);
            _view.chat.onPassClick = this._mapBase.passClick;
            this._mapBase.updateFollow(this._playerInfo.id);
            return;
        }// end function

        public function getPrestigeNo1PlayerId() : void
        {
            _data.call(Mod_WeekRanking_Base.get_week_ranking_first_player, this.getPrestigeBack, []);
            return;
        }// end function

        public function getPrestigeBack() : void
        {
            if (this._playerInfo)
            {
                this._playerInfo.prestigeNo1PlayerIdList = _ctrl.weekRanking.prestigeFirstList;
                this._playerInfo.rangkingofType = _ctrl.weekRanking.rangkingOfType;
                this._mapBase.setAwardFollower();
            }
            return;
        }// end function

        private function updateCatFollow() : void
        {
            return;
        }// end function

        private function onPracticeSpeed(param1:int) : void
        {
            var num:* = param1;
            var num_:* = num;
            if (this._playerInfo.practiceSpeedNum == 0)
            {
                _view.showTip(MapViewBaseLang.SpeedOver);
                return;
            }
            var time:* = (this._playerInfo.practiceTime - getTimer()) / 1000;
            time = (time + 3595) / 3600;
            num = Math.min(num, time, this._playerInfo.practiceSpeedNum);
            if (num == 0)
            {
                _view.showTip(MapViewBaseLang.SpeedError);
                return;
            }
            var tip:* = Lang.sprintf(MapViewBaseLang.SpeedAsk, HtmlText.yellow2("" + num * 30), HtmlText.yellow2("" + num), HtmlText.green("+" + num * this._playerInfo.practiceExpOne));
            if (num_ == 1)
            {
                this.checkBoxSelect2(ConsumeAlertSetType.practiceSpeed1, tip, function () : void
            {
                _data.call(Mod_Practice_Base.quickly, quickly_back, []);
                return;
            }// end function
            );
            }
            else
            {
                this.checkBoxSelect2(ConsumeAlertSetType.practiceSpeed24, tip, function () : void
            {
                _data.call(Mod_Practice_Base.quickly_all, quickly_back, []);
                return;
            }// end function
            );
            }
            return;
        }// end function

        private function quickly_back() : void
        {
            if (_ctrl.practice.result == Mod_Practice_Base.SUCCESS)
            {
                this.get_practice_data();
            }
            else if (_ctrl.practice.result == Mod_Practice_Base.NOT_ENOUGH_INGOT)
            {
                _view.showTip(MapViewBaseLang.SpeedIngot);
            }
            else if (_ctrl.practice.result == Mod_Practice_Base.NOT_ENOUGH_TIMES)
            {
                _view.showTip(MapViewBaseLang.SpeedOver);
            }
            else
            {
                _view.showTip(MapViewBaseLang.SpeedError);
            }
            return;
        }// end function

        protected function checkBoxSelect1(param1:String, param2:String, param3:Function) : void
        {
            var cookie:* = param1;
            var msg:* = param2;
            var callback:* = param3;
            var checked:* = _view.getCookie(cookie) == 1;
            if (checked)
            {
                this.callback();
            }
            else
            {
                _view.alert.iAlert.hasCheckbox = true;
                _view.alert.showYesNoMsg(msg, MapViewBaseLang.Yes, MapViewBaseLang.No, function (param1:int) : void
            {
                if (param1 == AlertButtonType.Yes)
                {
                    callback();
                    if (_view.alert.iAlert.checked == true)
                    {
                        _view.setCookie(cookie, 1);
                    }
                }
                return;
            }// end function
            );
            }
            return;
        }// end function

        protected function checkBoxSelect2(param1:int, param2:String, param3:Function) : void
        {
            var cookieId:* = param1;
            var msg:* = param2;
            var callback:* = param3;
            if (_view.consumeAlertSetting.isAlert(cookieId))
            {
                this.callback();
            }
            else
            {
                _view.alert.iAlert.hasCheckbox = true;
                _view.alert.showYesNoMsg(msg, MapViewBaseLang.Yes, MapViewBaseLang.No, function (param1:int) : void
            {
                if (param1 == AlertButtonType.Yes)
                {
                    callback();
                    if (_view.alert.iAlert.checked == true)
                    {
                        _view.consumeAlertSetting.saveSetting(cookieId, true);
                    }
                }
                return;
            }// end function
            );
            }
            return;
        }// end function

        protected function startMove(param1:int, param2:int, param3:int, param4:int) : void
        {
            this._view.friendMessage.clear();
            return;
        }// end function

        protected function endMove() : void
        {
            return;
        }// end function

        public function updatePetLv(param1:int) : void
        {
            this._playerInfo.petLv = param1;
            this._mapBase.updatePetLv(this._playerInfo.id, param1);
            return;
        }// end function

        public function updateNpcLoack(param1:int) : void
        {
            return;
        }// end function

        public function fate_achievement_completed_back() : void
        {
            this._mapBase.updateCatFollow(_ctrl.achievement.catPlayerId);
            return;
        }// end function

        protected function player_follow_role_change_back() : void
        {
            var _loc_3:PlayerInfo = null;
            var _loc_1:* = this.ctrlMap.followList;
            var _loc_2:int = 0;
            for each (_loc_2 in _loc_1)
            {
                
                _loc_3 = this.ctrlMap.getPlayerInfo(_loc_2);
                this._mapBase.showFollow(_loc_2, _loc_3.followRoleId);
            }
            return;
        }// end function

        public function showFollow(param1:int, param2:int) : void
        {
            if (this.inStage == false)
            {
                return;
            }
            this._mapBase.showFollow(param1, param2);
            return;
        }// end function

        protected function change_equip_back() : void
        {
            this._mapBase.updateBodyUrl(this.ctrlNotify.eqPlayerId);
            this.setFactionCloth();
            return;
        }// end function

        protected function enter_town() : void
        {
            _data.patch(Mod_Town_Base.enter_town, this.enter_town_back);
            _data.call(Mod_Town_Base.enter_town, this.enter_town_back, [this._id]);
            this._playerInfo = this.ctrlPlayer.playerInfo;
            _view.activities.visibleActivites = true;
            return;
        }// end function

        protected function enter_town_back() : void
        {
            this.setFactionCloth();
            return;
        }// end function

        protected function move_to(param1:int, param2:int, param3:int, param4:int) : void
        {
            _data.call(Mod_Town_Base.move_to, this.move_to_back, [param1, param2, param3, param4]);
            this.closePractice(false);
            if (param1 == param3 && param2 == param4)
            {
                this.endMove();
            }
            else
            {
                this.startMove(param1, param2, param3, param4);
            }
            return;
        }// end function

        protected function move_to_back() : void
        {
            var _loc_3:PlayerInfo = null;
            var _loc_1:* = this.ctrlMap.moveList;
            var _loc_2:int = 0;
            for each (_loc_2 in _loc_1)
            {
                
                _loc_3 = this.ctrlMap.getPlayerInfo(_loc_2);
                this._mapBase.moveToPlayer(_loc_3.id, _loc_3.x, _loc_3.y);
            }
            return;
        }// end function

        protected function get_players() : void
        {
            _data.call(Mod_Town_Base.get_players, this.get_players_back, []);
            return;
        }// end function

        protected function get_players_back() : void
        {
            var _loc_3:PlayerInfo = null;
            var _loc_1:* = this.ctrlMap.entownList;
            var _loc_2:int = 0;
            for each (_loc_2 in _loc_1)
            {
                
                _loc_3 = this.ctrlMap.getPlayerInfo(_loc_2);
                this._mapBase.addPlayer(_loc_3);
                this._mapBase.updateFollow(_loc_3.id);
            }
            this.setFactionCloth();
            return;
        }// end function

        protected function followSettingChange() : void
        {
            this._mapBase.updateFollow(this.ctrlMap.followChangePlayerId);
            return;
        }// end function

        protected function leave_town_back() : void
        {
            var _loc_1:* = this.ctrlMap.leaveList;
            var _loc_2:int = 0;
            for each (_loc_2 in _loc_1)
            {
                
                this._mapBase.removePlayer(_loc_2);
            }
            return;
        }// end function

        public function getTownMapInfo(param1:String, param2:Function) : MapInfo
        {
            var _loc_4:String = null;
            var _loc_5:String = null;
            var _loc_6:String = null;
            var _loc_3:* = this.townCache[param1] as MapInfo;
            if (_loc_3 == null)
            {
                var _loc_7:* = new MapInfo();
                _loc_3 = new MapInfo();
                this.townCache[param1] = _loc_7;
                _loc_4 = "/map.swf";
                _loc_5 = "/miniJPG.jpg";
                _loc_6 = "/config.xml";
                _loc_3.urlMap = this.getVersion(URI.townUrl + param1 + _loc_4);
                _loc_3.urlMini = this.getVersion(URI.townUrl + param1 + _loc_5);
                _loc_3.urlXML = this.getVersion(URI.townUrl + param1 + _loc_6);
                _loc_3.loadXML();
            }
            _loc_3.onComplete = param2;
            return _loc_3;
        }// end function

        public function getMissionMapInfo(param1:String, param2:int, param3:Function) : MapInfo
        {
            var _loc_5:String = null;
            var _loc_6:String = null;
            var _loc_7:String = null;
            var _loc_4:* = this.missionCache[param1 + "_" + param2] as MapInfo;
            if (this.missionCache[param1 + "_" + param2] as MapInfo == null)
            {
                var _loc_8:* = new MapInfo();
                _loc_4 = new MapInfo();
                this.missionCache[param1 + "_" + param2] = _loc_8;
                _loc_5 = URI.missionUrl + param1 + "/map_" + param2 + ".swf";
                _loc_6 = URI.missionUrl + param1 + "/miniJPG_" + param2 + ".jpg";
                _loc_7 = URI.missionUrl + param1 + "/config_" + param2 + ".xml";
                _loc_4.urlMap = this.getVersion(_loc_5);
                _loc_4.urlMini = this.getVersion(_loc_6);
                _loc_4.urlXML = this.getVersion(_loc_7);
                _loc_4.loadXML();
            }
            _loc_4.onComplete = param3;
            return _loc_4;
        }// end function

        public function setFactionCloth() : void
        {
            var _loc_1:Object = null;
            if (this._playerInfo.signSuffix == "F0" || this._playerInfo.signSuffix == "F1")
            {
                _loc_1 = new Object();
                if (this._playerInfo.signSuffix == "F0")
                {
                    _loc_1.effect = buffInfoLang.FactionClothesEffectA;
                    _loc_1.info = buffInfoLang.FactionClothesInfoA;
                }
                else
                {
                    _loc_1.effect = buffInfoLang.FactionClothesEffectB;
                    _loc_1.info = buffInfoLang.FactionClothesInfoB;
                }
                _view.toolbar.factionClothes(_loc_1);
            }
            else
            {
                _view.toolbar.factionClothes();
            }
            return;
        }// end function

        private function getVersion(param1:String) : String
        {
            return param1 + "?v=" + URI.getVersion(param1);
        }// end function

    }
}
