package com.views
{
    import com.*;
    import com.assist.*;
    import com.assist.data.mission.*;
    import com.assist.server.*;
    import com.assist.view.*;
    import com.assist.view.interfaces.*;
    import com.assist.view.war.*;
    import com.lang.client.com.views.*;

    public class NineRegionsWarView extends SportWarView
    {
        public var warData:WarData;
        public var NineId:int = 1;
        public var NineLevel:int = 1;
        public var IsFirst:Boolean = false;

        public function NineRegionsWarView() : void
        {
            _type = WarType.NineRegionsWar;
            return;
        }// end function

        override public function show() : void
        {
            if (_view.campWar.inStageWithTip)
            {
                return;
            }
            if (_view.heroesWar.inStageWithTip)
            {
                return;
            }
            super.show();
            return;
        }// end function

        override protected function start() : void
        {
            onProgress = function (param1:int, param2:int, param3:int, param4:String) : void
            {
                _view.showLoading(NineRegionsWarViewLang.LoadInfo, param3, (param2 + 1), param1);
                return;
            }// end function
            ;
            loadResources();
            return;
        }// end function

        override protected function loadRoleResource() : void
        {
            _warData = this.warData;
            super.loadRoleResource();
            return;
        }// end function

        override protected function getStudyStuntPlayerIds() : Array
        {
            var _loc_5:int = 0;
            var _loc_1:* = _ctrl.nineRegions.playerIdList;
            var _loc_2:Array = [];
            var _loc_3:* = _loc_1.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = _loc_1[_loc_4];
                _loc_2.push([_loc_5]);
                _loc_4++;
            }
            return _loc_2;
        }// end function

        override protected function addonWarIcon(param1:Array, param2:Array) : void
        {
            param1.push("WarIcon");
            param2.push(URI.mapUrl + "nine_regions/nine_regions.png");
            param1.push("Background");
            param2.push(URI.mapUrl + "nine_regions/nine_regions" + this.NineId + ".swf");
            param1.push("Aura");
            param2.push(URI.effectsUrl + "aura.swf");
            return;
        }// end function

        override protected function createTarget() : void
        {
            var _loc_2:Array = null;
            var _loc_3:Array = null;
            var _loc_4:int = 0;
            var _loc_5:int = 0;
            _view.hideLoading();
            _war = _view.getAssetsObject("War", "War") as IWar;
            _war.warData = _warData;
            _war.background = background;
            _war.sportAwardText = "";
            _war.equitData = _ctrl.nineRegions.equitData;
            var _loc_1:String = "";
            if (!this.IsFirst)
            {
                _loc_1 = NineRegionsWarViewLang.End;
            }
            else
            {
                _loc_2 = NineRegionsType.getAward(this.NineId, this.NineLevel);
                _loc_3 = [];
                _loc_4 = _loc_2[0];
                _loc_5 = _loc_2[1];
                if (_loc_4 > 0)
                {
                    _loc_3.push(HtmlText.green(NineRegionsWarViewLang.Fram + "+" + _loc_4));
                }
                if (_loc_5 > 0)
                {
                    _loc_3.push(HtmlText.green(NineRegionsWarViewLang.Coin + "+" + NineRegionsType.coinsString(_loc_5)));
                }
                if (this.NineLevel == NineRegionsType.MaxLevel)
                {
                    _loc_3.push(NineRegionsWarViewLang.Open + HtmlText.yellow(NineRegionsType.getBlessNameByIdx(this.NineId)));
                }
                _loc_1 = Lang.sprintf(NineRegionsWarViewLang.AwardInfo, _loc_3.join(" "));
            }
            _war.sportAwardText = _loc_1;
            return;
        }// end function

        override protected function onCloseHandler(param1:Boolean) : void
        {
            clearRoles();
            closeWar();
            if (onClose is Function)
            {
                onClose(param1);
            }
            return;
        }// end function

    }
}
