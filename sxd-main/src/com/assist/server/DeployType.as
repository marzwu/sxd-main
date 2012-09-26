package com.assist.server
{

    public class DeployType extends Object
    {
        private static const Deploys:Object = {1:"天阵", 2:"地阵", 3:"水阵", 4:"火阵", 5:"风阵", 6:"雷阵", 7:"山阵", 8:"泽阵", 20:"全开阵"};

        public function DeployType()
        {
            return;
        }// end function

        public static function getDeployName(param1:int) : String
        {
            return Deploys[param1] || "";
        }// end function

    }
}
