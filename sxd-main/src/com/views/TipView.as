package com.views
{
    import com.assist.view.controls.*;
    import com.assist.view.interfaces.*;

    public class TipView extends Base
    {
        private var _tip:ITip;

        public function TipView()
        {
            return;
        }// end function

        public function show() : void
        {
            this.iTip.addTarget(_view.toolbar.content, "演示");
            return;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

        public function close() : void
        {
            return;
        }// end function

        public function hide() : void
        {
            this.iTip.hide();
            return;
        }// end function

        public function get iTip() : ITip
        {
            if (!this._tip)
            {
                this._tip = Tip.getInstance();
                this._tip.oParent = _structure.tip;
            }
            return this._tip;
        }// end function

    }
}
