package com.views
{
    import com.assist.*;
    import com.assist.server.*;
    import com.assist.view.interfaces.*;
    import com.assist.view.interfaces.map.*;
    import com.assist.view.map.*;
    import com.haloer.net.*;
    import com.lang.client.com.views.*;
    import flash.display.*;
    import flash.utils.*;

    public class NewWorldView extends Base implements IView
    {
        private var _world:INewWorld;
        private var _autoList:Array;
        private var _cloudMc:MovieClip;
        public var firstUse:Boolean;
        private var _frameSprite:IWorldFrame;
        private var _travelEventInfo:Object;
        public var endTownId:int = 0;

        public function NewWorldView()
        {
            this._autoList = [];
            return;
        }// end function

        public function show() : void
        {
            if (_view.luckyWheel.isMovie == true)
            {
                return;
            }
            if (_view.campWar.inStageWithTip)
            {
                return;
            }
            if (_view.heroesWar.inStageWithTip)
            {
                return;
            }
            if (_view.missionPractice.inStageWithTip)
            {
                return;
            }
            if (_view.multiMission.inStageWithTip)
            {
                return;
            }
            if (_view.heroPractice.inStageWithTip)
            {
                return;
            }
            if (_view.zodiac.inStageWithTip)
            {
                return;
            }
            _view.closeEvent();
            _view.screen.stopPlayerRun();
            if (!this._cloudMc)
            {
                this.loadCloud();
            }
            else
            {
                loadAssets("NewWorld", this.render, NewWorldViewLang.LoadAssets);
            }
            return;
        }// end function

        private function loadCloud() : void
        {
            var res:Array;
            res = new Array();
            res.push(URI.addonsUrl + "cloud_for_change.swf");
            var errorHandler:* = function (param1:int) : void
            {
                var _loc_2:* = param1 == (res.length - 1) ? ("Can not find MiniMap") : ("Can not find:" + res[param1].replace(/^[\s\S]+\/""^[\s\S]+\//, ""));
                _view.alert.confirm(_loc_2);
                return;
            }// end function
            ;
            var oneComplete:* = function (param1:int, param2:Boolean) : void
            {
                return;
            }// end function
            ;
            File.loadList(res, this.loadCloudBack, this.showProgress, oneComplete, errorHandler);
            return;
        }// end function

        private function loadCloudBack(param1:Array) : void
        {
            var _loc_2:* = param1.pop();
            this._cloudMc = _loc_2.getClassObject("CloudForChange") as MovieClip;
            loadAssets("NewWorld", this.render, NewWorldViewLang.LoadAssets);
            return;
        }// end function

        protected function showProgress(param1:int, param2:int, param3:int, param4:String) : void
        {
            _view.initLoading.loading(param2 + "", param3, param2, param1, param4);
            return;
        }// end function

        private function render() : void
        {
            var townId:int;
            var item:String;
            var sign:String;
            this._world = _view.getAssetsObject("NewWorld", "NewWorld") as INewWorld;
            _popup.addView(this, this._world.content);
            this._world.tip = _view.tip.iTip;
            this._world.alert = _view.alert.iAlert;
            this._world.logoVisible = URI.isBaidu == false && URI.isMangguo == false;
            if (this.firstUse)
            {
                townId = TownType.getId(TownType.WoLongCheng);
            }
            else
            {
                townId = _ctrl.player.mapId;
            }
            if (TownType.isTownById(townId) == false)
            {
                if (_ctrl.player.townMapId)
                {
                    townId = _ctrl.player.townMapId;
                }
                else
                {
                    townId = TownType.getId(TownType.WoLongCheng);
                }
            }
            var townSign:* = TownType.getSign(townId);
            if (townId <= TownType.MaxOldMap)
            {
                townSign;
            }
            this._world.defaultTown = townSign;
            if (townSign == "")
            {
                this._world.defaultTown = "Door";
            }
            this._world.townInfo = TownType.getOpenedTownInfo();
            var towns:* = TownType.getNewOpenedTownSigns();
            if (towns.indexOf(townSign) == -1 && townSign != "")
            {
                towns.push(townSign);
            }
            var _loc_2:int = 0;
            var _loc_3:* = this._autoList;
            while (_loc_3 in _loc_2)
            {
                
                item = _loc_3[_loc_2];
                if (towns.indexOf(item) == -1 && item != "" && item != "Door")
                {
                    towns.push(item);
                }
            }
            this._world.townOpened = towns;
            this._world.townAllowed = towns;
            this._world.onArrive = function (param1:String) : void
            {
                var endTownSign:* = param1;
                _autoList = [];
                endTownId = TownType.getId(endTownSign);
                if (endTownId == 0)
                {
                    setTimeout(function () : void
                {
                    close();
                    _view.world.show();
                    _view.world.showTarget();
                    return;
                }// end function
                , 800);
                    _cloudMc.gotoAndPlay(1);
                    _view.structure.tip.addChild(_cloudMc);
                    _world.hiddenThis();
                }
                else
                {
                    close();
                    _view.townMap.gotoTownAtId(endTownId);
                }
                return;
            }// end function
            ;
            this._world.onTownClick = function () : void
            {
                _view.quest.haltWayFinding();
                return;
            }// end function
            ;
            this._world.onClose = function () : void
            {
                close();
                return;
            }// end function
            ;
            sign = _ctrl.player.playerInfo.sign + _ctrl.player.playerInfo.signSuffix;
            if (this._frameSprite == null)
            {
                this._frameSprite = (MapStatic.mapInstance as IMapInstance).worldFrame;
                this._frameSprite.playerInfo = _ctrl.player.playerInfo;
            }
            this._world.playerPosition(sign, this._frameSprite);
            if (this._autoList.length > 1)
            {
                this._world.autoTown(this._autoList);
            }
            this.reposition();
            return;
        }// end function

        public function showTarget() : void
        {
            if (this._world)
            {
            }
            return;
        }// end function

        public function reposition(param1:Boolean = true) : void
        {
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
                this._world.reposition(Structure.minStageWidth, Structure.minStageHeight, Structure.maxStageWidth, Structure.maxStageHeight, Structure.stageClip);
            }
            return;
        }// end function

        public function autoEnterTown(param1:int, param2:int) : void
        {
            var _loc_3:* = TownType.getSign(param1);
            var _loc_4:* = TownType.getSign(param2);
            if (_loc_3 == "")
            {
                _loc_3 = "Door";
            }
            if (_loc_4 == "")
            {
                _loc_4 = "Door";
            }
            this._autoList = [_loc_3, _loc_4];
            if (param1 == 0 && param2 == 0)
            {
                this._autoList.length = 0;
            }
            return;
        }// end function

        public function close() : void
        {
            this.clear();
            if (this._world != null)
            {
                this._world.close();
            }
            _popup.closeView(this);
            _view.openEvent();
            this.firstUse = false;
            return;
        }// end function

        public function clear() : void
        {
            if (_view.travelEvent.inStage)
            {
                _view.travelEvent.close();
            }
            return;
        }// end function

    }
}
