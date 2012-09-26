package com.views
{
    import com.assist.*;
    import com.assist.data.mission.*;
    import com.assist.server.*;
    import com.assist.view.interfaces.*;
    import com.assist.view.war.*;
    import com.haloer.net.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;

    public class FactionWarView extends SportWarView
    {
        public var awardExp:int;
        public var awardFame:int;
        public var awardCoin:int;
        public var warData:WarData;
        private var _preloadId:int;

        public function FactionWarView() : void
        {
            _type = WarType.FactionWar;
            return;
        }// end function

        override public function show() : void
        {
            removeWar();
            this.stopPreload();
            super.show();
            return;
        }// end function

        override protected function start() : void
        {
            onProgress = function (param1:int, param2:int, param3:int, param4:String) : void
            {
                _view.showLoading(FactionWarViewLang.LoadInfo, param3, (param2 + 1), param1);
                return;
            }// end function
            ;
            _popup.addMask();
            loadResources();
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
            _war = _view.getAssetsObject("War", "War") as IWar;
            _war.warData = _warData;
            _war.autoWar = true;
            if (this.awardExp || this.awardFame || this.awardCoin)
            {
                _war.sportAwardText = FactionWarViewLang.Award + (this.awardExp ? (FactionWarViewLang.Exp + " <font color=\"#00ff00\">" + this.awardExp + "</font>  ") : ("")) + (this.awardFame ? (FactionWarViewLang.Fame + " <font color=\"#00ff00\">" + this.awardFame + "</font>  ") : ("")) + (this.awardCoin ? (FactionWarViewLang.Coin + " <font color=\"#00ff00\">" + this.awardCoin + "</font>  ") : (""));
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
