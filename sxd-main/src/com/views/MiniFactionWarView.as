package com.views
{
    import com.*;
    import com.assist.*;
    import com.assist.data.mission.*;
    import com.assist.server.*;
    import com.assist.view.interfaces.*;
    import com.assist.view.war.*;
    import com.haloer.net.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;

    public class MiniFactionWarView extends SportWarView implements IView
    {
        public var awardExp:int;
        public var awardFame:int;
        public var awardCoin:int;
        public var warData:WarData;
        private var _preloadId:int;

        public function MiniFactionWarView() : void
        {
            _type = WarType.MiniFactionWar;
            return;
        }// end function

        override public function show() : void
        {
            removeWar();
            this.stopPreload();
            super.show();
            return;
        }// end function

        override protected function showEffect() : void
        {
            onEffectFinish(null);
            return;
        }// end function

        override protected function start() : void
        {
            onProgress = function (param1:int, param2:int, param3:int, param4:String) : void
            {
                _view.showLoading(MiniFactionWarViewLang.LoadInfo, param3, (param2 + 1), param1);
                return;
            }// end function
            ;
            onAfterAdded = function () : void
            {
                _popup.addMask(false, 0);
                return;
            }// end function
            ;
            _popup.addMask(false, 0);
            this.loadResources();
            return;
        }// end function

        override protected function loadResources() : void
        {
            loadAssets("MiniFactionWar", this.loadRoleResource, MiniFactionWarViewLang.LoadInfo);
            return;
        }// end function

        override protected function loadRoleResource() : void
        {
            _warData = this.warData;
            super.loadRoleResource();
            return;
        }// end function

        override protected function createTarget() : void
        {
            _view.hideLoading();
            _war = _view.getAssetsObject("MiniFactionWar", "MiniFactionWar") as IWar;
            _war.warData = _warData;
            _war.autoWar = true;
            if (this.awardCoin || this.awardFame)
            {
                _war.sportAwardText = Lang.sprintf(MiniFactionWarViewLang.Award, "<font color=\"#00ff00\">" + this.awardCoin + "</font>", "<font color=\"#00ff00\">" + this.awardFame + "</font>");
            }
            _popup.removeMask();
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

        public function startPreload() : void
        {
            _data.call(Mod_Role_Base.get_role_id_list, this.preloadResources, []);
            return;
        }// end function

        public function stopPreload() : void
        {
            File.stopLoadList(this._preloadId);
            return;
        }// end function

        private function preloadResources() : void
        {
            var sign:String;
            var signs:* = RoleType.getRoleSigns(_ctrl.rolemsg.roleIdList);
            var mainRoleSuffix:* = _ctrl.player.playerInfo.signSuffix;
            var i:int;
            while (i < signs.length)
            {
                
                sign = signs[i];
                if (RoleType.isMainRole(sign))
                {
                    sign = sign + mainRoleSuffix;
                }
                signs[i] = URI.warRolesUrl + sign + ".swf";
                i = (i + 1);
            }
            var callback:* = function (param1:Array) : void
            {
                return;
            }// end function
            ;
            this._preloadId = File.loadList(signs, callback);
            return;
        }// end function

    }
}
