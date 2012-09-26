package com.views
{
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.interfaces.*;
    import com.haloer.net.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;

    public class TriggerFunctionView extends Base implements IView
    {
        private var _triggerList:Array;
        private var _campWarList:Array;
        public var isFirstCamp:Boolean = false;
        private var _trigger:ITriggerFunction;
        public var onStart:Function;
        private var _light:Class;
        private var _functionOpen:FunctionOpen;
        private var _triggerUrl:Array;
        private var _newTriggerList:Array;

        public function TriggerFunctionView()
        {
            return;
        }// end function

        public function show() : void
        {
            if (this._triggerList == null || this._triggerList.length <= 0)
            {
                return;
            }
            loadAssets("TriggerFunction", this.loadFunctionAssets, TriggerFunctionViewLang.LoadInfo, false, true);
            return;
        }// end function

        private function loadFunctionAssets() : void
        {
            var progress:* = function (param1:int, param2:int) : void
            {
                _view.panelLoading.updatePanelLoading(TriggerFunctionViewLang.LoadInfo, param2);
                return;
            }// end function
            ;
            File.loadList(this._triggerUrl, this.render, progress, null, this.error);
            return;
        }// end function

        private function error(param1:int) : void
        {
            _view.alert.confirm(TriggerFunctionViewLang.LackImage + this._triggerList[param1]);
            return;
        }// end function

        public function triggerList(param1:Array, param2:Boolean = true) : void
        {
            var _loc_3:* = param1.length;
            var _loc_4:* = _loc_3 - 1;
            while (_loc_4 >= 0)
            {
                
                if (param1[_loc_4] == "Stunt")
                {
                    param1.splice(_loc_4, 1);
                }
                if (param1[_loc_4] == FunctionType.CampWar && param2)
                {
                    param1[_loc_4] = FunctionType.CampWar;
                }
                _loc_4 = _loc_4 - 1;
            }
            this.triggerUrl(param1);
            this._triggerList = param1;
            return;
        }// end function

        public function get_war_mode() : void
        {
            if (FunctionType.isOpened(FunctionType.CampWar) == false)
            {
                return;
            }
            this.isFirstCamp = true;
            _data.call(Mod_HeroesWar_Base.get_war_mode, this.getWarModeCallBack, []);
            return;
        }// end function

        private function getWarModeCallBack() : void
        {
            this.isFirstCamp = false;
            _view.activities.getWarModeCallBack();
            var _loc_1:* = _ctrl.heroesWar.getWarMode;
            var _loc_2:* = this._campWarList.length;
            var _loc_3:* = _loc_2 - 1;
            while (_loc_3 >= 0)
            {
                
                if (this._campWarList[_loc_3] == FunctionType.CampWar)
                {
                    this._campWarList[_loc_3] = _loc_1.mode == 0 ? (FunctionType.CampWar) : (FunctionType.HeroesWar);
                }
                _loc_3 = _loc_3 - 1;
            }
            this.triggerList(this._campWarList, false);
            this.show();
            return;
        }// end function

        private function render(param1:Array) : void
        {
            this.loadFunctionBarEffect(param1);
            return;
        }// end function

        public function loadFunctionBarEffect(param1:Array) : void
        {
            var list:* = param1;
            _view.panelLoading.close();
            this.renderTarget(list);
            return;
        }// end function

        private function renderTarget(param1:Array) : void
        {
            var list:* = param1;
            this._trigger = _view.getAssetsObject("TriggerFunction", "TriggerFunction") as ITriggerFunction;
            _structure.alert.addChild(this._trigger.content);
            var newList:* = this.triggerDataRender(list);
            this._trigger.onStart = function () : void
            {
                if (onStart is Function)
                {
                    onStart();
                }
                close();
                return;
            }// end function
            ;
            this._trigger.triggerUrl = URI.triggerUrl;
            this._trigger.newFunction(newList);
            _view.center(sign, this._trigger.content);
            _view.guide.trackPartners(5, this._trigger.content);
            return;
        }// end function

        private function triggerUrl(param1:Array) : void
        {
            var _loc_4:String = null;
            this._triggerUrl = [];
            var _loc_2:* = param1.length;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = URI.triggerUrl + param1[_loc_3] + ".swf";
                this._triggerUrl.push(_loc_4);
                _loc_3++;
            }
            return;
        }// end function

        private function triggerDataRender(param1:Array) : Array
        {
            var _loc_4:Object = null;
            this._newTriggerList = [];
            var _loc_2:* = param1.length;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = {};
                _loc_4.map = (param1[_loc_3] as File).loader;
                _loc_4.sign = this._triggerList[_loc_3];
                this._newTriggerList.push(_loc_4);
                _loc_3++;
            }
            return this._newTriggerList;
        }// end function

        public function isOpenTrigger(param1:String) : Boolean
        {
            if (this._newTriggerList == null)
            {
                return false;
            }
            var _loc_2:* = this._newTriggerList.length;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2)
            {
                
                if (this._newTriggerList[_loc_3].sign == param1)
                {
                    return true;
                }
                _loc_3++;
            }
            return false;
        }// end function

        public function clear() : void
        {
            this._triggerList = [];
            this._trigger.clear();
            return;
        }// end function

        public function close() : void
        {
            this.isFirstCamp = false;
            this.clear();
            _view.cancelCenter(sign);
            _structure.alert.removeChild(this._trigger.content);
            _view.guide.startTrainingGuides();
            return;
        }// end function

    }
}
