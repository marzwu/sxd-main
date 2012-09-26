package com.views
{
    import com.*;
    import com.assist.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import flash.events.*;

    public class ActivationKeysView extends Base implements IView
    {
        private var _ak:IActivationKeys;

        public function ActivationKeysView()
        {
            return;
        }// end function

        public function show() : void
        {
            _data.call(Mod_Item_Base.get_empty_grid_number, this.loadResource, [1]);
            return;
        }// end function

        private function loadResource() : void
        {
            loadAssets("ActivationKeys", this.render, ActivationKeysViewLang.LoadInfo);
            return;
        }// end function

        private function render() : void
        {
            this._ak = _view.getAssetsObject("ActivationKeys", "ActivationKeys") as IActivationKeys;
            _popup.addView(this, this._ak.content);
            this._ak.tip = _view.tip.iTip;
            this._ak.drag = _view.drag.iDrag;
            this._ak.webDomain = URI.serverName;
            this._ak.nickName = _ctrl.player.nickname;
            this._ak.url = URI.activationKeysUrl;
            this._ak.onClose = function () : void
            {
                close();
                return;
            }// end function
            ;
            this._ak.onSuccess = function (param1:String) : void
            {
                success(param1);
                return;
            }// end function
            ;
            this._ak.onDebug = function (event:Event) : void
            {
                return;
            }// end function
            ;
            this._ak.init();
            _view.center(sign, this._ak.content);
            return;
        }// end function

        private function success(param1:String) : void
        {
            if (_ctrl.player.packNum < 1 && _ctrl.item.result < 1)
            {
                _view.alert.confirm(ActivationKeysViewLang.PackFull);
            }
            else
            {
                if (param1 == "")
                {
                    if (_ctrl.player.packNum >= 1)
                    {
                        param1 = ActivationKeysViewLang.CheckPack;
                    }
                    else
                    {
                        param1 = ActivationKeysViewLang.CheckWarehouse;
                    }
                    param1 = htmlFormat(Lang.sprintf(ActivationKeysViewLang.Succeed, htmlFormat(ActivationKeysViewLang.Gift, 12, 16631433), param1), 12, 16777215, true);
                }
                _view.alert.confirm(param1);
            }
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
            this._ak.clear();
            return;
        }// end function

    }
}
