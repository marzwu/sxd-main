package com.views
{
    import com.assist.server.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;

    public class AchievementView extends Base implements IView
    {
        private var _achievement:IAchievement;
        private var _delayGotoAchievementLabel:Function = null;

        public function AchievementView()
        {
            return;
        }// end function

        public function show() : void
        {
            if (_view.luckyWheel.isMovie == true)
            {
                return;
            }
            this.loadData();
            return;
        }// end function

        public function close() : void
        {
            this.clear();
            _popup.closeView(this);
            return;
        }// end function

        public function clear() : void
        {
            this._achievement.clear();
            return;
        }// end function

        private function loadData() : void
        {
            var callBack:Function;
            callBack = function () : void
            {
                get_player_achievement_list(loadDataCallBak);
                return;
            }// end function
            ;
            AchievementType.loadData(callBack);
            return;
        }// end function

        private function loadDataCallBak() : void
        {
            loadAssets("Achievement", this.render, AchievementViewLang.LoadInfo);
            return;
        }// end function

        private function showUI() : void
        {
            _popup.addView(this, this._achievement.content);
            _view.center(sign, this._achievement.content);
            return;
        }// end function

        private function render() : void
        {
            if (this._achievement == null)
            {
                this._achievement = _view.getAssetsObject("Achievement", "Achievement") as IAchievement;
            }
            this.init();
            this.getPlayerAchievementListCallBack();
            this.showUI();
            if (this._delayGotoAchievementLabel is Function)
            {
                this._delayGotoAchievementLabel();
            }
            return;
        }// end function

        private function init() : void
        {
            this._achievement.tip = this._view.tip.iTip;
            this._achievement.drag = this._view.drag.iDrag;
            this._achievement.onClose = this.close;
            this._achievement.init();
            return;
        }// end function

        public function gotoAchievementLabel(param1:int) : void
        {
            var callBack:Function;
            var delay:Function;
            var intAchievementId:* = param1;
            callBack = function () : void
            {
                getPlayerAchievementListCallBack();
                _achievement.gotoAchievementLabel(intAchievementId);
                return;
            }// end function
            ;
            delay = function () : void
            {
                _achievement.gotoAchievementLabel(intAchievementId);
                _delayGotoAchievementLabel = null;
                return;
            }// end function
            ;
            if (this.inStage)
            {
                this.get_player_achievement_list(callBack);
            }
            else
            {
                this.switchSelf();
                this._delayGotoAchievementLabel = delay;
            }
            return;
        }// end function

        private function get_player_achievement_list(param1:Function) : void
        {
            this._data.call(Mod_Achievement_Base.get_player_achievement_list, param1, [], false);
            return;
        }// end function

        private function getPlayerAchievementListCallBack() : void
        {
            var _loc_1:* = this._ctrl.achievement.getPlayerAchievementList;
            this._achievement.renderAchievementList(_loc_1);
            return;
        }// end function

    }
}
