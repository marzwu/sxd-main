package com.views
{
    import com.assist.*;
    import com.assist.view.interfaces.*;
    import com.haloer.net.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import flash.display.*;
    import flash.net.*;
    import flash.text.*;

    public class PreventIndulgeView extends Base implements IView
    {
        private var _preventIndulge:IPreventIndulge;
        private var _mask:Sprite;
        private var _againstWallowsState:int;
        public var blackScreen:Boolean = false;

        public function PreventIndulgeView()
        {
            return;
        }// end function

        public function show() : void
        {
            if (URI.preventUrl)
            {
                _view.alert.confirm(PreventIndulgeViewLang.PreventIndulgeInfo, this.openPreventUrl);
            }
            else
            {
                loadAssets("PreventIndulge", this.render, PreventIndulgeViewLang.LoadInfo);
            }
            return;
        }// end function

        public function openPreventUrl(param1:uint) : void
        {
            navigateToURL(new URLRequest(URI.preventUrl), /wanwan\.sina\.com""wanwan\.sina\.com/.test(URI.serverName) ? ("_blank") : ("_self"));
            return;
        }// end function

        public function close() : void
        {
            this.closeUI();
            if (this.blackScreen == true)
            {
                _view.alert.confirm(PreventIndulgeViewLang.ThreeHours);
                this._mask.alpha = 1;
                this._data.close();
            }
            return;
        }// end function

        public function clear() : void
        {
            this._preventIndulge.clear();
            return;
        }// end function

        private function render() : void
        {
            if (this._preventIndulge == null)
            {
                this._preventIndulge = _view.getAssetsObject("PreventIndulge", "PreventIndulge") as IPreventIndulge;
            }
            if (inStage)
            {
                this.closeUI();
                if (this.blackScreen == false)
                {
                    return;
                }
            }
            this.addMask();
            _popup.addView(this, this._preventIndulge.content);
            this._preventIndulge.onOkBtn = this.validate_id_card;
            this._preventIndulge.onCloseBtn = this.close;
            this._preventIndulge.onCloseBtn = function () : void
            {
                close();
                return;
            }// end function
            ;
            var intType:int;
            if (!URI.nonKid && URI.idCard != "")
            {
                intType;
            }
            this._preventIndulge.render(intType);
            _view.center(sign, this._preventIndulge.content);
            return;
        }// end function

        private function addMask() : void
        {
            var _loc_2:TextField = null;
            if (this._mask == null)
            {
                this._mask = new Sprite();
                this._mask.graphics.beginFill(0);
                this._mask.graphics.drawRect(0, 0, this._view.stage.width, this._view.stage.height);
                this._mask.graphics.endFill();
                _loc_2 = new TextField();
                _loc_2.autoSize = TextFieldAutoSize.LEFT;
                _loc_2.htmlText = htmlFormat(PreventIndulgeViewLang.MustRest, 18, 16777215, true);
                _loc_2.x = (_view.toolbar.width - _loc_2.width) / 2;
                _loc_2.y = (_view.toolbar.height - _loc_2.height) / 2 - 25;
                this._mask.addChild(_loc_2);
            }
            this._mask.alpha = 0.3;
            var _loc_1:* = _ctrl.player.againstWallowsNotify == Mod_Player_Base.TIMEUP || _ctrl.player.againstWallowsInfo == Mod_Player_Base.AGAINST_WALLOWS;
            if (_loc_1)
            {
                _popup.addChild(this._mask);
            }
            return;
        }// end function

        private function removeMask() : void
        {
            if (_popup.contains(this._mask))
            {
                _popup.removeChild(this._mask);
            }
            return;
        }// end function

        public function closeUI() : void
        {
            this.clear();
            _view.alert.hide();
            _popup.closeView(this);
            return;
        }// end function

        private function validate_id_card() : void
        {
            this._data.call(Mod_Player_Base.validate_id_card, this.validateIdCardCallBack, [this._preventIndulge.identity]);
            return;
        }// end function

        private function validateIdCardCallBack() : void
        {
            var _loc_1:Cookie = null;
            if (_ctrl.player.validateIdCard == Mod_Player_Base.SUCCESS)
            {
                _view.activities.removePreventIndulge();
                this.removeMask();
                _view.openEvent();
                this.closeUI();
                _loc_1 = new Cookie("PreventIndulge");
                _loc_1.clear("MustExit");
            }
            else
            {
                this._preventIndulge.renderOkBtn(PreventIndulgeViewLang.VerifyFail);
            }
            return;
        }// end function

    }
}
