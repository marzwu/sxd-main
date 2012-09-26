package com.views
{
    import com.assist.server.*;
    import com.assist.view.interfaces.*;
    import com.haloer.net.*;
    import flash.geom.*;

    public class ActivitiesShowView extends Base implements IView
    {
        private var _activitisList:Array;
        private var _activitisObj:Object;
        private var _activitisDataList:Array;
        private var _activity:IActivitiesShow;

        public function ActivitiesShowView()
        {
            this._activitisObj = {hasData:false};
            this._activitisList = new Array();
            this._activitisDataList = new Array();
            return;
        }// end function

        public function show() : void
        {
            var _loc_1:Array = [_view.getAssetsUrl("ActivitiesShow")];
            File.loadList(_loc_1, this.render);
            return;
        }// end function

        private function render(param1:Array) : void
        {
            var _loc_2:Object = null;
            var _loc_3:Array = null;
            var _loc_4:int = 0;
            var _loc_5:String = null;
            var _loc_6:int = 0;
            var _loc_7:Object = null;
            var _loc_8:IActivitiesShow = null;
            var _loc_9:Point = null;
            var _loc_10:Point = null;
            if (!this._activitisObj.bHasData)
            {
                this._activitisObj.bHasData = true;
                _loc_3 = ActivityType.ActivitysList;
                _loc_4 = 0;
                while (_loc_4 < _loc_3.length)
                {
                    
                    this._activity = (param1[0] as File).getClassObject("ActivitiesShow") as IActivitiesShow;
                    _loc_5 = _loc_3[_loc_4];
                    this._activity.onStartActivity = this.onStartActivity;
                    if (ActivityType.ActivityAward == _loc_5)
                    {
                        this._activity.notCloseViewList = [ISealStone, IAlert];
                    }
                    _popup.addView(this, this._activity.content);
                    this._activitisObj[_loc_5] = this._activity;
                    _loc_6 = 0;
                    while (_loc_6 < this._activitisDataList.length)
                    {
                        
                        if (this._activitisDataList[_loc_6].type == _loc_5)
                        {
                            _loc_2 = this._activitisDataList[_loc_6];
                            this._activitisDataList.splice(_loc_6, 1);
                            if (_loc_2.bAdd)
                            {
                                this._activity.addActivity(_loc_2);
                            }
                            else
                            {
                                this._activity.removeActivity(_loc_2);
                            }
                            _loc_6 = _loc_6 - 1;
                        }
                        _loc_6++;
                    }
                    _loc_4++;
                }
            }
            while (this._activitisList.length > 0)
            {
                
                _loc_7 = this._activitisList.pop();
                _loc_8 = this._activitisObj[_loc_7.type];
                _loc_9 = Structure.stageOffset;
                _loc_10 = new Point();
                _loc_10.x = _loc_7.point.x - _loc_9.x;
                _loc_10.y = _loc_7.point.y - _loc_9.y;
                _loc_8.openPanel(_loc_10);
                this._activitisObj[_loc_7.type + "P"] = _loc_7.point;
            }
            return;
        }// end function

        public function close() : void
        {
            return;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

        public function openFunctionPanel(param1:Point, param2:String) : void
        {
            var _loc_5:IActivitiesShow = null;
            var _loc_3:Object = {};
            _loc_3.type = param2;
            _loc_3.point = param1;
            var _loc_4:int = 0;
            while (_loc_4 < this._activitisList.length)
            {
                
                if (this._activitisList[_loc_4].type == param2)
                {
                    this._activitisList.splice(_loc_4, 1);
                    return;
                }
                _loc_4++;
            }
            if (this._activitisObj.bHasData)
            {
                _loc_5 = this._activitisObj[param2];
                if (_loc_5.isOnStage)
                {
                    return;
                }
            }
            this._activitisList.push(_loc_3);
            return;
        }// end function

        public function addActivity(param1:String, param2:Boolean = true) : void
        {
            var _loc_4:IActivitiesShow = null;
            var _loc_5:int = 0;
            var _loc_6:Object = null;
            var _loc_7:Object = null;
            var _loc_3:* = ActivityType.getActivityDataForSign(param1);
            _loc_3.bAdd = param2;
            if (this._activitisObj.bHasData)
            {
                _loc_4 = this._activitisObj[_loc_3.type];
                if (param2)
                {
                    _loc_4.addActivity(_loc_3);
                }
                else
                {
                    _loc_4.removeActivity(_loc_3);
                }
                this.addParentButton(!_loc_4.isEmpty, _loc_3.type);
            }
            else
            {
                if (param2)
                {
                    this._activitisDataList.push(_loc_3);
                    this.addParentButton(true, _loc_3.type);
                    return;
                }
                _loc_5 = 0;
                while (_loc_5 < this._activitisDataList.length)
                {
                    
                    _loc_6 = this._activitisDataList[_loc_5];
                    if (_loc_6.sign == param1)
                    {
                        this._activitisDataList.splice(_loc_5, 1);
                        _loc_5 = _loc_5 - 1;
                    }
                    _loc_5++;
                }
                _loc_5 = 0;
                while (_loc_5 < this._activitisDataList.length)
                {
                    
                    _loc_7 = this._activitisDataList[_loc_5];
                    if (_loc_7.type == _loc_3.type)
                    {
                        this.addParentButton(true, _loc_3.type);
                        return;
                    }
                    _loc_5++;
                }
                this.addParentButton(false, _loc_3.type);
            }
            return;
        }// end function

        private function onStartActivity(param1:Object) : void
        {
            _view.activities.onStartActivity(param1);
            return;
        }// end function

        public function removeChildren() : void
        {
            var _loc_1:Array = null;
            var _loc_2:int = 0;
            var _loc_3:String = null;
            var _loc_4:IActivitiesShow = null;
            if (this._activitisObj.bHasData)
            {
                _loc_1 = ActivityType.ActivitysList;
                _loc_2 = 0;
                while (_loc_2 < _loc_1.length)
                {
                    
                    _loc_3 = _loc_1[_loc_2];
                    _loc_4 = this._activitisObj[_loc_3];
                    _loc_4.closePanel();
                    _loc_2++;
                }
            }
            return;
        }// end function

        public function addParentButton(param1:Boolean, param2:String) : void
        {
            if (param1)
            {
                _view.activities.addActivity(param2);
            }
            else
            {
                _view.activities.removeActivity(param2);
            }
            if (param2 == ActivityType.ActivityAward)
            {
                _view.activities.visibleBtnEffect(param2, "", param1);
            }
            return;
        }// end function

        public function reposition() : void
        {
            var _loc_1:Array = null;
            var _loc_2:int = 0;
            var _loc_3:String = null;
            var _loc_4:IActivitiesShow = null;
            var _loc_5:Point = null;
            var _loc_6:Point = null;
            var _loc_7:Point = null;
            if (this._activitisObj.bHasData)
            {
                _loc_1 = ActivityType.ActivitysList;
                _loc_2 = 0;
                while (_loc_2 < _loc_1.length)
                {
                    
                    _loc_3 = _loc_1[_loc_2];
                    _loc_4 = this._activitisObj[_loc_3];
                    _loc_5 = Structure.stageOffset;
                    _loc_6 = _view.activities.getActivityPoint(_loc_3);
                    _loc_7 = new Point();
                    _loc_7.x = _loc_6.x - _loc_5.x;
                    _loc_7.y = _loc_6.y - _loc_5.y;
                    _loc_4.updatePoint = _loc_7;
                    _loc_2++;
                }
            }
            return;
        }// end function

    }
}
