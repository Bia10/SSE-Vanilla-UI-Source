/**
 * 
 */

/**********************************************************************
 Copyright (c) 2010 Scaleform Corporation. All Rights Reserved.
 Licensees may use this file in accordance with the valid Scaleform
 License Agreement provided with the software. This file is provided 
 AS IS with NO WARRANTY OF ANY KIND, INCLUDING THE WARRANTY OF DESIGN, 
 MERCHANTABILITY AND FITNESS FOR ANY PURPOSE.
**********************************************************************/

import gfx.core.UIComponent;
import gfx.utils.Constraints;

[InspectableList("vconstrain", "hconstrain", "focusModeVertical", "focusModeHorizontal", "controllerMask", "visible")]
class gfx.layout.Panel extends UIComponent {

	[Inspectable(type="String", enumeration="none,top,center,bottom,all", defaultValue="none")]	
	public var vconstrain:String = "none";
	[Inspectable(type="String", enumeration="none,left,center,right,all", defaultValue="none")]
	public var hconstrain:String = "none";
	[Inspectable(type="String", enumeration="default,loop,hold", defaultValue="default")]
	public var focusModeVertical:String = "default";
	[Inspectable(type="String", enumeration="default,loop,hold", defaultValue="default")]
	public var focusModeHorizontal:String = "default";
	[Inspectable(type="String", defaultValue="FFFF")]
	public var controllerMask:String = "FFFF";

	private var _constraints:Constraints;
	private var _hcenter:Array;
	private var _vcenter:Array;
		
// Initialization:
	/**
	 * 
	 */
	public function Panel() {
		super();		
	}
			
	/** @exclude */
	public function toString():String {
		return "[Scaleform Panel " + _name + "]";
	}

// Private Methods:
	private function configUI():Void {
		super.configUI();

		// Setup focus group system mask
		MovieClip(this).focusGroupMask = parseInt(controllerMask, 16);
		
		// Constrain mode for non-panel elements
		var hstretch:Boolean = (this.hconstrain == "all");
		var vstretch:Boolean = (this.vconstrain == "all");

		_constraints = new Constraints(this);
		_hcenter = [];
		_vcenter = [];

		// Find sub elements	
		for (var i in this) {
			var obj:Object = this[i];
			
			// Child panel?
			if (obj instanceof Panel) {
				var vconstrain:Number = 0;
				var hconstrain:Number = 0;
				var panel:Panel = Panel(obj);
				switch (panel.vconstrain) {
					case "top": { vconstrain = Constraints.TOP; break; }
					case "center": { 
						addToVCenter(panel);
						break; 
					}
					case "bottom": { vconstrain = Constraints.BOTTOM; break; }
					case "all": { vconstrain = Constraints.TOP | Constraints.BOTTOM; break; }
				}
				switch (panel.hconstrain) {
					case "left": { hconstrain = Constraints.LEFT; break; }
					case "center": { 
						addToHCenter(panel);
						break; 
					}
					case "right": { hconstrain = Constraints.RIGHT; break; }
					case "all": { hconstrain = Constraints.LEFT | Constraints.RIGHT; break; }					
				}				
				_constraints.addElement(obj, vconstrain | hconstrain);
			}
			
			// Other element?
			else if (obj instanceof MovieClip) {
				if (hstretch || vstretch) {
					_constraints.addElement(obj, (hstretch ? (Constraints.LEFT | Constraints.RIGHT) : 0) | 
												 (vstretch ? (Constraints.TOP | Constraints.BOTTOM) : 0));
				}
			}
		}			
	}

	private function addToHCenter(clip:MovieClip):Void {
		if (!_hcenter) { _hcenter = []; }
		_hcenter.push({clip:clip, metrics:{left:clip._x, right:_width-clip._x-clip._width}});
	}
	
	private function addToVCenter(clip:MovieClip):Void {
		if (!_vcenter) { _vcenter = []; }
		_vcenter.push({clip:clip, metrics:{top:clip._y, right:_height-clip._y-clip._height}});
	}

	private function draw():Void {
		_constraints.update(__width, __height);
		
		if (_hcenter || _vcenter) {
			var o:flash.geom.Rectangle = Stage.originalRect;
			var wdelta:Number = (__width - o.width) / 2;
			var hdelta:Number = (__height - o.height) / 2;
			
			if (_vcenter) {
				for (var i:Number = 0; i < _vcenter.length; i++) {
					var elem:Object = _vcenter[i];
					var clip:MovieClip = elem.clip;
					var metrics:Object = elem.metrics;					
					clip._y = metrics.top + hdelta;
				}
			}
			if (_hcenter) {
				for (var i:Number = 0; i < _hcenter.length; i++) {
					var elem:Object = _hcenter[i];
					var clip:MovieClip = elem.clip;			
					var metrics:Object = elem.metrics;
					clip._x = metrics.left + wdelta;
				}
			}
		}
	}
}
