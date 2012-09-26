package com.views
{
    import com.assist.*;
    import com.assist.view.interfaces.*;
    import com.haloer.net.*;
    import flash.display.*;

    public class NineRegionsDramaView extends Base implements IView
    {
        private var _targetUi:IMcNineRegionsDrama;
        private var _content:Sprite;
        private var _jieId:int = 0;

        public function NineRegionsDramaView()
        {
            this._content = new Sprite();
            return;
        }// end function

        public function show() : void
        {
            return;
        }// end function

        public function close() : void
        {
            return;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

        public function loadDrama(param1:int) : void
        {
            var res:Array;
            var jie:* = param1;
            this._jieId = jie;
            res = new Array();
            var errorHandler:* = function (param1:int) : void
            {
                var _loc_2:* = param1 == (res.length - 1) ? ("Can not find MiniMap") : ("Can not find:" + res[param1].replace(/^[\s\S]+\/""^[\s\S]+\//, ""));
                _view.alert.confirm(_loc_2);
                return;
            }// end function
            ;
            var oneComplete:* = function (param1:int, param2:Boolean) : void
            {
                return;
            }// end function
            ;
            res.push(URI.nineRegionsDramaUrl + "nine_regions_drama" + jie + ".swf");
            File.loadList(res, this.loadOver, this.showProgress, oneComplete, errorHandler);
            return;
        }// end function

        private function showProgress(param1:int, param2:int, param3:int, param4:String) : void
        {
            _view.initLoading.loading(param2 + "", param3, param2, param1, param4);
            return;
        }// end function

        private function loadOver(param1:Array) : void
        {
            while (this._content.numChildren > 0)
            {
                
                this._content.removeChildAt(0);
            }
            var _loc_2:* = param1.pop();
            this._targetUi = _loc_2.getClassObject("NineRegionsDrama") as IMcNineRegionsDrama;
            this._content.addChild(this._targetUi.content);
            this._targetUi.onGotoTeam = this.onGotoDrama;
            if (!inStage)
            {
                _popup.addView(this, this._content);
                _view.center(sign, this._content);
            }
            return;
        }// end function

        private function onGotoDrama() : void
        {
            _popup.closeView(this);
            _view.nineRegionsTeamCreat.jieId = this._jieId;
            _view.nineRegionsTeamCreat.show();
            return;
        }// end function

    }
}
