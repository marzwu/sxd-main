package com.assist.view.interfaces
{
    import com.assist.view.info.*;

    public interface IDreamSection extends IContent, IDragTitleBar
    {

        public function IDreamSection();

        function setInfo(param1:DreamSectionInfo) : void;

        function set onTip(param1:Function) : void;

        function set onWar(param1:Function) : void;

        function set onChangeEnding(param1:Function) : void;

        function set onNextPartner(param1:Function) : void;

        function set onRecruitmentRole(param1:Function) : void;

        function set onClose(param1:Function) : void;

        function recruitmentOver(param1:int) : void;

    }
}
