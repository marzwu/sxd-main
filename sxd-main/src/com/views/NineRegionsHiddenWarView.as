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

    public class NineRegionsHiddenWarView extends SportWarView
    {
        public var warData:WarData;

        public function NineRegionsHiddenWarView() : void
        {
            _type = WarType.NineRegionsHiddenWar;
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
                _view.showLoading(NineRegionsHiddenWarViewLang.LoadInfo, param3, (param2 + 1), param1);
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

        override protected function addonWarIcon(param1:Array, param2:Array) : void
        {
            param1.push("WarIcon");
            param2.push(URI.mapUrl + "nine_regions_hidden/nine_regions_hidden.png");
            param1.push("Background");
            param2.push(URI.mapUrl + "nine_regions_hidden/nine_regions_hidden.swf");
            param1.push("Aura");
            param2.push(URI.effectsUrl + "aura.swf");
            return;
        }// end function

        override protected function createTarget() : void
        {
            _view.hideLoading();
            _war = _view.getAssetsObject("War", "War") as IWar;
            _war.warData = _warData;
            _war.background = background;
            var _loc_1:* = NineRegionsType.getHiddenInfoById(_ctrl.nineRegions.hiddenLevel);
            var _loc_2:* = _loc_1[1];
            var _loc_3:* = _loc_1[2];
            if (_loc_2 > 0 || _loc_3 > 0)
            {
                _war.sportAwardText = Lang.sprintf(NineRegionsHiddenWarViewLang.Award, _loc_2 > 0 ? (NineRegionsHiddenWarViewLang.fame + HtmlText.green("+" + _loc_2)) : (""), _loc_3 > 0 ? (NineRegionsHiddenWarViewLang.wuhun + HtmlText.green("+" + _loc_3)) : (""));
            }
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
