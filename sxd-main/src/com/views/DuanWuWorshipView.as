package com.views
{
    import com.*;
    import com.assist.view.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;

    public class DuanWuWorshipView extends Base implements IView
    {
        private var _worship:IDuanWuWorship;
        private var zongziColor:Object;
        private var zongziType:Object;

        public function DuanWuWorshipView()
        {
            this.zongziColor = {0:16777215, 1:47086, 2:16773376};
            this.zongziType = {0:DuanWuWorshipViewLang.WhiteZongzi, 1:DuanWuWorshipViewLang.BlueZongzi, 2:DuanWuWorshipViewLang.YellowZongzi};
            return;
        }// end function

        public function show() : void
        {
            this.openWorship();
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
            this._worship.clear();
            return;
        }// end function

        private function openWorship() : void
        {
            _data.call(Mod_DuanWu_Base.worship_state, this.openWorshipCallBack, []);
            return;
        }// end function

        private function onWorship(param1:int) : void
        {
            _data.call(Mod_DuanWu_Base.worship, this.worshipCallBack, [param1]);
            return;
        }// end function

        public function worship_state() : void
        {
            _data.call(Mod_DuanWu_Base.worship_state, this.worshipStateCallBack, []);
            return;
        }// end function

        private function worshipStateCallBack() : void
        {
            var _loc_1:* = _ctrl.duanWu.isWorshiped;
            var _loc_2:Object = {};
            if (_loc_1 == Mod_DuanWu_Base.CAN_GET)
            {
                _loc_2.state = 1;
                _loc_2.info = HtmlText.white(DuanWuWorshipViewLang.Worship);
                _loc_2.showEffect = true;
            }
            else
            {
                _loc_2.state = 2;
                if (_loc_1 == Mod_DuanWu_Base.CAN_NOT_GET)
                {
                    _loc_2.info = HtmlText.format(DuanWuWorshipViewLang.IsGet, 10066329);
                }
                else
                {
                    _loc_2.info = HtmlText.format(DuanWuWorshipViewLang.TimeOut, 10066329);
                }
                _loc_2.showEffect = false;
            }
            _view.activityDuanWu.quYuanState(_loc_2);
            return;
        }// end function

        private function render() : void
        {
            if (this._worship == null)
            {
                this._worship = _view.getAssetsObject("DuanWuWorship", "DuanWuWorship") as IDuanWuWorship;
                this._worship.tip = _view.tip.iTip;
                this._worship.drag = _view.drag.iDrag;
            }
            _popup.addView(this, this._worship.content);
            _view.center(sign, this._worship.content);
            this._worship.render();
            this._worship.onClose = this.close;
            this._worship.onTextLink = _view.toolbar.onTextLink;
            this._worship.onWorship = this.onWorship;
            this._worship.recordAry = _ctrl.duanWu.getRecordList;
            this._worship.coins = _ctrl.player.coins;
            this._worship.ingot = _ctrl.player.ingot;
            this._worship.vipLevel = _ctrl.player.vipLevel;
            this._worship.isWorshiped = _ctrl.duanWu.isWorshiped;
            this._worship.zongziNum = _ctrl.duanWu.zongziNum;
            return;
        }// end function

        private function openWorshipCallBack() : void
        {
            loadAssets("DuanWuWorship", this.render, DuanWuWorshipViewLang.OpenWorship);
            return;
        }// end function

        private function worshipCallBack() : void
        {
            var callBack:Function;
            var ary:Array;
            var obj:Object;
            var num:int;
            var framNum:int;
            var info:String;
            var result:* = _ctrl.duanWu.worshipResult;
            if (result == Mod_DuanWu_Base.SUCCESS)
            {
                callBack = function () : void
            {
                _worship.recordAry = _ctrl.duanWu.worshipList;
                _worship.isWorshiped = Mod_DuanWu_Base.CAN_NOT_GET;
                _worship.dialogue();
                _worship.zongziNum = _ctrl.duanWu.worshipZongziNum;
                return;
            }// end function
            ;
                ary = _ctrl.duanWu.worshipList;
                obj = ary[(ary.length - 1)];
                num = Math.pow(10, obj["type"]);
                framNum = 10 * Math.pow(10, obj["type"]);
                if (obj["type"] == 2)
                {
                    framNum;
                }
                info = Lang.sprintf(DuanWuWorshipViewLang.SuccesMessage, HtmlText.yellow(this.zongziType[obj["type"]]), HtmlText.yellow("+" + framNum));
                _view.activities.showWinEffect();
                _view.alert.confirm(info, callBack);
                this.worship_state();
            }
            else
            {
                _view.showTip(this.message(result));
            }
            return;
        }// end function

        private function message(param1:int) : String
        {
            var _loc_2:String = "";
            switch(param1)
            {
                case Mod_DuanWu_Base.FAILED:
                {
                    _loc_2 = DuanWuWorshipViewLang.Failed;
                    break;
                }
                case Mod_DuanWu_Base.NOT_ENOUGH_VIP:
                {
                    _loc_2 = DuanWuWorshipViewLang.NotEnoughVIP;
                    break;
                }
                case Mod_DuanWu_Base.ARG_ERROR:
                {
                    _loc_2 = DuanWuWorshipViewLang.ArgError;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

    }
}
