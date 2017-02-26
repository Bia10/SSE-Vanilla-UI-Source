//Since this is new to Skyrim, I had to kind of guess how it worked. ~ Greavesy
class LoadWaitSpinner extends MovieClip
{
	var bFadedIn:Boolean;
	var LoadingIconHolder: MovieClip;
	function LoadWaitSpinner()
	{
		super();
		bFadedIn = false;
	}
	function InitExtensions()
	{
		Shared.GlobalFunc.SetLockFunction();
		LoadingIconHolder.Lock("BR");
	}
	function FadeInMenu()
	{
		if (!bFadedIn)
		{
			_parent.gotoAndPlay("fadeIn");
			bFadedIn = true;
		}
	}
	function FadeOutMenu()
	{
		if (bFadedIn)
		{
			_parent.gotoAndPlay("fadeOut");
			bFadedIn = false;
		}
	}
}