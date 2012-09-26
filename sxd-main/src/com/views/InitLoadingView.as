package com.views
{
    import com.*;
    import com.assist.*;
    import com.assist.view.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import flash.utils.*;

    public class InitLoadingView extends Base implements IView
    {
        private var _il:IInitLoading;
        private var _limitForLogo:int = 2;
        private var _toolbarLoaded:Boolean = false;
        private var _toolbarHandler:Function;

        public function InitLoadingView()
        {
            return;
        }// end function

        public function show() : void
        {
            var _loc_1:String = this;
            _loc_1._limitForLogo = this._limitForLogo - 1;
            if (this._limitForLogo-- == 0)
            {
                this._il.content.gotoAndStop(2);
            }
            if (this._limitForLogo < -1)
            {
                this._limitForLogo = -1;
            }
            this.render();
            return;
        }// end function

        public function get logoSuffix() : String
        {
            var _loc_1:String = "";
            if (URI.isBaidu || URI.isPlatformB)
            {
                _loc_1 = "Baidu";
            }
            else if (URI.isMangguo)
            {
                _loc_1 = "Mangguo";
            }
            return _loc_1;
        }// end function

        private function render() : void
        {
            if (this._il == null)
            {
                this._il = _view.getAssetsObject("InitLoading" + this.logoSuffix, "InitLoading") as IInitLoading;
                this._il.tip = InitLoadingViewLang.Tip;
            }
            _popup.addView(this, this._il.content);
            this.loading("");
            _view.closeEvent();
            return;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

        public function close() : void
        {
            this.reposition(false);
            this.clear();
            _popup.closeView(this);
            _view.openEvent();
            return;
        }// end function

        public function loadChooseRole() : void
        {
            var callback:* = function () : void
            {
                _view.chooseRoles.show();
                close();
                backendLoadToolbar();
                return;
            }// end function
            ;
            this.loadResources(["ChooseRoles"], callback);
            return;
        }// end function

        public function loadToolbar() : void
        {
            if (_view.login.first == false)
            {
                this.loadToolbar1(this.get_player_info);
            }
            else if (this._toolbarLoaded == true)
            {
                this.get_player_info();
            }
            else
            {
                this._toolbarHandler = this.get_player_info;
            }
            if (inStage == false)
            {
                this.render();
            }
            return;
        }// end function

        public function backendLoadToolbar() : void
        {
            var callback:* = function () : void
            {
                if (_toolbarHandler is Function)
                {
                    _toolbarHandler();
                }
                _toolbarLoaded = true;
                return;
            }// end function
            ;
            this.loadToolbar1(callback);
            return;
        }// end function

        private function loadToolbar1(param1:Function) : void
        {
            this.loadResources(["Toolbar", "PanelLoading", "DelayMessage", "Map", "Chat", "Templet", "WorldNotice"], param1);
            return;
        }// end function

        public function get_player_info() : void
        {
            Helper.backtrace("Mod_Player_Base.get_player_info, 1");
            _view.formatServerData();
            _data.call(Mod_Player_Base.get_player_info, this.getPlayerInfoCallback, []);
            return;
        }// end function

        private function getPlayerInfoCallback() : void
        {
            Helper.backtrace("Mod_Player_Base.get_player_info, 0");
            setTimeout(this.jiekou_test, 60000);
            setTimeout(this.jiekou_test, 300000);
            setTimeout(this.jiekou_test, 600000);
            _view.afterGetPlayerInfo();
            return;
        }// end function

        public function jiekou_test() : void
        {
            this._data.call(Mod_Player_Base.jiekou_test, null, []);
            return;
        }// end function

        private function loadResources(param1:Array, param2:Function) : void
        {
            var _loc_3:* = new LoadResponder(param2, this.loading);
            _view.loadResources(param1, _loc_3);
            return;
        }// end function

        public function loading(param1:String, param2:int = 0, param3:int = 0, param4:int = 1, param5:String = "") : void
        {
            var _loc_6:* = Lang.sprintf(InitLoadingViewLang.Loading, (param3 + 1), param4, param2, param5);
            this.loading1(_loc_6, param2);
            return;
        }// end function

        public function loading1(param1:String, param2:int = 100) : void
        {
            this._il.render(param1, param2);
            this.reposition(false);
            return;
        }// end function

        public function reposition(param1:Boolean = true) : void
        {
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            if (inStage == false)
            {
                return;
            }
            if (param1 == true)
            {
                _view.toolbar.reposition();
            }
            else
            {
                _loc_2 = Structure.stageWidth;
                _loc_3 = Structure.stageHeight;
                this._il.content.x = (_loc_2 - this._il.content.width) / 2;
                this._il.content.y = (_loc_3 - this._il.content.height) / 2;
            }
            _structure.reposition();
            return;
        }// end function

        public function set tip(param1:String) : void
        {
            this._il.tip = param1;
            return;
        }// end function

    }
}
