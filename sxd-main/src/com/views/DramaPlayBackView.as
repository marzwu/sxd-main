package com.views
{
    import com.assist.server.*;
    import com.assist.view.interfaces.map.*;
    import com.lang.client.com.views.*;
    import com.views.drama.*;

    final public class DramaPlayBackView extends Base implements IView
    {
        private var _target:IDramaPlayBack;
        private var _seeId:int = 100000;

        public function DramaPlayBackView()
        {
            return;
        }// end function

        public function show() : void
        {
            if (_view.luckyWheel.isMovie)
            {
                return;
            }
            loadAssets("DramaPlayBack", this.loadComplete, DramaPlayBackViewLang.LoadAssets);
            return;
        }// end function

        public function close() : void
        {
            _popup.closeView(this);
            return;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

        private function loadComplete() : void
        {
            if (this._target == null)
            {
                this._target = _view.getAssetsObj("DramaPlayBack").loader.content as IDramaPlayBack;
                this._target.onClose = this.close;
                this._target.onSelect = this.onSelect;
                _view.drag.iDrag.addTarget(this._target.dragTitleBar, this._target.content);
            }
            if (inStage == false)
            {
                _popup.addView(this, this._target.content);
            }
            this._target.initData(TownType.isOpenedByTownId, MissionType.isOpenedByMissionId, DramaXml.dataXML);
            return;
        }// end function

        public function onSelect(param1:XML, param2:Function = null) : void
        {
            _view.drama.init(this._seeId, param1.@uri);
            var _loc_3:String = this;
            _loc_3._seeId = this._seeId + 1;
            _view.drama.playdrama(this._seeId++, param2, true);
            return;
        }// end function

        public function dramaPlay(param1:String, param2:Function = null, param3:Boolean = true) : void
        {
            _view.drama.init(this._seeId, param1);
            var _loc_4:String = this;
            _loc_4._seeId = this._seeId + 1;
            _view.drama.playdrama(this._seeId++, param2, param3);
            return;
        }// end function

    }
}
