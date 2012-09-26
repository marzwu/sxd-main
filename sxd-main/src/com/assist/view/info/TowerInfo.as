package com.assist.view.info
{
    import com.*;
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.interfaces.map.*;
    import com.assist.view.pack.*;
    import com.lang.client.com.assist.view.info.*;

    public class TowerInfo extends Object
    {
        public var daoName:Array;
        public var daoLv:Array;
        public var roleDisplay:IFrameSprite;
        public var sign:String = "";
        public var layer:int = 1;
        public var sequenceWar:int = 0;
        public var sequenceMax_:int = 0;
        public var bagNum:int = 0;
        public var awardAutoTip1:String = "";
        public var awardAutoTip2:String = "";
        public var resetNum:int = 0;
        public var resetIngot:int = 0;
        public var panelIdx:int = 1;
        public var inAuto:Boolean = false;
        public var hideId:int = 0;
        public var warIdx:int = 0;
        public var autoSellL:Boolean = false;
        public var autoSellZ:Boolean = false;
        public var layderTip:String = "";
        public var isShowTip:Boolean = true;
        public var isHideWar:Boolean;

        public function TowerInfo()
        {
            this.daoLv = [0, 50, 61, 81, 101, 111, 121];
            this.daoName = ["", TowerInfoLang.Layder1, TowerInfoLang.Layder2, TowerInfoLang.Layder3, TowerInfoLang.Layder4, TowerInfoLang.Layder5, TowerInfoLang.Layder6, ""];
            return;
        }// end function

        public function get resetTip() : String
        {
            if (this.resetNum == 0)
            {
                return TowerInfoLang.NotResetCount;
            }
            if (this.sequenceWar == 1)
            {
                return TowerInfoLang.InFirst;
            }
            if (this.resetIngot == 0)
            {
                return Lang.sprintf(TowerInfoLang.ResetTip1, this.daoName[this.layer], this.resetNum);
            }
            return Lang.sprintf(TowerInfoLang.ResetTip2, HtmlText.yellow(this.resetIngot + TowerInfoLang.Ingot), this.daoName[this.layer], this.resetNum);
        }// end function

        public function getLayderTip(param1:int) : String
        {
            var _loc_2:String = "";
            if (param1 == this.layer)
            {
                _loc_2 = Lang.sprintf(TowerInfoLang.Sequence1, this.daoName[param1], this.sequenceWar) + "\n" + htmlFormat(TowerInfoLang.NowLocation, 14, 44783);
            }
            else if (param1 > this.layer)
            {
                _loc_2 = this.daoName[param1] + "\n" + htmlFormat(Lang.sprintf(TowerInfoLang.OpenLayderCondition, this.daoName[(param1 - 1)]), 14, 16711680);
            }
            else
            {
                return Lang.sprintf(TowerInfoLang.OpenUp, this.daoName[param1]);
            }
            return "<b><font size=\'14\'>" + _loc_2 + "</font></b>";
        }// end function

        public function get hideTowerName() : String
        {
            return this.daoName[this.hideId] + TowerInfoLang.HideLadyer;
        }// end function

        public function get sequenceString() : String
        {
            if (this.sequenceWar <= 25)
            {
                return Lang.sprintf(TowerInfoLang.Sequence2, this.sequenceWar);
            }
            return Lang.sprintf(TowerInfoLang.Sequence2, 25);
        }// end function

        public function get layderName() : String
        {
            return this.daoName[this.layer];
        }// end function

        public function get dir() : int
        {
            if ((this.sequenceWar & 1) == 1)
            {
                return -1;
            }
            return 1;
        }// end function

        public function get action() : String
        {
            if (this.sequenceWar == 26)
            {
                return "stand";
            }
            return "war";
        }// end function

        public function get awardNames() : Array
        {
            var _loc_6:String = null;
            var _loc_1:* = this.sequenceWar;
            if (_loc_1 > 25)
            {
                _loc_1 = 25;
                ;
            }
            var _loc_2:* = TowerType.getMonsterId(this.layer, _loc_1);
            var _loc_3:* = TowerType.getSoulIdList(this.layer, _loc_1);
            var _loc_4:Array = [];
            var _loc_5:Object = {};
            for each (_loc_2 in _loc_3)
            {
                
                _loc_6 = SoulType.getSoulName(_loc_2);
                if (_loc_5[_loc_6] == null)
                {
                    _loc_5[_loc_6] = _loc_6;
                    _loc_4.push(htmlFormat(_loc_6, 12, SoulType.getSoulQualityColor(_loc_2), false, true));
                }
            }
            _loc_4.push(HtmlText.green(TowerInfoLang.Exp + TowerType.getAwardExp(this.layer, _loc_1)));
            if (this.sequenceMax_ == (this.sequenceWar - 1))
            {
                _loc_4.push(HtmlText.green(TowerInfoLang.Eternal + 500));
            }
            return _loc_4;
        }// end function

        public function get awardTips() : Array
        {
            var _loc_6:String = null;
            var _loc_7:SoulTipSprite = null;
            if (this.isShowTip == false)
            {
                return [];
            }
            var _loc_1:* = this.sequenceWar;
            if (_loc_1 > 25)
            {
                _loc_1 = 25;
                ;
            }
            var _loc_2:* = TowerType.getMonsterId(this.layer, _loc_1);
            var _loc_3:* = TowerType.getSoulIdList(this.layer, _loc_1);
            var _loc_4:Array = [];
            var _loc_5:uint = 0;
            for each (_loc_2 in _loc_3)
            {
                
                _loc_6 = SoulType.getSoulName(_loc_2);
                if (_loc_4[_loc_6] == null)
                {
                    _loc_5 = SoulType.getSoulQualityColor(_loc_2);
                    _loc_7 = new SoulTipSprite();
                    _loc_7.iconUrl = URI.getSoulsIconUrl(_loc_2);
                    _loc_7.nameHtml = htmlFormat(SoulType.getSoulName(_loc_2), 16, _loc_5, true);
                    _loc_7.desHtml = htmlFormat(SoulType.getSoulContent(_loc_2), 12, 15658734);
                    _loc_4[_loc_6] = _loc_7;
                }
            }
            return _loc_4;
        }// end function

        public function get monsterName() : String
        {
            var _loc_1:* = this.sequenceWar;
            if (_loc_1 > 25)
            {
                _loc_1 = 25;
                ;
            }
            var _loc_2:* = TowerType.getMonsterId(this.layer, _loc_1);
            return MonsterType.getMonsterNameById(_loc_2);
        }// end function

    }
}
