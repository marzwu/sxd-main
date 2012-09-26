package com.assist.view.info
{
    import com.assist.server.*;

    public class PlayerInfo extends Object
    {
        public var id:int;
        public var roleId:int;
        public var x:int;
        public var y:int;
        public var name:String = "";
        public var nameColor:int = 15658734;
        public var _followRoleId:int = 0;
        public var isMine:Boolean = false;
        public var is_have_cat:Boolean = false;
        public var is_role_follow:Boolean = false;
        public var is_pet_follow:Boolean = false;
        public var is_cat_follow:Boolean = false;
        public var fullHeadUrl:String = "";
        public var sign:String = "";
        private var _signSuffix:String = "";
        public var bPutOnClothes:Boolean = false;
        public var starUser:int = 0;
        public var topUser:int = 0;
        public var petLv:int = 0;
        public var petStar:int = 0;
        public var isChampion:Boolean;
        public var sign2:String = "";
        public var action2:String = "";
        public var speed:int = 0;
        public var offY1:int = 0;
        public var offY2:int;
        public var showType:int = 0;
        public var underPractice:int = 0;
        public var warState:int = 0;
        public var factionId:int = 0;
        public var factionName:String = "";
        public var factionColor:int = 15658734;
        public var practice:int = 0;
        public var practiceExp:int = 0;
        public var practiceExpOne:int = 0;
        public var practiceTime:int = 0;
        public var practiceWar:int = 0;
        public var practiceSpeedNum:int = 0;
        public var prestigeNo1PlayerIdList:Array;
        public var rangkingofType:int = 0;
        private var _itemIdMount:int = 0;
        private var _itemIdAvatar:int = 0;
        public static var info:PlayerInfo;

        public function PlayerInfo(param1:Boolean = false) : void
        {
            this.prestigeNo1PlayerIdList = [];
            this.isMine = param1;
            if (param1)
            {
                this.nameColor = 15964160;
            }
            return;
        }// end function

        public function get signSuffix() : String
        {
            return this._signSuffix;
        }// end function

        public function set signSuffix(param1:String) : void
        {
            this._signSuffix = param1;
            return;
        }// end function

        public function set followRoleId(param1:int) : void
        {
            this._followRoleId = param1;
            return;
        }// end function

        public function get followRoleId() : int
        {
            return this._followRoleId;
        }// end function

        public function get signHash() : String
        {
            return this.sign2 + this.action2 + this.sign + this.signSuffix + this.practice;
        }// end function

        public function get nameHtml() : String
        {
            return "<font size=\'13\' color=\'#" + this.nameColor.toString(16) + "\'>" + this.name + "</font>";
        }// end function

        public function get factionNameHtml() : String
        {
            if (this.factionId == 0)
            {
                return "";
            }
            return "\n<font size=\'13\' color=\'#" + this.factionColor.toString(16) + "\'>【" + this.factionName + "】</font>";
        }// end function

        public function setMount(param1:int) : void
        {
            this._itemIdMount = param1;
            this.updateMountAvatar();
            return;
        }// end function

        public function setAvatar(param1:int) : void
        {
            this._itemIdAvatar = param1;
            this.updateMountAvatar();
            return;
        }// end function

        private function updateMountAvatar() : void
        {
            var _loc_1:int = 0;
            var _loc_2:String = null;
            this.sign2 = "";
            this.action2 = "";
            var _loc_3:int = 0;
            this.underPractice = 0;
            var _loc_3:* = _loc_3;
            this.showType = _loc_3;
            var _loc_3:* = _loc_3;
            this.offY2 = _loc_3;
            var _loc_3:* = _loc_3;
            this.offY1 = _loc_3;
            this.speed = _loc_3;
            if (this._itemIdMount == 32)
            {
                this.action2 = "cloud";
                this.sign2 = "cloud";
                this.speed = 40;
                this.offY1 = 21;
                this.offY2 = -38;
                this.showType = 1;
            }
            else if (this._itemIdMount == 1008)
            {
                this.action2 = "cloud";
                this.sign2 = "feijian";
                this.speed = 80;
                this.offY1 = 21;
                this.offY2 = -43;
                this.showType = 1;
                this.underPractice = 1;
            }
            else if (this._itemIdMount == 1192)
            {
                this.action2 = "cloud";
                this.sign2 = "hulu";
                this.speed = 100;
                this.offY1 = 21;
                this.offY2 = -95;
                this.showType = 1;
                this.underPractice = 1;
            }
            else if (this._itemIdMount == 1195)
            {
                this.action2 = "cloud";
                this.sign2 = "hulu2";
                this.speed = 100;
                this.offY1 = 21;
                this.offY2 = -95;
                this.showType = 1;
                this.underPractice = 1;
            }
            else if (this._itemIdMount == 1094)
            {
                this.action2 = "cloud";
                this.sign2 = "cloud2";
                this.speed = 100;
                this.offY1 = 21;
                this.offY2 = -50;
                this.showType = 1;
                this.underPractice = 1;
            }
            else if (this._itemIdMount == 1055)
            {
                this.action2 = "mount_baihu_";
                this.sign2 = "BaiHu";
                this.speed = 100;
                this.showType = 2;
                this.underPractice = 1;
            }
            else if (this._itemIdMount == 1177)
            {
                this.action2 = "mount_lingyu_";
                this.sign2 = "LingYu";
                this.speed = 100;
                this.showType = 2;
                this.underPractice = 1;
            }
            else if (this._itemIdMount == 1196)
            {
                this.action2 = "";
                this.sign2 = "mount_fenleiyi_";
                this.speed = 150;
                this.showType = 3;
                this.underPractice = 1;
            }
            else if (this._itemIdMount == 1372)
            {
                this.speed = 150;
                this.showType = 4;
                this.underPractice = 1;
                this.sign2 = RoleType.getRoleSign(this.roleId) + "_0214";
            }
            else if (this._itemIdMount == 1482)
            {
                this.speed = 100;
                _loc_2 = RoleType.getRoleSign(this.roleId) + "_Q0";
                this.sign2 = _loc_2;
                this.showType = 4;
                this.underPractice = 1;
            }
            else if (this._itemIdAvatar != 0)
            {
                _loc_1 = ItemType.getMonsterId(this._itemIdAvatar);
                _loc_2 = MonsterType.getMonsterSign(_loc_1);
                _loc_2 = MonsterType.sameResource(_loc_2);
                this.sign2 = _loc_2;
                this.showType = 4;
                this.underPractice = 1;
            }
            return;
        }// end function

    }
}
