package com.views
{
    import com.*;
    import com.assist.*;
    import com.assist.data.mission.*;
    import com.assist.view.*;
    import com.assist.view.interfaces.*;
    import com.assist.view.war.*;
    import com.lang.client.com.views.*;

    public class BeelzebubTrialsWarView extends SportWarView
    {
        public var warData:WarData;

        public function BeelzebubTrialsWarView() : void
        {
            _type = WarType.BeelzebubTrialsWar;
            return;
        }// end function

        override public function show() : void
        {
            if (_view.campWar.inStageWithTip)
            {
                return;
            }
            if (_view.heroesWar.inStageWithTip)
            {
                return;
            }
            super.show();
            return;
        }// end function

        override protected function start() : void
        {
            onProgress = function (param1:int, param2:int, param3:int, param4:String) : void
            {
                _view.showLoading(BeelzebubTrialsWarViewLang.LoadAssets, param3, (param2 + 1), param1);
                return;
            }// end function
            ;
            loadResources();
            return;
        }// end function

        override protected function loadRoleResource() : void
        {
            _warData = this.warData;
            super.loadRoleResource();
            return;
        }// end function

        override protected function getStudyStuntPlayerIds() : Array
        {
            var _loc_5:int = 0;
            var _loc_1:* = _ctrl.beelzebubTrials.playerIdList;
            var _loc_2:Array = [];
            var _loc_3:* = _loc_1.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = _loc_1[_loc_4];
                _loc_2.push([_loc_5]);
                _loc_4++;
            }
            return _loc_2;
        }// end function

        override protected function addonWarIcon(param1:Array, param2:Array) : void
        {
            param1.push("WarIcon");
            param2.push(URI.mapUrl + "beelzebub_trials/beelzebub_trials.png");
            param1.push("Background");
            param2.push(URI.mapUrl + "beelzebub_trials/beelzebub_trials.swf");
            param1.push("Aura");
            param2.push(URI.effectsUrl + "aura.swf");
            return;
        }// end function

        override protected function createTarget() : void
        {
            _view.hideLoading();
            _war = _view.getAssetsObject("War", "War") as IWar;
            _war.warData = _warData;
            _war.background = background;
            _war.equitData = _ctrl.beelzebubTrials.equitData;
            var _loc_1:String = "";
            var _loc_2:Array = [];
            var _loc_3:* = _ctrl.beelzebubTrials.awardFlag;
            if (_ctrl.beelzebubTrials.awardFame <= 0 && _ctrl.beelzebubTrials.awardCoin <= 0)
            {
                _loc_1 = BeelzebubTrialsWarViewLang.End;
            }
            else
            {
                if (_ctrl.beelzebubTrials.awardFame > 0)
                {
                    _loc_2.push(HtmlText.green(BeelzebubTrialsWarViewLang.fram + "+" + _ctrl.beelzebubTrials.awardFame));
                }
                if (_ctrl.beelzebubTrials.awardCoin > 0)
                {
                    _loc_2.push(HtmlText.green(BeelzebubTrialsWarViewLang.coin + "+" + _ctrl.beelzebubTrials.awardCoin));
                }
                _loc_1 = Lang.sprintf(BeelzebubTrialsWarViewLang.AwardInfo, _loc_3, _loc_2.join(" "));
            }
            var _loc_4:* = _loc_3 > 3 ? (BeelzebubTrialsWarViewLang.End) : (_loc_1);
            _war.sportAwardText = _loc_4;
            return;
        }// end function

        override protected function onCloseHandler(param1:Boolean) : void
        {
            clearRoles();
            closeWar();
            if (onClose is Function)
            {
                onClose(param1);
            }
            return;
        }// end function

    }
}
