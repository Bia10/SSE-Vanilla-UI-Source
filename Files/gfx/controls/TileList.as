﻿/**
 * The TileList, similar to the ScrollingList, is a list component that can scroll its elements. It can instantiate list items by itself or use existing list items on the stage. A ScrollIndicator or ScrollBar component can also be attached to this list component to provide scoll feedback and control. The difference between the TileList and the ScrollingList is that the TileList can support multiple rows and columns at the same time. List item selection can move in all four cardinal directions. This component is populated via a DataProvider. The dataProvider is assigned via code, as shown in the example below:
<i>tileList.dataProvider = ["item1", "item2", "item3", "item4", "item5"];</i>

	<b>Inspectable Properties</b>
	A MovieClip that derives from the TileList component will have the following inspectable properties:<ul>
	<li><i>visible</i>: Hides the component if set to false. This does not hide the attached scrollbar or any external list item renderers.</li>
	<li><i>disabled</i>: Disables the component if set to true. This does disable both the attached scrollbar and the list items (both internally created and external renderers).</li>
	<li><i>itemRenderer</i>: The symbol name of the ListItemRenderer. Used to create list item instances internally. Has no effect if the rendererInstanceName property is set.</li>
	<li><i>rendererInstanceName</i>: Prefix of the external list item renderers to use with this ScrollingList component. The list item instances on the stage must be prefixed with this property value. If this property is set to the value ‘r’, then all list item instances to be used with this component must have the following values: ‘r1’, ‘r2’, ‘r3’,… The first item should have the number 1.</li>
	<li><i>scrollBar</i>: Instance name of a ScrollBar component on the stage or a symbol name. If an instance name is specified, then the ScrollingList will hook into that instance. If a symbol name is specified, an instance of the symbol will be created by the ScrollingList.</li>
	<li><i>margin</i>: The margin between the boundary of the list component and the list items created internally. This value has no effect if the rendererInstanceName property is set.</li>
	<li><i>rowHeight</i>: The height of list item instances created internally. This value has no effect if the rendererInstanceName property is set.</li>
	<li><i>columnWidth</i>: The width of list item instances created internally. This value has no effect if the rendererInstanceName property is set.</li>
	<li><i>externalColumnCount</i>: When the rendererInstanceName property is set, this value is used to notify the TileList of the number of columns used by the external renderers.</li>
	<li><i>direction</i>: The scrolling direction. The semantics of rows and columns do not change depending on this value. </li>
    <li><i>enableInitCallback</i>: If set to true, _global.CLIK_loadCallback() will be fired when a component is loaded and _global.CLIK_unloadCallback will be called when the component is unloaded. These methods receive the instance name, target path, and a reference the component as parameters.  _global.CLIK_loadCallback and _global.CLIK_unloadCallback should be overriden from the game engine using GFx FunctionObjects.</li>
	<li><i>soundMap</i>: Mapping between events and sound process. When an event is fired, the associated sound process will be fired via _global.gfxProcessSound, which should be overriden from the game engine using GFx FunctionObjects.</li></ul>
	
	<b>States</b>
	The TileList component supports three states based on its focused and disabled properties. <ul>
	<li>default or enabled state.</li>
	<li>focused state, that typically highlights the component’s border area.</li>
	<li>disabled state.</li></ul>
	
	<b>Events</b>
	All event callbacks receive a single Object parameter that contains relevant information about the event. The following properties are common to all events. <ul>
	<li><i>type</i>: The event type.</li>
	<li><i>target</i>: The target that generated the event.</li></ul>
		
	The events generated by the TileList component are listed below. The properties listed next to the event are provided in addition to the common properties.<ul>
	<li><i>show</i>: The component’s visible property has been set to true at runtime.</li>
	<li><i>hide</i>: The component’s visible property has been set to false at runtime.</li>
	<li><i>focusIn</i>: The component has received focus.</li>
	<li><i>focusOut</i>: The component has lost focus.</li>
	<li><i>change</i>: The selected index has changed.<ul>
		<li><i>index</i>: The new selected index. Number type. Values 0 to number of list items minus 1.</li></ul></li>
	<li><i>itemPress</i>: The list item has been pressed down.<ul>
		<li><i>renderer</i>: The list item that was pressed. CLIK Button type. </li>
		<li><i>item</i>: The data associated with the list item. This value is retrieved from the list’s DataProvider. AS2 Object type. </li>
		<li><i>index</i>: The index of the list item relative to the list’s DataProvider. Number type. Values 0 to number of list items minus 1.</li>
		<li><i>controllerIdx</i>: The index of the mouse cursor used to generate the event (Applicable only for multi-mouse-cursor environments). Number type. Values 0 to 3.</li></ul></li>
	<li><i>itemClick</i>: A list item has been clicked.<ul>
		<li><i>renderer</i>: The list item that was clicked. CLIK Button type.</li>
		<li><i>item</i>: The data associated with the list item. This value is retrieved from the list’s DataProvider.AS2 Object type.</li>
		<li><i>index</i>: The index of the list item relative to the list’s DataProvider. Number type. Values 0 to number of list items minus 1.</li>
		<li><i>controllerIdx</i>: The index of the mouse cursor used to generate the event (Applicable only for multi-mouse-cursor environments). Number type. Values 0 to 3.</li></ul></li>
	<li><i>itemDoubleClick</i>: The mouse cursor has been double clicked.<ul>
		<li><i>renderer</i>: The list item was double clicked. CLIK Button type.</li>
		<li><i>item</i>: The data associated with the list item. This value is retrieved from the list’s DataProvider. AS2 Object type.</li>
		<li><i>index</i>: The index of the list item relative to the list’s DataProvider. Number type. Values 0 to number of list items minus 1.</li>
		<li><i>controllerIdx</i>: The index of the mouse cursor used to generate the event (Applicable only for multi-mouse-cursor environments). Number type. Values 0 to 3.</li></ul></li>
	<li><i>itemRollOver</i>: The mouse cursor has rolled over a list item.<ul>
		<li><i>renderer</i>: The list item that was rolled over. CLIK Button type.</li>
		<li><i>item</i>: The data associated with the list item. This value is retrieved from the list’s DataProvider. AS2 Object type.</li>
		<li><i>index</i>: The index of the list item relative to the list’s DataProvider. Number type. Values 0 to number of list items minus 1.</li>
		<li><i>controllerIdx</i>: The index of the mouse cursor used to generate the event (Applicable only for multi-mouse-cursor environments). Number type. Values 0 to 3.</li></ul></li>
	<li><i>itemRollOut</i>: The mouse cursor has rolled out of a list item.<ul>
		<li><i>renderer</i>: The list item that was rolled out of. CLIK Button type.</li>
		<li><i>item</i>: The data associated with the list item. This value is retrieved from the list’s DataProvider. AS2 Object type.</li>
		<li><i>index</i>: The index of the list item relative to the list’s DataProvider. Number type. Values 0 to number of list items minus 1.</li>
		<li><i>controllerIdx</i>: The index of the mouse cursor used to generate the event (Applicable only for multi-mouse-cursor environments).  Number type. Values 0 to 3.</li></ul></li></ul>
 */

/**********************************************************************
 Copyright (c) 2009 Scaleform Corporation. All Rights Reserved.

 Portions of the integration code is from Epic Games as identified by Perforce annotations.
 Copyright © 2010 Epic Games, Inc. All rights reserved.
 
 Licensees may use this file in accordance with the valid Scaleform
 License Agreement provided with the software. This file is provided 
 AS IS with NO WARRANTY OF ANY KIND, INCLUDING THE WARRANTY OF DESIGN, 
 MERCHANTABILITY AND FITNESS FOR ANY PURPOSE.
**********************************************************************/

/*
	LM: Consider adding "wrapping" behaviour that exists in ScrollingList.
*/
 
import flash.external.ExternalInterface; 
import gfx.controls.CoreList;
import gfx.ui.InputDetails;
import gfx.ui.NavigationCode;
 
[InspectableList("disabled", "visible", "itemRenderer", "inspectableScrollBar", "rowHeight", "columnWidth", "direction", "inspectableRendererInstanceName", "externalColumnCount", "margin", "enableInitCallback", "soundMap", "wrapOutOfSet")]
class gfx.controls.TileList extends CoreList {
	
// Constants:

// Public Properties:
	/** 
	 * Determines how focus "wraps" when the end or beginning of the component is reached.
	 	<ul>
		<li>"normal": The focus will leave the component when it reaches the end of the data</li>
		<li>"wrap": The selection will wrap to the beginning or end.</li>
		<li>"stick": The selection will stop when it reaches the end of the data.</li>
		<li>"refuse": The selection will refuse to change if it is asked to go off of the end of the data</li>
		</ul>
	 */
	public var wrapping:String = "normal";
	
	//Whether or not to wrap to the next set or not when moving within a set (column if direction is horizontal, or row if direction is vertical.
	[Inspectable(defaultValue=false)]
	public var wrapOutOfSet:Boolean = false;
	
	/** Determines if the "rowCount" property is applied directly, or converted by the component. ScrollingList does not use autoRowCount, but includes it for consistency. **/
	public var autoRowCount:Boolean = false;

// Private Properties:	
	private var _rowHeight:Number;
	private var _columnWidth:Number;
	private var _direction:String = "horizontal";
	private var _scrollPosition:Number = 0;
	private var _rowCount:Number; //?
	private var _columnCount:Number;
	private var totalRows:Number = 0;
	private var totalColumns:Number = 0;
	[Inspectable(name="scrollBar", type="String")]
	private var inspectableScrollBar:Object;
	private var autoScrollBar:Boolean = false;
	/** The number of columns to use when setting external item renderers */
	[Inspectable()]
	private var externalColumnCount:Number = 0;
	[Inspectable(defaultValue="1")]
	private var margin:Number = 1;
	//Whether or not this list has a selectable item in it
	private var bHasASelectableItem:Boolean = false;
	
// UI Elements:	
	private var _scrollBar:MovieClip;


	
// Initialization:
	/**
	 * The constructor is called when a TileList or a sub-class of TileList is instantiated on stage or by using {@code attachMovie()} in ActionScript. This component can <b>not</b> be instantiated using {@code new} syntax. When creating new components that extend TileList, ensure that a {@code super()} call is made first in the constructor.
	 */
	public function TileList() { super(); }

// Public Methods:
	/**
	 * Get and set a ScrollBar for the list. The scrollBar can be set as a library linkage ID, an instance name on the stage relative to the component, or a reference to an existing ScrollBar elsewhere in the application. The automatic behaviour in this component only supports a vertical scrollBar, positioned on the top right, the entire height of the component.
	 */
	public function get scrollBar():Object { return _scrollBar; }
	public function set scrollBar(value:Object):Void {
		if (!initialized) { 
			inspectableScrollBar = value; 
			return;
		}
		
		if (_scrollBar != null) {
			_scrollBar.removeEventListener("scroll", this, "handleScroll");
			_scrollBar.removeEventListener("change", this, "handleScroll");
			_scrollBar.focusTarget = null;
			if (autoScrollBar) { _scrollBar.removeMovieClip(); } // Clean up auto-created scrollbars only!
		}
		
		autoScrollBar = false; // Reset
		if (typeof(value) == "string") {
			_scrollBar = MovieClip(_parent[value.toString()]); // Outside reference by name
			if (_scrollBar == null) {
				_scrollBar = container.attachMovie(value.toString(), "_scrollBar", 1000); // Created using linkage
				if (_scrollBar != null) { autoScrollBar = true; }
			}
		} else { // Outside reference
			_scrollBar = MovieClip(value);
		}		
		
		invalidate(); // Redraw to reset scrollbar bounds, even if there is no scrollBar.
		
		if (_scrollBar == null) { return; }
		
		// Now that we have a scrollBar, lets set it up.
		if (_scrollBar.setScrollProperties != null) {
			_scrollBar.addEventListener("scroll", this, "handleScroll");
		} else {
			_scrollBar.addEventListener("change", this, "handleScroll");
		}
		_scrollBar.focusTarget = this;
		_scrollBar.tabEnabled = false;
		drawScrollBar();
		updateScrollBar();
	}
	
	/**
	 * Set the height of each row.  By default, the height is 0, and determined by the itemRenderer asset.
	 */
	[Inspectable(defaultValue="0")]
	public function get rowHeight():Number { return _rowHeight; }
	public function set rowHeight(value:Number):Void {
		if (value == 0) { value = null; return; }
		_rowHeight = value;
		invalidate();
	}
	
	/**
	 * Set the width of each column.  By default, the width is 0, and determined by an itemRenderer instance.
	 */
	[Inspectable(defaultValue="0")]
	public function get columnWidth():Number { return _columnWidth; }
	public function set columnWidth(value:Number):Void {
		if (value == 0) { value = null; return; }
		_columnWidth = value;
		invalidate();
	}
	
	/**
	 * Set the height of the component to accommodate the number of rows specified.
	 */
	public function get rowCount():Number { return totalRows; }
	public function set rowCount(value:Number):Void {
		_rowCount = autoRowCount ? Math.ceil(value / totalColumns) : value;
		var h:Number = _rowHeight;
		if (h == null) {
			var item:MovieClip = renderers[0];
			// For now.  Maybe create one if we have too...
			h = item.height;
		}
		setSize(__width, h * _rowCount + margin*2);
	}
	
	/**
	 * Set the width of the component to accommodate the number of columns specified.
	 */
	public function get columnCount():Number { return totalColumns; }
	public function set columnCount(value:Number):Void {	
		_columnCount = value;
		var w:Number = _columnWidth;
		if (w == null) {
			var item:MovieClip = renderers[0];
			// For now.  Maybe create one if we have too...
			w = item.width;
		}
		setSize(w * columnCount, __height);
	}
	
	/**
	 * Set the scrolling direction of the TileList. The {@code direction} can be set to "horizontal" or "vertical". TileLists can only scroll in one direction at a time.
	 */
	[Inspectable(type="List", enumeration="horizontal,vertical", defaultValue="horizontal")]
	public function get direction():String { return _direction; }
	public function set direction(value:String):Void {
		if (value == _direction) { return; }
		_direction = value;
		invalidate();
	}

	[Inspectable(defaultValue="false", verbose="1")]
	public function get disabled():Boolean { return _disabled; }
	public function set disabled(value:Boolean):Void { 
		super.disabled = value;
		if (initialized) { setState(); }
	}		
	
	/**
	 * The selected index of the DataProvider.  The itemRenderer of the selectedIndex will be set to {@code selected=true}.
	 */
	public function get selectedIndex():Number { return _selectedIndex; }
	public function set selectedIndex(value:Number):Void {
		var renderer:MovieClip = getRendererAt(_selectedIndex);
		if (renderer != null) { // Only reset items in range
			renderer.displayFocus = false;
			renderer.selected = false; 
		}
		super.selectedIndex = value;
		renderer = getRendererAt(_selectedIndex);
		if (totalRows * totalColumns == 0) {
			return;
		} else if (renderer != null) {
			renderer.displayFocus = true;
			renderer.selected = true; // Item is in range. Just set it.
		} else {
			scrollToIndex(_selectedIndex); // Will redraw
			getRendererAt(_selectedIndex).displayFocus = true;
		}
	}
	
	/**
	 * Scroll the list to the specified index.  If the index is currently visible, the position will not change. The scroll position will only change the minimum amount it has to to display the index.
	 * @param index The index to scroll to.
	 */
	public function scrollToIndex(index:Number):Void {
		var factor:Number = (_direction=="horizontal" ? totalRows : totalColumns);
		var startIndex:Number = _scrollPosition * factor;
		if (factor == 0) { return; }
		if (index >= startIndex && index < startIndex + (totalRows * totalColumns)) {
			return;
		} else if (index < startIndex) {
			scrollPosition = (index / factor >> 0);
		} else {
			scrollPosition = Math.floor(index / factor) - (_direction=="horizontal"?totalColumns:totalRows) + 1;
		}
	}	
	
	/**
	 * The vertical or horizontal scroll position of the list.
	 */
	public function get scrollPosition():Number { return _scrollPosition; }
	public function set scrollPosition(value:Number):Void {
		var maxScrollPosition:Number = Math.ceil((_dataProvider.length - totalRows*totalColumns) / (_direction=="horizontal" ? totalRows: totalColumns));
		value = Math.max(0, Math.min(maxScrollPosition, Math.round(value)));
		if (_scrollPosition == value) { return; }
		_scrollPosition = value;
		invalidateData();
		updateScrollBar();
	}
	
	public function invalidateData():Void {	
		// Keep the items in range (in case the component grows larger than the number of renderers)
		var itemsPerSet:Number = (_direction == "horizontal" ? totalRows : totalColumns); // Number of items in each set (column or row)
		var numberOfSets:Number = Math.ceil(_dataProvider.length / itemsPerSet); // Number of sets
		var maxScrollPosition:Number = numberOfSets - (_direction == "horizontal" ? totalColumns : totalRows);
		_scrollPosition = Math.max(0, Math.min(maxScrollPosition, _scrollPosition));
		
		var startIndex:Number = _scrollPosition * itemsPerSet;
		var endIndex:Number = startIndex + (totalColumns * totalRows) -1;
		
		_dataProvider.requestItemRange(startIndex, endIndex, this, "populateData");
		// Set pending items to "waiting" state.
	}
	
	/** @exclude */
	public function get availableWidth():Number {
		return ((autoScrollBar && _direction == "vertical") ? __width - _scrollBar._width : __width) - margin*2;
	}
	
	/** @exclude */
	public function get availableHeight():Number {
		return ((autoScrollBar && _direction == "horizontal") ? __height - _scrollBar._height : __height) - margin*2;
	}
	
	/** @exclude */
	public function setRendererList(value:Array, newColumnCount:Number):Void {
		if (newColumnCount != null) { externalColumnCount = newColumnCount; }
		super.setRendererList(value);
	}
	
	public function handleInput(details:InputDetails, pathToFocus:Array):Boolean
	{		
		// Pass on to renderer first.
		if (pathToFocus == null) { pathToFocus = []; }
		var renderer:MovieClip = getRendererAt(_selectedIndex);
		if (renderer != null && renderer.handleInput != null) {
			var handled:Boolean = renderer.handleInput(details, pathToFocus.slice(1));
			if (handled) { return true; }
		}
		
		var keyPress:Boolean = (details.value == "keyDown");
		var nav:String = details.navEquivalent;
		
		var nextDelta:Number;
		
		var foundNextIndex:Boolean = false;
		var nextIndex:Number = _selectedIndex;
		
		var itemsPerSet:Number = (_direction == "horizontal" ? totalRows : totalColumns); // Number of items in each set (column or row)
		
		var currentSet:Number = Math.floor(_selectedIndex / itemsPerSet);
		
		var movingWithinSet:Boolean = false;
		
		// Directional navigation commands differ depending on layout direction.
		if (_direction == "horizontal") {
			switch (nav) {
				case NavigationCode.RIGHT:
			 		nextDelta = totalRows;
					break;
				case NavigationCode.LEFT:
					nextDelta = -totalRows;
					break;
				case NavigationCode.UP:
					movingWithinSet = true;
					nextDelta = -1;
					break;
				case NavigationCode.DOWN:
					movingWithinSet = true;
					nextDelta = 1;
					break;
			}
		} else {
			switch (nav) {
				case NavigationCode.DOWN:
			 		nextDelta = totalColumns;
					break;
				case NavigationCode.UP:
					nextDelta = -totalColumns;
					break;
				case NavigationCode.LEFT:
					movingWithinSet = true;
					nextDelta = -1;
					break;
				case NavigationCode.RIGHT:
					movingWithinSet = true;
					nextDelta = 1;
					break;
			}
		}
		
		// These navigation commands don't change depending on direction.
		switch (nav) {
			case NavigationCode.HOME:
				//start one in front of the beginning and move forward
				nextIndex = -1;
				nextDelta = 1;
				break;				
			case NavigationCode.END:
				//start one off the end and go backwards
				nextIndex = _dataProvider.length;
				nextDelta = -1;
				break;
			case NavigationCode.PAGE_DOWN:
				//start one above where you expect to be going and iterate forward on a one by one basis
				nextDelta = 1;
				nextIndex = _selectedIndex + (totalColumns * totalRows) - 1;
				break;				
			case NavigationCode.PAGE_UP:
				//start one below where you expect to be going and iterate backward on a one by one basis
				nextDelta = -1;
				nextIndex = _selectedIndex - (totalColumns * totalRows) + 1;
				break;
		}
		
		//Delta was not set, means the key was not handled.
		if (nextDelta == null )
			return false;
		//If the key was handled but it is not key down, just eat it.
		if (!keyPress)
			return true;
		//If we do not have any selectable items...
		if (bHasASelectableItem == false)
		{
			//If wrapping is enabled, just return
			if (wrapping == "stick" || wrapping == "wrap")
			{
				return true;
			}
			else // Otherwise, don't handle it.
			{
				return false;
			}
		}
		
		do
		{
			nextIndex = nextIndex + nextDelta;
			
			//WrapOutOfSet handling
			if (!wrapOutOfSet && movingWithinSet)
			{
				//If you would have moved out of set, undo the change and reverse delta.
				if (Math.floor(nextIndex / itemsPerSet) != currentSet)
				{
					nextIndex = nextIndex - nextDelta;
					nextDelta = -nextDelta;
				}
			}
			
			//Did we go off the end?
			if (nextIndex >= _dataProvider.length)
			{
				if (wrapping == "stick")
				{
					//Find the last selectable thing
					nextIndex = _dataProvider.length;
					nextDelta = -1;
				}
				else if (wrapping == "wrap")
				{
					//Back to the beginning
					nextIndex = 0;
				} 
				else if (wrapping == "refuse")
				{
					//Refuse to move
					nextIndex = _selectedIndex;
				}
				else 
				{
					//We will move out of this object, so we will not handle it.
					return false;
				}
			}
			//Are we before the beginning?
			else if (nextIndex < 0)
			{
				if (wrapping == "stick")
				{
					//Find the first selectable thing
					nextIndex = -1;
					nextDelta = 1;
				} 
				else if (wrapping == "wrap")
				{
					//Go to the end
					nextIndex = _dataProvider.length-1;
				}
				else if (wrapping == "refuse")
				{
					//Refuse to move
					nextIndex = _selectedIndex;
				}
				else 
				{
					//We will move out of this object, so we will not handle it.
					return false;
				}
			}
			
			//Cannot be off of the list.
			//Also, cannot be unselectable or have an undefined data provider
			if (nextIndex >= 0 && nextIndex < _dataProvider.length && _dataProvider[nextIndex] != undefined &&
				(_dataProvider[nextIndex].unselectable == undefined || 
				 _dataProvider[nextIndex].unselectable == false) )
			{
				foundNextIndex = true;
			}
		} while (!foundNextIndex)
		
		if (selectedIndex != nextIndex) { selectedIndex = nextIndex; }
		
		return true;
	}
	
		
	/** @exclude */
	public function toString():String {
		return "[Scaleform TileList " + _name + "]";
	}
	
	
// Private Methods:
	private function configUI():Void {
		super.configUI();
		if (inspectableScrollBar != '' && inspectableScrollBar != null) {
			scrollBar = inspectableScrollBar;
			inspectableScrollBar = null;
		}		
	}
	
	private function draw():Void {
		if (sizeIsInvalid) { 
			_width = __width;
			_height = __height;
		}
		
		if (externalRenderers) {
			totalColumns = (externalColumnCount == 0) ? 1 : externalColumnCount; // Defaults to 1 if its not set.
			totalRows = Math.ceil(renderers.length / totalColumns);
		} else {
			container._xscale = 10000 / _xscale; // Counter scale the list items.
			container._yscale = 10000 / _yscale;
			
			var w:Number = _columnWidth;
			var h:Number = _rowHeight;
			if (h == null || w == null) {
				var temp:MovieClip = createItemRenderer(99);
                temp.enableInitCallback = false;
				if (w == null) { w = temp._width; }
				if (h == null) { h = temp._height; }
				temp.removeMovieClip();
			}

			totalRows = availableHeight / h >> 0;
			totalColumns = availableWidth / w >> 0;
			var totalRenderers:Number = totalRows * totalColumns;	
			
			drawRenderers(totalRenderers);
			drawLayout(w,h);
			updateScrollBar();
			drawScrollBar();
		}
		
		updateScrollBar();
		invalidateData();
		setState();
		
		super.draw();
	}
	
	private function drawLayout(rendererWidth:Number, rendererHeight:Number):Void {
		for (var i:Number =0; i<renderers.length; i++) {
			var r:MovieClip = renderers[i];
			if (direction == "horizontal") {
				r._y = (i % totalRows) * rendererHeight + margin;
				r._x = (i / totalRows >> 0) * rendererWidth + margin;
			} else {
				r._x = (i % totalColumns) * rendererWidth + margin;
				r._y = (i / totalColumns >> 0) * rendererHeight + margin;
			}
			renderers[i].setSize(rendererWidth, rendererHeight);
		}
		drawScrollBar();
	}
	
	private function changeFocus():Void {
		super.changeFocus();
		setState();
		var renderer:MovieClip = getRendererAt(_selectedIndex);
		if (renderer != null) {
			renderer.displayFocus = _focused;			
		}	
	}	
	
	private function populateData(data:Array):Void {
		bHasASelectableItem = false;
		for (var i:Number=0; i<totalColumns*totalRows; i++) {
			var renderer:MovieClip = renderers[i];
			var index:Number = _scrollPosition * ((_direction == "horizontal") ? totalRows: totalColumns) + i;
			renderers[i].setListData(index, itemToLabel(data[i]), _selectedIndex == index); //LM: Consider passing renderer position also. (Supports animation)
			renderer.setData(data[i]);
			//If something was already selectable, or this item is selectable, then there exists a selectable item in the list.
			bHasASelectableItem =  bHasASelectableItem || data[i].unselectable == undefined || data[i].unselectable == false;
		}
	}
	
	private function getRendererAt(index:Number):MovieClip {
		var rendererIndex:Number = index - _scrollPosition * (_direction == "horizontal" ? totalRows : totalColumns);
		if (rendererIndex > _dataProvider.length-1) { return null; }
		return renderers[rendererIndex];
	}
	
	private function handleScroll(event:Object):Void {
		var newPosition:Number = event.target.position;
		if (isNaN(newPosition)) { return; }
		scrollPosition = newPosition;
	}
	
	private function drawScrollBar():Void {
		if (!autoScrollBar) { return; }
		_scrollBar.direction = _direction;
		if (_direction == "vertical") {
			_scrollBar._rotation = 0;
			_scrollBar._x = __width - _scrollBar._width + margin;
			_scrollBar._y = margin;
			_scrollBar.height = __height - margin*2;
		} else {
			_scrollBar._rotation = -90;
			_scrollBar._x = margin;
			_scrollBar._y = __height - margin;
			_scrollBar.width = __width - margin*2; // When the ScrollBar is rotated, we can set its width instead.
		}
	}
	
	// The data/size changes
	private function updateScrollBar():Void {
		var max:Number;// = Math.max(0, dataProvider.length / (totalColumns*totalRows) >> 0);	
		if (direction == "horizontal") {
			max = Math.ceil(_dataProvider.length / totalRows) - totalColumns;
		} else {
			max = Math.ceil(_dataProvider.length / totalColumns) - totalRows;
		}
		if (_scrollBar.setScrollProperties != null) {
			_scrollBar.setScrollProperties((_direction=="horizontal"?totalColumns:totalRows), 0, max);
		} else {
			_scrollBar.minimum = 0;
			_scrollBar.maximum = max;
		}
		_scrollBar.position = _scrollPosition;
		_scrollBar.trackScrollPageSize = Math.max(1, (_direction=="horizontal"?totalColumns:totalRows));
	}	
	
	private function scrollWheel(delta:Number):Void {
		if (_disabled) { return; }
		scrollPosition = _scrollPosition - delta;
	}
	
	private function setState():Void {
		tabEnabled = focusEnabled = !_disabled;
		gotoAndPlay(_disabled ? "disabled" : _focused ? "focused" : "default");
		if (_scrollBar) { 
			_scrollBar.disabled = _disabled; 
			_scrollBar.tabEnabled = false;
		}
		for (var i:Number=0; i<renderers.length; i++) {
			renderers[i].disabled = _disabled;
			renderers[i].tabEnabled = false;
		}
	}

}