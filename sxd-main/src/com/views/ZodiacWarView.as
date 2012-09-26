package com.views
{
    import com.*;
    import com.assist.*;
    import com.assist.data.mission.*;
    import com.assist.view.*;
    import com.assist.view.interfaces.*;
    import com.assist.view.war.*;
    import com.lang.client.com.views.*;

    public class ZodiacWarView extends SportWarView
    {
        public var warData:WarData;

        public function ZodiacWarView() : void
        {
            _type = WarType.ZodiacWar;
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
                _view.showLoading(ZodiacWarViewLang.LoadInfo, param3, (param2 + 1), param1);
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
            param2.push(URI.mapUrl + "zodiac/zodiac.png");
            param1.push("Background");
            param2.push(URI.mapUrl + "zodiac/zodiac.swf");
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
            if (_ctrl.zodiac.awardGoldOilName || _ctrl.zodiac.awardAura)
            {
                _war.sportAwardText = Lang.sprintf(ZodiacWarViewLang.Award, _ctrl.zodiac.awardGoldOilName ? (HtmlText.yellow2(_ctrl.zodiac.awardGoldOilName + "+1")) : (""), _ctrl.zodiac.awardAura ? (ZodiacWarViewLang.Aura + HtmlText.green("+" + _ctrl.zodiac.awardAura)) : (""));
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
