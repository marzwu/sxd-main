package com.views
{
    import com.assist.view.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import flash.display.*;

    public class FurnaceRoleDialogView extends Base implements IView
    {
        private var _roleDialog:IFuranceRoleDialog;
        private var _speakRoleId:int;
        private var _lastFav:int;
        private var _roleType:Boolean;

        public function FurnaceRoleDialogView()
        {
            return;
        }// end function

        public function show() : void
        {
            return;
        }// end function

        public function close() : void
        {
            return;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

        public function onRoleSpeak(param1:int, param2:Boolean = false) : void
        {
            this._speakRoleId = param1;
            loadAssets("Furnace", null, FurnaceMapViewLang.LoadRoleSpeak, false, false, this.roleSpeakLoadComplete);
            return;
        }// end function

        private function roleSpeakLoadComplete() : void
        {
            var _loc_1:MovieClip = null;
            if (!this._roleDialog)
            {
                this._roleDialog = _view.getAssetsObject("Furnace", "FuranceRoleDialog") as IFuranceRoleDialog;
                this._roleDialog.onOpenSend(this.onOpenSend);
                this._roleDialog.onClose(this.onCloseWindow);
                this._roleDialog.onSendItem(this.onSendItem);
                this._roleDialog.onLevelUp(this.onLevelUp);
                this._roleDialog.onTip = this.onTip;
                _view.drag.iDrag.addTarget(this._roleDialog.dragTitleBar, this._roleDialog.content);
                _loc_1 = _view.getAssetsObject("Furnace", "McLevel") as MovieClip;
                _view.furnaceMap.setLevelUpMc(_loc_1);
            }
            this._roleDialog.openDialog(_view.furnaceMap.getInfoByRoleId(this._speakRoleId));
            _popup.addView(this, this._roleDialog.content);
            return;
        }// end function

        private function onOpenSend(param1:int) : void
        {
            this._speakRoleId = param1;
            var _loc_2:* = _view.furnaceMap.getInfoByRoleId(this._speakRoleId);
            this._lastFav = _loc_2.have_amount;
            _data.call(Mod_Item_Base.get_the_item_num, this.getItemNumBack, [_loc_2.itemId]);
            return;
        }// end function

        private function getItemNumBack() : void
        {
            var _loc_1:* = _ctrl.item.getTheItemNum["total_num"];
            this._roleDialog.openSendItem(_view.furnaceMap.getInfoByRoleId(this._speakRoleId), _loc_1);
            _popup.addView(this, this._roleDialog.content);
            return;
        }// end function

        private function onCloseWindow() : void
        {
            _popup.closeView(this);
            return;
        }// end function

        private function onSendItem(param1:int) : void
        {
            _data.call(Mod_Furnace_Base.submit_favor_item, this.sendItemBack, [param1]);
            return;
        }// end function

        private function sendItemBack() : void
        {
            var _loc_2:int = 0;
            var _loc_3:TextAnimation = null;
            var _loc_1:* = _view.furnaceMap.getInfoByRoleId(_ctrl.furnaceMap.opRoleId);
            if (_ctrl.furnaceMap.result == Mod_Furnace_Base.SUBMIT_SUCCESS)
            {
                --_ctrl.item.getTheItemNum["total_num"];
                _loc_2 = _ctrl.item.getTheItemNum["total_num"] - 1;
                this._roleDialog.openSendItem(_loc_1, _loc_2);
                _view.furnaceMap.updateFav(_ctrl.furnaceMap.opRoleId, _loc_1.have_amount);
                _loc_3 = new TextAnimation();
                _loc_3.color = HtmlText.Green;
                _loc_3.textInfo = "+" + (_loc_1.have_amount - this._lastFav) + " " + FurnaceMapViewLang.Fav_Catoon;
                _loc_3.size = 20;
                _loc_3.speed = -1;
                _loc_3.bold = true;
                _loc_3.point(270, 235);
                _loc_3.startAlphaNum = 30;
                _loc_3.target = this._roleDialog.content;
                _loc_3.start();
                this._lastFav = _loc_1.have_amount;
            }
            else
            {
                this._roleDialog.openSendItem(_loc_1, _ctrl.item.getTheItemNum["total_num"]);
            }
            return;
        }// end function

        private function onLevelUp(param1:int) : void
        {
            _data.call(Mod_Furnace_Base.role_level_up, this.levelBack, [param1]);
            return;
        }// end function

        private function levelBack() : void
        {
            _view.furnaceMap.changeRole(_ctrl.furnaceMap.opRoleId);
            _popup.closeView(this);
            return;
        }// end function

        private function onTip(param1:DisplayObject, param2 = null) : void
        {
            var _loc_3:Sprite = null;
            if (param2 == "" || param2 == null)
            {
                _view.tip.iTip.removeTarget(param1);
            }
            else
            {
                _view.tip.iTip.addTarget(param1, param2);
                _loc_3 = param1 as Sprite;
            }
            return;
        }// end function

    }
}
