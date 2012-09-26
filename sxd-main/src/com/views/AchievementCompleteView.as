package com.views
{
    import com.*;
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.interfaces.*;
    import com.assist.view.sound.*;
    import com.assist.view.toolbar.*;
    import com.haloer.net.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;

    public class AchievementCompleteView extends Base
    {
        private var _aryNotifyData:Array;
        private var _achievementComplete:IAchievementComplete;
        private var _mcButton:MovieClip;
        private var _file:File;
        private var _intTemp:int = 0;

        public function AchievementCompleteView()
        {
            this._aryNotifyData = [];
            return;
        }// end function

        public function close() : void
        {
            if (this._view.stage.contains(this._achievementComplete.content))
            {
                this._view.stage.removeChild(this._achievementComplete.content);
            }
            if (this._view.stage.contains(this._mcButton))
            {
                this._view.stage.removeChild(this._mcButton);
            }
            this._mcButton.removeEventListener(MouseEvent.CLICK, this.onMcButtonMouseClick);
            return;
        }// end function

        public function reposition(param1:Boolean = true) : void
        {
            if (param1 == true)
            {
                _view.toolbar.reposition();
            }
            else if (this._achievementComplete != null && this._view.stage.contains(this._achievementComplete.content))
            {
                this._achievementComplete.content.x = Math.max(350, Math.floor((this._view.stage.stageWidth - this._achievementComplete.content.width) / 2) - Structure.stageClip.x);
                this._achievementComplete.content.y = Math.max(Structure.stageHeight - 160, this._view.stage.stageHeight - Structure.stageOffset.y - 160);
                this._mcButton.x = this._achievementComplete.content.x;
                this._mcButton.y = this._achievementComplete.content.y;
            }
            return;
        }// end function

        public function notifyCompleteAchievementCallBack() : void
        {
            if (!FunctionType.isOpened(FunctionType.Achievement))
            {
                return;
            }
            if (this._ctrl.achievement.inLoadAchievementTypeData)
            {
                setTimeout(this.notifyCompleteAchievementCallBack, 20);
                return;
            }
            this.loadAchievementTypeCallBack();
            return;
        }// end function

        private function loadAchievementTypeCallBack() : void
        {
            var _loc_2:Object = null;
            var _loc_1:* = this._ctrl.achievement.notifyCompleteAchievement;
            if (FunctionType.isOpened(FunctionType.Achievement))
            {
                for each (_loc_2 in _loc_1)
                {
                    
                    this._aryNotifyData.push(_loc_2);
                }
                if (this._file == null)
                {
                    this._file = new File();
                }
                this._file.onComplete = this.render;
                this._file.load(URI.assetsUrl + "achievement_complete.swf");
            }
            return;
        }// end function

        private function render() : void
        {
            var _loc_1:Class = null;
            if (this._achievementComplete == null)
            {
                _loc_1 = this._file.getClassByName("AchievementComplete");
                this._achievementComplete = new _loc_1 as IAchievementComplete;
            }
            if (this._mcButton == null)
            {
                this._mcButton = new MovieClip();
                this._mcButton.graphics.beginFill(16777215);
                this._mcButton.graphics.drawRect(0, 0, 71, 301);
                this._mcButton.graphics.endFill();
                this._mcButton.height = 71;
                this._mcButton.width = 301;
                this._mcButton.buttonMode = true;
                this._mcButton.alpha = 0;
            }
            this._mcButton.addEventListener(MouseEvent.CLICK, this.onMcButtonMouseClick);
            this._achievementComplete.onShowTownCartoon = this.onShowTownCartoon;
            this._achievementComplete.onClose = this.close;
            this._achievementComplete.onShowAchievement = this._view.achievement.gotoAchievementLabel;
            this.isDelayShow();
            return;
        }// end function

        public function isDelayShow() : void
        {
            if (_view.inWar)
            {
                _view.onWarClose = function () : void
            {
                _view.onWarClose = null;
                showCartoon();
                return;
            }// end function
            ;
            }
            else
            {
                this.showCartoon();
            }
            return;
        }// end function

        private function showCartoon() : void
        {
            var _loc_1:Object = null;
            var _loc_2:String = null;
            var _loc_3:String = null;
            var _loc_4:String = null;
            var _loc_5:Object = null;
            var _loc_6:String = null;
            var _loc_7:String = null;
            var _loc_8:String = null;
            var _loc_9:String = null;
            var _loc_10:String = null;
            var _loc_11:String = null;
            var _loc_12:String = null;
            for each (_loc_1 in this._aryNotifyData)
            {
                
                if (_loc_1["player_id"] == this._ctrl.player.playerId)
                {
                    if (!this._view.stage.contains(this._achievementComplete.content))
                    {
                        this._view.stage.addChild(this._achievementComplete.content);
                        this._view.stage.addChild(this._mcButton);
                        this.reposition(false);
                    }
                    this._achievementComplete.show(_loc_1);
                }
                if (ActivityType.FactionLevel > 0)
                {
                    _loc_2 = "<a href=\'event:" + TextLinkType.Player + "_" + _loc_1["player_id"] + "_" + _loc_1["player_nickname"] + "\'><u>" + _loc_1["player_nickname"] + "</u></a>";
                    _loc_3 = "<a href=\'event:" + TextLinkType.Achievement + "_" + _loc_1["achievement_id"] + "\'>[<u>" + AchievementType.getName(_loc_1["achievement_id"]) + "</u>]</a>";
                    _loc_4 = "<font color=\'#80c269\'>[" + AchievementCompleteViewLang.Faction + "]</font>" + Lang.sprintf(HtmlText.white(AchievementCompleteViewLang.GetAchievement), HtmlText.yellow(_loc_2), HtmlText.yellow(_loc_3), HtmlText.white(AchievementType.getPoint(_loc_1["achievement_id"]).toString()));
                    _view.chat.receive(_loc_4, false, Mod_Chat_Base.FACTION);
                }
            }
            if (URI.weiBoNickName != "" && this._aryNotifyData.length > 0)
            {
                _loc_5 = this._aryNotifyData[0] as Object;
                _loc_6 = Lang.sprintf(AchievementCompleteViewLang.AchievementComplete, _loc_5["name"]);
                _loc_7 = _loc_5["content"];
                _loc_8 = AchievementCompleteViewLang.JoinGame;
                _loc_9 = Lang.sprintf(AchievementCompleteViewLang.IAmCompleted, _loc_5["name"]);
                _loc_10 = "http://game.weibo.com/shenxiandao";
                _loc_11 = "http://game.weibo.com/shenxiandao";
                _loc_12 = _loc_5["url"];
                _view.sendWeiBo(_loc_6, _loc_7, _loc_8, _loc_9, _loc_10, _loc_11, _loc_12);
            }
            this._aryNotifyData = [];
            return;
        }// end function

        private function onShowTownCartoon() : void
        {
            _view.townMap.showAchievement();
            SoundEffect.play(SoundEffect.AchievementComplete);
            return;
        }// end function

        private function onMcButtonMouseClick(event:MouseEvent) : void
        {
            this._achievementComplete.onMcButtonMouseClick();
            return;
        }// end function

    }
}
