package com.assist.server
{
    import com.assist.server.source.*;

    public class FurnaceType extends Object
    {
        public static const ItemLevel:int = 89;
        public static const PurpleItemId:int = 346;
        public static const NvWaShiItemId:int = 1411;
        private static var _roleList:Array;
        private static var _favItemList:Array;
        public static var COMMONFLAG:int = 0;
        public static var LEVELFLAG:int = 1;
        private static var _itemList:Array;

        public function FurnaceType() : void
        {
            return;
        }// end function

        public static function clear() : void
        {
            _roleList = null;
            _favItemList = null;
            return;
        }// end function

        public static function get roleList() : Array
        {
            var _loc_5:int = 0;
            var _loc_6:Object = null;
            var _loc_7:Object = null;
            var _loc_8:String = null;
            var _loc_9:int = 0;
            var _loc_10:String = null;
            if (_roleList)
            {
                return _roleList;
            }
            var _loc_1:* = FurnaceTypeData.roleList;
            var _loc_2:* = new Array();
            var _loc_3:* = new Array();
            var _loc_4:int = 0;
            while (_loc_4 < _loc_1.length)
            {
                
                _loc_3 = _loc_1[_loc_4];
                _loc_5 = 0;
                _loc_6 = new Object();
                _loc_6.canLevel = true;
                _loc_6.roleId = _loc_3[_loc_5++];
                _loc_6.sign = RoleType.getRoleSign(_loc_6.roleId);
                _loc_6.name = RoleType.getRoleName(_loc_6.roleId);
                _loc_6.have_amount = 0;
                _loc_6.fame = RoleType.getRoleFame(_loc_6.roleId);
                _loc_7 = new Object();
                _loc_7.roleId = _loc_3[_loc_5++];
                _loc_6.itemId = _loc_3[_loc_5++];
                _loc_6.needItems = _loc_3[_loc_5++];
                _loc_8 = FurnaceType.getChat(_loc_6.roleId, FurnaceType.COMMONFLAG);
                _loc_6.chatList = _loc_8.split("|");
                _loc_8 = FurnaceType.getChat(_loc_6.roleId, FurnaceType.LEVELFLAG);
                _loc_6.levelChat = _loc_8;
                _loc_7.sign = RoleType.getRoleSign(_loc_7.roleId);
                _loc_7.name = RoleType.getRoleName(_loc_7.roleId);
                _loc_7.itemId = _loc_6.itemId;
                _loc_7.strength = _loc_3[_loc_5++];
                _loc_7.agile = _loc_3[_loc_5++];
                _loc_7.intellect = _loc_3[_loc_5++];
                _loc_7.initial_health = _loc_3[_loc_5++];
                _loc_7.canLevel = false;
                _loc_7.wared = false;
                _loc_7.fame = RoleType.getRoleFame(_loc_7.roleId);
                _loc_9 = _loc_3[_loc_5++];
                _loc_10 = RoleStunt.getStuntSign(_loc_9);
                _loc_7.role_stunt_Name = RoleStunt.getStuntName(_loc_10);
                _loc_7.stunt_content = RoleStunt.getStuntDescription(_loc_9);
                _loc_8 = FurnaceType.getChat(_loc_7.roleId, FurnaceType.COMMONFLAG);
                _loc_7.chatList = _loc_8.split("|");
                _loc_8 = FurnaceType.getChat(_loc_7.roleId, FurnaceType.LEVELFLAG);
                _loc_7.levelChat = _loc_8;
                _loc_7.have_amount = 0;
                _loc_7.inBody = false;
                _loc_6.childObj = _loc_7;
                _loc_6.text = "1";
                _loc_6.strength = _loc_3[_loc_5++];
                _loc_6.agile = _loc_3[_loc_5++];
                _loc_6.intellect = _loc_3[_loc_5++];
                _loc_6.initial_health = _loc_3[_loc_5++];
                _loc_9 = _loc_3[_loc_5++];
                _loc_10 = RoleStunt.getStuntSign(_loc_9);
                _loc_6.role_stunt_Name = RoleStunt.getStuntName(_loc_10);
                _loc_6.stunt_content = RoleStunt.getStuntDescription(_loc_9);
                _loc_6.inBody = false;
                _loc_2.push(_loc_6);
                _loc_4++;
            }
            var _loc_11:* = _loc_2;
            _roleList = _loc_2;
            return _loc_11;
        }// end function

        public static function get favItemIdList() : Array
        {
            var _loc_4:Array = null;
            var _loc_5:Boolean = false;
            var _loc_6:int = 0;
            var _loc_7:Object = null;
            var _loc_8:Object = null;
            if (_favItemList)
            {
                return _favItemList;
            }
            _favItemList = new Array();
            var _loc_1:* = FurnaceTypeData.favorItemList;
            var _loc_2:* = new Array();
            var _loc_3:int = 0;
            while (_loc_3 < _loc_1.length)
            {
                
                _loc_4 = _loc_1[_loc_3];
                _loc_5 = false;
                _loc_6 = 0;
                while (_loc_6 < _favItemList.length)
                {
                    
                    _loc_8 = _favItemList[_loc_6];
                    if (_loc_8.oldId == _loc_4[0])
                    {
                        _loc_8.list.push(_loc_4[1]);
                        _loc_5 = true;
                        break;
                    }
                    _loc_6++;
                }
                if (_loc_5)
                {
                }
                else
                {
                    _loc_7 = new Object();
                    _loc_7.oldId = _loc_4[0];
                    _loc_7.list = [_loc_4[1]];
                    _favItemList.push(_loc_7);
                }
                _loc_3++;
            }
            return _favItemList;
        }// end function

        public static function getItemByOldId(param1:int) : Array
        {
            var _loc_2:int = 0;
            while (_loc_2 < favItemIdList.length)
            {
                
                if (favItemIdList[_loc_2].oldId == param1)
                {
                    return _favItemList[_loc_2].list.concat();
                }
                _loc_2++;
            }
            return new Array();
        }// end function

        public static function getRoleNameByFavId(param1:int) : String
        {
            var _loc_2:int = 0;
            while (_loc_2 < roleList.length)
            {
                
                if (roleList[_loc_2].itemId == param1)
                {
                    return roleList[_loc_2].name;
                }
                _loc_2++;
            }
            return "";
        }// end function

        public static function getRoleObjById(param1:int) : Object
        {
            var _loc_2:int = 0;
            while (_loc_2 < roleList.length)
            {
                
                if (roleList[_loc_2].roleId == param1)
                {
                    return roleList[_loc_2];
                }
                _loc_2++;
            }
            return new Object();
        }// end function

        public static function getChat(param1:int, param2:int) : String
        {
            var _loc_5:Array = null;
            var _loc_3:* = FurnaceTypeData.roleChat;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3.length)
            {
                
                _loc_5 = _loc_3[_loc_4];
                if (_loc_5[0] == param1 && param2 == _loc_5[2])
                {
                    return _loc_5[1];
                }
                _loc_4++;
            }
            return "";
        }// end function

        public static function get itemList() : Array
        {
            var _loc_3:Object = null;
            var _loc_4:int = 0;
            if (_itemList)
            {
                return _itemList;
            }
            _itemList = new Array();
            var _loc_1:* = FurnaceTypeData.favorItemList;
            var _loc_2:int = 0;
            while (_loc_2 < _loc_1.length)
            {
                
                _loc_3 = null;
                _loc_4 = 0;
                while (_loc_4 < _itemList.length)
                {
                    
                    if (_itemList[_loc_4].srcItemId == _loc_1[_loc_2][0])
                    {
                        _loc_3 = _itemList[_loc_4];
                        break;
                    }
                    _loc_4++;
                }
                if (!_loc_3)
                {
                    _loc_3 = new Object();
                    _loc_3.srcItemId = _loc_1[_loc_2][0];
                    _loc_3.dscItemList = new Array();
                    _itemList.push(_loc_3);
                }
                _loc_3.dscItemList.push(_loc_1[_loc_2][1]);
                _loc_2++;
            }
            return _itemList;
        }// end function

        public static function getFavItemIdByRole(param1:int) : int
        {
            var _loc_2:* = FurnaceTypeData.roleList;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                if (_loc_2[_loc_3][1] == param1)
                {
                    return _loc_2[_loc_3][2];
                }
                _loc_3++;
            }
            return 0;
        }// end function

        public static function getAwardByRoleId(param1:int) : Array
        {
            var _loc_2:Array = [];
            var _loc_3:* = FurnaceTypeData.roleList;
            var _loc_4:int = 0;
            while (_loc_4 < _loc_3.length)
            {
                
                if (_loc_3[_loc_4][1] == param1)
                {
                    _loc_2 = [_loc_3[_loc_4][14], _loc_3[_loc_4][15], _loc_3[_loc_4][16], _loc_3[_loc_4][17]];
                }
                _loc_4++;
            }
            return _loc_2;
        }// end function

        public static function isCanLvRole(param1:int) : Boolean
        {
            var _loc_2:* = FurnaceTypeData.roleList;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                if (_loc_2[_loc_3][0] == param1)
                {
                    return true;
                }
                _loc_3++;
            }
            return false;
        }// end function

        public static function getOldRoleIdById(param1:int) : int
        {
            var _loc_2:* = FurnaceTypeData.roleList;
            var _loc_3:int = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                if (_loc_2[_loc_3][1] == param1)
                {
                    return _loc_2[_loc_3][0];
                }
                _loc_3++;
            }
            return 0;
        }// end function

    }
}
