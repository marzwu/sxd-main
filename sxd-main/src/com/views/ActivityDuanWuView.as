package com.views
{
    import com.assist.server.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;

    public class ActivityDuanWuView extends Base implements IView
    {
        private var _activityDuanWu:IActivityDuanWu;
        private var _inStage:Boolean = false;
        private var _caiQuanData:Object;
        private var _quYuanData:Object;
        private var _zhongZhiData:Object;

        public function ActivityDuanWuView()
        {
            return;
        }// end function

        public function duanWuActivity() : void
        {
            return;
        }// end function

        public function show() : void
        {
            loadAssets("ActivityDuanWu", this.render, ActivityDuanWuViewLang.LoadAssets);
            return;
        }// end function

        private function render() : void
        {
            if (this._activityDuanWu == null)
            {
                this._activityDuanWu = _view.getAssetsObject("ActivityDuanWu", "ActivityDuanWu") as IActivityDuanWu;
                this._activityDuanWu.tip = _view.tip.iTip;
                this._activityDuanWu.drag = _view.drag.iDrag;
            }
            _popup.addView(this, this._activityDuanWu.content);
            _view.center(sign, this._activityDuanWu.content);
            this._activityDuanWu.onCaiQuan = function () : void
            {
                if (_view.ctrl.player.packNum <= 0)
                {
                    _view.showTip(ActivityDuanWuViewLang.PackFull);
                    return;
                }
                _view.fingerGuess.enter_room();
                return;
            }// end function
            ;
            this._activityDuanWu.onQuYuan = function () : void
            {
                _view.duanWuWorship.show();
                return;
            }// end function
            ;
            this._activityDuanWu.onZhongzi = function () : void
            {
                if (_view.ctrl.player.packNum <= 0)
                {
                    _view.showTip(ActivityDuanWuViewLang.PackFull);
                    return;
                }
                close();
                _view.townMap.moveToBuild(TownType.getTownIdByLock(_ctrl.player.townKey), 7);
                return;
            }// end function
            ;
            this._activityDuanWu.onClose = function () : void
            {
                close();
                return;
            }// end function
            ;
            _view.buildSendItem.get_zongzi_state();
            _view.duanWuWorship.worship_state();
            this.caiQuanState(this._caiQuanData);
            return;
        }// end function

        public function caiQuanState(param1:Object) : void
        {
            this._caiQuanData = param1;
            if (this.inStage == false || param1 == null)
            {
                return;
            }
            this._activityDuanWu.caiQuanState(param1);
            return;
        }// end function

        public function quYuanState(param1:Object) : void
        {
            this._quYuanData = param1;
            if (this.inStage == false || param1 == null)
            {
                return;
            }
            this._activityDuanWu.quYuanState(param1);
            return;
        }// end function

        public function zhongZhiState(param1:Object) : void
        {
            this._zhongZhiData = param1;
            if (this.inStage == false || param1 == null)
            {
                return;
            }
            this._activityDuanWu.zhongZhiState(param1);
            return;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

        public function close() : void
        {
            _popup.closeView(this);
            return;
        }// end function

    }
}
