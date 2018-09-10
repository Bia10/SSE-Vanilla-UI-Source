﻿import gfx.events.EventDispatcher;
import gfx.ui.NavigationCode;
import gfx.managers.FocusHandler;
import gfx.ui.InputDetails;
import gfx.io.GameDelegate;
import Components.DeltaMeter;
import Shared.GlobalFunc;

class ItemCard extends MovieClip
{
	var ActiveEffectTimeValue:TextField;
	var ApparelArmorValue:TextField;
	var ApparelWarmthValue:TextField;
	var ApparelEnchantedLabel:TextField;
	var BookDescriptionLabel:TextField;
	var EnchantmentLabel:TextField;
	var ItemName:TextField;
	var ItemText:TextField;
	var ItemValueText:TextField;
	var ItemWeightText:TextField;
	var MagicCostLabel:TextField;
	var MagicCostPerSec:TextField;
	var MagicCostTimeLabel:TextField;
	var MagicCostTimeValue:TextField;
	var MagicCostValue:TextField;
	var MagicEffectsLabel:TextField;
	var MessageText:TextField;
	var PotionsLabel:TextField;
	var SecsText:TextField;
	var ShoutCostValue:TextField;
	var ShoutEffectsLabel:TextField;
	var SkillLevelText:TextField;
	var SkillTextInstance:TextField;
	var SliderValueText:TextField;
	var SoulLevel:TextField;
	var StolenTextInstance:TextField;
	var TotalChargesValue:TextField;
	var WeaponDamageValue:TextField;
	var WeaponEnchantedLabel:TextField;

	var ButtonRect:MovieClip;
	var ButtonRect_mc:MovieClip;
	var CardList_mc:MovieClip;
	var ChargeMeter_Default:MovieClip;
	var ChargeMeter_Enchantment:MovieClip;
	var ChargeMeter_SoulGem:MovieClip;
	var ChargeMeter_Weapon:MovieClip;
	var EnchantingSlider_mc:MovieClip;
	var Enchanting_Background:MovieClip;
	var Enchanting_Slim_Background:MovieClip;
	var ItemList:MovieClip;
	var ListChargeMeter:MovieClip;
	var PoisonInstance:MovieClip;
	var PrevFocus:MovieClip;
	var QuantitySlider_mc:MovieClip;
	var WeaponChargeMeter:MovieClip;

	var InputHandler:Function;
	var dispatchEvent:Function;

	var ItemCardMeters:Object;
	var LastUpdateObj:Object;

	var _bEditNameMode:Boolean;
	var bFadedIn:Boolean;

	function ItemCard()
	{
		super();
		Shared.GlobalFunc.MaintainTextFormat();
		Shared.GlobalFunc.AddReverseFunctions();
		gfx.events.EventDispatcher.initialize(this);
		QuantitySlider_mc = QuantitySlider_mc;
		ButtonRect_mc = ButtonRect;
		ItemList = CardList_mc.List_mc;
		SetupItemName();
		bFadedIn = false;
		InputHandler = undefined;
		_bEditNameMode = false;
	}
	function get bEditNameMode()
	{
		return _bEditNameMode;
	}
	function GetItemName()
	{
		return ItemName;
	}
	function SetupItemName(aPrevName)
	{
		ItemName = ItemText.ItemTextField;
		if (ItemName != undefined)
		{
			ItemName.textAutoSize = "shrink";
			ItemName.htmlText = aPrevName;
			ItemName.selectable = false;
		}
	}
	function onLoad()
	{
		QuantitySlider_mc.addEventListener("change",this,"onSliderChange");
		ButtonRect_mc.AcceptMouseButton.addEventListener("click",this,"onAcceptMouseClick");
		ButtonRect_mc.CancelMouseButton.addEventListener("click",this,"onCancelMouseClick");
		ButtonRect_mc.AcceptMouseButton.SetPlatform(0,false);
		ButtonRect_mc.CancelMouseButton.SetPlatform(0,false);
	}
	function SetPlatform(aiPlatform, abPS3Switch)
	{
		ButtonRect_mc.AcceptGamepadButton._visible = aiPlatform != 0;
		ButtonRect_mc.CancelGamepadButton._visible = aiPlatform != 0;
		ButtonRect_mc.AcceptMouseButton._visible = aiPlatform == 0;
		ButtonRect_mc.CancelMouseButton._visible = aiPlatform == 0;
		if (aiPlatform != 0)
		{
			ButtonRect_mc.AcceptGamepadButton.SetPlatform(aiPlatform,abPS3Switch);
			ButtonRect_mc.CancelGamepadButton.SetPlatform(aiPlatform,abPS3Switch);
		}
		ItemList.SetPlatform(aiPlatform,abPS3Switch);
	}
	function onAcceptMouseClick()
	{
		if (ButtonRect_mc._alpha == 100 && ButtonRect_mc.AcceptMouseButton._visible == true && InputHandler != undefined)
		{
			var _loc2_ = {value:"keyDown", navEquivalent:gfx.ui.NavigationCode.ENTER};
			InputHandler(_loc2_);
		}
	}
	function onCancelMouseClick()
	{
		if (ButtonRect_mc._alpha == 100 && ButtonRect_mc.CancelMouseButton._visible == true && InputHandler != undefined)
		{
			var _loc2_ = {value:"keyDown", navEquivalent:gfx.ui.NavigationCode.TAB};
			this.InputHandler(_loc2_);
		}
	}
	function FadeInCard()
	{
		if (!bFadedIn)
		{
			_visible = true;
			_parent.gotoAndPlay("fadeIn");
			bFadedIn = true;
		}
	}
	function FadeOutCard()
	{
		if (bFadedIn)
		{
			_parent.gotoAndPlay("fadeOut");
			bFadedIn = false;
		}
	}
	function get quantitySlider()
	{
		return QuantitySlider_mc;
	}
	function get weaponChargeMeter()
	{
		return ItemCardMeters[InventoryDefines.ICT_WEAPON];
	}
	function get itemInfo()
	{
		return this.LastUpdateObj;
	}
	function set itemInfo(aUpdateObj)
	{
		ItemCardMeters = new Array();
		var htmlItemName = this.ItemName == undefined ? "" : this.ItemName.htmlText;
		switch (aUpdateObj.type)
		{
			case InventoryDefines.ICT_ARMOR :
				if (aUpdateObj.effects.length == 0)
				{
					gotoAndStop(aUpdateObj.warmth != undefined ? "Apparel_Survival_reg" : "Apparel_reg");
				}
				else if (aUpdateObj.warmth != undefined)
				{
					gotoAndStop("Apparel_Survival_Enchanted");
				}
				else
				{
					gotoAndStop("Apparel_Enchanted");
				}
				ApparelArmorValue.textAutoSize = "shrink";
				ApparelArmorValue.SetText(aUpdateObj.armor);
				if (ApparelWarmthValue != undefined)
				{
					ApparelWarmthValue.textAutoSize = "shrink";
					ApparelWarmthValue.SetText(aUpdateObj.warmth);
				}
				ApparelEnchantedLabel.textAutoSize = "shrink";
				ApparelEnchantedLabel.htmlText = aUpdateObj.effects;
				SkillTextInstance.text = aUpdateObj.skillText;
				break;
			case InventoryDefines.ICT_WEAPON :
				if (aUpdateObj.effects.length == 0)
				{
					gotoAndStop("Weapons_reg");
				}
				else
				{
					gotoAndStop("Weapons_Enchanted");
					if (ItemCardMeters[InventoryDefines.ICT_WEAPON] == undefined)
					{
						ItemCardMeters[InventoryDefines.ICT_WEAPON] = new DeltaMeter(WeaponChargeMeter.MeterInstance);
					}
					if (aUpdateObj.usedCharge != undefined && aUpdateObj.charge != undefined)
					{
						ItemCardMeters[InventoryDefines.ICT_WEAPON].SetPercent(aUpdateObj.usedCharge);
						ItemCardMeters[InventoryDefines.ICT_WEAPON].SetDeltaPercent(aUpdateObj.charge);
						WeaponChargeMeter._visible = true;
					}
					else
					{
						WeaponChargeMeter._visible = false;
					}
				}
				var isPoisonedString = aUpdateObj.poisoned != true ? "Off" : "On";
				PoisonInstance.gotoAndStop(isPoisonedString);
				WeaponDamageValue.SetText(aUpdateObj.damage);
				WeaponEnchantedLabel.textAutoSize = "shrink";
				WeaponEnchantedLabel.htmlText = aUpdateObj.effects;
				break;
			case InventoryDefines.ICT_BOOK :
				if (aUpdateObj.description != undefined && aUpdateObj.description != "")
				{
					gotoAndStop("Books_Description");
					BookDescriptionLabel.SetText(aUpdateObj.description);
				}
				else
				{
					gotoAndStop("Books_reg");
				}
				break;
			case InventoryDefines.ICT_POTION :
			case InventoryDefines.ICT_FOOD :
				gotoAndStop("Potions_reg");
				PotionsLabel.textAutoSize = "shrink";
				PotionsLabel.htmlText = aUpdateObj.effects;
				SkillTextInstance.text = aUpdateObj.skillName == undefined ? "" : aUpdateObj.skillName;
				break;
			case InventoryDefines.ICT_SPELL_DEFAULT :
				gotoAndStop("Power_reg");
				MagicEffectsLabel.SetText(aUpdateObj.effects,true);
				MagicEffectsLabel.textAutoSize = "shrink";
				if (aUpdateObj.spellCost <= 0)
				{
					MagicCostValue._alpha = 0;
					MagicCostTimeValue._alpha = 0;
					MagicCostLabel._alpha = 0;
					MagicCostTimeLabel._alpha = 0;
					MagicCostPerSec._alpha = 0;
				}
				else
				{
					MagicCostValue._alpha = 100;
					MagicCostLabel._alpha = 100;
					MagicCostValue.text = aUpdateObj.spellCost.toString();
				}
				break;
			case InventoryDefines.ICT_SPELL :
				var castTime = aUpdateObj.castTime == 0;
				if (!castTime)
				{
					gotoAndStop("Magic_reg");
				}
				else
				{
					gotoAndStop("Magic_time_label");
				}
				SkillLevelText.text = aUpdateObj.castLevel.toString();
				MagicEffectsLabel.SetText(aUpdateObj.effects,true);
				MagicEffectsLabel.textAutoSize = "shrink";
				MagicCostValue.textAutoSize = "shrink";
				MagicCostTimeValue.textAutoSize = "shrink";
				if (!castTime)
				{
					MagicCostValue.text = aUpdateObj.spellCost.toString();
				}
				else
				{
					MagicCostTimeValue.text = aUpdateObj.spellCost.toString();
				}
				break;
			case InventoryDefines.ICT_INGREDIENT :
				gotoAndStop("Ingredients_reg");
				var i = 0;
				while (i < 4)
				{
					this["EffectLabel" + i].textAutoSize = "shrink";
					if (aUpdateObj["itemEffect" + i] != undefined && aUpdateObj["itemEffect" + i] != "")
					{
						this["EffectLabel" + i].textColor = 16777215;
						this["EffectLabel" + i].SetText(aUpdateObj["itemEffect" + i]);
					}
					else if (i < aUpdateObj.numItemEffects)
					{
						this["EffectLabel" + i].textColor = 10066329;
						this["EffectLabel" + i].SetText("$UNKNOWN");
					}
					else
					{
						this["EffectLabel" + i].SetText("");
					}
					i = i + 1;
				}
				break;
			case InventoryDefines.ICT_MISC :
				gotoAndStop("Misc_reg");
				break;
			case InventoryDefines.ICT_SHOUT :
				gotoAndStop("Shouts_reg");
				var iLastWord = 0;
				var i = 0;
				while (i < 3)
				{
					if (aUpdateObj["word" + i] != undefined && aUpdateObj["word" + i] != "" && aUpdateObj["unlocked" + i] == true)
					{
						iLastWord = i;
					}
					i = i + 1;
				}
				i = 0;
				while (i < 3)
				{
					var strDragonWord = aUpdateObj["dragonWord" + i] != undefined ? aUpdateObj["dragonWord" + i] : "";
					var strWord = aUpdateObj["word" + i] != undefined ? aUpdateObj["word" + i] : "";
					var bWordKnown = aUpdateObj["unlocked" + i] == true;
					this["ShoutTextInstance" + i].DragonShoutLabelInstance.ShoutWordsLabel.textAutoSize = "shrink";
					this["ShoutTextInstance" + i].ShoutLabelInstance.ShoutWordsLabelTranslation.textAutoSize = "shrink";
					this["ShoutTextInstance" + i].DragonShoutLabelInstance.ShoutWordsLabel.SetText(strDragonWord.toUpperCase());
					this["ShoutTextInstance" + i].ShoutLabelInstance.ShoutWordsLabelTranslation.SetText(strWord);
					if (bWordKnown && i == iLastWord && this.LastUpdateObj.soulSpent == true)
					{
						this["ShoutTextInstance" + i].gotoAndPlay("Learn");
					}
					else if (bWordKnown)
					{
						this["ShoutTextInstance" + i].gotoAndStop("Known");
						this["ShoutTextInstance" + i].gotoAndStop("Known");
					}
					else
					{
						this["ShoutTextInstance" + i].gotoAndStop("Unlocked");
						this["ShoutTextInstance" + i].gotoAndStop("Unlocked");
					}
					i++;
				}
				ShoutEffectsLabel.htmlText = aUpdateObj.effects;
				ShoutCostValue.text = aUpdateObj.spellCost.toString();
				break;
			case InventoryDefines.ICT_ACTIVE_EFFECT :
				gotoAndStop("ActiveEffects");
				MagicEffectsLabel.html = true;
				MagicEffectsLabel.SetText(aUpdateObj.effects,true);
				MagicEffectsLabel.textAutoSize = "shrink";
				if (aUpdateObj.timeRemaining > 0)
				{
					var iEffectTimeRemaining = Math.floor(aUpdateObj.timeRemaining);
					ActiveEffectTimeValue._alpha = 100;
					SecsText._alpha = 100;
					if (iEffectTimeRemaining >= 3600)
					{
						iEffectTimeRemaining = Math.floor(iEffectTimeRemaining / 3600);
						ActiveEffectTimeValue.text = iEffectTimeRemaining.toString();
						if (iEffectTimeRemaining == 1)
						{
							SecsText.text = "$hour";
						}
						else
						{
							SecsText.text = "$hours";
						}
					}
					else if (iEffectTimeRemaining >= 60)
					{
						iEffectTimeRemaining = Math.floor(iEffectTimeRemaining / 60);
						ActiveEffectTimeValue.text = iEffectTimeRemaining.toString();
						if (iEffectTimeRemaining == 1)
						{
							SecsText.text = "$min";
						}
						else
						{
							SecsText.text = "$mins";
						}
					}
					else
					{
						ActiveEffectTimeValue.text = iEffectTimeRemaining.toString();
						if (iEffectTimeRemaining == 1)
						{
							SecsText.text = "$sec";
						}
						else
						{
							SecsText.text = "$secs";
						}
					}
				}
				else
				{
					ActiveEffectTimeValue._alpha = 0;
					SecsText._alpha = 0;
				}
				break;
			case InventoryDefines.ICT_SOUL_GEMS :
				gotoAndStop("SoulGem");
				SoulLevel.text = aUpdateObj.soulLVL;
				break;
			case InventoryDefines.ICT_LIST :
				gotoAndStop("Item_list");
				if (aUpdateObj.listItems != undefined)
				{
					ItemList.entryList = aUpdateObj.listItems;
					ItemList.InvalidateData();
					ItemCardMeters[InventoryDefines.ICT_LIST] = new Components.DeltaMeter(ListChargeMeter.MeterInstance);
					ItemCardMeters[InventoryDefines.ICT_LIST].SetPercent(aUpdateObj.currentCharge);
					ItemCardMeters[InventoryDefines.ICT_LIST].SetDeltaPercent(aUpdateObj.currentCharge + ItemList.selectedEntry.chargeAdded);
					OpenListMenu();
				}
				break;
			case InventoryDefines.ICT_CRAFT_ENCHANTING :
			case InventoryDefines.ICT_HOUSE_PART :
				if (aUpdateObj.type == InventoryDefines.ICT_HOUSE_PART)
				{
					gotoAndStop("Magic_short");
					if (aUpdateObj.effects != undefined)
					{
						MagicEffectsLabel.SetText(aUpdateObj.effects,true);
					}
					else
					{
						MagicEffectsLabel.SetText("",true);
					}
				}
				else if (aUpdateObj.sliderShown == true)
				{
					gotoAndStop("Craft_Enchanting");
					ItemCardMeters[InventoryDefines.ICT_WEAPON] = new Components.DeltaMeter(ChargeMeter_Default.MeterInstance);
					if (aUpdateObj.totalCharges != undefined && aUpdateObj.totalCharges != 0)
					{
						TotalChargesValue.text = aUpdateObj.totalCharges;
					}
				}
				else if (aUpdateObj.damage != undefined)
				{
					gotoAndStop("Craft_Enchanting_Weapon");
					ItemCardMeters[InventoryDefines.ICT_WEAPON] = new Components.DeltaMeter(ChargeMeter_Weapon.MeterInstance);
					WeaponDamageValue.SetText(aUpdateObj.damage);
				}
				else if (aUpdateObj.armor != undefined)
				{
					gotoAndStop("Craft_Enchanting_Armor");
					ApparelArmorValue.SetText(aUpdateObj.armor);
					SkillTextInstance.text = aUpdateObj.skillText;
				}
				else if (aUpdateObj.soulLVL != undefined)
				{
					gotoAndStop("Craft_Enchanting_SoulGem");
					ItemCardMeters[InventoryDefines.ICT_WEAPON] = new Components.DeltaMeter(ChargeMeter_SoulGem.MeterInstance);
					SoulLevel.text = aUpdateObj.soulLVL;
				}
				else if (QuantitySlider_mc._alpha == 0)
				{
					gotoAndStop("Craft_Enchanting_Enchantment");
					ItemCardMeters[InventoryDefines.ICT_WEAPON] = new Components.DeltaMeter(ChargeMeter_Enchantment.MeterInstance);
				}
				if (aUpdateObj.usedCharge == 0 && aUpdateObj.totalCharges == 0)
				{
					ItemCardMeters[InventoryDefines.ICT_WEAPON].DeltaMeterMovieClip._parent._parent._alpha = 0;
				}
				else if (aUpdateObj.usedCharge != undefined)
				{
					ItemCardMeters[InventoryDefines.ICT_WEAPON].SetPercent(aUpdateObj.usedCharge);
				}
				if (aUpdateObj.effects != undefined && aUpdateObj.effects.length > 0)
				{
					if (EnchantmentLabel != undefined)
					{
						EnchantmentLabel.SetText(aUpdateObj.effects,true);
					}
					EnchantmentLabel.textAutoSize = "shrink";
					WeaponChargeMeter._alpha = 100;
					Enchanting_Background._alpha = 60;
					Enchanting_Slim_Background._alpha = 0;
				}
				else
				{
					if (EnchantmentLabel != undefined)
					{
						EnchantmentLabel.SetText("",true);
					}
					WeaponChargeMeter._alpha = 0;
					Enchanting_Slim_Background._alpha = 60;
					Enchanting_Background._alpha = 0;
				}
				break;
			case InventoryDefines.ICT_KEY :
			case InventoryDefines.ICT_NONE :
			default :
				gotoAndStop("Empty");
		}
		SetupItemName(htmlItemName);
		if (aUpdateObj.name != undefined)
		{
			var itemName = !(aUpdateObj.count != undefined && aUpdateObj.count > 1) ? aUpdateObj.name : aUpdateObj.name + " (" + aUpdateObj.count + ")";
			ItemText.ItemTextField.SetText(!(_bEditNameMode || aUpdateObj.upperCaseName == false) ? itemName.toUpperCase() : itemName,false);
			ItemText.ItemTextField.textColor = aUpdateObj.negativeEffect != true ? 16777215 : 16711680;
		}
		ItemValueText.textAutoSize = "shrink";
		ItemWeightText.textAutoSize = "shrink";
		if (aUpdateObj.value != undefined && ItemValueText != undefined)
		{
			ItemValueText.SetText(aUpdateObj.value.toString());
		}
		if (aUpdateObj.weight != undefined && ItemWeightText != undefined)
		{
			ItemWeightText.SetText(RoundDecimal(aUpdateObj.weight, 1).toString());
		}
		StolenTextInstance._visible = aUpdateObj.stolen == true;
		LastUpdateObj = aUpdateObj;
	}
	function RoundDecimal(aNumber, aPrecision)
	{
		var significantFigures = Math.pow(10, aPrecision);
		return Math.round(significantFigures * aNumber) / significantFigures;
	}
	function PrepareInputElements(aActiveClip)
	{
		var iQuantitySlider_yOffset = 92;
		var iCardList_yOffset = 98;
		var iEnchantingSlider_yOffset = 147.3;
		var iButtonRect_iOffset = 130;
		var iButtonRect_iOffsetEnchanting = 166;
		if (aActiveClip == EnchantingSlider_mc)
		{
			QuantitySlider_mc._y = -100;
			ButtonRect._y = iButtonRect_iOffsetEnchanting;
			EnchantingSlider_mc._y = iEnchantingSlider_yOffset;
			CardList_mc._y = -100;
			QuantitySlider_mc._alpha = 0;
			ButtonRect._alpha = 100;
			EnchantingSlider_mc._alpha = 100;
			CardList_mc._alpha = 0;
		}
		else if (aActiveClip == QuantitySlider_mc)
		{
			QuantitySlider_mc._y = iQuantitySlider_yOffset;
			ButtonRect._y = iButtonRect_iOffset;
			EnchantingSlider_mc._y = -100;
			CardList_mc._y = -100;
			QuantitySlider_mc._alpha = 100;
			ButtonRect._alpha = 100;
			EnchantingSlider_mc._alpha = 0;
			CardList_mc._alpha = 0;
		}
		else if (aActiveClip == CardList_mc)
		{
			QuantitySlider_mc._y = -100;
			ButtonRect._y = -100;
			EnchantingSlider_mc._y = -100;
			CardList_mc._y = iCardList_yOffset;
			QuantitySlider_mc._alpha = 0;
			ButtonRect._alpha = 0;
			EnchantingSlider_mc._alpha = 0;
			CardList_mc._alpha = 100;
		}
		else if (aActiveClip == ButtonRect)
		{
			QuantitySlider_mc._y = -100;
			ButtonRect._y = iButtonRect_iOffset;
			EnchantingSlider_mc._y = -100;
			CardList_mc._y = -100;
			QuantitySlider_mc._alpha = 0;
			ButtonRect._alpha = 100;
			EnchantingSlider_mc._alpha = 0;
			CardList_mc._alpha = 0;
		}
	}
	function ShowEnchantingSlider(aiMaxValue:Number, aiMinValue:Number, aiCurrentValue:Number):Void
	{
		gotoAndStop("Craft_Enchanting");
		QuantitySlider_mc = EnchantingSlider_mc;
		QuantitySlider_mc.addEventListener("change",this,"onSliderChange");
		PrepareInputElements(EnchantingSlider_mc);
		QuantitySlider_mc.maximum = aiMaxValue;
		QuantitySlider_mc.minimum = aiMinValue;
		QuantitySlider_mc.value = aiCurrentValue;
		PrevFocus = FocusHandler.instance.getFocus(0);
		FocusHandler.instance.setFocus(QuantitySlider_mc,0);
		InputHandler = HandleQuantityMenuInput;
		dispatchEvent({type:"subMenuAction", opening:true, menu:"quantity"});
	}

	function ShowQuantityMenu(aiMaxAmount:Number):Void
	{
		gotoAndStop("Quantity");
		PrepareInputElements(QuantitySlider_mc);
		QuantitySlider_mc.maximum = aiMaxAmount;
		QuantitySlider_mc.value = aiMaxAmount;
		SliderValueText.textAutoSize = "shrink";
		SliderValueText.SetText(Math.floor(QuantitySlider_mc.value).toString());
		PrevFocus = FocusHandler.instance.getFocus(0);
		FocusHandler.instance.setFocus(QuantitySlider_mc,0);
		InputHandler = HandleQuantityMenuInput;
		dispatchEvent({type:"subMenuAction", opening:true, menu:"quantity"});
	}

	function HideQuantityMenu(abCanceled:Boolean):Void
	{
		FocusHandler.instance.setFocus(PrevFocus,0);
		QuantitySlider_mc._alpha = 0;
		ButtonRect_mc._alpha = 0;
		InputHandler = undefined;
		dispatchEvent({type:"subMenuAction", opening:false, canceled:abCanceled, menu:"quantity"});
	}

	function OpenListMenu():Void
	{
		PrevFocus = FocusHandler.instance.getFocus(0);
		FocusHandler.instance.setFocus(ItemList,0);
		ItemList._visible = true;
		ItemList.addEventListener("itemPress",this,"onListItemPress");
		ItemList.addEventListener("listMovedUp",this,"onListSelectionChange");
		ItemList.addEventListener("listMovedDown",this,"onListSelectionChange");
		ItemList.addEventListener("selectionChange",this,"onListMouseSelectionChange");
		PrepareInputElements(CardList_mc);
		ListChargeMeter._alpha = 100;
		InputHandler = HandleListMenuInput;
		dispatchEvent({type:"subMenuAction", opening:true, menu:"list"});
	}

	function HideListMenu():Void
	{
		FocusHandler.instance.setFocus(PrevFocus,0);
		ListChargeMeter._alpha = 0;
		CardList_mc._alpha = 0;
		ItemCardMeters[InventoryDefines.ICT_LIST] = undefined;
		InputHandler = undefined;
		ItemList._visible = true;
		dispatchEvent({type:"subMenuAction", opening:false, menu:"list"});
	}

	function ShowConfirmMessage(astrMessage:String):Void
	{
		gotoAndStop("ConfirmMessage");
		PrepareInputElements(ButtonRect_mc);
		var messageArray:Array = astrMessage.split("\r\n");
		var strMessageText = messageArray.join("\n");
		MessageText.SetText(strMessageText);
		PrevFocus = FocusHandler.instance.getFocus(0);
		FocusHandler.instance.setFocus(this,0);
		InputHandler = HandleConfirmMessageInput;
		dispatchEvent({type:"subMenuAction", opening:true, menu:"message"});
	}

	function HideConfirmMessage():Void
	{
		FocusHandler.instance.setFocus(PrevFocus,0);
		ButtonRect_mc._alpha = 0;
		InputHandler = undefined;
		dispatchEvent({type:"subMenuAction", opening:false, menu:"message"});
	}

	function StartEditName(aInitialText:String, aiMaxChars:Number):Void
	{
		if (Selection.getFocus() != ItemName)
		{
			PrevFocus = FocusHandler.instance.getFocus(0);
			if (aInitialText != undefined)
			{
				ItemName.text = aInitialText;
			}
			ItemName.type = "input";
			ItemName.noTranslate = true;
			ItemName.selectable = true;
			ItemName.maxChars = aiMaxChars == undefined ? null : aiMaxChars;
			Selection.setFocus(ItemName,0);
			Selection.setSelection(0,0);
			InputHandler = HandleEditNameInput;
			dispatchEvent({type:"subMenuAction", opening:true, menu:"editName"});
			_bEditNameMode = true;
		}
	}

	function EndEditName():Void
	{
		ItemName.type = "dynamic";
		ItemName.noTranslate = false;
		ItemName.selectable = false;
		ItemName.maxChars = null;
		var bPreviousFocusEnabled:Boolean = PrevFocus.focusEnabled;
		PrevFocus.focusEnabled = true;
		Selection.setFocus(PrevFocus,0);
		PrevFocus.focusEnabled = bPreviousFocusEnabled;
		InputHandler = undefined;
		dispatchEvent({type:"subMenuAction", opening:false, menu:"editName"});
		_bEditNameMode = false;
	}

	function handleInput(details:InputDetails, pathToFocus:Array):Boolean
	{
		var bHandledInput:Boolean = false;
		if (pathToFocus.length > 0 && pathToFocus[0].handleInput != undefined)
		{
			pathToFocus[0].handleInput(details,pathToFocus.slice(1));
		}
		if (InputHandler != undefined)
		{
			bHandledInput = InputHandler(details);
		}
		return bHandledInput;
	}

	function HandleQuantityMenuInput(details:Object):Boolean
	{
		var bValidKeyPressed:Boolean = false;
		if (GlobalFunc.IsKeyPressed(details))
		{
			if (details.navEquivalent == NavigationCode.ENTER)
			{
				HideQuantityMenu(false);
				if (QuantitySlider_mc.value > 0)
				{
					dispatchEvent({type:"quantitySelect", amount:Math.floor(QuantitySlider_mc.value)});
				}
				else
				{
					itemInfo = LastUpdateObj;
				}
				bValidKeyPressed = true;
			}
			else if (details.navEquivalent == NavigationCode.TAB)
			{
				HideQuantityMenu(true);
				itemInfo = LastUpdateObj;
				bValidKeyPressed = true;
			}
		}
		return bValidKeyPressed;
	}
	function HandleListMenuInput(details:Object):Boolean
	{
		var bValidKeyPressed:Boolean = false;
		if (GlobalFunc.IsKeyPressed(details) && details.navEquivalent == NavigationCode.TAB)
		{
			HideListMenu();
			bValidKeyPressed = true;
		}
		return bValidKeyPressed;
	}
	function HandleConfirmMessageInput(details:Object):Boolean
	{
		var bValidKeyPressed:Boolean = false;
		if (GlobalFunc.IsKeyPressed(details))
		{
			if (details.navEquivalent == NavigationCode.ENTER)
			{
				HideConfirmMessage();
				dispatchEvent({type:"messageConfirm"});
				bValidKeyPressed = true;
			}
			else if (details.navEquivalent == NavigationCode.TAB)
			{
				HideConfirmMessage();
				dispatchEvent({type:"messageCancel"});
				itemInfo = LastUpdateObj;
				bValidKeyPressed = true;
			}
		}
		return bValidKeyPressed;
	}

	function HandleEditNameInput(details:Object):Boolean
	{
		Selection.setFocus(ItemName,0);
		if (GlobalFunc.IsKeyPressed(details))
		{
			if (details.navEquivalent == NavigationCode.ENTER && details.code != 32)
			{
				dispatchEvent({type:"endEditItemName", useNewName:true, newName:ItemName.text});
			}
			else if (details.navEquivalent == NavigationCode.TAB)
			{
				dispatchEvent({type:"endEditItemName", useNewName:false, newName:""});
			}
		}
		return true;
	}

	function onSliderChange():Void
	{
		var currentValue_tf:TextField = EnchantingSlider_mc._alpha <= 0 ? SliderValueText : TotalChargesValue;
		var iCurrentValue:Number = Number(currentValue_tf.text);
		var iNewValue:Number = Math.floor(QuantitySlider_mc.value);
		if (iCurrentValue != iNewValue)
		{
			currentValue_tf.SetText(iNewValue.toString());
			GameDelegate.call("PlaySound",["UIMenuPrevNext"]);
			dispatchEvent({type:"sliderChange", value:iNewValue});
		}
	}

	function onListItemPress(event:Object):Void
	{
		dispatchEvent(event);
		HideListMenu();
	}

	function onListMouseSelectionChange(event:Object):Void
	{
		if (event.keyboardOrMouse == 0)
		{
			onListSelectionChange(event);
		}
	}

	function onListSelectionChange(event:Object):Void
	{
		ItemCardMeters[InventoryDefines.ICT_LIST].SetDeltaPercent(ItemList.selectedEntry.chargeAdded + LastUpdateObj.currentCharge);
	}

}