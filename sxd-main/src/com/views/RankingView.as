﻿package com.views
{
    import com.assist.*;
    import com.assist.view.interfaces.*;

    public class RankingView extends Base implements IView
    {
        private var _ranking:IRanking;
        private var _aryRankingData:Array;

        public function RankingView()
        {
            this._aryRankingData = [];
            return;
        }// end function

        public function show() : void
        {
            loadAssets("Ranking", this.render, "加载排行榜信息");
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
            this._ranking.clear();
            return;
        }// end function

        private function render() : void
        {
            this._ranking = _view.getAssetsObject("Ranking", "Ranking") as IRanking;
            _popup.addView(this, this._ranking.content);
            this._ranking.onClose = function () : void
            {
                close();
                return;
            }// end function
            ;
            this._ranking.playerID = "015";
            this._ranking.onSecondRankingData = this.getSecondRanking;
            this._ranking.onRankingFieldData = this.getRankingField;
            this._ranking.onRankingData = this.getRanking;
            this._ranking.onMyRankingBtn = this.getMyRanking;
            this._ranking.render();
            _view.center(sign, this._ranking.content);
            return;
        }// end function

        private function getMyRanking() : Array
        {
            var _loc_5:Object = null;
            var _loc_6:Object = null;
            var _loc_1:* = this.dsRanking();
            var _loc_2:Array = [];
            var _loc_3:Array = [];
            var _loc_4:int = 0;
            while (_loc_4 < _loc_1.length)
            {
                
                _loc_6 = _loc_1[_loc_4];
                if (_loc_6.ID != this._ranking.playerID || _loc_6.Type != this._ranking.secondRankingID)
                {
                }
                else
                {
                    this._ranking.pageCurrent = Math.ceil(_loc_4 / 10);
                }
                _loc_4++;
            }
            for each (_loc_5 in _loc_1)
            {
                
                if (_loc_5.Type != this._ranking.secondRankingID)
                {
                    continue;
                }
                _loc_2.push(_loc_5);
            }
            this._aryRankingData = _loc_2;
            this._ranking.pageCount = this.getPageCount(_loc_2);
            _loc_3 = _loc_2.slice((this._ranking.pageCurrent - 1) * 10, (this._ranking.pageCurrent - 1) * 10 + 10);
            Helper.output("this._ranking.SecondRankingID = " + this._ranking.secondRankingID);
            Helper.output("排行榜数据.length = " + _loc_3.length);
            return _loc_3;
        }// end function

        private function getPageCount(param1:Array) : int
        {
            Helper.output("PageCount = " + Math.ceil(param1.length / 10));
            return Math.ceil(param1.length / 10);
        }// end function

        private function getSecondRanking() : Array
        {
            var _loc_3:Object = null;
            var _loc_1:* = this.dsSecondRanking();
            var _loc_2:Array = [];
            for each (_loc_3 in _loc_1)
            {
                
                if (_loc_3.Type != this._ranking.firstRankingType)
                {
                    continue;
                }
                _loc_2.push(_loc_3);
            }
            return _loc_2;
        }// end function

        private function dsSecondRanking() : Array
        {
            var _loc_1:Array = [];
            _loc_1 = [{ID:"001", Type:"001", Name:"财富排行"}, {ID:"002", Type:"001", Name:"充值排行"}, {ID:"003", Type:"001", Name:"阅历排行"}, {ID:"004", Type:"002", Name:"成就排行"}, {ID:"005", Type:"002", Name:"威望排行"}, {ID:"006", Type:"003", Name:"等级排行"}, {ID:"007", Type:"004", Name:"帮派排行"}];
            return _loc_1;
        }// end function

        private function getRankingField() : Array
        {
            var _loc_3:Object = null;
            var _loc_1:* = this.dsRankingField();
            var _loc_2:Array = [];
            for each (_loc_3 in _loc_1)
            {
                
                if (_loc_3.Type != this._ranking.secondRankingID)
                {
                    continue;
                }
                _loc_2.push(_loc_3);
            }
            return _loc_2;
        }// end function

        private function dsRankingField() : Array
        {
            var _loc_1:Array = [];
            _loc_1 = [{ID:"001", Type:"001", Fields0:"排名", Fields1:"玩家", Fields2:"等级", Fields3:"帮派", Fields4:"银两"}, {ID:"002", Type:"002", Fields0:"排名", Fields1:"玩家", Fields2:"等级", Fields3:"帮派", Fields4:"元宝"}, {ID:"003", Type:"003", Fields0:"排名", Fields1:"玩家", Fields2:"等级", Fields3:"帮派", Fields4:"阅历"}, {ID:"004", Type:"004", Fields0:"排名", Fields1:"玩家", Fields2:"等级", Fields3:"帮派", Fields4:"成就"}, {ID:"005", Type:"005", Fields0:"排名", Fields1:"玩家", Fields2:"等级", Fields3:"帮派", Fields4:"威望"}, {ID:"006", Type:"006", Fields0:"排名", Fields1:"玩家", Fields2:"等级", Fields3:"帮派"}, {ID:"007", Type:"007", Fields0:"排名", Fields1:"帮派", Fields2:"等级", Fields3:"人数"}];
            return _loc_1;
        }// end function

        private function getRanking() : Array
        {
            var _loc_4:Object = null;
            var _loc_1:* = this.dsRanking();
            var _loc_2:Array = [];
            var _loc_3:Array = [];
            for each (_loc_4 in _loc_1)
            {
                
                if (_loc_4.Type != this._ranking.secondRankingID)
                {
                    continue;
                }
                _loc_2.push(_loc_4);
            }
            this._aryRankingData = _loc_2;
            this._ranking.pageCount = this.getPageCount(_loc_2);
            _loc_3 = _loc_2.slice((this._ranking.pageCurrent - 1) * 10, (this._ranking.pageCurrent - 1) * 10 + 10);
            return _loc_3;
        }// end function

        public function dsRanking() : Array
        {
            var _loc_1:Array = [];
            _loc_1 = [{ID:"001", Type:"001", Field0:"001", Field1:"郭靖", Field2:"99", Field3:"丐帮", Field4:"99999"}, {ID:"002", Type:"001", Field0:"002", Field1:"郭破虏", Field2:"98", Field3:"丐帮", Field4:"99999"}, {ID:"003", Type:"001", Field0:"003", Field1:"郭芙", Field2:"97", Field3:"丐帮", Field4:"99999"}, {ID:"004", Type:"001", Field0:"004", Field1:"郭襄", Field2:"96", Field3:"丐帮", Field4:"99999"}, {ID:"005", Type:"001", Field0:"005", Field1:"黄蓉", Field2:"95", Field3:"丐帮", Field4:"99999"}, {ID:"006", Type:"001", Field0:"006", Field1:"黄药师", Field2:"94", Field3:"桃花岛", Field4:"99999"}, {ID:"007", Type:"001", Field0:"007", Field1:"洪七公", Field2:"93", Field3:"丐帮", Field4:"99999"}, {ID:"008", Type:"001", Field0:"008", Field1:"欧阳锋", Field2:"92", Field3:"白驼山", Field4:"99999"}, {ID:"009", Type:"001", Field0:"009", Field1:"欧阳克", Field2:"91", Field3:"白驼山", Field4:"99999"}, {ID:"010", Type:"001", Field0:"010", Field1:"段智兴", Field2:"90", Field3:"皇家大理", Field4:"99999"}, {ID:"011", Type:"001", Field0:"011", Field1:"段誉", Field2:"89", Field3:"皇家大理", Field4:"99999"}, {ID:"012", Type:"001", Field0:"012", Field1:"段正明", Field2:"99", Field3:"皇家大理", Field4:"99999"}, {ID:"013", Type:"001", Field0:"013", Field1:"段正淳", Field2:"99", Field3:"皇家大理", Field4:"99999"}, {ID:"014", Type:"001", Field0:"014", Field1:"段延庆", Field2:"99", Field3:"皇家大理", Field4:"99999"}, {ID:"015", Type:"001", Field0:"015", Field1:"周伯通", Field2:"99", Field3:"全真教", Field4:"99999"}, {ID:"016", Type:"001", Field0:"016", Field1:"王重阳", Field2:"99", Field3:"全真教", Field4:"99999"}, {ID:"017", Type:"001", Field0:"017", Field1:"杨康", Field2:"99", Field3:"皇家大金", Field4:"99999"}, {ID:"018", Type:"001", Field0:"018", Field1:"杨过", Field2:"99", Field3:"", Field4:"99999"}, {ID:"019", Type:"001", Field0:"019", Field1:"杨铁心", Field2:"99", Field3:"", Field4:"99999"}, {ID:"020", Type:"001", Field0:"020", Field1:"杨再兴", Field2:"99", Field3:"皇家大宋", Field4:"99999"}, {ID:"021", Type:"001", Field0:"021", Field1:"穆念慈", Field2:"99", Field3:"", Field4:"99999"}, {ID:"022", Type:"001", Field0:"022", Field1:"柯镇恶", Field2:"99", Field3:"江南七怪", Field4:"99999"}, {ID:"023", Type:"001", Field0:"023", Field1:"朱聪", Field2:"99", Field3:"江南七怪", Field4:"99999"}, {ID:"024", Type:"001", Field0:"024", Field1:"韩宝驹", Field2:"99", Field3:"江南七怪", Field4:"99999"}, {ID:"025", Type:"001", Field0:"025", Field1:"南希仁", Field2:"99", Field3:"江南七怪", Field4:"99999"}, {ID:"026", Type:"001", Field0:"026", Field1:"张阿生", Field2:"99", Field3:"江南七怪", Field4:"99999"}, {ID:"027", Type:"001", Field0:"027", Field1:"全金发", Field2:"99", Field3:"江南七怪", Field4:"99999"}, {ID:"028", Type:"001", Field0:"028", Field1:"韩小莹", Field2:"99", Field3:"江南七怪", Field4:"99999"}, {ID:"029", Type:"001", Field0:"029", Field1:"郭盛", Field2:"99", Field3:"梁山", Field4:"99999"}, {ID:"030", Type:"001", Field0:"030", Field1:"郭啸天", Field2:"99", Field3:"", Field4:"99999"}, {ID:"031", Type:"002", Field0:"030", Field1:"郭啸天", Field4:"99999"}, {ID:"032", Type:"003", Field0:"030", Field1:"郭啸天", Field2:"99", Field3:""}, {ID:"033", Type:"004", Field0:"030", Field2:"99", Field3:"", Field4:"99999"}, {ID:"034", Type:"005", Field0:"030", Field1:"楚留香", Field2:"99", Field3:"梁山"}, {ID:"035", Type:"006", Field0:"030", Field1:"姬冰雁", Field2:"99", Field3:"梁山"}, {ID:"036", Type:"006", Field0:"030", Field1:"胡铁花", Field2:"99", Field3:"梁山"}, {ID:"037", Type:"006", Field0:"030", Field1:"陈若男", Field2:"99", Field3:"梁山"}, {ID:"038", Type:"006", Field0:"030", Field1:"陆小凤", Field2:"99", Field3:"梁山"}, {ID:"039", Type:"006", Field0:"030", Field1:"江小鱼", Field2:"99", Field3:"梁山"}];
            return _loc_1;
        }// end function

    }
}
