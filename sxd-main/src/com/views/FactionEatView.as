package com.views
{
    import com.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.controls.*;
    import com.assist.view.interfaces.*;
    import com.haloer.data.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import flash.display.*;
    import flash.text.*;
    import flash.utils.*;

    public class FactionEatView extends Base
    {
        private var _txtUpTip:TextField;
        private var _txtDownTip:TextField;
        private var _txtLine:Sprite;
        private var _mcTip:MovieClip;
        private var _textFormat:TextFormat;
        private var _objCallEatInfo:Object;
        private var _objCallEatDetailedInfo:Object;

        public function FactionEatView()
        {
            return;
        }// end function

        private function get dialog() : IAlert
        {
            return _view.alert.iAlert;
        }// end function

        private function get tip() : ITip
        {
            return this._view.tip.iTip;
        }// end function

        public function callEat() : void
        {
            var callBack:Function;
            callBack = function (param1:uint) : void
            {
                if (param1 == AlertButtonType.Yes)
                {
                    call_eat();
                }
                return;
            }// end function
            ;
            this.dialog.yesLabel = FactionEatViewLang.DialogYes;
            this.dialog.noLabel = FactionEatViewLang.DialogNo;
            this.dialog.show(Lang.sprintf(FactionEatViewLang.CallEat, HtmlText.yellow("900" + FactionEatViewLang.Ingot)), AlertButtonType.Yes | AlertButtonType.No, callBack);
            return;
        }// end function

        public function gotoEat() : void
        {
            if (this._view.missionPractice.inStageWithTip)
            {
                return;
            }
            if (this._view.heroPractice.inStageWithTip)
            {
                return;
            }
            if (TownType.getSign(this._ctrl.player.mapId) == TownType.JiHuiSuo)
            {
                if (this._view.factionWindow.inStage)
                {
                    this._view.factionWindow.close();
                }
                return;
            }
            _view.townMap.gotoTownAtId(TownType.getId(TownType.JiHuiSuo));
            return;
        }// end function

        public function joinEat() : void
        {
            if (this._ctrl.faction.isCanJoinActivity["result"] != Mod_Faction_Base.YES)
            {
                return;
            }
            if (this._objCallEatDetailedInfo["is_join"] == Mod_Faction_Base.YES || this._objCallEatDetailedInfo["rem_time"] <= 0)
            {
                this._view.showTip(this.message(Mod_Faction_Base.IS_EAT));
                return;
            }
            this._view.progressBar.showProgressBar(FactionEatViewLang.Eating, 6, this.join_eat);
            return;
        }// end function

        public function checkFactionEat() : void
        {
            var callBack:Function;
            callBack = function () : void
            {
                _data.call(Mod_Faction_Base.is_can_join_activity, call_eat_detailed_info, []);
                return;
            }// end function
            ;
            if (!FunctionType.isOpened(FunctionType.Faction))
            {
                return;
            }
            if (ActivityType.getOpenLevelToSign(ActivityType.FactionEat) > ActivityType.FactionLevel)
            {
                return;
            }
            if (!this._view.townMap.inStage)
            {
                return;
            }
            if (TownType.getSign(_ctrl.player.mapId) != TownType.JiHuiSuo)
            {
                return;
            }
            setTimeout(callBack, 1000);
            return;
        }// end function

        public function factionEatClickCallBack() : void
        {
            var callBack:Function;
            callBack = function () : void
            {
                if (_ctrl.faction.callEatInfo["rem_time"] <= 0)
                {
                    _view.showTip(message(Mod_Faction_Base.TIME_UP));
                }
                else
                {
                    gotoEat();
                }
                return;
            }// end function
            ;
            if (!FunctionType.isOpened(FunctionType.Faction))
            {
                return;
            }
            if (ActivityType.getOpenLevelToSign(ActivityType.FactionEat) > ActivityType.FactionLevel)
            {
                return;
            }
            if (!this._view.townMap.inStage)
            {
                return;
            }
            this._data.call(Mod_Faction_Base.call_eat_info, callBack, []);
            return;
        }// end function

        public function closeEat() : void
        {
            if (!FunctionType.isOpened(FunctionType.Faction))
            {
                return;
            }
            if (ActivityType.getOpenLevelToSign(ActivityType.FactionEat) > ActivityType.FactionLevel)
            {
                return;
            }
            if (TownType.getSign(this._ctrl.player.mapId) != TownType.JiHuiSuo)
            {
                this._view.removeFromTimerProcessList(this.sign);
            }
            return;
        }// end function

        private function timer() : void
        {
            if (this._objCallEatDetailedInfo != null)
            {
                if (this._objCallEatDetailedInfo["rem_time"] <= 0)
                {
                    this._view.removeFromTimerProcessList(this.sign);
                    if (this._view.townMap.getBuildTarget(2) != null)
                    {
                        this._view.townMap.getBuildTarget(2).visible = false;
                        this._view.townMap.setBuildGetVisible(2, false);
                    }
                }
                else
                {
                    var _loc_1:* = this._objCallEatDetailedInfo;
                    var _loc_2:String = "rem_time";
                    var _loc_3:* = this._objCallEatDetailedInfo["rem_time"] - 1;
                    _loc_1[_loc_2] = _loc_3;
                    this.setTipString(this._objCallEatDetailedInfo);
                }
            }
            if (this._objCallEatInfo != null)
            {
                if (this._objCallEatInfo["rem_time"] <= 0)
                {
                    if (this._objCallEatDetailedInfo == null)
                    {
                        this._view.removeFromTimerProcessList(this.sign);
                    }
                }
                else
                {
                    var _loc_1:* = this._objCallEatInfo;
                    var _loc_2:String = "rem_time";
                    var _loc_3:* = this._objCallEatInfo["rem_time"] - 1;
                    _loc_1[_loc_2] = _loc_3;
                    this.updateFactionEatActivity(this._objCallEatInfo);
                }
            }
            return;
        }// end function

        private function setTipString(param1:Object) : void
        {
            if (this._ctrl.faction.isCanJoinActivity["result"] == Mod_Faction_Base.YES)
            {
                this._txtUpTip.htmlText = HtmlText.format(FactionEatViewLang.FactionEat, HtmlText.Yellow, 16, null, true) + "\r" + FactionEatViewLang.Caller + param1["nick_name"] + "\r" + FactionEatViewLang.RemainingTime1 + DateTime.formatFromSecond(param1["rem_time"]);
                if (param1["is_join"] == Mod_Faction_Base.NO)
                {
                    this._txtDownTip.htmlText = Lang.sprintf(FactionEatViewLang.EatGetInfo, HtmlText.yellow("20" + FactionEatViewLang.Power), HtmlText.yellow("50" + FactionEatViewLang.Fame));
                }
                else
                {
                    this._txtDownTip.htmlText = FactionEatViewLang.JoinFinish;
                }
                if (!this._mcTip.contains(this._txtLine))
                {
                    this._mcTip.addChild(this._txtLine);
                }
                if (!this._mcTip.contains(this._txtDownTip))
                {
                    this._mcTip.addChild(this._txtDownTip);
                }
            }
            else
            {
                this._txtUpTip.htmlText = FactionEatViewLang.NewMember;
                this._txtDownTip.htmlText = "";
                if (this._mcTip.contains(this._txtLine))
                {
                    this._mcTip.removeChild(this._txtLine);
                }
                if (this._mcTip.contains(this._txtDownTip))
                {
                    this._mcTip.removeChild(this._txtDownTip);
                }
            }
            this._txtUpTip.setTextFormat(this._textFormat);
            this._txtDownTip.setTextFormat(this._textFormat);
            return;
        }// end function

        private function updateFactionEatActivity(param1:Object) : void
        {
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            var _loc_2:String = "";
            var _loc_3:String = "";
            var _loc_6:String = "";
            var _loc_7:Boolean = false;
            var _loc_8:int = 0;
            if (param1["rem_time"] > 0)
            {
                _loc_2 = FactionEatViewLang.RemainingTime2 + DateTime.formatFromSecond(param1["rem_time"]);
                if (param1["is_join"] == Mod_Faction_Base.YES)
                {
                    _loc_3 = FactionEatViewLang.Joined;
                    _loc_4 = 0;
                    _loc_5 = 0;
                    _loc_8 = 0;
                }
                else
                {
                    _loc_3 = FactionEatViewLang.Join;
                    _loc_4 = 1;
                    _loc_5 = 1;
                    _loc_8 = 1;
                }
            }
            else
            {
                _loc_2 = Lang.sprintf(FactionEatViewLang.CallTimes, param1["rem_count"]);
                if (param1["rem_count"] <= 0)
                {
                    _loc_5 = 2;
                }
                else
                {
                    _loc_3 = FactionEatViewLang.Call;
                    _loc_4 = 2;
                    _loc_5 = 1;
                    _loc_6 = HtmlText.orange(FactionEatViewLang.CallEatIngot);
                    _loc_8 = 2;
                }
            }
            var _loc_9:* = this._ctrl.faction.isCanJoinActivity;
            if (this._ctrl.faction.isCanJoinActivity["result"] == Mod_Faction_Base.YES)
            {
                _loc_7 = false;
            }
            else
            {
                _loc_7 = true;
                _loc_6 = FactionEatViewLang.NewMember;
            }
            var _loc_10:Object = {sign:ActivityType.FactionEat, isStart:_loc_5, isShowTimer:false, explain:_loc_2, btnInfo:_loc_3, isShowBtnEffic:false, btnType:_loc_4, btnTipInfo:_loc_6, isFilter:_loc_7, state:_loc_8};
            this._view.factionWindow.getActivityState(_loc_10);
            return;
        }// end function

        private function call_eat() : void
        {
            this._data.call(Mod_Faction_Base.call_eat, this.callEatCallBack, []);
            return;
        }// end function

        private function callEatCallBack() : void
        {
            var callBack:Function;
            callBack = function (param1:uint) : void
            {
                gotoEat();
                return;
            }// end function
            ;
            var obj:* = this._ctrl.faction.callEat;
            if (obj["result"] == Mod_Faction_Base.SUCCESS)
            {
                this._view.activities.showWinEffect();
                this.call_eat_info();
                this.dialog.yesLabel = FactionEatViewLang.DialogYes;
                this.dialog.show(Lang.sprintf(FactionEatViewLang.CallEatInfo, HtmlText.yellow("1000" + FactionEatViewLang.Fame)), AlertButtonType.Yes, callBack);
            }
            else
            {
                this._view.showTip(this.message(obj["result"]));
            }
            return;
        }// end function

        private function join_eat() : void
        {
            this._data.call(Mod_Faction_Base.join_eat, this.joinEatCallBack, []);
            return;
        }// end function

        private function joinEatCallBack() : void
        {
            var _loc_1:* = this._ctrl.faction.joinEat;
            if (_loc_1["result"] == Mod_Faction_Base.SUCCESS)
            {
                this.dialog.yesLabel = FactionEatViewLang.DialogYes;
                this.dialog.show(Lang.sprintf(FactionEatViewLang.JoinEatInfo, HtmlText.yellow("20" + FactionEatViewLang.Power + "、50" + FactionEatViewLang.Fame)), AlertButtonType.Yes, null);
            }
            else
            {
                this._view.showTip(this.message(_loc_1["result"]));
            }
            return;
        }// end function

        public function call_eat_info() : void
        {
            if (ActivityType.getOpenLevelToSign(ActivityType.FactionEat) > ActivityType.FactionLevel)
            {
                return;
            }
            this._data.call(Mod_Faction_Base.call_eat_info, this.callEatInfoCallBack, []);
            return;
        }// end function

        private function callEatInfoCallBack() : void
        {
            this._objCallEatInfo = this._ctrl.faction.callEatInfo;
            this.updateFactionEatActivity(this._objCallEatInfo);
            if (this._objCallEatInfo["rem_time"] > 0)
            {
                this._view.addToTimerProcessList(this.sign, this.timer);
            }
            return;
        }// end function

        private function call_eat_detailed_info() : void
        {
            this._data.call(Mod_Faction_Base.call_eat_detailed_info, this.callEatDetailedInfoCallBack, []);
            return;
        }// end function

        public function callEatDetailedInfoCallBack() : void
        {
            this._objCallEatDetailedInfo = this._ctrl.faction.callEatDetailedInfo;
            if (this._objCallEatDetailedInfo["player_id"] == 0)
            {
                return;
            }
            var _loc_1:* = TownType.getTownNPCIdByFunc(_ctrl.player.mapId, NPCType.FactionGodNPC);
            if (_loc_1 != 0 && this._view.townMap.getBuildTarget(2) != null)
            {
                this._view.townMap.getBuildTarget(2).visible = true;
                this._view.townMap.setBuildGetVisible(2, this._objCallEatDetailedInfo["is_join"] == Mod_Faction_Base.NO);
            }
            if (this._mcTip == null)
            {
                this._txtUpTip = new TextField();
                this._txtUpTip.autoSize = TextFieldAutoSize.LEFT;
                this._txtUpTip.textColor = HtmlText.White;
                this._txtDownTip = new TextField();
                this._txtDownTip.autoSize = TextFieldAutoSize.LEFT;
                this._txtDownTip.textColor = HtmlText.White;
                this._txtDownTip.y = 73;
                this._textFormat = new TextFormat();
                this._textFormat.leading = 6;
                this._txtLine = new Sprite();
                this._txtLine.graphics.lineStyle(1, 4013373, 1);
                this._txtLine.graphics.moveTo(2, 69);
                this._txtLine.graphics.lineTo(160, 69);
                this._mcTip = new MovieClip();
                this._mcTip.addChild(this._txtUpTip);
                this._mcTip.addChild(this._txtLine);
                this._mcTip.addChild(this._txtDownTip);
            }
            if (this._view.factionWindow.inStage)
            {
                this.call_eat_info();
            }
            if (this._view.townMap.getBuildTarget(2) != null)
            {
                this.timer();
                this.tip.addTarget(this._view.townMap.getBuildTarget(2), this._mcTip);
            }
            this._view.addToTimerProcessList(this.sign, this.timer);
            return;
        }// end function

        private function message(param1:int) : String
        {
            var _loc_2:String = "";
            switch(param1)
            {
                case Mod_Faction_Base.SUCCESS:
                {
                    _loc_2 = FactionEatViewLang.Success;
                    break;
                }
                case Mod_Faction_Base.INSUFFICIENT_INGOT:
                {
                    _loc_2 = FactionEatViewLang.InsufficientIngot;
                    break;
                }
                case Mod_Faction_Base.TODAY_IS_CALL:
                {
                    _loc_2 = FactionEatViewLang.TodayIsCall;
                    break;
                }
                case Mod_Faction_Base.IS_CALL:
                {
                    _loc_2 = FactionEatViewLang.IsCall;
                    break;
                }
                case Mod_Faction_Base.IS_EAT:
                {
                    _loc_2 = FactionEatViewLang.IsEat;
                    break;
                }
                case Mod_Faction_Base.TIME_UP:
                {
                    _loc_2 = FactionEatViewLang.TimeUp;
                    break;
                }
                case Mod_Faction_Base.NO_BANQUET:
                {
                    _loc_2 = FactionEatViewLang.NoBanquet;
                    break;
                }
                default:
                {
                    _loc_2 = FactionEatViewLang.Error + param1;
                    break;
                }
            }
            return _loc_2;
        }// end function

    }
}
