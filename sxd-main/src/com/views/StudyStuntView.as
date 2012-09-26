package com.views
{
    import com.assist.*;
    import com.assist.view.interfaces.*;
    import com.assist.view.interfaces.map.*;
    import com.assist.view.map.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;
    import flash.utils.*;

    public class StudyStuntView extends Base implements IView
    {
        private var _studyStunt:IStudyStunt;
        private var _frameSprite:IFrameSprite;
        private var _blnInStudyStunt:Boolean = false;

        public function StudyStuntView()
        {
            return;
        }// end function

        public function show() : void
        {
            if (_view.luckyWheel.isMovie == true)
            {
                return;
            }
            this.loadData();
            return;
        }// end function

        public function close() : void
        {
            this.clear();
            _popup.closeView(this);
            return;
        }// end function

        public function clear() : void
        {
            this._studyStunt.clear();
            if (this._studyStunt.content._Background.contains(this._frameSprite.com.assist.view.interfaces.base:IContent::content))
            {
                this._studyStunt.content._Background.removeChild(this._frameSprite.com.assist.view.interfaces.base:IContent::content);
            }
            this._frameSprite = null;
            this._view.removeFromFrameProcessList(String(this));
            this._view.openEvent();
            return;
        }// end function

        public function reposition(param1:Boolean = true) : void
        {
            if (!inStage)
            {
                return;
            }
            if (param1 == true)
            {
                _view.toolbar.reposition();
            }
            else
            {
                this._studyStunt.reposition(Structure.minStageWidth, Structure.minStageHeight, Structure.maxStageWidth, Structure.maxStageHeight, Structure.stageWidth, Structure.stageHeight);
            }
            return;
        }// end function

        private function loadData() : void
        {
            this.player_stunt_info(this.loadDataCallBack);
            return;
        }// end function

        private function loadDataCallBack() : void
        {
            if (!this._ctrl.studyStunt.isLoadComplete)
            {
                setTimeout(this.loadDataCallBack, 50);
                return;
            }
            loadAssets("StudyStunt", this.render, StudyStuntViewLang.LoadInfo);
            return;
        }// end function

        private function showUI() : void
        {
            _popup.addView(this, this._studyStunt.content);
            this._view.chat.changePoint = 0;
            this._view.chat.updateDepth(this);
            this._view.screen.stopPlayerRun();
            this._view.closeEvent();
            return;
        }// end function

        private function render() : void
        {
            if (this._studyStunt == null)
            {
                this._studyStunt = _view.getAssetsObject("StudyStunt", "StudyStunt") as IStudyStunt;
            }
            this.init();
            this.playerStuntInfoCallBack();
            this.showUI();
            this.reposition(false);
            return;
        }// end function

        private function init() : void
        {
            this._studyStunt.tip = this._view.tip.iTip;
            this._studyStunt.onClose = this.close;
            this._studyStunt.onStudyStunt = this.player_study_stunt;
            this._studyStunt.onReturnTown = this.close;
            this._studyStunt.playerLevel = this._ctrl.player.level;
            this._studyStunt.iconUrl = URI.studyStuntIconUrl;
            this._studyStunt.init();
            if (this._frameSprite == null)
            {
                this._frameSprite = MapStatic.mapInstance.frame;
                this._frameSprite.initUrl(_ctrl.player.playerInfo.sign + _ctrl.player.playerInfo.signSuffix, "seat");
                this._frameSprite.pass(_view.time2);
                this._frameSprite.com.assist.view.interfaces.base:IContent::content.x = 647;
                this._frameSprite.com.assist.view.interfaces.base:IContent::content.y = 412;
                this._studyStunt.content._Background.addChild(this._frameSprite.com.assist.view.interfaces.base:IContent::content);
                this._studyStunt.playerSeat = this._frameSprite.com.assist.view.interfaces.base:IContent::content;
            }
            _view.addToFrameProcessList(String(this), this.enterFrameHandler);
            return;
        }// end function

        private function enterFrameHandler() : void
        {
            if (inStage == false)
            {
                _view.removeFromFrameProcessList(String(this));
                return;
            }
            this._frameSprite.pass(_view.time2);
            return;
        }// end function

        private function player_stunt_info(param1:Function) : void
        {
            _data.call(Mod_StudyStunt_Base.player_stunt_info, param1, []);
            return;
        }// end function

        private function playerStuntInfoCallBack() : void
        {
            var _loc_1:* = this._ctrl.studyStunt.stuntInfo;
            var _loc_2:* = this._ctrl.studyStunt.stuntPointInfo;
            var _loc_3:* = this._ctrl.studyStunt.playerInfo;
            this._studyStunt.renderPlayerStuntInfo(_loc_1, _loc_2, _loc_3);
            return;
        }// end function

        private function player_study_stunt(param1:int, param2:int, param3:String) : void
        {
            var callBack:Function;
            var intStuntId:* = param1;
            var intStuntLevel:* = param2;
            var strTip:* = param3;
            callBack = function () : void
            {
                playerStudyStuntCallBack(strTip);
                return;
            }// end function
            ;
            if (this._blnInStudyStunt)
            {
                return;
            }
            this._blnInStudyStunt = true;
            _data.call(Mod_StudyStunt_Base.player_study_stunt, callBack, [intStuntId, intStuntLevel]);
            return;
        }// end function

        private function playerStudyStuntCallBack(param1:String) : void
        {
            var strTip:* = param1;
            var objStudyStunt:* = this._ctrl.studyStunt.playerStudyStunt;
            if (objStudyStunt["result"] == Mod_StudyStunt_Base.STUDY_SUCCESS)
            {
                var callBack:* = function () : void
            {
                var _loc_1:* = _ctrl.studyStunt.stuntInfo;
                var _loc_2:* = _ctrl.studyStunt.stuntPointInfo;
                var _loc_3:* = _ctrl.studyStunt.playerInfo;
                _studyStunt.renderPlayStudyStunt(_loc_1, _loc_2, _loc_3, strTip);
                _blnInStudyStunt = false;
                return;
            }// end function
            ;
                this.player_stunt_info(callBack);
            }
            else
            {
                _view.showTip(this.message(objStudyStunt["result"]));
                this._blnInStudyStunt = false;
            }
            return;
        }// end function

        private function message(param1:int) : String
        {
            var _loc_2:String = "";
            switch(param1)
            {
                case Mod_StudyStunt_Base.STUDY_SUCCESS:
                {
                    _loc_2 = StudyStuntViewLang.StudySuccess;
                    break;
                }
                case Mod_StudyStunt_Base.NOENOUGH_AURA:
                {
                    _loc_2 = StudyStuntViewLang.NoenoughAura;
                    break;
                }
                case Mod_StudyStunt_Base.INVALID_ELEMENT:
                {
                    _loc_2 = StudyStuntViewLang.InvalidElement;
                    break;
                }
                case Mod_StudyStunt_Base.INVALID_STUNT_LEVEL:
                {
                    _loc_2 = StudyStuntViewLang.InvalidStuntLevel;
                    break;
                }
                case Mod_StudyStunt_Base.INVALID_PLAYER_LEVEL:
                {
                    _loc_2 = StudyStuntViewLang.InvalidPlayerLevel;
                    break;
                }
                case Mod_StudyStunt_Base.INVALID_FUNCTION:
                {
                    _loc_2 = StudyStuntViewLang.InvalidPlayerLevel;
                    break;
                }
                default:
                {
                    _loc_2 = StudyStuntViewLang.Error + param1;
                    break;
                }
            }
            return _loc_2;
        }// end function

    }
}
