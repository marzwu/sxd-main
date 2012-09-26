package com.views
{
    import com.assist.view.interfaces.*;
    import flash.utils.*;

    public class WorldNoticeView extends Base
    {
        private var _worldNotice:IWorldNotice;
        private var _strMessage:String;
        private var _intSecond:int = 5;

        public function WorldNoticeView()
        {
            return;
        }// end function

        public function close() : void
        {
            this._view.stage.removeChild(this._worldNotice.content);
            return;
        }// end function

        public function showMessage(param1:String, param2:int = 5) : void
        {
            this._strMessage = param1;
            this._intSecond = param2;
            if (this._worldNotice == null)
            {
                loadAssets("WorldNotice", this.render, "", true, true);
            }
            else
            {
                this.render();
            }
            return;
        }// end function

        public function reposition(param1:Boolean = true) : void
        {
            if (param1 == true)
            {
                _view.toolbar.reposition();
            }
            else if (this._worldNotice != null && this._view.stage.contains(this._worldNotice.content))
            {
                this._worldNotice.content.x = Math.max(290, Math.floor((this._view.stage.stageWidth - 420) / 2) - Structure.stageClip.x);
                this._worldNotice.content.y = 150 + Structure.stageOffset.y;
            }
            return;
        }// end function

        public function preLoad() : void
        {
            if (this._worldNotice == null)
            {
                this._worldNotice = _view.getAssetsObject("WorldNotice", "WorldNotice") as IWorldNotice;
            }
            return;
        }// end function

        private function render() : void
        {
            if (this._worldNotice == null)
            {
                this._worldNotice = _view.getAssetsObject("WorldNotice", "WorldNotice") as IWorldNotice;
            }
            this.showWorldNotice(this._strMessage, this._intSecond);
            return;
        }// end function

        private function showWorldNotice(param1:String, param2:int) : void
        {
            var delay:Function;
            var strMessage:* = param1;
            var intSecond:* = param2;
            delay = function () : void
            {
                showWorldNotice(strMessage, intSecond);
                return;
            }// end function
            ;
            if (this._view.inWar)
            {
                setTimeout(delay, 5000);
                return;
            }
            if (!this._view.stage.contains(this._worldNotice.content))
            {
                this._worldNotice.content.x = Math.max(290, Math.floor((this._view.stage.stageWidth - 420) / 2));
                this._worldNotice.content.y = 150 + Structure.stageOffset.y;
            }
            this._view.stage.addChild(this._worldNotice.content);
            this._worldNotice.onClose = this.close;
            this._worldNotice.show(strMessage, intSecond);
            return;
        }// end function

    }
}
