package com.views
{
    import com.assist.view.controls.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import flash.net.*;

    public class Tip2View extends Base implements IView
    {
        private var _tip:ITip2;
        private var _list:Array;
        private var _hackToolsTip:ITip2;
        private var _hackToolsTipList:Array;
        private var _alert:IAlert2;
        private var _title:String;
        private var _type:int;

        public function Tip2View()
        {
            this._list = [];
            this._hackToolsTipList = [];
            return;
        }// end function

        public function show() : void
        {
            return;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

        private function loadTip(param1:Function) : void
        {
            loadAssets("Tip2", param1, Tip2ViewLang.LoadInfo, true, true);
            return;
        }// end function

        public function close() : void
        {
            if (this.iTip)
            {
                this.iTip.hide();
            }
            return;
        }// end function

        public function test() : void
        {
            this.iTip.show("警告", "内容", TipType.Alert);
            this.iTip.show("失败", "内容", TipType.Failure);
            this.iTip.show("处理中...", "内容", TipType.Process);
            this.iTip.show("问题", "内容", TipType.Question);
            this.iTip.show("成功", "内容", TipType.Success);
            return;
        }// end function

        public function showTip(param1:String, param2:String, param3:int) : void
        {
            this._list.push({title:param1, content:param2, type:param3});
            this.loadTip(this.renderTip);
            return;
        }// end function

        private function renderTip() : void
        {
            if (this._list.length > 0)
            {
                this.iTip.show(this._list[0]["title"], this._list[0]["content"] || Tip2ViewLang.TipContent, this._list[0]["type"]);
                this._list = [];
            }
            return;
        }// end function

        public function hideTip() : void
        {
            if (this._tip)
            {
                this._tip.hide();
            }
            return;
        }// end function

        public function reposition() : void
        {
            if (this._tip)
            {
                this._tip.reposition(Structure.stageWidth, Structure.stageHeight);
            }
            if (this._alert)
            {
                this._alert.com.assist.view.interfaces:IAlert2::reposition(Structure.stageWidth, Structure.stageHeight);
            }
            if (this._hackToolsTip)
            {
                this._hackToolsTip.reposition(Structure.stageWidth, Structure.stageHeight);
            }
            return;
        }// end function

        public function showHackToolsTip(param1:String, param2:String = null) : void
        {
            this._hackToolsTipList.push({title:param1, content:param2});
            this.loadTip(this.renderHackToolsTip);
            return;
        }// end function

        private function renderHackToolsTip() : void
        {
            if (this._hackToolsTipList.length > 0)
            {
                this.hackToolsTip.show(this._hackToolsTipList[0]["title"], null, 0);
                this._hackToolsTipList = [];
            }
            return;
        }// end function

        public function showAlert(param1:String, param2:int = 5) : void
        {
            this._title = param1;
            this._type = param2;
            this.loadTip(this.renderAlert);
            return;
        }// end function

        private function renderAlert() : void
        {
            this.iAlert.com.assist.view.interfaces:IAlert2::show(this._title);
            return;
        }// end function

        private function get iTip() : ITip2
        {
            if (!this._tip)
            {
                this._tip = _view.getAssetsObject("Tip2", "Tip2") as ITip2;
                this._tip.oParent = _structure.tip;
                this._tip.delay = 2000;
                this.reposition();
            }
            return this._tip;
        }// end function

        private function get iAlert() : IAlert2
        {
            if (!this._alert)
            {
                this._alert = _view.getAssetsObject("Tip2", "Alert2") as IAlert2;
                this._alert.com.assist.view.interfaces:IAlert2::oParent = _structure.alert;
                this.reposition();
            }
            this._alert.onClose = function () : void
            {
                navigateToURL(new URLRequest("index.php"), "_self");
                return;
            }// end function
            ;
            return this._alert;
        }// end function

        private function get hackToolsTip() : ITip2
        {
            if (!this._hackToolsTip)
            {
                this._hackToolsTip = _view.getAssetsObject("Tip2", "HackToolsTip") as ITip2;
                this._hackToolsTip.oParent = _structure.tip;
                this._hackToolsTip.delay = 2000;
                this.reposition();
            }
            return this._hackToolsTip;
        }// end function

    }
}
