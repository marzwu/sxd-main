package com.views
{
    import com.assist.server.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import flash.utils.*;

    public class WeekRankingView extends Base implements IView
    {
        private var _showBtn:String;
        private var _weekRanking:IWeekRanking;

        public function WeekRankingView()
        {
            return;
        }// end function

        private function week_ranking_data_list() : void
        {
            _data.call(Mod_WeekRanking_Base.get_week_ranking, this.rankingListCallback, []);
            return;
        }// end function

        public function show_Btn() : void
        {
            _data.call(Mod_WeekRanking_Base.get_week_ranking, this.showBtnCallback, []);
            return;
        }// end function

        private function rankingListCallback() : void
        {
            var _loc_1:Object = null;
            if (this.inStage)
            {
                _loc_1 = _ctrl.weekRanking.getWeekRanking;
                this._weekRanking.getWeekRankingData(_loc_1);
            }
            else
            {
                loadAssets("WeekRanking", this.render, WeekRankingViewLang.loadAssets);
            }
            return;
        }// end function

        private function showBtnCallback() : void
        {
            var _loc_1:* = _ctrl.weekRanking.getWeekRanking;
            if (this._showBtn != "")
            {
                _view.activities.removeActivity(this._showBtn);
            }
            switch(_loc_1.rankingType)
            {
                case Mod_WeekRanking_Base.RANKING_TYPE_COIN:
                {
                    _view.activities.addActivity(ActivityType.CoinRank);
                    this._showBtn = ActivityType.CoinRank;
                    break;
                }
                case Mod_WeekRanking_Base.RANKING_TYPE_FAME:
                {
                    _view.activities.addActivity(ActivityType.FameRank);
                    this._showBtn = ActivityType.FameRank;
                    break;
                }
                case Mod_WeekRanking_Base.RANKING_TYPE_MISSION:
                {
                    _view.activities.addActivity(ActivityType.MissionRank);
                    this._showBtn = ActivityType.MissionRank;
                    break;
                }
                case Mod_WeekRanking_Base.RANKING_TYPE_STATE_POINT:
                {
                    _view.activities.addActivity(ActivityType.StatePointRank);
                    this._showBtn = ActivityType.StatePointRank;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function show() : void
        {
            this.week_ranking_data_list();
            return;
        }// end function

        public function render() : void
        {
            if (this._weekRanking == null)
            {
                this._weekRanking = _view.getAssetsObject("WeekRanking", "WeekRanking") as IWeekRanking;
                this._weekRanking.tip = _view.tip.iTip;
            }
            _popup.addView(this, this._weekRanking.content);
            this._weekRanking.onClose = function () : void
            {
                close();
                return;
            }// end function
            ;
            this._weekRanking.onShowPlayerInfo = function (param1:Object) : void
            {
                setTimeout(_view.toolbar.showPlayerInfo, 200, param1.playerId, param1.nickName);
                return;
            }// end function
            ;
            this._weekRanking.init();
            this.rankingListCallback();
            return;
        }// end function

        public function clear() : void
        {
            this._weekRanking.clear();
            return;
        }// end function

        public function close() : void
        {
            this.clear();
            _popup.closeView(this);
            return;
        }// end function

    }
}
