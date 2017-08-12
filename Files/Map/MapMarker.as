import gfx.io.GameDelegate;

class Map.MapMarker extends gfx.controls.Button
{
   static var TopDepth = 0;
   static var IconTypes = new Array("EmptyMarker","CityMarker","TownMarker","SettlementMarker","CaveMarker","CampMarker","FortMarker","NordicRuinMarker","DwemerMarker","ShipwreckMarker","GroveMarker","LandmarkMarker","DragonlairMarker","FarmMarker","WoodMillMarker","MineMarker","ImperialCampMarker","StormcloakCampMarker","DoomstoneMarker","WheatMillMarker","SmelterMarker","StableMarker","ImperialTowerMarker","ClearingMarker","PassMarker","AltarMarker","RockMarker","LighthouseMarker","OrcStrongholdMarker","GiantCampMarker","ShackMarker","NordicTowerMarker","NordicDwellingMarker","DocksMarker","ShrineMarker","RiftenCastleMarker","RiftenCapitolMarker","WindhelmCastleMarker","WindhelmCapitolMarker","WhiterunCastleMarker","WhiterunCapitolMarker","SolitudeCastleMarker","SolitudeCapitolMarker","MarkarthCastleMarker","MarkarthCapitolMarker","WinterholdCastleMarker","WinterholdCapitolMarker","MorthalCastleMarker","MorthalCapitolMarker","FalkreathCastleMarker","FalkreathCapitolMarker","DawnstarCastleMarker","DawnstarCapitolMarker","DLC02MiraakTempleMarker","DLC02RavenRockMarker","DLC02StandingStonesMarker","DLC02TelvanniTowerMarker","DLC02ToSkyrimMarker","DLC02ToSolstheimMarker","DLC02CastleKarstaagMarker","","DoorMarker","QuestTargetMarker","QuestTargetDoorMarker","MultipleQuestTargetMarker","PlayerSetMarker","YouAreHereMarker");
   var HitAreaClip;

   var Index: Number;

   var TextClip: MovieClip;

   var _FadingIn: Boolean;
   var _FadingOut: Boolean;

   var state: String;

   var stateMap: Array;

   var textField: TextField;

   function MapMarker()
   {
      super();
      hitArea = HitAreaClip;
      textField = TextClip.MarkerNameField;
      textField.autoSize = "left";
      Index = -1;
      disableFocus = true;
      _FadingIn = false;
      _FadingOut = false;
      stateMap.release = ["up"];
   }
   function configUI()
   {
      super.configUI();
      onRollOver = function()
      {
      };
      onRollOut = function()
      {
      };
   }
   function get FadingIn(): Boolean
   {
      return _FadingIn;
   }
   function set FadingIn(value): Void
   {
      if(value != _FadingIn)
      {
         _FadingIn = value;
         if(_FadingIn)
         {
            _visible = true;
            gotoAndPlay("fade_in");
         }
      }
   }
   function get FadingOut(): Boolean
   {
      return _FadingOut;
   }
   function set FadingOut(value): Void
   {
      if(value != _FadingOut)
      {
         _FadingOut = value;
         if(_FadingOut)
         {
            gotoAndPlay("fade_out");
         }
      }
   }
   function setState(state): Void
   {
      if(!_FadingOut && !_FadingIn)
      {
         super.setState(state);
      }
   }
   function MarkerRollOver(): Boolean
   {
      var _loc2_ = false;
      setState("over");
      _loc2_ = state == "over";
      if(_loc2_)
      {
         var _loc3_ = _parent.getInstanceAtDepth(Map.MapMarker.TopDepth);
         if(undefined != _loc3_)
         {
            _loc3_.swapDepths(Map.MapMarker(_loc3_).Index);
         }
         swapDepths(Map.MapMarker.TopDepth);
         GameDelegate.call("PlaySound",["UIMapRollover"]);
      }
      return _loc2_;
   }
   function MarkerRollOut(): Void
   {
      setState("out");
   }
   function MarkerClick(): Void
   {
      GameDelegate.call("MarkerClick",[this.Index]);
   }
}
