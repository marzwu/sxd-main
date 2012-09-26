package com.views
{
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;

    public class WarPageView extends Base implements IView
    {
        private var warPage:IWarPage;

        public function WarPageView()
        {
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

        public function warPageInfoComplete() : void
        {
            loadAssets("WarPage", null, WarPageViewLang.WarPageLoading, false, false, this.loadComplete);
            return;
        }// end function

        private function loadComplete() : void
        {
            if (!this.warPage)
            {
                this.warPage = _view.getAssetsObject("WarPage", "McWarPage") as IWarPage;
                this.warPage.onDekaron(this.onDekaron);
                this.warPage.onGetReward(this.onGetReward);
                this.warPage.onRecord(this.onRecord);
                _view.drag.iDrag.addTarget(this.warPage.dragTitleBar, this.warPage.content);
            }
            this.warPage.info = _ctrl.warPage.enemyList;
            return;
        }// end function

        private function onDekaron() : void
        {
            return;
        }// end function

        private function onGetReward() : void
        {
            return;
        }// end function

        private function onRecord() : void
        {
            return;
        }// end function

    }
}
