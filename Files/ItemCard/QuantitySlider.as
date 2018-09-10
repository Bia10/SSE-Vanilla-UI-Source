import gfx.ui.InputDetails;
import gfx.ui.NavigationCode;
import Shared.GlobalFunc;

class QuantitySlider extends gfx.controls.Slider
{
   var dispatchEvent: Function;

   function QuantitySlider()
   {
      super();
   }
   function handleInput(details, pathToFocus) : Boolean
   {
      var bHandledInput = super.handleInput(details,pathToFocus);
      if(!bHandledInput)
      {
         if(Shared.GlobalFunc.IsKeyPressed(details))
         {
            if(details.navEquivalent == gfx.ui.NavigationCode.PAGE_DOWN || details.navEquivalent == gfx.ui.NavigationCode.GAMEPAD_L1)
            {
               value = Math.floor(this.__get__value() - this.__get__maximum() / 4);
               this.dispatchEvent({type:"change"});
               bHandledInput = true;
            }
            else if(details.navEquivalent == gfx.ui.NavigationCode.PAGE_UP || details.navEquivalent == gfx.ui.NavigationCode.GAMEPAD_R1)
            {
               value = Math.ceil(this.__get__value() + this.__get__maximum() / 4);
               this.dispatchEvent({type:"change"});
               bHandledInput = true;
            }
         }
      }
      return bHandledInput;
   }
}
