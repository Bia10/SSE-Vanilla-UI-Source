import gfx.io.GameDelegate;
import Map.MapMenu;

class Map.LocalMap extends MovieClip
{
   
   var ClearedDescription: TextField;
   var ClearedText: TextField;
   var LocationDescription: TextField;

   var LocationTextClip: MovieClip;
   var TextureHolder: MovieClip;
   var LocalMapHolder_mc: MovieClip;
   var BottomBar: MovieClip;

   var MapImageLoader: MovieClipLoader;

   var _TextureWidth: Number;
   var _TextureHeight: Number;

   var IconDisplay: MapMenu;

   var bUpdated; //Bool?

   function LocalMap()
   {
      super();
      IconDisplay = new Map.MapMenu(this);
      MapImageLoader = new MovieClipLoader();
      MapImageLoader.addListener(this);
      _TextureWidth = 800;
      _TextureHeight = 450;
      LocationDescription = LocationTextClip.LocationText;
      LocationDescription.noTranslate = true;
      LocationTextClip.swapDepths(3);
      ClearedDescription = ClearedText;
      ClearedDescription.noTranslate = true;
      TextureHolder = LocalMapHolder_mc;
   }
   function get TextureWidth(): Number
   {
      return this._TextureWidth;
   }
   function get TextureHeight(): Number
   {
      return this._TextureHeight;
   }
   function onLoadInit(TargetClip: MovieClip): Void
   {
      TargetClip._width = _TextureWidth;
      TargetClip._height = _TextureHeight;
   }
   function InitMap(): Void
   {
      if(!bUpdated)
      {
         MapImageLoader.loadClip("img://Local_Map", TextureHolder);
         bUpdated = true;
      }
      var _loc3_ = {x:this._x,y:this._y};
      var _loc2_ = {x:this._x + this._TextureWidth,y:this._y + this._TextureHeight};
      _parent.localToGlobal(_loc3_);
      _parent.localToGlobal(_loc2_);
      GameDelegate.call("SetLocalMapExtents",[_loc3_.x,_loc3_.y,_loc2_.x,_loc2_.y]);
   }
   function Show(abShow): Void
   {
      _parent.gotoAndPlay(!abShow?"fadeOut":"fadeIn");
      BottomBar.RightButton.visible = !abShow;
      BottomBar.LocalMapButton.label = !abShow?"$Local Map":"$World Map";
   }
   function SetBottomBar(aBottomBar): Void
   {
      BottomBar = aBottomBar;
   }
   function SetTitle(aName, aCleared): Void
   {
      LocationDescription.text = aName == undefined?"":aName;
      ClearedDescription.text = aCleared == undefined?"":"(" + aCleared + ")";
   }
}
