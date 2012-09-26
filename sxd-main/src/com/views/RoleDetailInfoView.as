package com.views
{
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;

    public class RoleDetailInfoView extends Base implements IView
    {
        private var _roleDetailInfo:IRoleDetailInfo;
        public var playerRoleId:int;
        public var playerName:String;

        public function RoleDetailInfoView()
        {
            return;
        }// end function

        public function show() : void
        {
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
            this._roleDetailInfo.clear();
            return;
        }// end function

        public function updateDetailInfo(param1:int, param2:String) : void
        {
            this.playerName = param2;
            this.playerRoleId = param1;
            this.get_role_war_attribute();
            return;
        }// end function

        private function showUI() : void
        {
            _popup.addView(this, this._roleDetailInfo.content);
            _view.center(sign, this._roleDetailInfo.content);
            return;
        }// end function

        private function render() : void
        {
            if (this._roleDetailInfo == null)
            {
                this._roleDetailInfo = _view.getAssetsObject("RoleDetailInfo", "RoleDetailInfo") as IRoleDetailInfo;
            }
            this.init();
            this.getRoleWarAttributecallBack();
            this.showUI();
            return;
        }// end function

        private function init() : void
        {
            this._roleDetailInfo.tip = this._view.tip.iTip;
            this._roleDetailInfo.drag = this._view.drag.iDrag;
            this._roleDetailInfo.onClose = this.close;
            this._roleDetailInfo.playerLevel = this._ctrl.player.level;
            this._roleDetailInfo.init();
            return;
        }// end function

        private function loadData() : void
        {
            if (this.playerRoleId == 0)
            {
                return;
            }
            _data.call(Mod_Role_Base.get_role_war_attribute, this.loadDataCallBack, [this.playerRoleId]);
            return;
        }// end function

        private function loadDataCallBack() : void
        {
            loadAssets("RoleDetailInfo", this.render, RoleDetailInfoViewLang.LoadInfo);
            return;
        }// end function

        private function get_role_war_attribute() : void
        {
            if (this.playerRoleId == 0)
            {
                return;
            }
            _data.call(Mod_Role_Base.get_role_war_attribute, this.getRoleWarAttributecallBack, [this.playerRoleId]);
            return;
        }// end function

        private function getRoleWarAttributecallBack() : void
        {
            var _loc_1:* = this._ctrl.rolemsg.roleWarAttributeData;
            _loc_1["role_name"] = this.playerName;
            this._roleDetailInfo.renderDetailInfo(_loc_1);
            return;
        }// end function

    }
}
