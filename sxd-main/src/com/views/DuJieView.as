package com.views
{
    import com.assist.view.interfaces.*;
    import com.protocols.*;
    import flash.utils.*;

    public class DuJieView extends Base implements IView
    {
        public var roleList:Array;
        public var roleObj:Object;
        public var defaultObj:Object;
        private var _target:IDuJie;
        private var _warTime:int = 0;

        public function DuJieView()
        {
            this.roleList = [];
            this.roleObj = {};
            this.defaultObj = {};
            return;
        }// end function

        public function show() : void
        {
            if (_view.campWar.inStageWithTip)
            {
                return;
            }
            if (_view.heroesWar.inStageWithTip)
            {
                return;
            }
            if (_view.factionWarMap.inStageWithTip)
            {
                return;
            }
            if (_view.multiMission.inStageWithTip)
            {
                return;
            }
            if (_view.serverWarCup.inStageWithTip)
            {
                return;
            }
            if (_view.superSport.inStageWithTip)
            {
                return;
            }
            if (_view.takeBibleRoad.inStageWithTip)
            {
                return;
            }
            if (_view.tower.inStageWithTip)
            {
                return;
            }
            if (_view.worldBossMap.inStageWithTip)
            {
                return;
            }
            if (_view.zodiac.inStageWithTip)
            {
                return;
            }
            if (_view.nineRegionsMap.inStageWithTip)
            {
                return;
            }
            if (_view.beelzebubTrialsMap.inStageWithTip)
            {
                return;
            }
            if (_view.topWarMap.inStageWithTip)
            {
                return;
            }
            loadAssets("DuJie", this.loadComplete, "", true);
            return;
        }// end function

        public function close() : void
        {
            _popup.closeView(this);
            return;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

        private function loadComplete() : void
        {
            if (this._target == null)
            {
                this._target = _view.getAssetsObject("DuJie", "MCDuJie") as IDuJie;
                this._target.onClose = this.close;
                this._target.onOk = this.onOk;
            }
            if (inStage == false)
            {
                _popup.addView(this, this._target.content);
            }
            this._target.init(this.roleObj, this.defaultObj, this.roleList);
            return;
        }// end function

        private function onOk() : void
        {
            this.go_dujie(this.roleObj.id, this._target.selectRole.id, this._target.selectLineup);
            return;
        }// end function

        private function onWarClose(param1:Boolean) : void
        {
            if (_ctrl.dujie.result == Mod_Dujie_Base.SUCCESS)
            {
                _view.roleMsg.show();
            }
            return;
        }// end function

        private function go_dujie(param1:int, param2:int, param3:int) : void
        {
            if (this._warTime > getTimer())
            {
                return;
            }
            this._warTime = getTimer() + 700;
            _view.dujieWar.opened = true;
            _data.call(Mod_Dujie_Base.go_dujie, this.go_dujie_back, [param1, param2, param3]);
            return;
        }// end function

        private function go_dujie_back() : void
        {
            if (_ctrl.dujie.result == Mod_Dujie_Base.SUCCESS || _ctrl.dujie.result == Mod_Dujie_Base.FAIL)
            {
                this.close();
                _view.dujieWar.warData = _ctrl.dujie.warData;
                _view.dujieWar.onClose = this.onWarClose;
                _view.dujieWar.show();
            }
            else
            {
                _view.showTip(_ctrl.dujie.resultTip);
            }
            return;
        }// end function

    }
}
