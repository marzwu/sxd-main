package com.views
{
    import com.assist.server.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import flash.display.*;

    public class NineRegionsView extends Base implements IView
    {
        public var targetUi:INineRegions;
        private var _chooseJie:int = 0;

        public function NineRegionsView()
        {
            return;
        }// end function

        public function show() : void
        {
            if (_view.heroesWar.inStageWithTip)
            {
                return;
            }
            if (_view.tower.inStageWithTip)
            {
                return;
            }
            if (_view.campWar.inStageWithTip)
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
            if (_view.multiMission.inStageWithTip)
            {
                return;
            }
            _data.call(Mod_NineRegions_Base.open_panel, this.openPanelBack, []);
            return;
        }// end function

        public function close() : void
        {
            if (this.targetUi)
            {
                this.targetUi.init();
            }
            return;
        }// end function

        private function startChallengeCallBack() : void
        {
            var data:* = _ctrl.nineRegions.warObj;
            if (data.challengeResult == Mod_NineRegions_Base.CHALLENGE_SUCCESS)
            {
                _view.nineRegionsWar.warData = _ctrl.nineRegions.warData;
                _view.nineRegionsWar.onClose = function (param1:Boolean) : void
            {
                if (param1)
                {
                }
                show();
                _view.chat.resetDepth();
                return;
            }// end function
            ;
                _view.nineRegionsWar.show();
            }
            else if (data.challengeResult == Mod_NineRegions_Base.CHALLENGE_LEVEL)
            {
                _view.showTip(NineRegionsViewLang.NotEnoughLevel);
            }
            else if (data.challengeResult == Mod_NineRegions_Base.CHALLENGE_TOWER)
            {
                _view.showTip(NineRegionsViewLang.NotPassTower);
            }
            else if (data.challengeResult == Mod_NineRegions_Base.CHALLENGE_REGION)
            {
                _view.showTip(NineRegionsViewLang.NotRegion);
            }
            else if (data.challengeResult == Mod_NineRegions_Base.CHALLENGE_OTHER)
            {
                _view.showTip(NineRegionsViewLang.OtherErr);
            }
            return;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

        public function openPanelBack() : void
        {
            loadAssets("NineRegions", this.loadComplete, NineRegionsViewLang.LoadingInfo, false, true);
            return;
        }// end function

        private function loadComplete() : void
        {
            if (!this.targetUi)
            {
                this.targetUi = _view.getAssetsObject("NineRegions", "McNineRegionsMain") as INineRegions;
                this.targetUi.onWar = this.onWar;
                this.targetUi.onCloseFun = this.onCloseWindow;
                this.targetUi.onTip = this.onTip;
                this.targetUi.onHiddenWar = this.onHiddenWar;
            }
            if (!inStage)
            {
                _popup.addView(this, this.targetUi.content);
                _view.center(sign, this.targetUi.content);
            }
            if (_ctrl.nineRegions.isFrist)
            {
                this.targetUi.firstCatoon(_ctrl.player.level);
            }
            else
            {
                this.targetUi.setJieLevel(_ctrl.nineRegions.curJie, _ctrl.nineRegions.curLevel);
                this.targetUi.playerLv = _ctrl.player.level;
            }
            var _loc_1:* = NineRegionsType.getHiddenInfoById(_ctrl.nineRegions.hiddenLevel);
            this.targetUi.bShowHidden(_ctrl.nineRegions.hiddenLevel != 0, _loc_1[0], _loc_1[3]);
            return;
        }// end function

        public function updatePlayerLv() : void
        {
            if (this.targetUi)
            {
                this.targetUi.playerLv = _ctrl.player.level;
            }
            return;
        }// end function

        private function onWar(param1:int, param2:int) : void
        {
            _view.nineRegionsWar.IsGetWarData = true;
            this._chooseJie = param1;
            if (param1 == 0)
            {
                _data.call(Mod_NineRegions_Base.start_challenge, this.openTeamCreat, [1, 1]);
            }
            else
            {
                _data.call(Mod_NineRegions_Base.start_challenge, this.openTeamCreat, [param1, param2]);
            }
            return;
        }// end function

        private function openTeamCreat() : void
        {
            this.onCloseWindow();
            if (_ctrl.nineRegions.warObj.firstChallenge && this._chooseJie <= 2)
            {
                _view.nineRegionsDrama.loadDrama(this._chooseJie);
            }
            else
            {
                _view.nineRegionsTeamCreat.jieId = this._chooseJie;
                _view.nineRegionsTeamCreat.show();
            }
            return;
        }// end function

        private function onCloseWindow() : void
        {
            _popup.closeView(this);
            return;
        }// end function

        private function warBack() : void
        {
            if (_ctrl.nineRegions.warObj.firstChallenge)
            {
                this.startChallengeCallBack();
            }
            else
            {
                this.startChallengeCallBack();
            }
            return;
        }// end function

        private function onHiddenWar() : void
        {
            _data.call(Mod_NineRegions_Base.challenge_hidden_level, this.onHiddenWarBack, [_ctrl.nineRegions.hiddenLevel]);
            return;
        }// end function

        private function onHiddenWarBack() : void
        {
            if (_ctrl.nineRegions.hiddenWarResult == Mod_NineRegions_Base.CANT_CHALLENGE_HIDDEN)
            {
                _view.showTip(NineRegionsViewLang.CantChallengeHidden);
                return;
            }
            _view.nineRegionsHiddenWar.warData = _ctrl.nineRegions.hiddenWarData;
            _view.nineRegionsHiddenWar.onClose = function (param1:Boolean) : void
            {
                if (param1)
                {
                }
                _view.chat.resetDepth();
                return;
            }// end function
            ;
            _view.nineRegionsHiddenWar.show();
            return;
        }// end function

        private function onTip(param1:DisplayObject, param2 = null) : void
        {
            var _loc_3:Sprite = null;
            if (param2 == "" || param2 == null)
            {
                _view.tip.iTip.removeTarget(param1);
            }
            else
            {
                _view.tip.iTip.addTarget(param1, param2);
                _loc_3 = param1 as Sprite;
            }
            return;
        }// end function

    }
}
