package com.views
{
    import com.assist.view.interfaces.*;

    public class ProgressBarView extends Base implements IView
    {
        private var _progressBar:IProgressBar;

        public function ProgressBarView()
        {
            return;
        }// end function

        public function show() : void
        {
            this.showProgressBar();
            return;
        }// end function

        public function showProgressBar(param1:String = "", param2:int = 6, param3:Function = null) : void
        {
            var loadCallBack:Function;
            var title:* = param1;
            var second:* = param2;
            var callBack:* = param3;
            loadCallBack = function () : void
            {
                if (_progressBar == null)
                {
                    _progressBar = _view.getAssetsObject("ProgressBar", "ProgressBar") as IProgressBar;
                }
                render(title, second, callBack);
                return;
            }// end function
            ;
            loadAssets("ProgressBar", loadCallBack, "", true, true);
            return;
        }// end function

        public function clear() : void
        {
            this._progressBar.clear();
            return;
        }// end function

        public function close() : void
        {
            this.clear();
            _popup.closeView(this);
            return;
        }// end function

        private function render(param1:String, param2:int, param3:Function) : void
        {
            _popup.addView(this, this._progressBar.content);
            _view.center(sign, this._progressBar.content);
            this._progressBar.onClose = this.close;
            this._progressBar.show(param1, param2, param3);
            return;
        }// end function

    }
}
