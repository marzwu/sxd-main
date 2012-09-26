package com.assist.server
{
    import com.assist.server.source.*;

    public class DreamSectionType extends Object
    {

        public function DreamSectionType()
        {
            return;
        }// end function

        public static function findRoleList() : Array
        {
            var _loc_4:int = 0;
            var _loc_5:Object = null;
            var _loc_6:int = 0;
            var _loc_7:String = null;
            var _loc_1:* = new Array();
            var _loc_2:* = new Array();
            var _loc_3:int = 0;
            while (_loc_3 < DreamSectionTypeData.roleList.length)
            {
                
                _loc_2 = DreamSectionTypeData.roleList[_loc_3];
                _loc_4 = 0;
                _loc_5 = new Object();
                _loc_5.roleId = _loc_2[_loc_4++];
                _loc_5.unlock_condition = _loc_2[_loc_4++];
                _loc_5.casual_point = _loc_2[_loc_4++];
                _loc_5.roleName = _loc_2[_loc_4++];
                _loc_5.strength = _loc_2[_loc_4++];
                _loc_5.agile = _loc_2[_loc_4++];
                _loc_5.intellect = _loc_2[_loc_4++];
                _loc_5.initial_health = _loc_2[_loc_4++];
                _loc_6 = _loc_2[_loc_4++];
                _loc_7 = RoleStunt.getStuntSign(_loc_6);
                _loc_5.role_stunt_Name = RoleStunt.getStuntName(_loc_7);
                _loc_5.sign = _loc_2[_loc_4++];
                _loc_5.oldRoleName = _loc_2[_loc_4++];
                _loc_5.stunt_content = RoleStunt.getStuntDescription(_loc_6);
                _loc_5.lock = 0;
                _loc_5.is_challenged = 0;
                _loc_5.is_recruited = 0;
                _loc_1.push(_loc_5);
                _loc_3++;
            }
            return _loc_1;
        }// end function

        public static function findRoleInfoById(param1:int) : Array
        {
            var _loc_3:Array = null;
            var _loc_2:int = 0;
            while (_loc_2 < DreamSectionTypeData.roleList.length)
            {
                
                _loc_3 = DreamSectionTypeData.roleList[_loc_2];
                if (_loc_3[0] == param1)
                {
                    return _loc_3;
                }
                _loc_2++;
            }
            return new Array();
        }// end function

        public static function findSectionById(param1:int) : Array
        {
            var _loc_4:Array = null;
            var _loc_5:Object = null;
            var _loc_2:* = new Array();
            var _loc_3:int = 0;
            while (_loc_3 < DreamSectionTypeData.sectionList.length)
            {
                
                _loc_4 = DreamSectionTypeData.sectionList[_loc_3];
                if (_loc_4[0] == param1)
                {
                    _loc_5 = new Object();
                    _loc_5.roleId = _loc_4[0];
                    _loc_5.lock = _loc_4[1];
                    _loc_5.award_lock = _loc_4[2];
                    _loc_5.mission_monster_team_id = _loc_4[3];
                    _loc_5.dreamId1 = _loc_4[4];
                    _loc_5.dreamName1 = _loc_4[5];
                    _loc_5.dreamId2 = _loc_4[6];
                    _loc_5.dreamName2 = _loc_4[7];
                    _loc_5.award_aura = _loc_4[8];
                    _loc_2.push(_loc_5);
                }
                _loc_3++;
            }
            _loc_2.sortOn("lock", Array.NUMERIC);
            return _loc_2;
        }// end function

    }
}
