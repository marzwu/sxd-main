package com.views
{
    import com.assist.view.controls.*;
    import com.assist.view.interfaces.*;
    import flash.display.*;

    public class DragView extends Base implements IView
    {
        private var _iDrag:IDrag;

        public function DragView() : void
        {
            this.iDrag.onMouseDown = function (param1:Sprite) : void
            {
                _popup.updateFocusView(param1);
                return;
            }// end function
            ;
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

        public function close() : void
        {
            return;
        }// end function

        public function get iDrag() : IDrag
        {
            if (!this._iDrag)
            {
                this._iDrag = Drag.getInstance();
            }
            return this._iDrag;
        }// end function

    }
}
