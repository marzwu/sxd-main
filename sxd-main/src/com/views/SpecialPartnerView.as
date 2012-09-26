package com.views
{
    import com.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.controls.*;
    import com.assist.view.interfaces.*;
    import com.assist.view.interfaces.map.*;
    import com.assist.view.map.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;

    public class SpecialPartnerView extends Base implements IView
    {
        private var _specialPartner:ISpecialPartner;
        private var _frameSprite:IFrameSprite;
        private var _dialog:IAlert = null;
        private var _aryMissionId:Array;

        public function SpecialPartnerView()
        {
            this._aryMissionId = [];
            return;
        }// end function

        public function show() : void
        {
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
            this._view.removeFromTimerProcessList(sign);
            this._specialPartner.clear();
            this._frameSprite = null;
            this._dialog.hide();
            return;
        }// end function

        public function getPartnerInfo() : void
        {
            var callBack:Function;
            callBack = function () : void
            {
                if (inStage)
                {
                    getPartnerInfoCallBack();
                }
                else
                {
                    setActivityBtn();
                }
                return;
            }// end function
            ;
            this.get_partner_info(callBack);
            return;
        }// end function

        public function isNeedRefresh(param1:int) : void
        {
            var _loc_2:int = 0;
            for each (_loc_2 in this._aryMissionId)
            {
                
                if (_loc_2 == param1)
                {
                    this.getPartnerInfo();
                    return;
                }
            }
            return;
        }// end function

        private function showUI() : void
        {
            _popup.addView(this, this._specialPartner.content);
            _view.center(sign, this._specialPartner.content);
            return;
        }// end function

        private function render() : void
        {
            if (this._specialPartner == null)
            {
                this._specialPartner = _view.getAssetsObject("SpecialPartner", "SpecialPartner") as ISpecialPartner;
            }
            this.init();
            this.getPartnerInfoCallBack();
            this.showUI();
            return;
        }// end function

        private function init() : void
        {
            this._specialPartner.tip = this._view.tip.iTip;
            this._specialPartner.drag = this._view.drag.iDrag;
            this._specialPartner.onClose = this.close;
            this._specialPartner.onGet = this.get_mission_award;
            this._specialPartner.onIngotCompleted = this.ingotComplete;
            this._specialPartner.onInvite = this.invite_partner;
            this._specialPartner.onGotoMission = this.gotoMission;
            this._specialPartner.onOpenVip = this._view.vip.switchSelf;
            this._specialPartner.playerMissionLock = this._ctrl.player.missionKey;
            this._specialPartner.onAddFrameSprite = this.addFrameSprite;
            this._dialog = this._view.alert.iAlert;
            this._specialPartner.init();
            return;
        }// end function

        private function gotoMission(param1:int) : void
        {
            if (MissionType.getMissionLock(param1) <= this._ctrl.player.missionKey)
            {
                this.close();
                this._view.quest.wayFinding("mission," + MissionType.getTownIdByMissionId(param1) + "," + param1);
            }
            else
            {
                this._view.showTip(SpecialPartnerViewLang.NeddMission + MissionType.getMissionName(param1), null);
            }
            return;
        }// end function

        private function ingotComplete(param1:int, param2:int) : void
        {
            var callBack:Function;
            var intIngot:* = param1;
            var intRoleId:* = param2;
            callBack = function (param1:uint) : void
            {
                if (param1 == AlertButtonType.Yes)
                {
                    ingot_complete(intRoleId);
                }
                return;
            }// end function
            ;
            this._dialog.yesLabel = SpecialPartnerViewLang.Ok;
            this._dialog.cancelLabel = SpecialPartnerViewLang.Cancel;
            this._dialog.hasCheckbox = false;
            this._dialog.show(Lang.sprintf(SpecialPartnerViewLang.IngotComplete, HtmlText.yellow(intIngot + SpecialPartnerViewLang.Ingot)), AlertButtonType.Yes | AlertButtonType.Cancel, callBack);
            return;
        }// end function

        private function enterFrameHandler() : void
        {
            if (inStage == false)
            {
                _view.removeFromFrameProcessList(String(this));
                return;
            }
            if (this._frameSprite != null)
            {
                this._frameSprite.pass(_view.time2);
            }
            return;
        }// end function

        private function setActivityBtn() : void
        {
            var _loc_2:int = 0;
            var _loc_3:Object = null;
            var _loc_4:Object = null;
            var _loc_1:* = this.getCurrentRole();
            if (_loc_1 == null)
            {
                _view.activities.removeActivity(FunctionType.SpecialPartner);
            }
            else
            {
                _view.activities.openActivity(FunctionType.SpecialPartner);
                _view.activities.visibleBtnEffect(FunctionType.SpecialPartner, "", false);
                _loc_2 = 0;
                while (_loc_2 < _loc_1.length)
                {
                    
                    _loc_3 = _loc_1[_loc_2];
                    for each (_loc_4 in _loc_3["require_list"] as Array)
                    {
                        
                        if (_loc_4["require_status"] == Mod_SpecialPartner_Base.MS_CANCOMPLETE)
                        {
                            _view.activities.visibleBtnEffect(FunctionType.SpecialPartner, "", true);
                            return;
                        }
                    }
                    _loc_2++;
                }
            }
            return;
        }// end function

        private function getCurrentRole() : Array
        {
            var _loc_4:Object = null;
            var _loc_5:Boolean = false;
            var _loc_6:Object = null;
            var _loc_1:* = _ctrl.specialPartner.getPartnerInfo;
            var _loc_2:Array = [];
            this._aryMissionId = [];
            var _loc_3:int = 0;
            while (_loc_3 < _loc_1.length)
            {
                
                _loc_4 = _loc_1[_loc_3];
                _loc_5 = true;
                for each (_loc_6 in _loc_4["require_list"] as Array)
                {
                    
                    if (_loc_6["require_status"] != Mod_SpecialPartner_Base.MS_COMPLETED)
                    {
                        _loc_5 = false;
                        _loc_2.push(_loc_4);
                        break;
                    }
                }
                if (_loc_5 && _loc_4["invite_status"] != Mod_SpecialPartner_Base.IS_INVITED)
                {
                    _loc_2.push(_loc_4);
                }
                _loc_3++;
            }
            if (_loc_2.length != 0)
            {
                return _loc_2;
            }
            return null;
        }// end function

        private function loadData() : void
        {
            this.get_partner_info(this.loadDataCallBack);
            return;
        }// end function

        private function loadDataCallBack() : void
        {
            loadAssets("SpecialPartner", this.render, SpecialPartnerViewLang.Load);
            return;
        }// end function

        private function get_partner_info(param1:Function) : void
        {
            if (!FunctionType.isOpened(FunctionType.SpecialPartner))
            {
                return;
            }
            _data.call(Mod_SpecialPartner_Base.get_partner_info, param1, []);
            return;
        }// end function

        private function getPartnerInfoCallBack() : void
        {
            this.setActivityBtn();
            var _loc_1:* = this.getCurrentRole();
            if (_loc_1 != null)
            {
                this._specialPartner.renderPartnerInfo(_loc_1);
            }
            return;
        }// end function

        private function addFrameSprite(param1:Object) : void
        {
            if (this._frameSprite != null)
            {
                if (this._frameSprite.com.assist.view.interfaces.base:IContent::content.parent && this._frameSprite.com.assist.view.interfaces.base:IContent::content.parent.contains(this._frameSprite.com.assist.view.interfaces.base:IContent::content))
                {
                    this._frameSprite.com.assist.view.interfaces.base:IContent::content.parent.removeChild(this._frameSprite.com.assist.view.interfaces.base:IContent::content);
                    this._frameSprite = null;
                }
            }
            this._frameSprite = MapStatic.mapInstance.frame;
            this._frameSprite.initUrl(param1["role_sign"], "stand");
            this._frameSprite.pass(_view.time2);
            this._frameSprite.com.assist.view.interfaces.base:IContent::content.x = 137;
            this._frameSprite.com.assist.view.interfaces.base:IContent::content.y = 275;
            this._frameSprite.shadowVisible = false;
            this._specialPartner.frameSprite = this._frameSprite;
            this._view.addToFrameProcessList(sign, this.enterFrameHandler);
            return;
        }// end function

        private function get_mission_award(param1:int) : void
        {
            var callBack:Function;
            var intRequireId:* = param1;
            callBack = function () : void
            {
                getMissionAwardCallBack(intRequireId);
                return;
            }// end function
            ;
            _data.call(Mod_SpecialPartner_Base.get_mission_award, callBack, [intRequireId]);
            return;
        }// end function

        private function getMissionAwardCallBack(param1:int) : void
        {
            var _loc_2:* = this._ctrl.specialPartner.getMissionAward;
            if (_loc_2["result"] == Mod_SpecialPartner_Base.MCR_SUCCESS)
            {
                this._specialPartner.renderGetAward(param1);
                this.get_partner_info(this.setActivityBtn);
            }
            else
            {
                this._view.showTip(this.message(_loc_2["result"]));
            }
            return;
        }// end function

        private function ingot_complete(param1:int) : void
        {
            _data.call(Mod_SpecialPartner_Base.ingot_complete, this.ingotCompleteCallBack, [param1]);
            return;
        }// end function

        private function ingotCompleteCallBack() : void
        {
            var _loc_1:* = this._ctrl.specialPartner.ingotComplete;
            if (_loc_1["result"] == Mod_SpecialPartner_Base.ICR_SUCCESS)
            {
                this._specialPartner.renderIngotCompleted(this._ctrl.specialPartner.ingotCompleteRequireList);
                this._view.showTip(this.message(_loc_1["result"]), null, TipType.Success);
                this.getPartnerInfo();
            }
            else
            {
                this._view.showTip(this.message(_loc_1["result"]));
            }
            return;
        }// end function

        private function invite_partner(param1:int) : void
        {
            _data.call(Mod_SpecialPartner_Base.invite_partner, this.invitePartnerCallBack, [param1]);
            return;
        }// end function

        private function invitePartnerCallBack() : void
        {
            var _loc_1:* = this._ctrl.specialPartner.invitePartner;
            if (_loc_1["result"] == Mod_SpecialPartner_Base.IPR_SUCCESS)
            {
                this._view.showTip(this.message(_loc_1["result"]), null, TipType.Success);
                this.close();
                this.getPartnerInfo();
            }
            else
            {
                this._view.showTip(this.message(_loc_1["result"]));
            }
            return;
        }// end function

        private function message(param1:int) : String
        {
            var _loc_2:String = "";
            switch(param1)
            {
                case Mod_SpecialPartner_Base.MCR_SUCCESS:
                {
                    _loc_2 = SpecialPartnerViewLang.MCR_SUCCESS;
                    break;
                }
                case Mod_SpecialPartner_Base.MCR_ALREADY_GET:
                {
                    _loc_2 = SpecialPartnerViewLang.MCR_ALREADY_GET;
                    break;
                }
                case Mod_SpecialPartner_Base.MCR_CANT_GET:
                {
                    _loc_2 = SpecialPartnerViewLang.MCR_CANT_GET;
                    break;
                }
                case Mod_SpecialPartner_Base.ICR_SUCCESS:
                {
                    _loc_2 = SpecialPartnerViewLang.ICR_SUCCESS;
                    break;
                }
                case Mod_SpecialPartner_Base.ICR_NO_INGOT:
                {
                    _loc_2 = SpecialPartnerViewLang.ICR_NO_INGOT;
                    break;
                }
                case Mod_SpecialPartner_Base.IPR_SUCCESS:
                {
                    _loc_2 = SpecialPartnerViewLang.IPR_SUCCESS;
                    break;
                }
                case Mod_SpecialPartner_Base.IPR_CANT_INVITE:
                {
                    _loc_2 = SpecialPartnerViewLang.IPR_CANT_INVITE;
                    break;
                }
                case Mod_SpecialPartner_Base.MCR_GET_ERROR:
                {
                    _loc_2 = SpecialPartnerViewLang.MCR_GET_ERROR;
                    break;
                }
                case Mod_SpecialPartner_Base.ICR_ERROR:
                {
                    _loc_2 = SpecialPartnerViewLang.ICR_ERROR;
                    break;
                }
                case Mod_SpecialPartner_Base.IPR_ERROR:
                {
                    _loc_2 = SpecialPartnerViewLang.IPR_ERROR;
                    break;
                }
                case Mod_SpecialPartner_Base.ICR_VIPLV_ERROR:
                {
                    _loc_2 = SpecialPartnerViewLang.ICR_VIPLV_ERROR;
                    break;
                }
                case Mod_SpecialPartner_Base.MCR_BAG_FULL:
                {
                    _loc_2 = SpecialPartnerViewLang.MCR_BAG_FULL;
                    break;
                }
                case Mod_SpecialPartner_Base.IPR_FULL_PARTNER:
                {
                    _loc_2 = SpecialPartnerViewLang.IPR_FULL_PARTNER;
                    break;
                }
                case Mod_SpecialPartner_Base.IPR_NO_FAME:
                {
                    _loc_2 = SpecialPartnerViewLang.IPR_NO_FAME;
                    break;
                }
                case Mod_SpecialPartner_Base.IPR_NO_COIN:
                {
                    _loc_2 = SpecialPartnerViewLang.IPR_NO_COIN;
                    break;
                }
                default:
                {
                    _loc_2 = SpecialPartnerViewLang.Error + param1;
                    break;
                }
            }
            return _loc_2;
        }// end function

    }
}
