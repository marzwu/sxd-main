package com.datas
{

    public class SuperSportData extends Base
    {
        private var _openSuperSport:Array;
        private var _challengeList:Array;
        private var _startChallenge:Array;
        private var _clearCdTime:Array;
        private var _buyChallengeTimes:Array;
        private var _newSportWarReport:Array;
        private var _notify:Array;
        private var _closeSuperSport:Array;
        private var _playerWarReport:Array;
        private var _rankingTop:Array;
        private var _updateWinTop:Array;
        private var _notifyGlobal:Array;
        private var _getCdTime:Array;
        private var _getChallengeTimes:Array;

        public function SuperSportData()
        {
            return;
        }// end function

        public function get openSuperSport() : Array
        {
            return this._openSuperSport;
        }// end function

        public function get challengeList() : Array
        {
            return this._challengeList;
        }// end function

        public function get startChallenge() : Array
        {
            return this._startChallenge;
        }// end function

        public function get clearCdTime() : Array
        {
            return this._clearCdTime;
        }// end function

        public function get buyChallengeTimes() : Array
        {
            return this._buyChallengeTimes;
        }// end function

        public function get newSportWarReport() : Array
        {
            return this._newSportWarReport;
        }// end function

        public function get getNotify() : Array
        {
            return this._notify;
        }// end function

        public function get closeSuperSport() : Array
        {
            return this._closeSuperSport;
        }// end function

        public function get playerWarReport() : Array
        {
            return this._playerWarReport;
        }// end function

        public function get rankingTop() : Array
        {
            return this._rankingTop;
        }// end function

        public function get updateWinTop() : Array
        {
            return this._updateWinTop;
        }// end function

        public function get notifyGlobal() : Array
        {
            return this._notifyGlobal;
        }// end function

        public function get getCdTime() : Array
        {
            return this._getCdTime;
        }// end function

        public function get getChallengeTimes() : Array
        {
            return this._getChallengeTimes;
        }// end function

        public function open_super_sport(param1:Array) : void
        {
            this._openSuperSport = param1;
            return;
        }// end function

        public function get_challenge_list(param1:Array) : void
        {
            this._challengeList = param1;
            return;
        }// end function

        public function start_challenge(param1:Array) : void
        {
            this._startChallenge = param1;
            return;
        }// end function

        public function clear_cd_time(param1:Array) : void
        {
            this._clearCdTime = param1;
            return;
        }// end function

        public function buy_challenge_times(param1:Array) : void
        {
            this._buyChallengeTimes = param1;
            return;
        }// end function

        public function notify_new_sport_war_report(param1:Array) : void
        {
            this._newSportWarReport = param1;
            return;
        }// end function

        public function notify(param1:Array) : void
        {
            this._notify = param1;
            return;
        }// end function

        public function close_super_sport(param1:Array) : void
        {
            this._closeSuperSport = param1;
            return;
        }// end function

        public function get_player_war_report(param1:Array) : void
        {
            this._playerWarReport = param1;
            return;
        }// end function

        public function get_ranking_top(param1:Array) : void
        {
            this._rankingTop = param1[0];
            return;
        }// end function

        public function notify_update_win_top(param1:Array) : void
        {
            this._updateWinTop = param1;
            return;
        }// end function

        public function notify_global(param1:Array) : void
        {
            this._notifyGlobal = param1;
            return;
        }// end function

        public function get_cd_time(param1:Array) : void
        {
            this._getCdTime = param1;
            return;
        }// end function

        public function get_challenge_times(param1:Array) : void
        {
            this._getChallengeTimes = param1;
            return;
        }// end function

    }
}
