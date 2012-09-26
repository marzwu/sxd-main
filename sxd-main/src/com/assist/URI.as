package com.assist
{
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;

    public class URI extends Object
    {
        private static var _domain:String = "localhost";
        private static var _serverPort:int = 8888;
        private static var _clientUrl:String = "http://sxd.xdcdn.net/2012090801/";
        private static var _policyPort:int = 888;
        private static var _gateWayPort:int = 10010;
        private static var _args:Object = {};
        private static var _assetsUrl:String;
        private static var _fullClientUrl:String;
        private static var _version:Object = {};
        public static var test:Boolean = false;
        private static var _stage:Stage;
        private static var _lc:LocalConnection = new LocalConnection();

        public function URI()
        {
            return;
        }// end function

        public static function get playerName() : String
        {
            return _args["player_name"];
        }// end function

        public static function set playerName(param1:String) : void
        {
            _args["player_name"] = param1;
            return;
        }// end function

        public static function get hashCode() : String
        {
            return _args["hash_code"];
        }// end function

        public static function set hashCode(param1:String) : void
        {
            _args["hash_code"] = param1;
            return;
        }// end function

        public static function get time() : String
        {
            return _args["time"];
        }// end function

        public static function set time(param1:String) : void
        {
            _args["time"] = param1;
            return;
        }// end function

        public static function get ip() : String
        {
            return _args["ip"] || _domain || "";
        }// end function

        public static function get port() : int
        {
            return _args["port"] || _serverPort || 0;
        }// end function

        public static function get gameVersion() : int
        {
            return _args["game_version"] || Config.GameVersion || 0;
        }// end function

        public static function get assetsRnd() : String
        {
            return _args["assets_rnd"] || "";
        }// end function

        public static function get openTime() : int
        {
            return _args["open_time"] || 0;
        }// end function

        public static function get serverName() : String
        {
            return _args["server_name"] || "";
        }// end function

        public static function get serverUrl() : String
        {
            return _args["server_url"] || "";
        }// end function

        public static function get worldWarServerUrl() : String
        {
            return _args["world_war_server_url"] || "";
        }// end function

        public static function get worldFactionWarUrl() : String
        {
            if (Config.EnableProtocolHelper == true)
            {
                return _args["world_faction_war_url"] || "http://192.168.5.126/";
            }
            return _args["world_faction_war_url"] || "";
        }// end function

        public static function get worldTopWarWarServerUrl() : String
        {
            return _args["world_top_war_war_server_url"] || "";
        }// end function

        public static function nickNameSuffix(param1:Boolean = false) : String
        {
            var _loc_2:* = _args["nickname_suffix"] || "";
            if (param1 && _loc_2 != "")
            {
                _loc_2 = _loc_2.replace(".", "\\.");
                _loc_2 = _loc_2.replace("-", "\\-");
                _loc_2 = _loc_2.replace("[", "\\[");
                _loc_2 = _loc_2.replace("]", "\\]");
            }
            return _loc_2;
        }// end function

        public static function get webSiteUrl() : String
        {
            return _args["website"] || "";
        }// end function

        public static function get bbsUrl() : String
        {
            return _args["bbs"] || "";
        }// end function

        public static function get rechargeUrl() : String
        {
            return _args["recharge"] || "";
        }// end function

        public static function get bugUrl() : String
        {
            return _args["bug"] || "";
        }// end function

        public static function get bugListUrl() : String
        {
            return _args["bug_list_url"] || "";
        }// end function

        public static function get bugFeedbackUrl() : String
        {
            return _args["bug_feedback_url"] || "";
        }// end function

        public static function get activationKeysUrl() : String
        {
            return _args["code"] || "";
        }// end function

        public static function get vipInfoUrl() : String
        {
            return _args["vip_info"] || "";
        }// end function

        public static function get sourceUrl() : String
        {
            return _args["source"] || "";
        }// end function

        public static function get cid() : int
        {
            return parseInt(_args["cid"]) || 0;
        }// end function

        public static function get regdate() : int
        {
            return _args["regdate"] || 0;
        }// end function

        public static function get publish() : String
        {
            return _args["publish"] || "";
        }// end function

        public static function get isBaidu() : Boolean
        {
            return parseInt(_args["baidu"]) == 1;
        }// end function

        public static function get preventUrl() : String
        {
            return _args["prevent_url"];
        }// end function

        public static function get isMangguo() : Boolean
        {
            return parseInt(_args["mangguo"]) == 1;
        }// end function

        public static function get nonKid() : Boolean
        {
            return parseInt(_args["non_kid"]) == 1;
        }// end function

        public static function get vipHidden() : Boolean
        {
            return parseInt(_args["vip_hidden"]) == 1;
        }// end function

        public static function get gmUrl() : String
        {
            return _args["gm_url"] || "";
        }// end function

        public static function get isSogou() : Boolean
        {
            return parseInt(_args["sogou"]) == 1;
        }// end function

        public static function get isPlatformB() : Boolean
        {
            return parseInt(_args["platform_b"]) == 1;
        }// end function

        public static function get weiBoNickName() : String
        {
            return _args["weibo_nickname"] || "";
        }// end function

        public static function get weiBoGender() : String
        {
            var _loc_1:* = _args["weibo_gender"];
            return /^(?:m|f|n)$""^(?:m|f|n)$/.test(_loc_1) ? (_loc_1) : ("n");
        }// end function

        public static function get canPk() : Boolean
        {
            return parseInt(_args["can_pk"]) == 1;
        }// end function

        public static function get isCombined() : Boolean
        {
            return parseInt(_args["is_combined"]) == 1;
        }// end function

        public static function set domain(param1:String) : void
        {
            _domain = param1;
            return;
        }// end function

        public static function get fullClientUrl() : String
        {
            return _fullClientUrl;
        }// end function

        public static function get fullAssetsUrl() : String
        {
            return _fullClientUrl + "assets/";
        }// end function

        public static function get clientUrl() : String
        {
            return _clientUrl;
        }// end function

        public static function get gateWayPort() : int
        {
            return _gateWayPort;
        }// end function

        public static function get serverPort() : int
        {
            return _serverPort;
        }// end function

        public static function set serverPort(param1:int) : void
        {
            _serverPort = param1;
            return;
        }// end function

        public static function get policyPort() : int
        {
            return _policyPort;
        }// end function

        public static function get assetsUrl() : String
        {
            return _assetsUrl;
        }// end function

        public static function get addonsUrl() : String
        {
            return _assetsUrl + "addons/";
        }// end function

        public static function get townUrl() : String
        {
            return _assetsUrl + "map/town/";
        }// end function

        public static function get soundUrl() : String
        {
            return _assetsUrl + "map/sound/";
        }// end function

        public static function get mapUrl() : String
        {
            return _assetsUrl + "map/";
        }// end function

        public static function get missionUrl() : String
        {
            return _assetsUrl + "map/mission/";
        }// end function

        public static function get sportUrl() : String
        {
            return _assetsUrl + "map/sport/";
        }// end function

        public static function get worldBossUrl() : String
        {
            return _assetsUrl + "map/world_boss/";
        }// end function

        public static function get goodsIconUrl() : String
        {
            return _assetsUrl + "icons/goods/";
        }// end function

        public static function get npcIconUrl() : String
        {
            return _assetsUrl + "icons/npc/";
        }// end function

        public static function get buffIconUrl() : String
        {
            return _assetsUrl + "icons/buff/";
        }// end function

        public static function get nineRegionsBlessing() : String
        {
            return _assetsUrl + "icons/blessing/";
        }// end function

        public static function get topWarRole() : String
        {
            return _assetsUrl + "roles/top_war/";
        }// end function

        public static function get effectsUrl() : String
        {
            return _assetsUrl + "roles/effects/";
        }// end function

        public static function get screenUrl() : String
        {
            return _assetsUrl + "roles/screen/";
        }// end function

        public static function get dramaUrl() : String
        {
            return _assetsUrl + "drama/";
        }// end function

        public static function get nineRegionsDramaUrl() : String
        {
            return _assetsUrl + "drama/NineRegions/";
        }// end function

        public static function get bossUrl() : String
        {
            return _assetsUrl + "icons/boss/";
        }// end function

        public static function get fateUrl() : String
        {
            return _assetsUrl + "icons/fate/";
        }// end function

        public static function get flowerUrl() : String
        {
            return _assetsUrl + "icons/flower/";
        }// end function

        public static function get avatarUrl() : String
        {
            return _assetsUrl + "roles/avatar/";
        }// end function

        public static function get stuntsUrl() : String
        {
            return _assetsUrl + "roles/stunts/";
        }// end function

        public static function get roleUrl() : String
        {
            return _assetsUrl + "roles/";
        }// end function

        public static function get iconsUrl() : String
        {
            return _assetsUrl + "roles/icons/";
        }// end function

        public static function get iconsMiniUrl() : String
        {
            return _assetsUrl + "roles/miniIcons/";
        }// end function

        public static function get chooseRolesUrl() : String
        {
            return _assetsUrl + "icons/choose_roles/";
        }// end function

        public static function get warRolesUrl() : String
        {
            return _assetsUrl + "roles/war/";
        }// end function

        public static function get dreamRoleUrl() : String
        {
            return _assetsUrl + "roles/dream_role/";
        }// end function

        public static function get furnaceRoleUrl() : String
        {
            return _assetsUrl + "roles/furnace_role/";
        }// end function

        public static function get furnaceItemIconUrl() : String
        {
            return _assetsUrl + "roles/furnace_role/ItemIcon/";
        }// end function

        public static function get researchIconUrl() : String
        {
            return _assetsUrl + "icons/research/";
        }// end function

        public static function get farmIconUrl() : String
        {
            return _assetsUrl + "icons/farm/";
        }// end function

        public static function get activityUrl() : String
        {
            return _assetsUrl + "icons/activity/";
        }// end function

        public static function get triggerUrl() : String
        {
            return _assetsUrl + "icons/trigger/";
        }// end function

        public static function get soundEffectUrl() : String
        {
            return _assetsUrl + "sound_effect/";
        }// end function

        public static function getRoleIconUrl(param1:String) : String
        {
            return iconsUrl + param1 + ".png";
        }// end function

        public static function getGoodsIconUrl(param1:int) : String
        {
            return goodsIconUrl + param1 + ".png";
        }// end function

        public static function getSoulsIconUrl(param1:int) : String
        {
            return _assetsUrl + "icons/souls/" + param1 + ".swf";
        }// end function

        public static function get achievementUrl() : String
        {
            return _assetsUrl + "icons/achievement/";
        }// end function

        public static function get sportIconUrl() : String
        {
            return _assetsUrl + "roles/super_sport/";
        }// end function

        public static function get studyStuntIconUrl() : String
        {
            return _assetsUrl + "icons/study_stunt/";
        }// end function

        public static function get processTips() : String
        {
            return _assetsUrl + "icons/process_tips/";
        }// end function

        public static function get gameHelperIconUrl() : String
        {
            return _assetsUrl + "icons/game_helper/";
        }// end function

        public static function get idCard() : String
        {
            return _args["id_card"] || "";
        }// end function

        public static function set idCard(param1:String) : void
        {
            _args["id_card"] = param1;
            return;
        }// end function

        public static function set nonKid(param1:Boolean) : void
        {
            _args["non_kid"] = param1 == true ? (1) : (0);
            return;
        }// end function

        public static function get specialPartnerUrl() : String
        {
            return _assetsUrl + "icons/special_partner/";
        }// end function

        public static function get goodsNewUrl() : String
        {
            return _assetsUrl + "icons/goods_new/";
        }// end function

        public static function specialPartnerGoodUrl(param1:int) : String
        {
            return goodsNewUrl + param1 + ".png";
        }// end function

        public static function get findImmortalUrl() : String
        {
            return _assetsUrl + "icons/find_immortal/";
        }// end function

        public static function formatVersion(param1:String) : void
        {
            var _loc_3:String = null;
            var _loc_4:Array = null;
            var _loc_2:* = param1.split(/\r\
n|\r|\
n""\r\n|\r|\n/g);
            for each (_loc_3 in _loc_2)
            {
                
                _loc_4 = _loc_3.split("|");
                if (_loc_4.length == 2)
                {
                    _version[_loc_4[0]] = _loc_4[1];
                }
            }
            return;
        }// end function

        public static function getVersion(param1:String) : String
        {
            var _loc_4:int = 0;
            param1 = param1.replace(_assetsUrl, "");
            var _loc_2:* = param1.split("/");
            var _loc_3:* = _loc_2.length;
            if (_loc_3 > 1)
            {
                param1 = "";
                _loc_4 = 0;
                while (_loc_4 < (_loc_3 - 1))
                {
                    
                    param1 = param1 + ("/" + _loc_2[_loc_4].substr(0, 1));
                    _loc_4++;
                }
                param1 = param1 + "/" + _loc_2[(_loc_3 - 1)];
            }
            else
            {
                param1 = "/" + param1;
            }
            param1 = _version[param1] || "";
            return param1;
        }// end function

        public static function analyze(param1:Object) : void
        {
            _stage = param1.stage;
            var _loc_2:* = _stage.getChildAt(0);
            if (_loc_2.hasOwnProperty("args"))
            {
                _args = _loc_2.args;
            }
            if (_args["client_url"])
            {
                _clientUrl = _args["client_url"];
            }
            _assetsUrl = _clientUrl + "assets/";
            if (_clientUrl == "./")
            {
                _fullClientUrl = param1.loaderInfo.url.replace(/(Main|rw)\.swf(\?[\s\S]+?)?""(Main|rw)\.swf(\?[\s\S]+?)?/, "");
            }
            else
            {
                _fullClientUrl = _clientUrl;
            }
            return;
        }// end function

        public static function selectDomain(param1:Function = null) : void
        {
            if (test)
            {
                TempSelectDomain.stage = _stage;
                TempSelectDomain.show(param1);
            }
            return;
        }// end function

        public static function localConnection(param1:String) : void
        {
            var playerName:* = param1;
            _lc.allowDomain("*");
            _lc.allowInsecureDomain("*");
            _lc.client = Helper;
            _lc.addEventListener(StatusEvent.STATUS, statusHandler);
            var name:* = (serverName ? (serverName + "_") : ("")) + serverName;
            try
            {
                _lc.connect(name);
            }
            catch (e)
            {
            }
            return;
        }// end function

        private static function statusHandler(event:StatusEvent) : void
        {
            return;
        }// end function

    }
}
