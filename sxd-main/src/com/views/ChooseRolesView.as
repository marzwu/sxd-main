package com.views
{
    import com.assist.*;
    import com.assist.view.*;
    import com.assist.view.interfaces.*;
    import com.haloer.net.*;
    import com.lang.client.com.views.*;
    import com.protocols.*;

    public class ChooseRolesView extends Base implements IView
    {
        private var _cr:IChooseRoles;

        public function ChooseRolesView()
        {
            return;
        }// end function

        public function show() : void
        {
            var _loc_1:LoadResponder = null;
            if (_view.hasResource("ChooseRoles"))
            {
                this.render();
            }
            else
            {
                _loc_1 = new LoadResponder(this.render);
                _view.loadResources(["ChooseRoles"], _loc_1);
            }
            return;
        }// end function

        public function render() : void
        {
            this._cr = _view.getAssetsObject("ChooseRoles", "ChooseRoles") as IChooseRoles;
            _popup.addChild(this._cr.content);
            this._cr.tip = _view.tip.iTip;
            this._cr.onStart = this.start;
            this._cr.init(Structure.minStageWidth, Structure.minStageHeight, Structure.maxStageWidth, Structure.maxStageHeight);
            return;
        }// end function

        private function start(param1:String, param2:int) : void
        {
            var name:* = param1;
            var roleId:* = param2;
            var callback:* = function () : void
            {
                getPlayerFirstInitCallback(name);
                return;
            }// end function
            ;
            _data.call(Mod_Player_Base.player_first_init, callback, [roleId, name + URI.nickNameSuffix()]);
            Helper.backtrace("Mod_Player_Base.player_first_init, 1");
            return;
        }// end function

        private function getPlayerFirstInitCallback(param1:String) : void
        {
            var str:String;
            var http:HTTP;
            var name:* = param1;
            Helper.backtrace("Mod_Player_Base.player_first_init, 0");
            switch(_ctrl.player.createdRole)
            {
                case Mod_Player_Base.SUCCEED:
                {
                    this.close();
                    _view.initLoading.loadToolbar();
                    if (URI.isBaidu)
                    {
                        str;
                    }
                    else if (URI.isSogou)
                    {
                        str;
                    }
                    else if (URI.isPlatformB)
                    {
                        str;
                    }
                    if (str)
                    {
                        http = new HTTP();
                        http.data = {action:"CREATE", user:URI.playerName, nickname:name};
                        http.onComplete = function (param1:Object) : void
            {
                return;
            }// end function
            ;
                        http.onError = function () : void
            {
                return;
            }// end function
            ;
                        http.load("http://" + URI.serverName + "/" + str);
                    }
                    break;
                }
                case Mod_Player_Base.DUPLICATED_NICKNAME:
                {
                    this._cr.error = ChooseRolesViewLang.DuplicatedNickName;
                    break;
                }
                case Mod_Player_Base.FORBIDDEN_NICKNAME:
                {
                    this._cr.error = ChooseRolesViewLang.ForbiddenNickName;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function clear() : void
        {
            this._cr.clear();
            _view.removeResource("ChooseRoles");
            return;
        }// end function

        public function close() : void
        {
            this.clear();
            _popup.removeChild(this._cr.content);
            return;
        }// end function

    }
}
