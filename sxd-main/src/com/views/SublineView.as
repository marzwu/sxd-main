package com.views
{
    import com.assist.view.interfaces.*;

    public class SublineView extends Base implements IView
    {
        private var _subline:ISubline;

        public function SublineView()
        {
            return;
        }// end function

        public function show() : void
        {
            loadAssets("Subline", this.render, "加载分线");
            return;
        }// end function

        public function render() : void
        {
            this._subline = _view.getAssetsObject("Subline", "Subline") as ISubline;
            _popup.addView(this, this._subline.content);
            this.fillData();
            this._subline.onClose = function () : void
            {
                close();
                return;
            }// end function
            ;
            this._subline.onSendLine = function (param1:int) : void
            {
                return;
            }// end function
            ;
            _view.center(sign, this._subline.content);
            return;
        }// end function

        public function clear() : void
        {
            this._subline.clear();
            return;
        }// end function

        public function close() : void
        {
            this.clear();
            _popup.closeView(this);
            return;
        }// end function

        private function fillData() : void
        {
            var _loc_1:Object = {name:"服务器1", id:1, state:1};
            var _loc_2:Object = {name:"服务器2", id:2, state:2};
            var _loc_3:Object = {name:"服务器3", id:3, state:1};
            var _loc_4:Object = {name:"服务器4", id:4, state:2};
            var _loc_5:Object = {name:"服务器5", id:5, state:1};
            var _loc_6:Object = {name:"服务器6", id:6, state:2};
            var _loc_7:Object = {name:"服务器7", id:7, state:1};
            var _loc_8:Object = {name:"服务器8", id:8, state:2};
            var _loc_9:Array = [_loc_1];
            this._subline.receive(_loc_9, 1);
            return;
        }// end function

    }
}
