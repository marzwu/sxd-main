package com.views
{
    import com.assist.server.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;

    public class MyFlowerRecordView extends Base implements IView
    {
        private var _myFlowerRecord:IMyFlowerRecord;

        public function MyFlowerRecordView()
        {
            return;
        }// end function

        public function show() : void
        {
            if (!FunctionType.isOpened(FunctionType.SendFlower))
            {
                return;
            }
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
            this._myFlowerRecord.clear();
            return;
        }// end function

        private function showUI() : void
        {
            _popup.addView(this, this._myFlowerRecord.content);
            _view.center(sign, this._myFlowerRecord.content);
            return;
        }// end function

        private function render() : void
        {
            var _loc_1:* = this._ctrl.sendFlower.sendFlowerInfo();
            if (_loc_1["result"] == Mod_SendFlower_Base.FUN_OPENED)
            {
                this._view.showTip(this.message(_loc_1["result"]));
                return;
            }
            if (this._myFlowerRecord == null)
            {
                this._myFlowerRecord = _view.getAssetsObject("SendFlower", "MyFlowerRecord") as IMyFlowerRecord;
            }
            this.init();
            this._myFlowerRecord.init();
            this.playerSendFlowerInfoCallBack();
            this.showUI();
            return;
        }// end function

        private function init() : void
        {
            this._myFlowerRecord.tip = this._view.tip.iTip;
            this._myFlowerRecord.drag = this._view.drag.iDrag;
            this._myFlowerRecord.onClose = this.close;
            this._myFlowerRecord.onTextLink = this._view.toolbar.onTextLink;
            this._myFlowerRecord.onQueryFlower = this.send_flower_ranking;
            return;
        }// end function

        private function loadData() : void
        {
            _data.call(Mod_SendFlower_Base.player_send_flower_info, this.loadDataCallBack, [this._ctrl.player.playerId]);
            return;
        }// end function

        private function loadDataCallBack() : void
        {
            loadAssets("SendFlower", this.render, MyFlowerRecordViewLang.LoadInfo);
            return;
        }// end function

        private function playerSendFlowerInfoCallBack() : void
        {
            var _loc_1:* = this._ctrl.sendFlower.sendFlowerInfo();
            if (_loc_1["result"] == Mod_SendFlower_Base.FUN_OPENED)
            {
                this._view.showTip(this.message(_loc_1["result"]));
                return;
            }
            var _loc_2:* = this._ctrl.sendFlower.sendFlowerRecord();
            this._myFlowerRecord.renderMyFlowerRecord(_loc_1, _loc_2);
            return;
        }// end function

        private function send_flower_ranking() : void
        {
            _data.call(Mod_SendFlower_Base.send_flower_ranking, this.sendFlowerRankingCallBack, []);
            return;
        }// end function

        private function sendFlowerRankingCallBack() : void
        {
            var _loc_1:* = this._ctrl.sendFlower.sendFlowerRanking();
            this._myFlowerRecord.renderSendFlowerRanking(_loc_1);
            return;
        }// end function

        private function message(param1:int) : String
        {
            var _loc_2:String = "";
            switch(param1)
            {
                case Mod_SendFlower_Base.SUCCESS:
                {
                    _loc_2 = MyFlowerRecordViewLang.Success;
                    break;
                }
                case Mod_SendFlower_Base.FUN_OPENED:
                {
                    _loc_2 = MyFlowerRecordViewLang.FunOpened;
                    break;
                }
                case Mod_SendFlower_Base.NOT_ENOUGH_INGOT:
                {
                    _loc_2 = MyFlowerRecordViewLang.NotEnoughIngot;
                    break;
                }
                case Mod_SendFlower_Base.NOT_ENOUGH_COIN:
                {
                    _loc_2 = MyFlowerRecordViewLang.NotEnoughCoin;
                    break;
                }
                case Mod_SendFlower_Base.SAME_SEX:
                {
                    _loc_2 = MyFlowerRecordViewLang.SameSex;
                    break;
                }
                case Mod_SendFlower_Base.SEND_SELF:
                {
                    _loc_2 = MyFlowerRecordViewLang.SendSelf;
                    break;
                }
                default:
                {
                    _loc_2 = MyFlowerRecordViewLang.Error + param1;
                    break;
                }
            }
            return _loc_2;
        }// end function

    }
}
