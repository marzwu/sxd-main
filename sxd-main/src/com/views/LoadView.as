package com.views
{
    import com.assist.*;
    import com.haloer.net.*;

    public class LoadView extends Base implements IView
    {

        public function LoadView()
        {
            return;
        }// end function

        public function show() : void
        {
            var file:* = new HTTP();
            file.onComplete = function (param1:String) : void
            {
                URI.formatVersion(param1);
                File.onVersion = URI.getVersion;
                _view.login.show();
                _view.hideLoadingText();
                return;
            }// end function
            ;
            file.load(URI.clientUrl + "assets.txt?rnd=" + URI.assetsRnd);
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

    }
}
