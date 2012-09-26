package com.views
{
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;

    public class OtherTeamInfoView extends Base implements IView
    {
        private var _target:IOtherTeamInfo;
        private var _teamId:int;

        public function OtherTeamInfoView()
        {
            return;
        }// end function

        public function show() : void
        {
            _data.call(Mod_NewTopWar_Base.team_info, this.teamInfoBack, [this._teamId]);
            return;
        }// end function

        private function teamInfoBack() : void
        {
            loadAssets("OtherTeamInfo", this.render, OtherTeamInfoViewLang.Open);
            return;
        }// end function

        public function close() : void
        {
            _popup.closeView(this);
            this.clear();
            return;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

        private function render() : void
        {
            if (!this._target)
            {
                this._target = _view.getAssetsObject("OtherTeamInfo", "McOtherTeamInfo") as IOtherTeamInfo;
                this._target.onClose = this.close;
                this._target.onSeePlayerInfo = this.showPlayerInfoView;
                _view.drag.iDrag.addTarget(this._target.dragTitleBar, this._target.content);
            }
            _popup.addView(this, this._target.content);
            this._target.teamInfo = _ctrl.newTopWar.otherTeamInfoObj;
            return;
        }// end function

        private function showPlayerInfoView(param1:int, param2:String) : void
        {
            if (param1 == _ctrl.player.playerId)
            {
                return;
            }
            _view.otherRoleMsg.init(param1, param2);
            _view.otherRoleMsg.show();
            return;
        }// end function

        public function set teamId(param1:int) : void
        {
            this._teamId = param1;
            this.show();
            return;
        }// end function

        public function set teamInfo(param1:Object) : void
        {
            _ctrl.newTopWar.otherTeamInfoObj = param1;
            this.teamInfoBack();
            return;
        }// end function

    }
}
