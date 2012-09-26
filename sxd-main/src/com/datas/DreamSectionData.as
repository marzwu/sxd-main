package com.datas
{
    import com.assist.data.mission.*;
    import com.assist.server.*;
    import com.assist.view.info.*;

    public class DreamSectionData extends Base
    {
        public var result:int = 0;
        public var info:DreamSectionInfo;
        public var warData:WarData;

        public function DreamSectionData()
        {
            this.info = new DreamSectionInfo();
            return;
        }// end function

        private function init() : void
        {
            var _loc_2:Object = null;
            var _loc_3:Array = null;
            this.info.roleList = DreamSectionType.findRoleList();
            var _loc_1:int = 0;
            while (_loc_1 < this.info.roleList.length)
            {
                
                _loc_2 = this.info.roleList[_loc_1];
                _loc_3 = DreamSectionType.findSectionById(_loc_2.roleId);
                _loc_2.guanList = _loc_3;
                _loc_1++;
            }
            return;
        }// end function

        public function getRoleInfo(param1:Array) : void
        {
            var _loc_3:String = null;
            var _loc_4:Array = null;
            var _loc_5:int = 0;
            if (!this.info.roleList)
            {
                this.init();
            }
            this.result = param1[0];
            var _loc_2:* = param1[1];
            for (_loc_3 in _loc_2)
            {
                
                _loc_4 = _loc_2[_loc_3];
                _loc_5 = 0;
                while (_loc_5 < this.info.roleList.length)
                {
                    
                    if (_loc_4[0] == this.info.roleList[_loc_5].roleId)
                    {
                        this.info.roleList[_loc_5].lock = _loc_4[1];
                        this.info.roleList[_loc_5].is_locked = _loc_4[2];
                        this.info.roleList[_loc_5].is_challenged = _loc_4[3];
                        this.info.roleList[_loc_5].is_recruited = _loc_4[4];
                        break;
                    }
                    _loc_5++;
                }
            }
            this.info.causal_point = param1[2];
            return;
        }// end function

        public function getChallengeSection(param1:Array) : void
        {
            this.result = param1[0];
            this.info.aura = param1[1];
            this.info.next_lock = param1[2];
            this.warData = new WarData();
            this.warData.format([0, 0, 0, [param1[3][0]]]);
            return;
        }// end function

        public function recruitPartner(param1:Array) : void
        {
            this.result = param1[0];
            return;
        }// end function

    }
}
