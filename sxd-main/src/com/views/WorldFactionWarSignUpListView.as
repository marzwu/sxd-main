package com.views
{
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import flash.display.*;

    public class WorldFactionWarSignUpListView extends Base implements IView
    {
        private var _target:IWorldFactionWarSignUpList;

        public function WorldFactionWarSignUpListView()
        {
            return;
        }// end function

        public function show() : void
        {
            if (inStage == true)
            {
                return;
            }
            _data.call(Mod_WorldFactionWar_Base.sign_list, this.getInfoBack, []);
            return;
        }// end function

        private function getInfoBack() : void
        {
            loadAssets("WorldFactionwarSignupList", this.loadComplete, WorldFactionWarSignUpListViewLang.Loading);
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
                this._target = _view.getAssetsObject("WorldFactionwarSignupList", "MCSignUpListClass") as IWorldFactionWarSignUpList;
                this._target.onClose = this.close;
                this._target.onLink = this.onLink;
                _view.drag.iDrag.addTarget(this._target.dragTitleBar, this._target.content);
            }
            this._target.myRank = _ctrl.worldFactionWar.myRank;
            this._target.initRank(_ctrl.worldFactionWar.signUpList);
            this._target.bBaoMingTime = _ctrl.worldFactionWar.info.stateServer == Mod_WorldFactionWar_Base.WORLD_FACTION_WAR_SIGN_UP;
            _popup.addView(this, this._target.content);
            return;
        }// end function

        private function onLink(param1:int, param2:String) : void
        {
            if (param1 == _ctrl.player.playerId)
            {
                return;
            }
            _view.otherRoleMsg.init(param1, param2);
            _view.otherRoleMsg.show();
            return;
        }// end function

        private function onTip(param1:DisplayObject, param2 = null) : void
        {
            if (param1 == null)
            {
                return;
            }
            if (param2 == null || param2 == "")
            {
                _view.tip.iTip.removeTarget(param1);
            }
            else
            {
                _view.tip.iTip.addTarget(param1, param2);
            }
            return;
        }// end function

    }
}
