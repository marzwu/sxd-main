package com.views
{
    import com.assist.server.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import flash.display.*;

    public class HaloRoleView extends Base implements IView
    {
        private var _haloRole:IHaloRole;
        private var _openTime:int = 0;
        private var _isOpen:Boolean = false;
        private var _isButtle:Boolean = false;
        private var _rect:Sprite;
        private var _buttleLock:int = 1;
        private var _buttleId:int = 0;

        public function HaloRoleView()
        {
            return;
        }// end function

        public function show() : void
        {
            this.get_challenge_info();
            return;
        }// end function

        public function get_challenge_info() : void
        {
            _data.call(Mod_HaloRole_Base.get_challenge_info, this.getChallengeInfoCallBack, []);
            return;
        }// end function

        public function add_HaloRole() : void
        {
            _data.call(Mod_HaloRole_Base.get_challenge_info, this.addHaloRoleCallBack, []);
            return;
        }// end function

        public function start_challenge() : void
        {
            if (this._isOpen == false)
            {
                return;
            }
            this.drawBlack();
            _data.call(Mod_HaloRole_Base.start_challenge, this.startChallengeCallBack, []);
            return;
        }// end function

        public function openHaloRole() : void
        {
            if (FunctionType.isOpened(FunctionType.HaloRole))
            {
                return;
            }
            if (this._openTime <= 0)
            {
                return;
            }
            if (this._openTime <= _ctrl.player.serverTime)
            {
                this.add_HaloRole();
            }
            return;
        }// end function

        public function addHaloRoleCallBack() : void
        {
            var _loc_1:* = this._ctrl.haloRole.getChallengeInfo;
            this._openTime = _loc_1.openTime;
            if (_loc_1.isOpen == Mod_HaloRole_Base.OPEN)
            {
                this._isOpen = true;
                this.addActivity();
            }
            return;
        }// end function

        public function getChallengeInfoCallBack() : void
        {
            var _loc_1:Object = null;
            if (this.inStage)
            {
                _loc_1 = this._ctrl.haloRole.getChallengeInfo;
                if (_loc_1.isOpen != Mod_HaloRole_Base.OPEN)
                {
                    this._isOpen = false;
                }
                this._haloRole.getButtleData(_loc_1);
            }
            else
            {
                loadAssets("HaloRole", this.render, HaloRoleViewLang.loadAssets);
            }
            return;
        }// end function

        public function startChallengeCallBack() : void
        {
            if (_ctrl.haloRole.warStatus != Mod_HaloRole_Base.INVALID_PARAM)
            {
                _view.haloRoleWar.warData = _ctrl.haloRole.warData;
                _view.haloRoleWar.aura = _ctrl.haloRole.aura;
                _view.haloRoleWar.onClose = function (param1:Boolean) : void
            {
                playDrama(false, _buttleId, get_challenge_info);
                return;
            }// end function
            ;
                _view.haloRoleWar.onAfterAdded = function () : void
            {
                _rect.graphics.clear();
                _rect.parent.removeChild(_rect);
                _rect = null;
                return;
            }// end function
            ;
                _view.haloRoleWar.show();
            }
            this._isButtle = false;
            return;
        }// end function

        private function playDrama(param1:Boolean, param2:int, param3:Function) : void
        {
            var _loc_4:Object = {};
            var _loc_5:String = "";
            if (param1)
            {
                _loc_5 = HaloRoleType.getStartDrama(param2);
            }
            else
            {
                _loc_5 = HaloRoleType.getEndDrama(param2);
            }
            _view.dramaPlayBack.dramaPlay(_loc_5, param3);
            return;
        }// end function

        public function drawBlack() : void
        {
            this._rect = new Sprite();
            this._rect.graphics.beginFill(0);
            this._rect.graphics.drawRect(0, 0, 1250, 650);
            this._rect.graphics.endFill();
            this._view.structure.popup.addChild(this._rect);
            return;
        }// end function

        private function render() : void
        {
            this._haloRole = _view.getAssetsObject("HaloRole", "HaloRole") as IHaloRole;
            _popup.addView(this, this._haloRole.content);
            _view.center(sign, this._haloRole.content);
            this._haloRole.tip = _view.tip.iTip;
            this._haloRole.drag = _view.drag.iDrag;
            this._haloRole.getButtleList(HaloRoleType.ButtleList);
            this._haloRole.onChange = function (param1:Object) : void
            {
                _buttleId = HaloRoleType.getRoleId(param1.sign);
                if (_isButtle || _isOpen == false)
                {
                    return;
                }
                _isButtle = true;
                playDrama(true, _buttleId, start_challenge);
                return;
            }// end function
            ;
            this._haloRole.onClose = function () : void
            {
                close();
                return;
            }// end function
            ;
            this.getChallengeInfoCallBack();
            return;
        }// end function

        private function addActivity() : void
        {
            _view.activities.addActivity(FunctionType.HaloRole);
            return;
        }// end function

        private function removeActivity() : void
        {
            _view.activities.removeActivity(FunctionType.HaloRole);
            return;
        }// end function

        public function close() : void
        {
            if (this._isOpen == false)
            {
                this.removeActivity();
            }
            this._isButtle = false;
            this._haloRole.clear();
            _popup.closeView(this);
            return;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

    }
}
