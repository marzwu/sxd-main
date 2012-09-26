package com.views
{
    import com.assist.server.*;
    import com.assist.view.controls.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;

    public class PartnersNewView extends Base implements IView
    {
        private var _partnersNew:IPartnersNew;
        private var _dialog:IAlert = null;

        public function PartnersNewView()
        {
            return;
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
            this.partners_list(0);
            return;
        }// end function

        private function partners_list(param1:int) : void
        {
            this._data.call(Mod_Partners_Base.partners_list, this.partnersListCallBack, [param1]);
            return;
        }// end function

        public function partners_invite(param1:int) : void
        {
            this._data.call(Mod_Partners_Base.partners_invite, this.partnersInviteCallBack, [param1]);
            return;
        }// end function

        private function partnersListCallBack() : void
        {
            var _loc_1:Array = null;
            if (this.inStage)
            {
                _loc_1 = _ctrl.partners.getPartnersList();
                this._partnersNew.getPartnersList(_loc_1);
                this._view.guide.trackPartners(3, this._partnersNew.content);
                this._view.guide.trackPartners2(3, this._partnersNew.content);
                if (_loc_1.length > 0 && _loc_1[0]["list"].length == 0)
                {
                    this._view.guide.trackPartners(4, this._partnersNew.content);
                    this._view.guide.trackPartners2(4, this._partnersNew.content);
                }
            }
            else
            {
                loadAssets("PartnersNew", this.render, PartnersViewLang.LoadInfo);
            }
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
            this.partners_list(0);
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

        private function render() : void
        {
            if (this._partnersNew == null)
            {
                this._partnersNew = _view.getAssetsObject("PartnersNew", "PartnersNew") as IPartnersNew;
                this._partnersNew.tip = _view.tip.iTip;
                this._partnersNew.drag = _view.drag.iDrag;
            }
            _popup.addView(this, this._partnersNew.content);
            var obj:* = _ctrl.partners.getRecruitCount();
            this._partnersNew.getPlayerFameLevel(obj.fame_level, _ctrl.player.fame);
            this._partnersNew.getTeamPesonNum(obj.curr_count, obj.max_count);
            this._partnersNew.onClose = function () : void
            {
                close();
                return;
            }// end function
            ;
            this._partnersNew.onCheckInfo = function (param1:Object) : void
            {
                _view.partnersInfo.showForRoleId(param1.role_id);
                return;
            }// end function
            ;
            this._partnersNew.onInvitation = function (param1:Object) : void
            {
                partners_invite(param1.role_id);
                return;
            }// end function
            ;
            this._partnersNew.init();
            this.partnersListCallBack();
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
            this._partnersNew.clear();
            return;
        }// end function

    }
}
