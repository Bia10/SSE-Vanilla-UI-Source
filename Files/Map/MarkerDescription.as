import gfx.io.GameDelegate;

class Map.MarkerDescription extends MovieClip
{
   var DescriptionList: Array;
   var LineItem0: MovieClip;
   var Title: TextField;

   function MarkerDescription()
   {
      super();
      Title = this.Title;
      Title.autoSize = "left";
      DescriptionList = new Array();
      DescriptionList.push(LineItem0);
      DescriptionList[0]._visible = false;
   }
   function SetDescription(aTitle, aLineItems): Void
   {
      Title.text = aTitle == undefined?"":aTitle;
      var _loc8_ = Title.text.length <= 0?0:Title._height;
      var _loc2_ = 0;
      while(_loc2_ < aLineItems.length)
      {
         if(_loc2_ >= DescriptionList.length)
         {
            DescriptionList.push(attachMovie("DescriptionLineItem","LineItem" + _loc2_,getNextHighestDepth()));
            DescriptionList[_loc2_]._x = DescriptionList[0]._x;
            DescriptionList[_loc2_]._y = DescriptionList[0]._y;
         }
         DescriptionList[_loc2_]._visible = true;
         var _loc3_ = DescriptionList[_loc2_].Item;
         var _loc5_ = DescriptionList[_loc2_].Value;
         var _loc4_ = aLineItems[_loc2_].Item;
         _loc3_.autoSize = "left";
         _loc3_.text = !(_loc4_ != undefined && _loc4_.length > 0)?"":_loc4_ + ": ";
         _loc5_.autoSize = "left";
         _loc5_.text = aLineItems[_loc2_].Value == undefined?"":aLineItems[_loc2_].Value;
         _loc5_._x = _loc3_._x + _loc3_._width;
         _loc8_ = _loc8_ + DescriptionList[_loc2_]._height;
         _loc2_ = _loc2_ + 1;
      }
      while(_loc2_ < DescriptionList.length)
      {
         DescriptionList[_loc2_]._visible = false;
         _loc2_ = _loc2_ + 1;
      }
      var _loc7_ = (- _loc8_) / 2;
      _loc2_ = 0;
      Title._y = _loc7_;
      _loc7_ = _loc7_ + (Title.text.length <= 0?0:Title._height);
      while(_loc2_ < DescriptionList.length)
      {
         DescriptionList[_loc2_]._y = _loc7_;
         _loc7_ = _loc7_ + DescriptionList[_loc2_]._height;
         _loc2_ = _loc2_ + 1;
      }
   }
   function OnShowFinish(): Void
   {
      GameDelegate.call("PlaySound",["UIMapRolloverFlyout"]);
   }
}
