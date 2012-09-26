package com.assist.view.interfaces
{
    import flash.display.*;

    public interface IMyFaction
    {

        public function IMyFaction();

        function get content() : MovieClip;

        function clear() : void;

        function set tip(param1:ITip) : void;

        function set drag(param1:IDrag) : void;

        function set getFactionData(param1:Object) : void;

        function set onSendFlower(param1:Function) : void;

        function set onClose(param1:Function) : void;

        function set onTanHe(param1:Function) : void;

        function set onOpenJoinFaction(param1:Function) : void;

        function set onOpenSsembly(param1:Function) : void;

        function set onShowPerson(param1:Function) : void;

        function set onShowLog(param1:Function) : void;

        function set onReturnTown(param1:Function) : void;

        function set isInAssembly(param1:Boolean) : void;

        function set onShowAudit(param1:Function) : void;

        function set onAllRefuse(param1:Function) : void;

        function set onPk(param1:Function) : void;

        function set onInvitation(param1:Function) : void;

        function set onPersonCheck(param1:Function) : void;

        function set onSendMessige(param1:Function) : void;

        function set onQuit(param1:Function) : void;

        function set onAddFriend(param1:Function) : void;

        function set onAppointJob(param1:Function) : void;

        function set onkickoutMember(param1:Function) : void;

        function set onDismissJob(param1:Function) : void;

        function set getFactionPersonList(param1:Array) : void;

        function set getFactionLogList(param1:Array) : void;

        function set getFactionApplyList(param1:Array) : void;

        function set onTextLink(param1:Function) : void;

        function set onRefuse(param1:Function) : void;

        function set onThrough(param1:Function) : void;

        function set onTransferFaction(param1:Function) : void;

        function set disMissBool(param1:String) : void;

        function set onDismissSure(param1:Function) : void;

        function set onDescInfo(param1:Function) : void;

        function set onNoticeInfo(param1:Function) : void;

        function set onGroupNumber(param1:Function) : void;

        function getInviteInfo(param1:Object) : void;

    }
}
