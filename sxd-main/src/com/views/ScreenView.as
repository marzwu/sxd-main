package com.views
{
    import com.assist.view.interfaces.map.*;
    import com.assist.view.map.*;
    import com.views.map.*;
    import flash.display.*;

    public class ScreenView extends Base implements IView
    {
        private var _screen:Sprite;
        private var _currentMap:MapViewBase;

        public function ScreenView()
        {
            this._screen = new Sprite();
            return;
        }// end function

        public function show() : void
        {
            this.render();
            return;
        }// end function

        private function render() : void
        {
            _view.structure.content.addChild(this._screen);
            _view.toolbar.init();
            this._screen.addChild(_view.toolbar.content);
            this.initMap();
            if (_ctrl.player.bossMapId != 0)
            {
                _view.worldBossMap.gotoBossTown(_ctrl.player.bossMapId);
            }
            else
            {
                _view.townMap.gotoTownAtId(_ctrl.player.jihuisuoId || _ctrl.player.townMapId);
            }
            _view.setting.loadInitSound();
            _view.chooseCamp.loginToChoose();
            _view.activities.show();
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

        public function get display() : Sprite
        {
            return this._screen;
        }// end function

        public function stopPlayerRun() : void
        {
            if (this._currentMap)
            {
                this._currentMap.stopPlayerRun();
            }
            return;
        }// end function

        public function set currentMap(param1:MapViewBase) : void
        {
            if (this._currentMap)
            {
                this._currentMap.clear();
            }
            this._currentMap = param1;
            this._currentMap.clear();
            this._screen.addChildAt(this._currentMap.content, 0);
            return;
        }// end function

        public function get currentMap() : MapViewBase
        {
            return this._currentMap;
        }// end function

        private function initMap() : void
        {
            MapStatic.mapInstance = _view.getAssetsObj("Map").loader.content as IMapInstance;
            _view.townMap.init();
            _view.missionMap.init();
            _view.worldBossMap.init();
            _view.factionWarMap.init();
            _view.furnaceMap.init();
            return;
        }// end function

    }
}
