package com.assist.view.info
{
    import com.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.lang.client.com.assist.view.info.*;
    import flash.events.*;

    public class PetLongInfo extends EventDispatcher
    {
        public var lv:int = 0;
        public var star:int = 0;
        public var exp:int = 0;
        public var expMax:int = 0;
        public var expAdd:int = 0;
        public var hit:int = 0;
        private var _feedNum:int = 0;
        public var feedType:int = 0;
        public var isUpStar:Boolean = false;
        public var isUpLv:Boolean = false;
        public var vipLv:int = 0;
        public var playerLv:int = 0;
        public static const FEEDNUMCHANGE:String = "";

        public function PetLongInfo()
        {
            return;
        }// end function

        public function get feedNum() : int
        {
            return this._feedNum;
        }// end function

        public function set feedNum(param1:int) : void
        {
            this._feedNum = param1;
            dispatchEvent(new Event(FEEDNUMCHANGE));
            return;
        }// end function

        public function reset(param1:int = 0, param2:int = 0, param3:int = 0, param4:int = 0) : void
        {
            this.lv = param1;
            this.star = param2;
            this.isUpStar = false;
            this.isUpLv = false;
            this.exp = param3;
            this.expAdd = 0;
            this.expMax = PetType.getExp(param1, param2);
            this.feedNum = param4;
            return;
        }// end function

        public function feed(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int) : void
        {
            this.isUpStar = this.star != param2;
            this.isUpLv = false;
            this.lv = param1;
            this.star = param2;
            this.feedType = param5;
            this.hit = param7;
            this.exp = param3;
            this.expAdd = param4;
            this.expMax = PetType.getExp(param1, param2);
            this.feedNum = param6;
            return;
        }// end function

        public function upLv(param1:int, param2:int, param3:int) : void
        {
            this.lv = param1;
            this.star = param2;
            this.isUpStar = false;
            this.isUpLv = true;
            this.exp = param3;
            this.expAdd = 0;
            this.expMax = PetType.getExp(param1, param2);
            return;
        }// end function

        public function get canIngot() : Boolean
        {
            return this.vipLv >= 4;
        }// end function

        public function get isFull() : Boolean
        {
            return PetType.isMaxLv(this.lv, this.star);
        }// end function

        public function get canUpLv() : Boolean
        {
            return this.star == 10 && this.exp >= this.expMax && PetType.isMaxLv(this.lv, this.star) == false;
        }// end function

        public function get isFeed() : Boolean
        {
            return this.expAdd > 0;
        }// end function

        public function get miniHit() : Boolean
        {
            return this.hit == 1;
        }// end function

        public function get maxHit() : Boolean
        {
            return this.hit == 2;
        }// end function

        public function get coinTip() : String
        {
            return Lang.sprintf(PetLongInfoLang.CoinEatTip, HtmlText.yellow2(PetType.getCoin(10 * int(this.playerLv / 10)) + PetLongInfoLang.Coin));
        }// end function

        public function get ingotTip() : String
        {
            return Lang.sprintf(PetLongInfoLang.IngotEatTip, HtmlText.yellow2(PetType.getIngot(10 * int(this.playerLv / 10)) + PetLongInfoLang.Ingot));
        }// end function

        public function get expAddTip() : String
        {
            if (this.expAdd == 0)
            {
                return "";
            }
            if (this.hit == 1)
            {
                return HtmlText.format(Lang.sprintf(PetLongInfoLang.BaoJiMin, this.expAdd), 16773632, 14, null, true);
            }
            if (this.hit == 2)
            {
                return HtmlText.format(Lang.sprintf(PetLongInfoLang.BaoJiMax, this.expAdd), 16773632, 14, null, true);
            }
            return HtmlText.format(PetLongInfoLang.Exp + " +" + this.expAdd, 65280, 14, null, true);
        }// end function

        public function get helpTip() : String
        {
            if (this.canIngot)
            {
                return [PetLongInfoLang.HelpTip1, PetLongInfoLang.HelpTip2, PetLongInfoLang.HelpTip3].join("\n");
            }
            return [PetLongInfoLang.HelpTip1, PetLongInfoLang.HelpTip3].join("\n");
        }// end function

        public function get expString() : String
        {
            return PetLongInfoLang.Exp + " " + this.exp + "/" + this.expMax;
        }// end function

        public function get addAttString() : String
        {
            return PetLongInfoLang.AddAtt + " +" + PetType.getAttack(this.lv, this.star);
        }// end function

        public function get addDefString() : String
        {
            return PetLongInfoLang.AddDef + " +" + PetType.getDefense(this.lv, this.star);
        }// end function

        public function get addLifeString() : String
        {
            return PetLongInfoLang.AddLife + " +" + PetType.getLife(this.lv, this.star);
        }// end function

        public function get addAttTip() : String
        {
            if (this.isFull)
            {
                return "";
            }
            var _loc_1:* = this.lv;
            var _loc_2:* = this.star + 1;
            if (_loc_2 > 10)
            {
                _loc_1++;
                _loc_2 = 1;
            }
            if (_loc_1 > 10)
            {
                _loc_1 = 10;
                _loc_2 = 10;
            }
            return PetLongInfoLang.NextAddTip + HtmlText.green(" +" + PetType.getAttack(_loc_1, _loc_2));
        }// end function

        public function get addDefTip() : String
        {
            if (this.isFull)
            {
                return "";
            }
            var _loc_1:* = this.lv;
            var _loc_2:* = this.star + 1;
            if (_loc_2 > 10)
            {
                _loc_1++;
                _loc_2 = 1;
            }
            if (_loc_1 > 10)
            {
                _loc_1 = 10;
                _loc_2 = 10;
            }
            return PetLongInfoLang.NextDefTip + HtmlText.green(" +" + PetType.getDefense(_loc_1, _loc_2));
        }// end function

        public function get addLiftTip() : String
        {
            if (this.isFull)
            {
                return "";
            }
            var _loc_1:* = this.lv;
            var _loc_2:* = this.star + 1;
            if (_loc_2 > 10)
            {
                _loc_1++;
                _loc_2 = 1;
            }
            if (_loc_1 > 10)
            {
                _loc_1 = 10;
                _loc_2 = 10;
            }
            return PetLongInfoLang.NextLifeTip + HtmlText.green(" +" + PetType.getLife(_loc_1, _loc_2));
        }// end function

        public function get mouseTip() : String
        {
            var _loc_1:Array = ["", PetLongInfoLang.Jie1, PetLongInfoLang.Jie2, PetLongInfoLang.Jie3, PetLongInfoLang.Jie4, PetLongInfoLang.Jie5, PetLongInfoLang.Jie6, PetLongInfoLang.Jie7, PetLongInfoLang.Jie8, PetLongInfoLang.Jie9, PetLongInfoLang.Jie10];
            var _loc_2:Array = ["", "", PetLongInfoLang.Bian1, PetLongInfoLang.Bian2, PetLongInfoLang.Bian3, PetLongInfoLang.Bian4, PetLongInfoLang.Bian5, PetLongInfoLang.Bian6, PetLongInfoLang.Bian7, PetLongInfoLang.Bian8, PetLongInfoLang.Bian9];
            var _loc_3:Array = [];
            var _loc_4:* = _loc_1[this.star] + PetType.getName(this.lv);
            if (this.lv > 1)
            {
                _loc_4 = _loc_4 + "(" + _loc_2[this.lv] + ")";
            }
            _loc_3.push(HtmlText.format(_loc_4, PetType.getColor(this.lv), 12, "", true));
            _loc_4 = PetLongInfoLang.Exp + " " + this.exp + " / " + PetType.getExp(this.lv, this.star);
            _loc_4 = _loc_4 + "（" + int(100 * this.exp / PetType.getExp(this.lv, this.star)) + "%）";
            _loc_3.push(_loc_4);
            _loc_3.push(this.addAttString);
            if (PetType.getDefense(this.lv, this.star) > 0)
            {
                _loc_3.push(this.addDefString);
            }
            if (PetType.getLife(this.lv, this.star) > 0)
            {
                _loc_3.push(this.addLifeString);
            }
            return _loc_3.join("\n");
        }// end function

        public function get reqLvTip() : String
        {
            var _loc_1:int = 0;
            var _loc_2:Array = ["", "", PetLongInfoLang.Bian1, PetLongInfoLang.Bian2, PetLongInfoLang.Bian3, PetLongInfoLang.Bian4, PetLongInfoLang.Bian5, PetLongInfoLang.Bian6, PetLongInfoLang.Bian7, PetLongInfoLang.Bian8, PetLongInfoLang.Bian9];
            var _loc_3:* = this.lv - 1;
            while (_loc_3 > 1)
            {
                
                _loc_1 = PetType.getReqLv(_loc_3);
                if (this.playerLv >= _loc_1)
                {
                    break;
                }
                _loc_3 = _loc_3 - 1;
            }
            _loc_3++;
            var _loc_4:Array = [];
            var _loc_5:* = Lang.sprintf(PetLongInfoLang.LongTip1, PetType.getName(_loc_3), _loc_2[_loc_3]);
            _loc_4.push(HtmlText.red(_loc_5));
            _loc_5 = Lang.sprintf(PetLongInfoLang.LongTip2, PetType.getReqLv(this.lv));
            _loc_4.push(HtmlText.format(_loc_5, 16773120));
            _loc_4.push(PetLongInfoLang.LongTip3);
            _loc_4.push(PetLongInfoLang.AddAtt + " +" + PetType.getAttack(_loc_3, 1));
            if (PetType.getDefense(_loc_3, 1) > 0)
            {
                _loc_4.push(PetLongInfoLang.AddDef + " +" + PetType.getDefense(_loc_3, 1));
            }
            if (PetType.getLife(_loc_3, 1) > 0)
            {
                _loc_4.push(PetLongInfoLang.AddLife + " +" + PetType.getLife(_loc_3, 1));
            }
            return _loc_4.join("\n");
        }// end function

    }
}
