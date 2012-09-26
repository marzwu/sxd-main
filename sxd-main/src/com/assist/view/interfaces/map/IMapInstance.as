package com.assist.view.interfaces.map
{
    import com.assist.view.interfaces.factionWar.*;
    import flash.display.*;

    public interface IMapInstance
    {

        public function IMapInstance();

        function get town() : ITownMap;

        function get furnace() : IFurnaceMap;

        function get mission() : IMissionMap;

        function get boss() : IWorldBossMap;

        function get beelzebubTrials() : IBeelzebubTrialsMap;

        function get nineRegionsMap() : INineRegionsMap;

        function get topWarMap() : ITopWarMap;

        function get drama() : IDramaManage;

        function get frame() : IFrameSprite;

        function get worldFrame() : IWorldFrame;

        function get faction() : IFactionWarMap;

        function get boxObj() : MovieClip;

        function get boxStar() : MovieClip;

        function get soulBox() : MovieClip;

    }
}
