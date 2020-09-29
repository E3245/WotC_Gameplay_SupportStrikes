class X2Helpers_SupportStrikes extends Object
	config(GameCore);

struct DLCAnimSetAdditions
{
	var Name CharacterTemplate;
	var String AnimSet;
	var String FemaleAnimSet;
};

var config Array<DLCAnimSetAdditions> AnimSetAdditions;

var config array<name>					AppendSupportStrikesCinematicToUnits;

static function OnPostCharacterTemplatesCreated()
{
	local X2CharacterTemplateManager CharacterTemplateMgr;
	local X2CharacterTemplate SoldierTemplate;
	local array<X2DataTemplate> DataTemplates;
	local int ScanTemplates, ScanAdditions;

	CharacterTemplateMgr = class'X2CharacterTemplateManager'.static.GetCharacterTemplateManager();
	
	for ( ScanAdditions = 0; ScanAdditions < default.AnimSetAdditions.Length; ++ScanAdditions )
	{
		CharacterTemplateMgr.FindDataTemplateAllDifficulties(default.AnimSetAdditions[ScanAdditions].CharacterTemplate, DataTemplates);
		for ( ScanTemplates = 0; ScanTemplates < DataTemplates.Length; ++ScanTemplates )
		{
			SoldierTemplate = X2CharacterTemplate(DataTemplates[ScanTemplates]);
			if (SoldierTemplate != none)
			{
				SoldierTemplate.AdditionalAnimSets.AddItem(AnimSet(`CONTENT.RequestGameArchetype(default.AnimSetAdditions[ScanAdditions].AnimSet)));
				SoldierTemplate.AdditionalAnimSetsFemale.AddItem(AnimSet(`CONTENT.RequestGameArchetype(default.AnimSetAdditions[ScanAdditions].FemaleAnimSet)));

				//Append any Cinematic maps into the soldiers as well
				//SoldierTemplate.strMatineePackages.AddItem("CIN_Vehicle_Aircraft_A10");
			}
		}
	}
}