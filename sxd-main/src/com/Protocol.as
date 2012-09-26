package com
{
    import com.assist.*;
    import com.haloer.utils.*;
    import com.protocols.*;
    import flash.utils.*;

    public class Protocol extends Object
    {
        private static var _wired:Dictionary;
        public static var modName:String;
        public static var funName:String;

        public function Protocol()
        {
            return;
        }// end function

        public static function init() : void
        {
            if (_wired == null)
            {
                _wired = new Dictionary();
                addWired(Mod_Town_Base.enter_town);
                addWired(Mod_Town_Base.leave_town);
                addWired(Mod_Town_Base.move_to);
                addWired(Mod_Chat_Base.bro_to_players);
                addWired(Mod_Player_Base.update_player_data);
            }
            return;
        }// end function

        public static function addWired(param1:Object) : void
        {
            var _loc_2:* = param1["module"];
            var _loc_3:* = param1["action"];
            _wired[concat(_loc_2, _loc_3)] = true;
            return;
        }// end function

        public static function removeWired(param1:int, param2:int) : void
        {
            var _loc_3:* = concat(param1, param2);
            if (_wired[_loc_3])
            {
                delete _wired[_loc_3];
            }
            return;
        }// end function

        public static function keepAlive(param1:int, param2:int) : Boolean
        {
            return _wired[concat(param1, param2)];
        }// end function

        public static function concat(param1:int, param2:int) : String
        {
            return [param1, "-", param2].join("");
        }// end function

        public static function analyze(param1:ByteArray, param2:Array) : Array
        {
            var _loc_3:* = readArray(param1, param2);
            return _loc_3;
        }// end function

        private static function readArray(param1:ByteArray, param2:Array) : Array
        {
            var _loc_6:int = 0;
            var _loc_7:uint = 0;
            var _loc_8:Number = NaN;
            var _loc_9:Array = null;
            var _loc_10:uint = 0;
            var _loc_11:int = 0;
            var _loc_3:Array = [];
            var _loc_4:* = param2.length;
            var _loc_5:uint = 0;
            while (_loc_5 < _loc_4)
            {
                
                switch(param2[_loc_5])
                {
                    case Utils.BooleanUtil:
                    {
                        _loc_3.push(param1.readBoolean());
                        break;
                    }
                    case Utils.ByteUtil:
                    {
                        _loc_3.push(param1.readByte());
                        break;
                    }
                    case Utils.DoubleUtil:
                    {
                        _loc_3.push(param1.readDouble());
                        break;
                    }
                    case Utils.LongUtil:
                    {
                        _loc_6 = param1.readInt();
                        _loc_7 = param1.readUnsignedInt();
                        _loc_8 = _loc_6 * Math.pow(2, 32) + _loc_7;
                        _loc_3.push(_loc_8);
                        break;
                    }
                    case Utils.FloatUtil:
                    {
                        _loc_3.push(param1.readFloat());
                        break;
                    }
                    case Utils.IntUtil:
                    {
                        _loc_3.push(param1.readInt());
                        break;
                    }
                    case Utils.ShortUtil:
                    {
                        _loc_3.push(param1.readShort());
                        break;
                    }
                    case Utils.StringUtil:
                    {
                        _loc_3.push(param1.readUTF());
                        break;
                    }
                    default:
                    {
                        if (param2[_loc_5] is Array)
                        {
                            _loc_9 = [];
                            _loc_10 = param1.readUnsignedShort();
                            _loc_11 = 0;
                            while (_loc_11 < _loc_10)
                            {
                                
                                _loc_9[_loc_11] = readArray(param1, param2[_loc_5]);
                                _loc_11++;
                            }
                            _loc_3.push(_loc_9);
                        }
                        break;
                    }
                }
                _loc_5 = _loc_5 + 1;
            }
            return _loc_3;
        }// end function

        public static function synthesize(param1:Array, param2:Array) : ByteArray
        {
            return writeArray(param1, param2, true);
        }// end function

        private static function writeArray(param1:Array, param2:Array, param3:Boolean = false) : ByteArray
        {
            var _loc_6:uint = 0;
            var _loc_8:String = null;
            var _loc_9:uint = 0;
            var _loc_10:uint = 0;
            var _loc_11:int = 0;
            var _loc_12:int = 0;
            var _loc_13:ByteArray = null;
            var _loc_4:* = new ByteArray();
            var _loc_5:* = param2.length;
            if (param1.length != _loc_5)
            {
                _loc_8 = "[request]接口不匹配：" + getProtocolDescription(param2);
                Helper.error(_loc_8);
                throw new Error(_loc_8);
            }
            _loc_6 = 0;
            while (_loc_6 < _loc_5)
            {
                
                switch(param2[_loc_6])
                {
                    case Utils.BooleanUtil:
                    {
                        _loc_4.writeBoolean(param1[_loc_6]);
                        break;
                    }
                    case Utils.ByteUtil:
                    {
                        _loc_4.writeByte(param1[_loc_6]);
                        break;
                    }
                    case Utils.DoubleUtil:
                    {
                        _loc_4.writeDouble(param1[_loc_6]);
                        break;
                    }
                    case Utils.LongUtil:
                    {
                        _loc_9 = param1[_loc_6] / Math.pow(2, 32);
                        _loc_10 = param1[_loc_6] % Math.pow(2, 32);
                        _loc_4.writeUnsignedInt(_loc_9);
                        _loc_4.writeUnsignedInt(_loc_10);
                        break;
                    }
                    case Utils.FloatUtil:
                    {
                        _loc_4.writeFloat(param1[_loc_6]);
                        break;
                    }
                    case Utils.IntUtil:
                    {
                        _loc_4.writeInt(param1[_loc_6]);
                        break;
                    }
                    case Utils.ShortUtil:
                    {
                        _loc_4.writeShort(param1[_loc_6]);
                        break;
                    }
                    case Utils.StringUtil:
                    {
                        _loc_4.writeUTF(param1[_loc_6]);
                        break;
                    }
                    default:
                    {
                        if (param2[_loc_6] is Array)
                        {
                            _loc_11 = param1[_loc_6].length;
                            _loc_4.writeShort(_loc_11);
                            _loc_12 = 0;
                            while (_loc_12 < _loc_11)
                            {
                                
                                _loc_13 = writeArray(param1[_loc_6][_loc_12], param2[_loc_6], true);
                                _loc_4.writeBytes(_loc_13, 0, _loc_13.length);
                                _loc_12++;
                            }
                        }
                        break;
                    }
                }
                _loc_6 = _loc_6 + 1;
            }
            var _loc_7:* = new ByteArray();
            if (param3 == false)
            {
                _loc_7.writeShort(_loc_4.length);
            }
            _loc_7.writeBytes(_loc_4, 0, _loc_4.length);
            return _loc_7;
        }// end function

        public static function lookupProtocol(param1:int, param2:int) : Object
        {
            var _loc_4:String = null;
            var _loc_5:Object = null;
            var _loc_6:Array = null;
            var _loc_7:int = 0;
            var _loc_8:int = 0;
            var _loc_9:Object = null;
            var _loc_3:Object = {};
            for (_loc_4 in Mod.Modules)
            {
                
                if (parseInt(_loc_4) == param1)
                {
                    _loc_5 = Mod.Modules[_loc_4];
                    _loc_6 = _loc_5["Actions"];
                    _loc_7 = _loc_6.length;
                    _loc_8 = 0;
                    while (_loc_8 < _loc_7)
                    {
                        
                        _loc_9 = _loc_5[_loc_6[_loc_8]];
                        if (_loc_9["action"] == param2)
                        {
                            _loc_3 = _loc_9;
                            break;
                        }
                        _loc_8++;
                    }
                    break;
                }
            }
            return _loc_3;
        }// end function

        public static function getProtocolDescription(param1:Array) : String
        {
            var _loc_3:String = null;
            var _loc_4:Class = null;
            var _loc_5:Array = null;
            var _loc_6:int = 0;
            var _loc_7:int = 0;
            var _loc_8:Object = null;
            var _loc_2:String = "";
            for (_loc_3 in Mod.Modules)
            {
                
                _loc_4 = Mod.Modules[_loc_3];
                _loc_5 = _loc_4["Actions"];
                _loc_6 = _loc_5.length;
                _loc_7 = 0;
                while (_loc_7 < _loc_6)
                {
                    
                    _loc_8 = _loc_4[_loc_5[_loc_7]];
                    if (_loc_8["request"] == param1)
                    {
                        modName = (_loc_4 + "").replace(/^\[class |\]$""^\[class |\]$/g, "");
                        funName = _loc_5[_loc_7];
                        _loc_2 = [modName, "(module:", _loc_8["module"], ")", ", ", funName, "(action:", _loc_8["action"], ")"].join("");
                        break;
                    }
                    _loc_7++;
                }
            }
            return _loc_2;
        }// end function

    }
}
