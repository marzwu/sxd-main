package com.views
{
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.controls.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;

    public class PartnersView extends Base implements IView
    {
        private var _partners:IPartners;
        private var _dialog:IAlert = null;

        public function PartnersView()
        {
            return;
        }// end function

        private function get isOpenSport() : Boolean
        {
            return FunctionType.isOpened(FunctionType.SuperSport);
        }// end function

        public function show() : void
        {
            if (this._view.missionMap.inStageWithTip)
            {
                return;
            }
            if (FunctionType.isOpened(FunctionType.Partners) == false)
            {
                _view.alert.confirm(PartnersViewLang.FirstRole);
                return;
            }
            this.loadData();
            return;
        }// end function

        public function close() : void
        {
            this.clear();
            _popup.closeView(this);
            this._view.guide.triggerDeploy();
            this._view.guide.stopPartnersGuides2();
            return;
        }// end function

        public function clear() : void
        {
            this._dialog.hide();
            this._partners.clear();
            return;
        }// end function

        private function loadData() : void
        {
            this._data.call(Mod_Partners_Base.partners_list, this.loadDtaCallBack, [0]);
            return;
        }// end function

        private function loadDtaCallBack() : void
        {
            var callBack:* = function () : void
            {
                render();
                partnersListCallBack();
                showUI();
                return;
            }// end function
            ;
            loadAssets("Partners", callBack, PartnersViewLang.LoadInfo);
            return;
        }// end function

        private function render() : void
        {
            if (this._partners == null)
            {
                this._partners = _view.getAssetsObject("Partners", "Partners") as IPartners;
            }
            this.init();
            this._partners.render();
            return;
        }// end function

        private function showUI() : void
        {
            _popup.addView(this, this._partners.content);
            _view.center(sign, this._partners.content);
            return;
        }// end function

        private function init() : void
        {
            this._partners.roleIconUrl = URI.iconsUrl;
            this._dialog = _view.alert.iAlert;
            this._partners.tip = _view.tip.iTip;
            this._partners.drag = _view.drag.iDrag;
            this._partners.onCloseBtn = this.close;
            this._partners.onPartnersData = this.partners_list;
            this._partners.onPartnersItemBtn = this.partners_invite;
            this._partners.isOpenSport = this.isOpenSport;
            this._partners.pageCurrent = 1;
            return;
        }// end function

        private function getPageCount(param1:Array) : int
        {
            return Math.ceil(param1.length / 12);
        }// end function

        private function partners_list() : void
        {
            this._data.call(Mod_Partners_Base.partners_list, this.partnersListCallBack, [this._partners.partnersJobType]);
            return;
        }// end function

        private function partnersListCallBack() : void
        {
            var _loc_1:* = this._ctrl.partners.getPartnersList();
            var _loc_2:* = this._ctrl.partners.getRecruitCount();
            var _loc_3:Object = {fame:this._ctrl.player.fame, fame_level:_loc_2["fame_level"], coin:this._ctrl.player.coins};
            this._partners.setPlayerInfo(_loc_3);
            this._partners.pageCount = this.getPageCount(_loc_1);
            this._partners.setDataBtn(_loc_1);
            if (this._partners.pageCurrent > this._partners.pageCount)
            {
                this._partners.pageCurrent = this._partners.pageCount;
            }
            _loc_1 = _loc_1.slice((this._partners.pageCurrent - 1) * 12, this._partners.pageCurrent * 12);
            this._partners.renderPartnersList(_loc_1);
            this._partners.renderRecruitCount(_loc_2);
            this._view.guide.trackPartners(3, this._partners.content);
            this._view.guide.trackPartners2(3, this._partners.content);
            if (_loc_1.length == 0)
            {
                this._view.guide.trackPartners(4, this._partners.content);
                this._view.guide.trackPartners2(4, this._partners.content);
            }
            return;
        }// end function

        private function partners_invite() : void
        {
            this._data.call(Mod_Partners_Base.partners_invite, this.partnersInviteCallBack, [this._partners.partnersID]);
            return;
        }// end function

        private function partnersInviteCallBack() : void
        {
            var _loc_1:* = this._ctrl.partners.Recruit();
            if (_loc_1 != Mod_Partners_Base.SUCCEED)
            {
                _view.showTip(this.recruitMessage(_loc_1));
                return;
            }
            _view.showTip(PartnersViewLang.Succeed, null, TipType.Success);
            this.partners_list();
            return;
        }// end function

        private function recruitMessage(param1:int) : String
        {
            var _loc_2:String = "";
            switch(param1)
            {
                case Mod_Partners_Base.SUCCEED:
                {
                    _loc_2 = PartnersViewLang.Succeed;
                    break;
                }
                case Mod_Partners_Base.FAILED:
                {
                    _loc_2 = PartnersViewLang.Failed;
                    break;
                }
                case Mod_Partners_Base.NOENOUGHFEES:
                {
                    _loc_2 = PartnersViewLang.NoEnoughFees;
                    break;
                }
                case Mod_Partners_Base.COUNTLIMIT:
                {
                    _loc_2 = PartnersViewLang.CountLimit;
                    break;
                }
                case Mod_Partners_Base.NOENOUGHFAME:
                {
                    _loc_2 = PartnersViewLang.NoEnoughFame;
                    break;
                }
                default:
                {
                    _loc_2 = PartnersViewLang.Error + param1;
                    break;
                }
            }
            return _loc_2;
        }// end function

    }
}
