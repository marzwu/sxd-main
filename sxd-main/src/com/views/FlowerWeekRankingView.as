package com.views
{
    import com.assist.server.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import flash.utils.*;

    public class FlowerWeekRankingView extends Base implements IView
    {
        private var _flowerWeekRanking:IFlowerWeekRanking;
        public var cutOffTime:int = 1336924800;

        public function FlowerWeekRankingView()
        {
            return;
        }// end function

        public function show() : void
        {
            if (!FunctionType.isOpened(FunctionType.SendFlower))
            {
                return;
            }
            this.loadData();
            return;
        }// end function

        public function close() : void
        {
            this.clear();
            _popup.closeView(this);
            return;
        }// end function

        public function clear() : void
        {
            this._flowerWeekRanking.clear();
            this._view.removeFromTimerProcessList(sign);
            return;
        }// end function

        private function loadData() : void
        {
            this.get_send_flower_ranking_week(this.loadDataCallBack);
            return;
        }// end function

        private function loadDataCallBack() : void
        {
            loadAssets("FlowerWeekRanking", this.render, FlowerWeekRankingViewLang.LoadInfo);
            return;
        }// end function

        private function showUI() : void
        {
            _popup.addView(this, this._flowerWeekRanking.content);
            _view.center(sign, this._flowerWeekRanking.content);
            return;
        }// end function

        private function render() : void
        {
            if (this._flowerWeekRanking == null)
            {
                this._flowerWeekRanking = _view.getAssetsObject("FlowerWeekRanking", "FlowerWeekRanking") as IFlowerWeekRanking;
            }
            this.init();
            this._flowerWeekRanking.init();
            this.getSendFlowerRankingWeekBack();
            this.showUI();
            return;
        }// end function

        private function init() : void
        {
            this._flowerWeekRanking.tip = this._view.tip.iTip;
            this._flowerWeekRanking.drag = this._view.drag.iDrag;
            this._flowerWeekRanking.onClose = this.close;
            this._flowerWeekRanking.onTextLink = _view.toolbar.onTextLink;
            this._flowerWeekRanking.onIconClick = this.showPlayerInfo;
            return;
        }// end function

        private function showPlayerInfo(param1:int, param2:String) : void
        {
            setTimeout(_view.toolbar.showPlayerInfo, 50, param1, param2);
            return;
        }// end function

        private function get_send_flower_ranking_week(param1:Function) : void
        {
            return;
        }// end function

        private function getSendFlowerRankingWeekBack() : void
        {
            var _loc_1:* = this._ctrl.sendFlower.getSendFlowerRankingWeek();
            this._flowerWeekRanking.renderRankingList(_loc_1);
            return;
        }// end function

    }
}
