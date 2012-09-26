package com.assist.view.info
{

    public class RoleInfo extends Object
    {
        public var name:String = "";
        public var playerRoleId:int = 0;
        public var roleId:int = 0;
        public var jobId:int = 0;
        public var lv:int = 0;
        public var exp:Number = 0;
        public var expMax:Number = 0;
        public var fame:int = 0;
        public var fameLv:int = 0;
        public var pZhiYe:String = "";
        public var pShengMing:int = 0;
        public var pWuLi:int = 0;
        public var pZhanFa:String = "";
        public var pZhanFaMsg:String = "";
        public var pJueJi:int = 0;
        public var pWuXing:int = 0;
        public var pFaShu:int = 0;
        public var roleTopMsg:String = "";
        public var tingzhong:String = "0";
        public var flowers:String = "0";
        public var headUrl:String = "";
        public var sign:String = "";
        public var showDanYao:Boolean = false;
        public var showTraining:Boolean = false;
        public var showFollow:Boolean = false;
        public var showFlower:Boolean = false;
        public var showTFFame:Boolean = false;
        public var showChuanCheng:Boolean = false;
        public var showSeeInfo:Boolean = false;
        public var showYaoQing:Boolean = false;
        public var showOtherStrength:Boolean = true;
        public var showOtherFlowers:Boolean = true;
        public var canTrans:String = "";
        public var toTrans:String = "";
        public var beTrans:String = "";
        public var isdeploy:int = 0;
        public var fatePower:int = 0;
        public var ismain:Boolean = false;
        public var isfight:Boolean = false;
        public var petLv:int = 0;
        public var petStar:int = 0;

        public function RoleInfo()
        {
            return;
        }// end function

        public function get isFollow() : Boolean
        {
            return PlayerInfo.info.followRoleId == this.roleId;
        }// end function

        public function get nameColor() : int
        {
            if (this.isfight)
            {
                return 15963904;
            }
            return 16114847;
        }// end function

        public function get priority() : int
        {
            if (this.ismain)
            {
                return 10000;
            }
            if (this.isfight)
            {
                return 1000 + this.lv;
            }
            return this.lv;
        }// end function

    }
}
