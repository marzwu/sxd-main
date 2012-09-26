package com.datas
{
    import com.*;
    import com.assist.*;
    import com.assist.data.mission.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.info.*;
    import com.lang.client.com.datas.*;
    import com.protocols.*;

    public class TowerData extends Base
    {
        public var result:int = 0;
        public var info:TowerInfo;
        public var warData:WarData;
        public var warSoulId:int;
        public var warExp:int;
        public var warCoin:int;
        public var warFame:int;
        public var isPass:Boolean;
        public var warAura:int;
        public var completeName:String = "";

        public function TowerData()
        {
            this.info = new TowerInfo();
            return;
        }// end function

        public function get_tower_info(param1:Array) : void
        {
            this.info.sequenceMax_ = param1[0];
            this.info.layer = param1[1];
            this.info.sequenceWar = param1[2] + 1;
            this.info.bagNum = param1[3];
            this.info.resetNum = param1[4];
            this.info.resetIngot = param1[5];
            this.info.hideId = param1[6];
            this.info.panelIdx = 1;
            this.info.layderTip = "";
            this.info.isShowTip = true;
            if (this.info.sequenceWar == 26 && this.info.layer == 6)
            {
                this.info.layderTip = TowerDataLang.layderTip2;
            }
            else if (_data.player.level < this.info.daoLv[this.info.layer])
            {
                this.info.isShowTip = false;
                this.info.layderTip = Lang.sprintf(TowerDataLang.layderTip1, this.info.daoLv[this.info.layer]);
            }
            return;
        }// end function

        public function start_challenge(param1:Array) : void
        {
            this.result = param1[0];
            if (this.result != Mod_Tower_Base.SUCCESS)
            {
                return;
            }
            this.warData = new WarData();
            this.warData.format([0, 0, 0, [param1[1][0]]]);
            this.warSoulId = param1[2];
            this.warExp = param1[3];
            this.warFame = param1[4];
            this.warCoin = param1[5];
            this.isPass = param1[7] == 1;
            this.warAura = param1[8];
            this.info.bagNum = param1[6];
            this.info.panelIdx = 1;
            if (this.isPass)
            {
                if (this.info.warIdx > 0)
                {
                    if (this.info.sequenceMax_ < this.info.sequenceWar)
                    {
                        this.info.sequenceMax_ = this.info.sequenceWar;
                    }
                    var _loc_2:* = this.info;
                    var _loc_3:* = this.info.sequenceWar + 1;
                    _loc_2.sequenceWar = _loc_3;
                }
                else
                {
                    this.info.hideId = 0;
                }
            }
            return;
        }// end function

        public function reset_layer(param1:Array) : void
        {
            this.result = param1[0];
            if (this.result != Mod_Tower_Base.SUCCESS)
            {
                return;
            }
            this.info.resetNum = param1[1];
            this.info.resetIngot = param1[2];
            this.info.hideId = param1[3];
            this.info.sequenceWar = 1;
            this.info.panelIdx = 1;
            return;
        }// end function

        public function start_auto_challenge(param1:Array) : void
        {
            this.result = param1[0];
            if (this.result != Mod_Tower_Base.SUCCESS)
            {
                return;
            }
            this.info.panelIdx = 2;
            this.info.inAuto = true;
            this.info.awardAutoTip1 = "";
            this.info.awardAutoTip2 = Lang.sprintf(TowerDataLang.InAutoWar, this.info.sequenceWar);
            return;
        }// end function

        public function stop_auto_challenge(param1:Array) : void
        {
            return;
        }// end function

        public function notify_auto_challenge_report(param1:Array) : void
        {
            var _loc_2:String = null;
            var _loc_3:String = null;
            var _loc_4:String = null;
            var _loc_5:int = 0;
            var _loc_6:String = null;
            var _loc_7:int = 0;
            var _loc_8:int = 0;
            this.result = param1[0];
            if (this.result == Mod_Tower_Base.SUCCESS)
            {
                this.info.bagNum = param1[4];
                this.info.sequenceWar = param1[1] + 1;
                this.info.awardAutoTip2 = Lang.sprintf(TowerDataLang.InAutoWar, this.info.sequenceWar);
                _loc_2 = Lang.sprintf(TowerDataLang.SequenceGet, param1[1]);
                _loc_3 = "";
                _loc_4 = "";
                _loc_5 = param1[2];
                if (_loc_5 != 0)
                {
                    _loc_4 = htmlFormat("[" + SoulType.getSoulName(_loc_5) + "]", 12, SoulType.getSoulQualityColor(_loc_5));
                    _loc_3 = _loc_2 + _loc_4 + "\n";
                    _loc_7 = SoulType.getSoulQualityId(_loc_5);
                    _loc_8 = SoulType.getSoulSalePrice(_loc_5);
                    if (_loc_7 == 1 && this.info.autoSellL)
                    {
                        _loc_3 = _loc_3 + HtmlText.white(Lang.sprintf(TowerDataLang.AutoSell, _loc_4, 1, HtmlText.yellow(_loc_8.toString())));
                    }
                    else if (_loc_7 == 2 && this.info.autoSellZ)
                    {
                        _loc_3 = _loc_3 + HtmlText.white(Lang.sprintf(TowerDataLang.AutoSell, _loc_4, 3, HtmlText.yellow(_loc_8.toString())));
                    }
                }
                _loc_6 = _loc_2 + HtmlText.green(Lang.sprintf(TowerDataLang.Exp, param1[3]));
                this.info.awardAutoTip1 = _loc_3 + _loc_6 + this.info.awardAutoTip1;
            }
            if (this.result != Mod_Tower_Base.SUCCESS || this.info.sequenceWar == (this.info.sequenceMax_ + 1) || this.info.bagNum == 0)
            {
                this.info.awardAutoTip2 = TowerDataLang.StopAutoWar;
                this.info.inAuto = false;
            }
            return;
        }// end function

        public function quickly_auto_challenge(param1:Array) : void
        {
            this.result = param1[0];
            if (this.result == Mod_Tower_Base.SUCCESS)
            {
            }
            return;
        }// end function

        public function complete(param1:Array) : void
        {
            this.completeName = param1[0];
            return;
        }// end function

    }
}
