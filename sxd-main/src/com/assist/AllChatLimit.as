package com.assist
{
    import com.assist.server.*;
    import com.assist.view.*;
    import com.haloer.net.*;

    public class AllChatLimit extends Object
    {
        private var _isShieldPlayer:Boolean = false;
        private var _shieldPlayerList:Array;
        public static var isCN:Boolean = true;
        private static var _playerData:Object = {};
        private static var _cookie:Cookie;
        private static var _shieldPlayerList:Array;
        private static var _sameNum:int = 0;
        private static var _oldMsg:String = "";
        private static var shieldChat:Array = ["①", "②", "③", "④", "⑤", "⑥", "⑦", "⑧", "⑨", "⑩", "㈠", "㈡", "㈢", "㈣", "㈤", "㈥", "㈦", "㈧", "㈨", "㈩", "⑴", "⑵", "⑶", "⑷", "⑸", "⑹", "⑺", "⑻", "⑽", "⑼", "⒇", "⒆", "⒅", "⒄", "⒃", "⒂", "⒁", "⒀", "⑿", "⑾", "⒈", "⒒", "⒔", "⒓", "⒉", "⒊", "⒋", "⒕", "⒖", "⒌", "⒍", "⒗", "⒘", "⒎", "⒏", "⒙", "⒚", "⒐", "⒑", "⒛", "零", "壹", "贰", "叁", "肆", "伍", "陆", "柒", "捌", "玖", "拾", "一", "二", "三", "四", "五", "六", "七", "八", "九", "十", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "１", "２", "３", "４", "５", "６", "７", "８", "９", "０", "❶", "❷", "❸,", "❹", "❺", "❻", "❼", "❽", "❾", "⒈", "⒉", "⒊", "⒋", "⒍", "⒌", "⒎", "⒏", "⒐", "ー", "ニ", "ハ", "З", "О"];

        public function AllChatLimit()
        {
            this._shieldPlayerList = [];
            return;
        }// end function

        public static function forCN(param1:Object) : Boolean
        {
            var _loc_2:* = param1.serverTime - URI.openTime;
            var _loc_3:* = TownType.getTownIdByLock(param1.townKey);
            var _loc_4:* = param1.townKey;
            var _loc_5:* = TownType.getLock(TownType.getId(TownType.ShuShanCheng));
            var _loc_6:* = /^MSG\d+""^MSG\d+/.test(param1.message);
            var _loc_7:* = isShieldPlayerTalk(param1) == false && param1.playId != param1.mainPlayerId;
            if (param1.playId != param1.mainPlayerId && _loc_6 == false)
            {
                if (wordsLimit(param1) || !isSendTrue(param1, 6))
                {
                    _loc_7 = true;
                }
            }
            if (param1.isTester < 2)
            {
                if (_loc_4 >= _loc_5)
                {
                    if (param1.townKey < _loc_5)
                    {
                        _loc_7 = true;
                    }
                }
                else if (param1.townKey < _loc_4)
                {
                    _loc_7 = true;
                }
                if (_loc_5 > param1.townKey && param1.playId != param1.mainPlayerId)
                {
                    if (_loc_3 <= TownType.getId(TownType.XiaoYuCun) && _loc_2 > 345600)
                    {
                        _loc_7 = true;
                    }
                    if (getChatInfo(param1))
                    {
                        _loc_7 = true;
                    }
                }
            }
            return _loc_7;
        }// end function

        public static function forTW(param1:Object) : Boolean
        {
            var _loc_2:* = TownType.getLock(TownType.getId(TownType.ShuShanCheng));
            var _loc_3:* = isShieldPlayerTalk(param1) == false && param1.playId != param1.mainPlayerId;
            if (param1.isTester < 2)
            {
                if (_loc_2 > param1.townKey && param1.playId != param1.mainPlayerId)
                {
                    if (limliSameChat(param1))
                    {
                        shieldPlayerTalk(param1);
                        _loc_3 = true;
                    }
                }
            }
            return _loc_3;
        }// end function

        public static function forKR(param1:Object) : Boolean
        {
            var _loc_2:* = isShieldPlayerTalk(param1) == false && param1.playId != param1.mainPlayerId;
            return _loc_2;
        }// end function

        public static function forVN(param1:Object) : Boolean
        {
            var _loc_2:* = TownType.getLock(TownType.getId(TownType.ShuShanCheng));
            var _loc_3:* = isShieldPlayerTalk(param1) == false && param1.playId != param1.mainPlayerId;
            if (param1.isTester < 2)
            {
                if (_loc_2 > param1.townKey && param1.playId != param1.mainPlayerId)
                {
                    if (limliSameChat(param1))
                    {
                        shieldPlayerTalk(param1);
                        _loc_3 = true;
                    }
                }
            }
            return _loc_3;
        }// end function

        public static function initCookie() : void
        {
            _cookie = new Cookie("sxdChatLimit");
            shieldPlayerList();
            return;
        }// end function

        public static function setCookie(param1:String, param2:Object) : void
        {
            _cookie.setCookie(param1, param2);
            return;
        }// end function

        public static function getCookie(param1:String) : Object
        {
            return _cookie.getCookie(param1);
        }// end function

        public static function getChatInfo(param1:Object) : Boolean
        {
            var _loc_2:* = TownType.getLock(TownType.getId(TownType.ShuShanCheng));
            var _loc_3:* = (param1.townKey + 1) || 6;
            var _loc_4:* = isShieldPlayer(param1);
            var _loc_5:Boolean = false;
            var _loc_6:* = ljLimit(param1.message);
            if (_loc_4)
            {
                if (wordsLimit(param1) || !isSendTrue(param1, _loc_3))
                {
                    _loc_5 = true;
                }
                if (limliSameChat(param1))
                {
                    shieldPlayerTalk(param1);
                }
            }
            else
            {
                _loc_5 = true;
            }
            return _loc_6 || _loc_5 && _loc_2 > param1.townKey;
        }// end function

        public static function isWordsLimit(param1:Object) : Boolean
        {
            var _loc_2:Boolean = false;
            if (wordsLimit(param1) || !isSendTrue(param1, 6))
            {
                _loc_2 = true;
            }
            var _loc_3:* = ljLimit(param1.message);
            return _loc_3 || _loc_2;
        }// end function

        public static function isShieldPlayerTalk(param1:Object) : Boolean
        {
            return isShieldPlayer(param1);
        }// end function

        public static function shieldPlayerTalk(param1:Object) : void
        {
            var _loc_2:* = param1.playerId + "," + param1.serverTime;
            _shieldPlayerList.push(_loc_2);
            refuleShieldTalk(_shieldPlayerList);
            return;
        }// end function

        public static function refuleShieldTalk(param1:Array) : void
        {
            var _loc_2:* = param1.join("_");
            var _loc_3:Object = {};
            _loc_3.info = _loc_2;
            setCookie("chatLimit", _loc_3);
            return;
        }// end function

        public static function checkShieldPlayerTalk(param1:int, param2:int) : void
        {
            var _loc_3:Object = {};
            _loc_3.playId = param1;
            _loc_3.addTime = param2;
            shieldPlayerTalk({playerId:param1, serverTime:param2});
            return;
        }// end function

        private static function shieldPlayerList() : void
        {
            _shieldPlayerList = [];
            var _loc_1:* = getCookie("chatLimit");
            if (_loc_1 == null)
            {
                return;
            }
            var _loc_2:* = _loc_1.info;
            _shieldPlayerList = _loc_2.split("_");
            return;
        }// end function

        public static function isShieldPlayer(param1:Object) : Boolean
        {
            var _loc_6:String = null;
            var _loc_7:Array = null;
            var _loc_8:int = 0;
            var _loc_9:int = 0;
            var _loc_10:Object = null;
            var _loc_2:* = _shieldPlayerList.length;
            var _loc_3:Boolean = true;
            var _loc_4:Boolean = false;
            var _loc_5:* = _loc_2 - 1;
            while (_loc_5 >= 0)
            {
                
                _loc_6 = _shieldPlayerList[_loc_5];
                _loc_7 = _loc_6.split(",");
                _loc_8 = _loc_7[0];
                _loc_9 = _loc_7[1];
                if (_loc_8 == param1.playerId)
                {
                    _loc_10 = TimeChange.diffTimerInfo(_loc_9, param1.serverTime);
                    if (_loc_10.date >= 1)
                    {
                        _shieldPlayerList.splice(_loc_5, 1);
                        _loc_4 = true;
                    }
                    else
                    {
                        _loc_3 = false;
                    }
                }
                _loc_5 = _loc_5 - 1;
            }
            if (_loc_4)
            {
                refuleShieldTalk(_shieldPlayerList);
            }
            return _loc_3;
        }// end function

        private static function limliSameChat(param1:Object) : Boolean
        {
            var _loc_2:* = param1.message;
            var _loc_3:* = _oldMsg.length;
            var _loc_4:* = _loc_2.length;
            var _loc_5:int = 0;
            var _loc_6:Boolean = false;
            var _loc_7:* = countStr(_loc_2);
            if (_loc_3 >= _loc_4)
            {
                _loc_5 = int(_loc_3 * 0.8);
                if (_loc_5 > _loc_4)
                {
                    _oldMsg = _loc_2;
                    return false;
                }
                _loc_6 = renderSame(_loc_2, _oldMsg);
            }
            else
            {
                _loc_5 = int(_loc_4 * 0.8);
                if (_loc_5 > _loc_3)
                {
                    _oldMsg = _loc_2;
                    return false;
                }
                _loc_6 = renderSame(_oldMsg, _loc_2);
            }
            _oldMsg = _loc_2;
            if (_playerData[param1.playId] == null)
            {
                _playerData[param1.playId] = {};
                _playerData[param1.playId].sameNum = 0;
            }
            if (_loc_6)
            {
                var _loc_8:* = _playerData[param1.playId];
                var _loc_9:* = _playerData[param1.playId].sameNum + 1;
                _loc_8.sameNum = _loc_9;
            }
            else
            {
                _playerData[param1.playId].sameNum = 0;
            }
            return _playerData[param1.playId].sameNum >= 2 && _loc_7 > 10;
        }// end function

        private static function renderSame(param1:String, param2:String) : Boolean
        {
            var _loc_8:int = 0;
            var _loc_3:* = param1.length;
            var _loc_4:* = param2.length;
            var _loc_5:* = int(_loc_4 * 0.8);
            var _loc_6:int = 0;
            var _loc_7:int = 0;
            while (_loc_7 < _loc_3)
            {
                
                param1 = param1.charAt(_loc_7);
                _loc_8 = 0;
                while (_loc_8 < _loc_4)
                {
                    
                    param2 = param2.charAt(_loc_8);
                    if (param1 == param2)
                    {
                        _loc_6++;
                        break;
                    }
                    _loc_8++;
                }
                _loc_7++;
            }
            return _loc_6 >= _loc_5;
        }// end function

        public static function ljLimit(param1:String) : Boolean
        {
            var _loc_7:String = null;
            var _loc_8:int = 0;
            var _loc_9:Boolean = false;
            var _loc_10:Boolean = false;
            var _loc_2:* = param1;
            var _loc_3:* = _loc_2.length;
            var _loc_4:String = "";
            var _loc_5:Boolean = false;
            var _loc_6:int = 0;
            while (_loc_6 < _loc_3)
            {
                
                _loc_7 = _loc_2.charAt(_loc_6);
                _loc_8 = _loc_2.charCodeAt(_loc_6);
                _loc_9 = _loc_8 > 32 && _loc_8 < 47;
                _loc_10 = _loc_8 > 58 && _loc_8 < 63;
                if (_loc_7 != " " && _loc_7 != "　" && _loc_7 != "-" && _loc_9 == false && _loc_10 == false)
                {
                    _loc_4 = _loc_4 + _loc_7;
                }
                _loc_6++;
            }
            _loc_5 = /龙将|懒娃""龙将|懒娃/g.test(_loc_4);
            return _loc_5;
        }// end function

        public static function isSendTrue(param1:Object, param2:int) : Boolean
        {
            var _loc_9:int = 0;
            var _loc_3:* = param1.message;
            var _loc_4:* = _loc_3.length;
            var _loc_5:int = 0;
            var _loc_6:* = shieldChat;
            var _loc_7:* = shieldChat.length;
            var _loc_8:int = 0;
            while (_loc_8 < _loc_4)
            {
                
                _loc_9 = 0;
                while (_loc_9 < _loc_7)
                {
                    
                    if (_loc_3.charAt(_loc_8) == _loc_6[_loc_9])
                    {
                        _loc_5++;
                        if (_loc_5 >= param2)
                        {
                            return false;
                        }
                    }
                    _loc_9++;
                }
                _loc_8++;
            }
            return true;
        }// end function

        public static function wordsLimit(param1:Object) : Boolean
        {
            var _loc_6:String = null;
            var _loc_2:* = param1.message;
            var _loc_3:* = _loc_2.length;
            var _loc_4:String = "";
            var _loc_5:int = 0;
            while (_loc_5 < _loc_3)
            {
                
                _loc_6 = _loc_2.charAt(_loc_5);
                if (_loc_6 != " " && _loc_6 != "　")
                {
                    _loc_4 = _loc_4 + _loc_6;
                }
                _loc_5++;
            }
            return /壹|贰|叁|肆|伍|陆|柒|捌|玖|拾|佰|仟|①|②|③|④|⑤|⑥|⑦|⑧|⑨|⑩|㈠|㈡|㈢|㈣|㈤|㈥|㈦|㈧|㈨|㈩|⑴|⑵|⑶|⑷|⑸|⑹|⑺|⑻|⑼|⑽|叄|泗|汣|氿|叭|扒|妧|貦|萬|贎|莞|圆|圜|賲|宝|寳|圜寳|窷|聨|聫|聯|芫|架q|扣扣|蔻蔻|参参|送万寿无疆|\+飞仙|\+VIP满级|飞仙\+VIP|万寿无疆\+|\+万寿无疆|飞仙\+|送飞仙|送VIP|送vip|q:|送紫色装备|霖|億|蔻|疆|源|飛|q|Q|q\+""壹|贰|叁|肆|伍|陆|柒|捌|玖|拾|佰|仟|①|②|③|④|⑤|⑥|⑦|⑧|⑨|⑩|㈠|㈡|㈢|㈣|㈤|㈥|㈦|㈧|㈨|㈩|⑴|⑵|⑶|⑷|⑸|⑹|⑺|⑻|⑼|⑽|叄|泗|汣|氿|叭|扒|妧|貦|萬|贎|莞|圆|圜|賲|宝|寳|圜寳|窷|聨|聫|聯|芫|架q|扣扣|蔻蔻|参参|送万寿无疆|\+飞仙|\+VIP满级|飞仙\+VIP|万寿无疆\+|\+万寿无疆|飞仙\+|送飞仙|送VIP|送vip|q:|送紫色装备|霖|億|蔻|疆|源|飛|q|Q|q\+/i.test(_loc_4);
        }// end function

        private static function countStr(param1:String) : int
        {
            var _loc_2:int = 0;
            var _loc_3:* = param1.length;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3)
            {
                
                if (param1.charCodeAt(_loc_4) > 127)
                {
                    _loc_2 = _loc_2 + 2;
                }
                else
                {
                    _loc_2++;
                }
                _loc_4++;
            }
            return _loc_2;
        }// end function

    }
}
