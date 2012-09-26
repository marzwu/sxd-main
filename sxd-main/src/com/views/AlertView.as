package com.views
{
    import com.assist.*;
    import com.assist.view.controls.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;

    public class AlertView extends Base implements IView
    {
        private var _alert:IAlert;

        public function AlertView()
        {
            return;
        }// end function

        public function show() : void
        {
            var _loc_1:uint = 0;
            this.iAlert.yesLabel = "是";
            this.iAlert.noLabel = "否";
            this.iAlert.cancelLabel = "取消";
            this.iAlert.yesLabelTip = "四十四";
            this.iAlert.yesEnabled = false;
            this.iAlert.hasCheckbox = true;
            _loc_1 = AlertButtonType.Yes | AlertButtonType.No | AlertButtonType.Cancel;
            this.iAlert.show("测试", _loc_1, this.onCloseHandler);
            return;
        }// end function

        private function onCloseHandler(param1:uint) : void
        {
            Helper.output("onCloseHandler", this.iAlert.checked);
            switch(param1)
            {
                case AlertButtonType.Yes:
                {
                    break;
                }
                case AlertButtonType.No:
                {
                    break;
                }
                case AlertButtonType.Cancel:
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            this.iAlert.show("测试1", param1, null);
            return;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

        public function close() : void
        {
            if (this._alert)
            {
                this._alert.hide();
            }
            return;
        }// end function

        public function hide() : void
        {
            if (this.iAlert)
            {
                this.iAlert.hide();
            }
            return;
        }// end function

        public function reposition() : void
        {
            if (this._alert)
            {
                this._alert.reposition(Structure.minStageWidth, Structure.minStageHeight, Structure.maxStageWidth, Structure.maxStageHeight);
            }
            return;
        }// end function

        public function confirm(param1:String, param2:Function = null) : void
        {
            this.iAlert.yesLabel = AlertViewLang.Confirm;
            this.iAlert.show(param1, AlertButtonType.Yes, param2);
            return;
        }// end function

        public function showYesNoMsg(param1:String, param2:String = "确定", param3:String = "取消", param4:Function = null) : void
        {
            this.iAlert.yesLabel = param2;
            this.iAlert.noLabel = param3;
            this.iAlert.show(param1, AlertButtonType.Yes | AlertButtonType.No, param4);
            return;
        }// end function

        public function socketClosed(param1:String = "", param2:String = "") : void
        {
            var reason:* = param1;
            var reason2:* = param2;
            try
            {
                this.iAlert.yesLabel = AlertViewLang.Confirm;
                this.iAlert.show(reason || AlertViewLang.Closed, AlertButtonType.Yes);
            }
            catch (e)
            {
                Helper.alert(reason2 || AlertViewLang.Fault);
            }
            return;
        }// end function

        public function get iAlert() : IAlert
        {
            if (!this._alert)
            {
                this._alert = _view.getAssetsObject("Alert", "oAlert") as IAlert;
                this._alert.oParent = _structure.alert;
                this._alert.tip = _view.tip.iTip;
                this.reposition();
            }
            return this._alert;
        }// end function

        override public function get inStage() : Boolean
        {
            return this._alert && this._alert.content.parent;
        }// end function

    }
}
