package com.views
{
    import com.*;
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import flash.net.*;

    public class VipView extends Base implements IView
    {
        private var _iVip:IVip;
        private var _playerVipLevel:int;
        private var _moneyToNextLevel:int;
        private var _intChangeIngot:int;

        public function VipView()
        {
            return;
        }// end function

        public function show() : void
        {
            this.get_player_vip_info();
            return;
        }// end function

        private function get_player_vip_info() : void
        {
            _data.call(Mod_Vip_Base.get_player_vip_info, this.getPlayerVipInfoCallback, []);
            return;
        }// end function

        private function getPlayerVipInfoCallback() : void
        {
            this._playerVipLevel = _ctrl.vip.playerVipLevel;
            this._moneyToNextLevel = _ctrl.vip.moneyToNextLevel;
            loadAssets("Vip", this.render, VipViewLang.LoadInfo);
            return;
        }// end function

        private function render() : void
        {
            this._iVip = _view.getAssetsObject("Vip", "Vip") as IVip;
            _popup.addView(this, this._iVip.content);
            this._iVip.drag = _view.drag.iDrag;
            this._iVip.onClose = this.close;
            this._iVip.onRecharge = this.gotoRecharge;
            this._iVip.onShowVIPInfo = this.showVIPInfo;
            var _loc_1:* = URI.openTime;
            var _loc_2:* = _ctrl.player.serverTime;
            var _loc_3:* = _ctrl.player.serverTime - _loc_1;
            var _loc_4:* = new Date(2012, 2, 3);
            var _loc_5:* = new Date(2012, 2, 3).time / 1000;
            if (_loc_1 >= _loc_5)
            {
                this._iVip.showOnePayBtn = _loc_3 < 259200 && URI.isCombined == false;
                this._iVip.showFirstPayBtn = false;
            }
            else
            {
                this._iVip.showOnePayBtn = false;
                this._iVip.showFirstPayBtn = _ctrl.player.vipLevel == VIPType.Level0;
            }
            this.showInfo();
            _view.center(sign, this._iVip.content);
            return;
        }// end function

        private function gotoRecharge() : void
        {
            navigateToURL(new URLRequest(URI.rechargeUrl));
            this.close();
            return;
        }// end function

        private function showVIPInfo() : void
        {
            navigateToURL(new URLRequest(URI.vipInfoUrl));
            this.close();
            return;
        }// end function

        private function showInfo() : void
        {
            var _loc_1:* = this._playerVipLevel;
            var _loc_2:String = "";
            if (_loc_1 > 0)
            {
                _loc_2 = Lang.sprintf(VipViewLang.VipMember, _loc_1);
            }
            else
            {
                _loc_2 = VipViewLang.Nothing;
            }
            var _loc_3:* = _loc_1 >= VIPType.MaxLevel ? (VipViewLang.TopLevel1) : (Lang.sprintf(VipViewLang.NextLevel, (_loc_1 + 1)));
            var _loc_4:* = _loc_3 + "\n" + (_loc_1 >= VIPType.MaxLevel ? ("<font size=\"12\">" + VIPType.getVIPInfo(_loc_1) + "</font>") : ("<font size=\"12\">" + VIPType.getVIPInfo((_loc_1 + 1)) + "</font>"));
            var _loc_5:String = "";
            var _loc_6:int = 0;
            if (_loc_1 >= VIPType.MaxLevel)
            {
                _loc_5 = VipViewLang.TopLevel2;
                _loc_6 = VIPType.getRequireMoney(VIPType.MaxLevel);
            }
            else
            {
                _loc_5 = Lang.sprintf(VipViewLang.NextIngot, this._moneyToNextLevel, (_loc_1 + 1));
                _loc_6 = VIPType.getRequireMoney((_ctrl.player.vipLevel + 1));
            }
            this._iVip.info(_loc_2, _loc_4, _loc_5);
            this._iVip.renderProgressBar(this._moneyToNextLevel, _loc_6, this._intChangeIngot);
            return;
        }// end function

        private function send_ingot_receive_show_vip() : void
        {
            _data.call(Mod_Player_Base.send_ingot_receive_show_vip, this.sendIngotReceiveShowVipCallBack, []);
            return;
        }// end function

        private function sendIngotReceiveShowVipCallBack() : void
        {
            var callBack:Function;
            callBack = function () : void
            {
                _playerVipLevel = _ctrl.vip.playerVipLevel;
                _moneyToNextLevel = _ctrl.vip.moneyToNextLevel;
                showInfo();
                return;
            }// end function
            ;
            if (this._ctrl.player.isSendIngotReceiveShowVip)
            {
                this._intChangeIngot = this._ctrl.player.ingotChange;
                if (this.inStage)
                {
                    _data.call(Mod_Vip_Base.get_player_vip_info, callBack, []);
                }
                else
                {
                    this.show();
                }
            }
            return;
        }// end function

        public function clear() : void
        {
            this._iVip.clear();
            this._intChangeIngot = 0;
            return;
        }// end function

        public function close() : void
        {
            this.clear();
            _popup.closeView(this);
            return;
        }// end function

        public function sendIngotReceiveShowVip() : void
        {
            this.send_ingot_receive_show_vip();
            return;
        }// end function

    }
}
