package com.views
{
    import com.assist.view.interfaces.*;
    import com.assist.view.war.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import flash.events.*;

    public class WorldFactionWarRecordView extends Base implements IView
    {
        private var _target:IWorldFactionWarRecord;

        public function WorldFactionWarRecordView()
        {
            return;
        }// end function

        public function show() : void
        {
            if (inStage)
            {
                return;
            }
            if (_ctrl.worldFactionWar.signUpType != 2)
            {
                _view.worldFactionWarSignUp.switchSelf();
            }
            else
            {
                this.get_standings();
            }
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
                this._target = _view.getAssetsObject("WorldFactionwarRecord", "MCOutRecordClass") as IWorldFactionWarRecord;
                this._target.onClose = this.close;
                this._target.onLink = this.onLink;
                _view.drag.iDrag.addTarget(this._target.dragTitleBar, this._target.content);
            }
            this._target.update(_ctrl.worldFactionWar.dieOutTip, _ctrl.worldFactionWar.dieOutWarList);
            _popup.addView(this, this._target.content);
            return;
        }// end function

        private function onLink(event:TextEvent) : void
        {
            var _loc_2:* = event.text.split("_");
            if (_loc_2[0] == "war")
            {
                _data.call(Mod_WorldFactionWar_Base.world_faction_war_report, this.showWar, [_loc_2[1], _loc_2[2], _loc_2[3], _loc_2[4]]);
            }
            return;
        }// end function

        private function showWar() : void
        {
            _view.strategyWar.warType = WarType.WorldFactionWar;
            _view.strategyWar.wfWarData = _ctrl.worldFactionWar.warData;
            _view.strategyWar.show();
            return;
        }// end function

        public function update() : void
        {
            this.get_standings();
            return;
        }// end function

        private function get_standings() : void
        {
            _data.call(Mod_WorldFactionWar_Base.get_standings, this.get_standings_back, []);
            return;
        }// end function

        private function get_standings_back() : void
        {
            loadAssets("WorldFactionwarRecord", null, WorldFactionWarRecordViewLang.Loading, false, false, this.loadComplete);
            return;
        }// end function

    }
}
