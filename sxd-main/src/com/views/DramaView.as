package com.views
{
    import com.assist.*;
    import com.assist.view.info.*;
    import com.assist.view.interfaces.map.*;
    import com.assist.view.map.*;
    import com.protocols.*;
    import flash.display.*;
    import flash.utils.*;

    public class DramaView extends Base
    {
        private var _id:int = 0;
        private var _content:Sprite;
        private var _dramaCache:Array;
        private var _endFun:Function;
        private var _isSee:Boolean;
        private var _toWar:Boolean;
        private var _timeBackMask:int;
        private var _dramaMap:IDramaManage;

        public function DramaView()
        {
            this._content = new Sprite();
            this._dramaCache = [];
            this._content.graphics.beginFill(0, 1);
            this._content.graphics.drawRect(0, 0, 1250, 650);
            this._content.graphics.endFill();
            return;
        }// end function

        override public function get inStage() : Boolean
        {
            return this._content.stage != null;
        }// end function

        public function init(param1:int, param2:String) : void
        {
            var _loc_3:PlayerInfo = null;
            if (this._dramaCache[param1] == null)
            {
                this._dramaCache[param1] = MapStatic.mapInstance.drama;
                _loc_3 = _ctrl.player.playerInfo;
                (this._dramaCache[param1] as IDramaManage).initXMLUrl(param2, _loc_3.sign, _loc_3.signSuffix, _loc_3.name);
            }
            return;
        }// end function

        public function playdrama(param1:int, param2:Function, param3:Boolean, param4:int = 900) : void
        {
            if (this._id != 0)
            {
                return;
            }
            this._isSee = param3;
            this._id = param1;
            this._timeBackMask = param4;
            this._endFun = param2 || new Function();
            this._dramaMap = this._dramaCache[param1] as IDramaManage;
            this._content.addChild(this._dramaMap.content);
            _structure.tip.addChild(this._content);
            this._dramaMap.play(this.dramaEnd, this.dramagropress);
            this._dramaMap.closeVisible = param3;
            MouseCursor.show();
            if (this._content.stage)
            {
                this._content.stage.focus = null;
            }
            _view.chat.chatVisible = false;
            _view.processTip.visible = false;
            _view.screen.display.visible = false;
            return;
        }// end function

        private function dramagropress(param1:String, param2:int, param3:Boolean) : void
        {
            _view.showLoading(param1, 100);
            if (param3)
            {
                _view.panelLoading.close();
            }
            return;
        }// end function

        private function dramaEnd() : void
        {
            this._toWar = this._dramaMap.toWar;
            if (this._isSee == false && this._id < 8388608)
            {
                _data.call(Mod_Mission_Base.sign_play_mission_video, null, [this._id]);
            }
            if (this._toWar == false || this._isSee == true)
            {
                this._dramaMap.actionBackMask();
            }
            else
            {
                this._endFun();
            }
            setTimeout(this.dramaClear, this._timeBackMask);
            return;
        }// end function

        public function get toWar() : Boolean
        {
            return this._toWar;
        }// end function

        public function dramaClear() : void
        {
            if (this._id == 0)
            {
                return;
            }
            delete this._dramaCache[this._id];
            this._id = 0;
            this._dramaMap = null;
            _view.chat.chatVisible = true;
            _view.processTip.visible = true;
            _view.screen.display.visible = true;
            while (this._content.numChildren)
            {
                
                this._content.removeChildAt(0);
            }
            if (this._content.parent)
            {
                this._content.parent.removeChild(this._content);
            }
            if (this._toWar == false || this._isSee == true)
            {
                this._endFun();
            }
            return;
        }// end function

    }
}
