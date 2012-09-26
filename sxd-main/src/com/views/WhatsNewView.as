package com.views
{
    import com.assist.*;
    import com.assist.view.interfaces.*;
    import com.haloer.net.*;

    public class WhatsNewView extends Base implements IView
    {
        private var _whatsNew:IWhatsNew;
        private var _tempData:String;

        public function WhatsNewView()
        {
            return;
        }// end function

        public function show() : void
        {
            if (_view.login.first)
            {
                return;
            }
            this.loadData();
            return;
        }// end function

        private function loadData() : void
        {
            var http:HTTP;
            var url:String;
            var version:* = URI.gameVersion;
            if (_ctrl.player.lastPlayVersion < version)
            {
                http = new HTTP();
                url = URI.assetsUrl + "whats_new/" + version + ".txt";
                http.onComplete = function (param1:Object) : void
            {
                _tempData = param1 as String;
                loadResource();
                return;
            }// end function
            ;
                http.load(url + "?v=" + URI.getVersion(url));
            }
            return;
        }// end function

        private function loadResource() : void
        {
            loadAssets("WhatsNew", this.render, "", true, true);
            return;
        }// end function

        private function render() : void
        {
            this._whatsNew = _view.getAssetsObject("WhatsNew", "WhatsNew") as IWhatsNew;
            _popup.addView(this, this._whatsNew.content);
            _view.center(sign, this._whatsNew.content);
            this._whatsNew.tip = _view.tip.iTip;
            this._whatsNew.drag = _view.drag.iDrag;
            this._whatsNew.onClose = this.close;
            this._whatsNew.onDrama = this.playDrama;
            this._whatsNew.data = this._tempData;
            return;
        }// end function

        public function playDrama(param1:String) : void
        {
            _view.dramaPlayBack.onSelect(new XML("<drama uri=\"" + param1 + "\"/>"));
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
            removeResource("WhatsNew");
            return;
        }// end function

    }
}
