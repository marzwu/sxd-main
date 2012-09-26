package com.views
{
    import com.assist.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;

    public class HaloButtleView extends Base implements IView
    {
        private var _haloButtle:IHaloButtle;
        private var _buttleRoleId:int;
        private var _isFirst:Boolean = false;

        public function HaloButtleView()
        {
            return;
        }// end function

        public function show() : void
        {
            loadAssets("HaloButtle", this.render, HaloButtleViewLang.LoadAssets);
            return;
        }// end function

        public function getButtleRoleId(param1:int) : void
        {
            if (this._buttleRoleId != 0)
            {
                _view.showTip(HaloButtleViewLang.IsPlay);
                return;
            }
            this._buttleRoleId = param1;
            this.show();
            return;
        }// end function

        private function render() : void
        {
            if (this._haloButtle == null)
            {
                this._haloButtle = _view.getAssetsObject("HaloButtle", "HaloButtle") as IHaloButtle;
            }
            _popup.addView(this, this._haloButtle.content);
            this._haloButtle.onClose = function (param1:int) : void
            {
                if (param1 == 1)
                {
                    _view.furnaceMap.warSeccess(_buttleRoleId);
                }
                close();
                return;
            }// end function
            ;
            this._haloButtle.getButtleRoleId = this._buttleRoleId;
            var assetsUrl:* = URI.assetsUrl;
            var version:* = URI.assetsRnd;
            this._haloButtle.getCid = URI.cid == 3 ? (3) : (0);
            this._haloButtle.clientUrl(assetsUrl);
            this._haloButtle.getVersion("?v=" + version);
            if (this._isFirst == false)
            {
                this._haloButtle.init();
                this._isFirst = true;
            }
            else
            {
                this._haloButtle.langInit();
            }
            return;
        }// end function

        public function close() : void
        {
            this._buttleRoleId = 0;
            this._haloButtle.clear();
            _popup.closeView(this);
            return;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

    }
}
