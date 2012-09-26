package com.views
{
    import com.adobe.serialization.json.*;
    import com.assist.*;
    import com.assist.view.interfaces.*;
    import com.lang.client.com.views.*;
    import flash.events.*;
    import flash.net.*;

    public class GameMasterView extends Base implements IView
    {
        private var _gm:IGameMaster;
        private const MAX_SUBMIT_TIMES:int = 5;
        private var _loaderSubmitBug:URLLoader;
        private var _loaderGetBugList:URLLoader;
        private var _loaderSubmitAssess:URLLoader;
        private var _canGetBugList:Boolean = true;
        private var _intOpenPanel:int = 1;
        private var _intAssessId:int = 0;

        public function GameMasterView()
        {
            this._loaderSubmitBug = new URLLoader();
            this._loaderGetBugList = new URLLoader();
            this._loaderSubmitAssess = new URLLoader();
            return;
        }// end function

        private function submit_bug(param1:int, param2:String, param3:int) : void
        {
            var _loc_5:URLVariables = null;
            var _loc_6:URLRequest = null;
            var _loc_4:* = this.wordsLimit(param2);
            if (this.wordsLimit(param2))
            {
                param3 = 4;
            }
            if (param3 == 0)
            {
                _loc_5 = new URLVariables();
                _loc_5.username = this._ctrl.player.nickname + URI.nickNameSuffix();
                _loc_5.contents = param2;
                _loc_5.type = param1;
                _loc_5.time = this._ctrl.player.serverTime;
                _loc_5.webdomain = URI.serverName;
                _loc_5.user = URI.playerName;
                _loc_5.times = URI.time;
                _loc_5.sign = URI.hashCode;
                _loc_6 = new URLRequest();
                _loc_6.data = _loc_5;
                _loc_6.url = URI.bugUrl;
                this._loaderSubmitBug.load(_loc_6);
            }
            else if (param3 == 1)
            {
                _view.showTip(GameMasterViewLang.Prompts, GameMasterViewLang.TooLong);
            }
            else if (param3 == 2)
            {
                _view.showTip(GameMasterViewLang.Prompts, GameMasterViewLang.NoNull);
            }
            else if (param3 == 3)
            {
                _view.showTip(GameMasterViewLang.Prompts, GameMasterViewLang.UpperLimit);
            }
            else if (param3 == 4)
            {
                _view.showTip(GameMasterViewLang.Prompts, GameMasterViewLang.Error1);
            }
            return;
        }// end function

        public function wordsLimit(param1:String) : Boolean
        {
            var _loc_6:String = null;
            var _loc_2:* = param1.length;
            var _loc_3:String = "";
            var _loc_4:Boolean = false;
            var _loc_5:int = 0;
            while (_loc_5 < _loc_2)
            {
                
                _loc_6 = param1.charAt(_loc_5);
                if (_loc_6 != " " && _loc_6 != "　")
                {
                    _loc_3 = _loc_3 + _loc_6;
                }
                _loc_5++;
            }
            _loc_4 = /"法轮功""法轮�?/g.test(_loc_3);
            return _loc_4;
        }// end function

        private function get_bug_list() : void
        {
            if (!this._canGetBugList)
            {
                return;
            }
            this._canGetBugList = false;
            var _loc_1:* = new URLVariables();
            _loc_1.username = this._ctrl.player.nickname + URI.nickNameSuffix();
            _loc_1.time = this._ctrl.player.serverTime;
            _loc_1.webdomain = URI.serverName;
            _loc_1.user = URI.playerName;
            _loc_1.times = URI.time;
            _loc_1.sign = URI.hashCode;
            var _loc_2:* = new URLRequest();
            _loc_2.url = URI.bugListUrl;
            _loc_2.data = _loc_1;
            this._loaderGetBugList.load(_loc_2);
            return;
        }// end function

        private function submit_assess(param1:int, param2:int) : void
        {
            this._intAssessId = param1;
            var _loc_3:* = new URLVariables();
            _loc_3.username = this._ctrl.player.nickname + URI.nickNameSuffix();
            _loc_3.id = param1;
            _loc_3.type = param2;
            _loc_3.webdomain = URI.serverName;
            _loc_3.user = URI.playerName;
            _loc_3.times = URI.time;
            _loc_3.sign = URI.hashCode;
            var _loc_4:* = new URLRequest();
            new URLRequest().data = _loc_3;
            _loc_4.url = URI.bugFeedbackUrl;
            this._loaderSubmitAssess.load(_loc_4);
            return;
        }// end function

        public function show() : void
        {
            if (URI.gmUrl != "")
            {
                navigateToURL(new URLRequest(URI.gmUrl), "_blank");
            }
            else
            {
                this.loadResources();
            }
            return;
        }// end function

        private function loadResources() : void
        {
            loadAssets("GameMaster", this.render, GameMasterViewLang.LoadInfo, false, true);
            return;
        }// end function

        public function render() : void
        {
            if (inStage)
            {
                return;
            }
            this._gm = _view.getAssetsObject("GameMaster", "GameMaster") as IGameMaster;
            _popup.addView(this, this._gm.content);
            this._gm.drag = _view.drag.iDrag;
            this._gm.tip = _view.tip.iTip;
            this._gm.alert = _view.alert.iAlert;
            this._gm.nickName = _ctrl.player.nickname;
            this._gm.bbsUrl = URI.bbsUrl || "http : //bbs.xd.com/";
            this._gm.onSubmit = function (param1:int, param2:String, param3:int) : void
            {
                submit_bug(param1, param2, param3);
                return;
            }// end function
            ;
            this._gm.onGetBugList = function () : void
            {
                get_bug_list();
                return;
            }// end function
            ;
            this._gm.onSubmitAssess = this.submit_assess;
            this._gm.onClose = function (param1:int) : void
            {
                _intOpenPanel = param1;
                close();
                return;
            }// end function
            ;
            this._gm.init(this._intOpenPanel);
            this.addEvent();
            _view.center(sign, this._gm.content);
            return;
        }// end function

        private function addEvent() : void
        {
            this._loaderSubmitBug.addEventListener(Event.COMPLETE, this.onSubmitBugComplete);
            this._loaderSubmitBug.addEventListener(IOErrorEvent.IO_ERROR, this.ioError);
            this._loaderSubmitBug.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.securityError);
            this._loaderGetBugList.addEventListener(Event.COMPLETE, this.onGetBugListComplete);
            this._loaderGetBugList.addEventListener(IOErrorEvent.IO_ERROR, this.ioError);
            this._loaderGetBugList.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.securityError);
            this._loaderSubmitAssess.addEventListener(Event.COMPLETE, this.onSubmitAssessComplete);
            this._loaderSubmitAssess.addEventListener(IOErrorEvent.IO_ERROR, this.ioError);
            this._loaderSubmitAssess.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.securityError);
            return;
        }// end function

        private function removeEvent() : void
        {
            this._loaderSubmitBug.removeEventListener(Event.COMPLETE, this.onSubmitBugComplete);
            this._loaderSubmitBug.removeEventListener(IOErrorEvent.IO_ERROR, this.ioError);
            this._loaderSubmitBug.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.securityError);
            this._loaderGetBugList.removeEventListener(Event.COMPLETE, this.onGetBugListComplete);
            this._loaderGetBugList.removeEventListener(IOErrorEvent.IO_ERROR, this.ioError);
            this._loaderGetBugList.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.securityError);
            this._loaderSubmitAssess.removeEventListener(Event.COMPLETE, this.onSubmitAssessComplete);
            this._loaderSubmitAssess.removeEventListener(IOErrorEvent.IO_ERROR, this.ioError);
            this._loaderSubmitAssess.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.securityError);
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
            this.removeEvent();
            this._canGetBugList = true;
            this._gm.clear();
            return;
        }// end function

        private function onSubmitBugComplete(event:Event) : void
        {
            var _loc_2:* = this.message(parseInt(event.target.data));
            _view.showTip(GameMasterViewLang.Prompts, _loc_2);
            if (event.target.data == 1)
            {
                this._gm.renderSubmitBug = [true];
            }
            this._canGetBugList = true;
            return;
        }// end function

        private function onGetBugListComplete(event:Event) : void
        {
            var _loc_3:String = null;
            var _loc_4:Array = null;
            var _loc_2:* = event.target.data;
            if (_loc_2.length == 1)
            {
                _loc_3 = this.message(parseInt(_loc_2));
                _view.showTip(GameMasterViewLang.Prompts, _loc_3);
                this._canGetBugList = true;
            }
            else
            {
                _loc_4 = JSON.decode(_loc_2);
                this._gm.renderBugList = _loc_4;
            }
            return;
        }// end function

        private function onSubmitAssessComplete(event:Event) : void
        {
            var _loc_3:String = null;
            var _loc_2:* = event.target.data;
            if (_loc_2.length == 1)
            {
                _loc_3 = this.message(parseInt(_loc_2));
                _view.showTip(GameMasterViewLang.Prompts, _loc_3);
            }
            this._gm.renderSubmitAssessComplete(this._intAssessId);
            return;
        }// end function

        private function ioError(event:IOErrorEvent) : void
        {
            return;
        }// end function

        private function securityError(event:SecurityErrorEvent) : void
        {
            return;
        }// end function

        private function message(param1:int) : String
        {
            var _loc_2:String = "";
            switch(param1)
            {
                case 0:
                {
                    _loc_2 = GameMasterViewLang.SubmitFail;
                    break;
                }
                case 1:
                {
                    _loc_2 = GameMasterViewLang.SubmitSuccess;
                    break;
                }
                case 2:
                {
                    _loc_2 = GameMasterViewLang.ParaError;
                    break;
                }
                case 3:
                {
                    _loc_2 = GameMasterViewLang.NoServer;
                    break;
                }
                case 4:
                {
                    _loc_2 = GameMasterViewLang.NoAccount;
                    break;
                }
                case 5:
                {
                    _loc_2 = GameMasterViewLang.SubmitUpperLimit;
                    break;
                }
                case 6:
                {
                    _loc_2 = GameMasterViewLang.NoConsistency;
                    break;
                }
                case 7:
                {
                    _loc_2 = GameMasterViewLang.NoAssess;
                    break;
                }
                case 8:
                {
                    _loc_2 = GameMasterViewLang.AssessFinish;
                    break;
                }
                default:
                {
                    _loc_2 = GameMasterViewLang.Error + param1;
                    break;
                }
            }
            return _loc_2;
        }// end function

    }
}
