package com.views
{
    import com.assist.view.interfaces.*;
    import flash.display.*;

    public class PanelLoadingView extends Base implements IView
    {
        private var _panelLoading:IPanelLoading;
        private var _hadCallShow:Boolean = false;

        public function PanelLoadingView()
        {
            return;
        }// end function

        public function show() : void
        {
            if (this._hadCallShow)
            {
                return;
            }
            this._hadCallShow = true;
            this._panelLoading = _view.getAssetsObject("PanelLoading", "PanelLoading") as IPanelLoading;
            this._panelLoading.init();
            return;
        }// end function

        public function close() : void
        {
            this.clear();
            if (this.content && this.content.stage)
            {
                this.content.parent.removeChild(this.content);
            }
            _popup.removeMask();
            return;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

        public function updatePanelLoading(param1:String, param2:int, param3:int = 1, param4:int = 1) : void
        {
            _popup.addMask(true);
            _structure.tip.addChild(this.content);
            this.content.x = Structure.stageWidth - this.content.width >> 1;
            this.content.y = Structure.stageHeight - this.content.height >> 1;
            this._panelLoading.setLoadingProgress(param2, param3, param4);
            this._panelLoading.setLoadingText(param1);
            return;
        }// end function

        public function get content() : MovieClip
        {
            return this._panelLoading.content;
        }// end function

    }
}
