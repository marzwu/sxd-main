package com.views
{
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.controls.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;

    public class BuildSendItemView extends Base implements IView
    {
        private var targetUi:IBuildSendItem;

        public function BuildSendItemView()
        {
            return;
        }// end function

        public function show() : void
        {
            _data.call(Mod_DuanWu_Base.zongzi_state, this.openPanelBack, []);
            return;
        }// end function

        public function get_zongzi_state() : void
        {
            _data.call(Mod_DuanWu_Base.zongzi_state, this.getZongZhiStateCallBack, [], false);
            return;
        }// end function

        private function getZongZhiStateCallBack() : void
        {
            var _loc_4:int = 0;
            var _loc_1:* = _ctrl.duanWu.stateResult;
            var _loc_2:* = _loc_1 == Mod_DuanWu_Base.CAN_GET;
            var _loc_3:Object = {};
            if (_loc_2)
            {
                _loc_3.state = 1;
                _loc_3.info = HtmlText.white(BuildSendItemViewLang.LinQu);
                _loc_3.showEffect = true;
                _loc_4 = TownType.getLock(TownType.getId(TownType.ShuShanCheng));
                if (_ctrl.player.townKey < _loc_4)
                {
                    _loc_3.state = 2;
                    _loc_3.info = HtmlText.format(BuildSendItemViewLang.ShuShan, 10066329);
                    _loc_3.showEffect = false;
                }
            }
            else
            {
                if (_loc_1 == Mod_DuanWu_Base.CAN_NOT_GET)
                {
                    _loc_3.info = HtmlText.format(BuildSendItemViewLang.YiLinQu, 10066329);
                }
                else
                {
                    _loc_3.info = HtmlText.format(BuildSendItemViewLang.WeiKaiQi, 10066329);
                }
                _loc_3.state = 2;
                _loc_3.showEffect = false;
            }
            _view.activityDuanWu.zhongZhiState(_loc_3);
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

        public function openPanelBack() : void
        {
            loadAssets("BuildSendItem", null, BuildSendItemViewLang.LoadingInfo, false, false, this.loadComplete);
            return;
        }// end function

        private function loadComplete() : void
        {
            if (!this.targetUi)
            {
                this.targetUi = _view.getAssetsObject("BuildSendItem", "McBuildDialog") as IBuildSendItem;
                this.targetUi.getItemFun(this.onGetItem);
                this.targetUi.onClose(this.onClose);
            }
            if (!inStage)
            {
                _popup.addView(this, this.targetUi.content);
                _view.center(sign, this.targetUi.content);
            }
            this.targetUi.bCanGet = _ctrl.duanWu.stateResult == Mod_DuanWu_Base.CAN_GET;
            return;
        }// end function

        public function onGetItem() : void
        {
            if (_view.ctrl.player.packNum <= 0)
            {
                _view.showTip(BuildSendItemViewLang.PackFull);
                return;
            }
            _data.call(Mod_DuanWu_Base.get_zongzi, this.getItemBack, []);
            return;
        }// end function

        private function getItemBack() : void
        {
            switch(_ctrl.duanWu.getItemResult)
            {
                case Mod_DuanWu_Base.SUCCESS:
                {
                    this.get_zongzi_state();
                    _view.showTip(BuildSendItemViewLang.GetSecess, null, TipType.Success);
                    break;
                }
                case Mod_DuanWu_Base.FAILED:
                {
                    _view.showTip(BuildSendItemViewLang.GetFails);
                    break;
                }
                case Mod_DuanWu_Base.PACK_FULL:
                {
                    _view.showTip(BuildSendItemViewLang.PackFull);
                    break;
                }
                case Mod_DuanWu_Base.TIME_ERROR:
                {
                    _view.showTip(BuildSendItemViewLang.TIME_ERROR);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function onClose() : void
        {
            _popup.closeView(this);
            return;
        }// end function

    }
}
