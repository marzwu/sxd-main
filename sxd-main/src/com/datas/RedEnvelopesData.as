package com.datas
{

    public class RedEnvelopesData extends Base
    {
        public var getEnvelopsInfo:Array;
        public var GetEnvelope:Array;
        public var getDate:Array;

        public function RedEnvelopesData()
        {
            return;
        }// end function

        public function get_envelopes_info(param1:Array) : void
        {
            this.getEnvelopsInfo = param1[0];
            return;
        }// end function

        public function get_envelope(param1:Array) : void
        {
            this.GetEnvelope = param1;
            return;
        }// end function

        public function get_date(param1:Array) : void
        {
            this.getDate = param1;
            return;
        }// end function

    }
}
