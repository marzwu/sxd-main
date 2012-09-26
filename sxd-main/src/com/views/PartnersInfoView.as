package com.views
{
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;

    public class PartnersInfoView extends Base implements IView
    {
        private var _partnersInfo:IPartnersInfo;
        private var _roleId:int = 0;
        private var _roleUrl:String = "";

        public function PartnersInfoView()
        {
            return;
        }// end function

        public function show() : void
        {
            return;
        }// end function

        public function showForRoleId(param1:int) : void
        {
            this._roleId = param1;
            var _loc_2:* = RoleType.getRoleSign(this._roleId);
            this._roleUrl = URI.warRolesUrl + _loc_2 + ".swf";
            if (this.inStage == false)
            {
                loadAssets("PartnersInfo", this.render, PartnersInfoViewLang.LoadAssets);
            }
            else
            {
                this._partnersInfo.getPartnersId(this._roleId, this._roleUrl);
            }
            return;
        }// end function

        public function render() : void
        {
            if (this._partnersInfo == null)
            {
                this._partnersInfo = _view.getAssetsObject("PartnersInfo", "PartnersInfo") as IPartnersInfo;
            }
            _popup.addView(this, this._partnersInfo.content);
            _view.center(sign, this._partnersInfo.content);
            this._partnersInfo.onClose = function () : void
            {
                close();
                return;
            }// end function
            ;
            this._partnersInfo.getPartnersId(this._roleId, this._roleUrl);
            return;
        }// end function

        public function clear() : void
        {
            this._partnersInfo.clear();
            return;
        }// end function

        public function close() : void
        {
            this._roleId = 0;
            this.clear();
            _popup.closeView(this);
            return;
        }// end function

    }
}
