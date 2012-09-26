package com.views
{
    import com.assist.*;
    import com.assist.data.mission.*;
    import com.assist.view.*;
    import com.assist.view.interfaces.*;
    import com.assist.view.war.*;
    import com.lang.client.com.views.*;

    public class GetPeachWarView extends SportWarView
    {
        public var warData:WarData;

        public function GetPeachWarView() : void
        {
            _type = WarType.GetPeachWar;
            isBoss = true;
            return;
        }// end function

        public function set requested(param1:Boolean) : void
        {
            _requested = param1;
            return;
        }// end function

        override protected function start() : void
        {
            onProgress = function (param1:int, param2:int, param3:int, param4:String) : void
            {
                _view.showLoading(GetPeachWarViewLang.LoadInfo, param3, (param2 + 1), param1);
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

        override protected function addonWarIcon(param1:Array, param2:Array) : void
        {
            param1.push("WarIcon");
            param2.push(URI.mapUrl + "get_peach/get_peach.png");
            param1.push("Background");
            param2.push(URI.mapUrl + "get_peach/get_peach.swf");
            return;
        }// end function

        override protected function createTarget() : void
        {
            _view.hideLoading();
            _war = _view.getAssetsObject("War", "War") as IWar;
            _war.warData = _warData;
            _war.background = background;
            if (_ctrl.getPeach.warExp > 0)
            {
                _war.sportAwardText = GetPeachWarViewLang.Exp + HtmlText.green("+" + _ctrl.getPeach.warExp);
            }
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
