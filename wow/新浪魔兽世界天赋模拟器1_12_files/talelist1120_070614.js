/*
*/
maxLevel = 60;
talentPoints = 0;
currentTalent = 0;

icons = new Array();

function talList() {

    var win = window.open("","","resizable=1,toolbar=0,width=825,height=450,status=0,scrollbars=1,menubar=1");

	if(win != null)
	{
		win.document.write("<HTML><HEAD><LINK REL=\"stylesheet\" TYPE=\"text/css\" HREF=\"wwv/vault.css\"><TITLE>WoW "+currentClass+" talents</TITLE></HEAD>\n");
		win.document.write("<BODY BGCOLOR=\"#FFFFFF\" TEXT=\"000000\">\n");
		
		win.document.write(getAllTalents());
		
		win.document.write("</BODY></HTML>");
		win.document.close();
	}
	else
	{
		alert("An error occurred when displaying the talents list window. If you do not allow popup windows, you must copy/paste the info in the talent window to save the template.");
	}
}


function getAllTalents() {
	//sort: type *28 + 4*row + col
	var sortedTalents = new Array(28*3);
	var typeIdx = new Array();
	var tId;
	var rId;
	var cId;
	var sId;
	var html="<table width=85% border=1>";
	typeIdx[types[0]]= 0;
	typeIdx[types[1]]= 1;
	typeIdx[types[2]]= 2;
	
	for (var talentId in talents) {
		tId = typeIdx[talents[talentId].Type];
		rId = talents[talentId].Tier;
		cId = talents[talentId].Column;
		sId = tId*28+rId*4-4+cId;
		sortedTalents[sId] = talentId;
	}

	for (sId =0;sId< 28*3 ;sId++) {
		if (sId == 0) {
			html += "<tr><td align=middle><font class=\"accent\" size=20>"+types[0]+"</font></td><tr>";
		}
		if (sId == 28) {
			html += "<tr><td align=middle><font class=\"accent\" size=20>"+types[1]+"</font></td><tr>";
		}
		if (sId == 56) {
			html += "<tr><td align=middle><font class=\"accent\" size=20>"+types[2]+"</font></td><tr>";
		}

		if ( null != sortedTalents[sId] ) {
			html += showTalent2(sortedTalents[sId]);
		}
	}
	return html+"</table>";
}


function showTalent2(id)
{

	var html = "";
	html += "<tr><td>";
	if (iconEnable && !document.getElementById("simpleOutput").checked) {
		    html += "<img src="+ iconUrl + talents[id].Icon + ">";
	}

	html += "<nobr><span class=\"accent\"><b>" + talents[id].Name + "</b></span></nobr>";

	html += " 0";
	html += "/" + talents[id].Info.length + "</nobr><b> ["+talents[id].Type+"]</b>";
	for(var i in talents[id].Requirements)
	{
		var req = talents[id].Requirements[i];
		html += "<br><nobr><span class=\"smalltext\"";
		if(learned[req.Id] == null || learned[req.Id] < req.Amount)
		{
			html += " style=\"color: red;\"";
		}
		if(chinese){
			html += ">��Ҫ " + req.Amount + " ��";
		}else{
			html += ">Req " + req.Amount + " Point";
			if(req.Amount != 1)
			{			html += "s";		}
		}
		if(chinese){
		html += " �� " + talents[req.Id].Name + "</span></nobr>";
		}else{
		html += " in " + talents[req.Id].Name + "</span></nobr>";
		}
	}
	if(talents[id].Tier > 1)
	{
		var typereq = (talents[id].Tier - 1) * 5;
		html += "<br><nobr><span class=\"smalltext\"";
		if(masteries[talents[id].Type] < typereq)
		{
			html += " style=\"color: red;\"";
		}
		if(chinese){
		html += ">��Ҫ " + typereq + " ��";
		}else{
		html += ">Req " + typereq + " Point";
		if(talents[id].TypeReq != 1)
		{
			html += "s";
		}
		}
		if(chinese){
		html += " �� " + talents[id].Type + " �츳</span></nobr>";
		}else{
		html += " in " + talents[id].Type + " Talent</span></nobr>";
		}
	}
	var minLevel = getMinLevel(id);
	html += "<br><nobr><span class=\"smalltext\"";
	if(currentLevel < minLevel)
	{
	    html += " style=\"color: red;\"";
	}
	if(chinese){
	html += ">��͵ȼ�: " + minLevel;
	}else{
	html += ">Min Level: " + minLevel;
	}
	html += "</span></nobr>";

    html += "<br><br>";
    if(talents[id].Info.length > 0)
    {
	for (var j=1;j<=talents[id].Info.length;j++)
	{
	    if(chinese){
	    html += "<b>�ȼ� "+j+":</b> ";
	    }else{
	    html += "<b>Rank "+j+":</b> ";
	    }
	    var details = talents[id].Details;
	    if(details == "")
	    {
	        details = talents[id].Info[j-1].Details;
	    }
	    if(details != "")
	    {
	        html += "<span class=\"smalltext\">" + details + "</span><br>";
	    }
	    html += "<span class=\"accent\">" + getTalentDescription(id, j) + "</span><br>";
	}
    }
    return html;
}

//----8<-------------------------------------------[2005/01/13 16:53:39]


function showClassList() {
		var tmpStr="";
	for(var rId in classId){
		if (currentClass == rId) {
		tmpStr += "<INPUT type=radio name=\"radio\" checked onclick=\"OnSelectRadio("+classId[rId]+");\">"+rId;
		}else{
		tmpStr += "<INPUT type=radio name=\"radio\" onclick=\"OnSelectRadio("+classId[rId]+");\">"+rId;
		}
		setInnerHTML(document.getElementById("cn3"), tmpStr);
	}

}


function initLoad(){

if (currentClass == null || classId[currentClass] == null) {

var url2class;
if (window.location.href.match(/\?/)) {
url2class = window.location.href.replace(/^.*\?/,"");

if (url2class && !isNaN(url2class) && (url2class < 9)) {
	currentClass = classLst[url2class];
}}else{

	currentClass = classLst[5]; //---�޸ĵ�ǰĬ��ְҵ
}

	OnSelectType(currentClass);
	loadTalents();
	talents_main();
}
}

//----8<-------------------------------------------[
//constructor
//----8<-------------------------------------------[
function Talent(name, type, tier, column, icon, coords, details, description, info, requirements)
{
    this.Name = name;
    this.Type = type;
    this.Tier = tier;
    this.Column = column;
    this.Icon = icon;
    this.Coords = coords;
    this.Details = details;
    this.Description = description;
    this.Info = info;
    this.Requirements = requirements;
}

function TalentInfo(rank, amount, details, description)
{
    this.Rank = rank;
    this.Amount = amount;
    this.Details = details;
    this.Description = description;
}

function TalentImage(name, image, imageMap)
{
	this.Name = name;
	this.Image = iconUrl + image;
	this.imageMap = mapUrl + imageMap;
}

function TalentRequirement(id, amount)
{
	this.Id = id;
	this.Amount = amount;
}
//----8<-------------------------------------------[
//data
//----8<-------------------------------------------[
function preDefineClass(){
	classIdCn = {
		"��³��":0,
		"����"	:1,
		"��ʦ"	:2,
		"ʥ��ʿ":3,
		"��ʦ"	:4,
		"����"	:5,
		"������˾":6,
		"��ʿ"	:7,
		"սʿ"	:8
	};
	
	for ( var cId in classIdCn ) {
		classLstCn[classIdCn[cId]] = cId;
	}
	
	classIdEn = {
		"Druid"		:0,
		"Hunter"	:1,
		"Mage"		:2,
		"Paladin"	:3,
		"Priest"	:4,
		"Rogue"		:5,
		"Shaman"	:6,
		"Warlock"	:7,
		"Warrior"	:8
	}
	
	for ( var cId in classIdEn ) {
		classLstEn[classIdEn[cId]] = cId;
	}
	
	//classId * 3 [0-2]
	typesIdCn = new Array(
		"ƽ��", "Ұ��ս��", "�ָ�",
		"Ұ������", "���", "����",
		"����", "��˪", "����",
		"��ʥ", "����", "�ͽ�",
		"����", "��ʥ", "��Ӱ",
		"��ɱ", "ս��", "����",
		"Ԫ��", "��ǿ", "�ָ�",
		"ʹ��", "��ħѧʶ", "����",
		"����", "��ŭ", "����"
	);
	
	typesIdEn = new Array(
		"Balance", "Feral Combat", "Restoration",
		"Beast Mastery", "Marksmanship", "Survival",     
		"Arcane", "Frost", "Fire",		       
		"Holy", "Protection", "Retribution",	     
		"Discipline", "Holy", "Shadow",		  
		"Assassination", "Combat", "Subtlety",	   
		"Elemental Combat", "Enhancement", "Restoration",
		"Affliction", "Demonology", "Destruction",       
		"Arms", "Fury", "Protection"
		);		    

	for ( var cId in classIdEn ) {
		if(null==classStr) {
			classStr = cId;
		}else {
			classStr += ":"+cId;
		}
	}
}

function loadType() {
	if(chinese) {
		classId = classIdCn;
		classLst = classLstCn;
		typesId = typesIdCn;
	} else {
		classId = classIdEn;
		classLst = classLstEn;
		typesId = typesIdEn;	
	}

}

function loadBigImage(){
	talentImages[classLst[0]+typesId[0]] = iconUrl + "talent_druidbalance_r180.jpg";
	talentImages[classLst[0]+typesId[1]] = iconUrl + "talent_druidferalcombat_r180.jpg";
	talentImages[classLst[0]+typesId[2]] = iconUrl + "talent_druid_restoration_1p11.jpg";
	
	talentImages[classLst[1]+typesId[3]] = iconUrl + "talent_hunterbeastmastery_r170.jpg";
	talentImages[classLst[1]+typesId[4]] = iconUrl + "talent_huntermarksmanship_r170.jpg";
	talentImages[classLst[1]+typesId[5]] = iconUrl + "talent_huntersurvival_r170.jpg";
	
	talentImages[classLst[2]+typesId[6]] = iconUrl + "talent_mage_arcane_1p11_2.jpg";
	talentImages[classLst[2]+typesId[7]] = iconUrl + "talent_mage_frost_1p11_2.jpg";
	talentImages[classLst[2]+typesId[8]] = iconUrl + "talent_mage_fire_1p11_2.jpg";
	
	talentImages[classLst[3]+typesId[9]] = iconUrl + "talent_paladinholy_r191.jpg";
	talentImages[classLst[3]+typesId[10]] = iconUrl + "talent_paladinprotection_r191.jpg";
	talentImages[classLst[3]+typesId[11]] = iconUrl + "talent_paladinretribution_r192.jpg";
	
	talentImages[classLst[4]+typesId[12]] = iconUrl + "talent_priestdiscipline_r1.10.jpg";
	talentImages[classLst[4]+typesId[13]] = iconUrl + "talent_priestholy_r1.10.jpg";
	talentImages[classLst[4]+typesId[14]] = iconUrl + "talent_priestshadow_r1.10.jpg";
	
	talentImages[classLst[5]+typesId[15]] = iconUrl + "talent_rogueassassination_r112.jpg";
	talentImages[classLst[5]+typesId[16]] = iconUrl + "talent_roguecombat_r112.jpg";
	talentImages[classLst[5]+typesId[17]] = iconUrl + "talent_roguesubtlety_r112.jpg";
	
	talentImages[classLst[6]+typesId[18]] = iconUrl + "talent_shaman_elementalcombat_1p11_2.jpg";
	talentImages[classLst[6]+typesId[19]] = iconUrl + "talent_shaman_enhancement_1p11.jpg";
	talentImages[classLst[6]+typesId[20]] = iconUrl + "talent_shaman_restoration_1p11_2.jpg";
	
	talentImages[classLst[7]+typesId[21]] = iconUrl + "talent_warlockaffliction_r1.jpg";
	talentImages[classLst[7]+typesId[22]] = iconUrl + "talent_warlockdemonology_r1.jpg";
	talentImages[classLst[7]+typesId[23]] = iconUrl + "talent_warlockdestruction_r1.jpg";
	
	talentImages[classLst[8]+typesId[24]] = iconUrl + "talent_warriorarms_r1.jpg";
	talentImages[classLst[8]+typesId[25]] = iconUrl + "talent_warriorfury_r1.jpg";
	talentImages[classLst[8]+typesId[26]] = iconUrl + "talent_warriorprotection_r1.jpg";
}


//awu	get ID from option
function OnSelectType(i) {
	//alert(i+":"+typesId[3*classId[i]]+":"+typesId[3*classId[i]+1]+":"+typesId[3*classId[i]+2]+"<br>");
	types = new Array(typesId[3*classId[i]],typesId[3*classId[i]+1],typesId[3*classId[i]+2]);
	currentType = types[0];

	var tt;
	tt = document.getElementById("type_0");
	tt.value = types[0];
	tt = document.getElementById("type_1");
	tt.value = types[1];
	tt = document.getElementById("type_2");
	tt.value = types[2];
}


function OnSelectRadio(radio_id){
//	var isChange = confirm("ѡ��"+classLst[radio_id]+"��ȷ����?");
//	if (isChange == true) {
	currentClass = classLst[radio_id];
	OnSelectType(currentClass);
	loadTalents();
	talents_main();
//	}
}

//----8<-------------------------------------------[2005/01/10 19:47:55]


function loadTalents(){

	talents = new Array();	//for quick
	loadType();
	showClassList();
	loadBigImage();
	if(chinese) {
		loadTalentsCn();
	} else {
		loadTalentsEn();
	}
}
function loadTalentsCn(){

if (currentClass == classLst[0]) {

	talents[225] = new Talent( "Ѫ֮��", "Ұ��ս��", 4, 3, "Ability_GhoulFrenzy.png", "", "", "�����Ա���̬�µ����п��������������ļ����ڶԵ����������һ��֮����{0}�ļ�������һ�����������������", new Array(), new Array(new TalentRequirement(223, 3)));
	talents[537] = new Talent( "����֮�� (Ұ��)", "Ұ��ս��", 5, 3, "Spell_Nature_FaerieFire.png", "", "30����Ч����<br>˲��<br>6����ȴʱ��<br>��Ҫ�Ա���̬������̬��������̬<br>", "ʹĿ��Ļ��׽���175�㣬����40�롣��Ч�������ڼ䣬Ŀ���޷�Ǳ�л����Ρ�<br><br>Rank 2: -285�㻤��<br>Rank 3: -395�㻤��<br>Rank 4: -505�㻤��", new Array(), new Array());
	talents[540] = new Talent( "��֮Ѹ��", "Ұ��ս��", 3, 1, "Spell_Nature_SpiritWolf.png", "", "", "ʹ�����Ա���̬�µ��ƶ��ٶ���� {0}������������Ա���̬�µ����ܼ��� {1}��ֻ���ڻ�����Ч��", new Array(), new Array());
	talents[786] = new Talent( "Ұ�Գ��", "Ұ��ս��", 3, 2, "Ability_Hunter_Pet_Bear.png", "", "5 ŭ��<br>˲������<br>15 ����ȴʱ��<br>8-25 �����<br>��Ҫ����̬��������̬<br>", "��Ŀ���棬ʹ��ֹͣ��������ʹ����4���ڲ���ʩ���κη�����", new Array(), new Array());
	talents[220] = new Talent( "�ױ�", "Ұ��ս��", 1, 2, "Ability_Hunter_Pet_Hyena.png", "", "", "ʹ���鳻����ӻ���צ����ɨ�����ܵ�ŭ�����������ļ��� {0} ŭ��������", new Array(), new Array());
	talents[190] = new Talent( "��ŭ", "�ָ�", 1, 3, "Spell_Holy_BlessingOfStamina.png", "", "", "�����������̬�;�����̬ʱ�� {0} �ļ��ʻ�� 10�� ŭ��ֵ�������ڽ��뱪��̬ʱ��� 40�� ������", new Array(), new Array());
	talents[784] = new Talent( "������̬", "ƽ��", 7, 2, "Spell_Moonkin_Form.png", "", "684 ����<br>˲������<br>", "��³������������̬����������̬�£�����ֵ���360%���뾶30�뷶Χ�ڵ����ж��ѵķ�������һ���ʶ����3%��������̬��ֻ��ʩ��ƽ��ϵ�ķ�����<br><br>������Խ��ʩ�������ϵ����б��κ��ƶ�����Ч����", new Array(), new Array());
	talents[222] = new Talent( "Ұ����ײ", "Ұ��ս��", 2, 2, "Ability_Druid_Bash.png", "", "", "ʹ����ػ���ͻϮ���ܵĻ���Ч������ʱ���ӳ� {0}", new Array(), new Array());
	talents[221] = new Talent( "Ұ������", "Ұ��ս��", 1, 3, "Ability_Druid_DemoralizingRoar.png", "", "", "ʹ��Ĵ�־�����Ĺ���ǿ�ȼ���Ч����� {0}������˺ҧ����ɵ��˺���� {1}", new Array(), new Array());
	talents[526] = new Talent( "ǿ����ŭ", "�ָ�", 2, 3, "Ability_Druid_Enrage.png", "", "", "ʹ��Ŀ�ŭ������������ {0} ŭ��ֵ��", new Array(), new Array());
	talents[207] = new Talent( "ǿ�����Ƹ���", "ƽ��", 2, 1, "Spell_Nature_StrangleVines.png", "", "", "ʹ����{0}�ļ�����ʩ�ž�������ʱ������Ϊ�����˺�������ϡ�", new Array(), new Array());
	talents[192] = new Talent( "ǿ������֮��", "�ָ�", 2, 1, "Spell_Nature_HealingTouch.png", "", "", "ʹ�������֮����ʩ��ʱ����� {0}", new Array(), new Array());
	talents[189] = new Talent( "ǿ��Ұ��ӡ��", "�ָ�", 1, 2, "Spell_Nature_Regeneration.png", "", "", "ʹ���Ұ��ӡ�ǵ�Ч�����{0}", new Array(), new Array());
	talents[208] = new Talent( "ǿ���»���", "ƽ��", 2, 2, "Spell_Nature_StarFall.png", "", "", "ʹ����»������˺�������һ���������{0}", new Array(), new Array());
	talents[782] = new Talent( "ǿ����Ȼ֮��", "ƽ��", 1, 3, "Spell_Nature_NaturesWrath.png", "", "", "������Ȼ֮��ʩչ���������ס���˵ļ���{0}", new Array(), new Array(new TalentRequirement(781, 1)));
	talents[235] = new Talent( "��Ⱥ����", "Ұ��ս��", 7, 2, "Spell_Holy_BlessingOfStamina.png", "", "", "���Ա����ܻ������̬�£�ʹ�뾶45�뷶Χ�ڵ�����С�ӳ�Ա��Զ�̺ͽ�ս�����������һ���ļ������3%��", new Array(), new Array());
	talents[542] = new Talent( "Ұ����ŭ", "Ұ��ս��", 5, 1, "Ability_Druid_Ravage.png", "", "", "ʹ���צ����ɨ����鳻��ͻӻ���������ɵ��˺���� {0}", new Array(), new Array());
	talents[532] = new Talent( "ǿ������", "�ָ�", 6, 3, "Spell_Nature_ResistNature.png", "", "", "ʹ������Ϸ���������Ч����Ч���ļ������{0}", new Array(), new Array());
	talents[198] = new Talent( "ǿ���ش���", "�ָ�", 4, 4, "Spell_Nature_Rejuvenation.png", "", "", "ʹ��Ļش�����Ч����� {0}", new Array(), new Array());
	talents[227] = new Talent( "ǿ��˺��", "Ұ��ս��", 4, 1, "INV_Misc_MonsterFang_01.png", "", "", "ʹ���˺�鼼�������ĵ�����ֵ���� {0}", new Array(), new Array());
	talents[211] = new Talent( "ǿ���ǻ���", "ƽ��", 4, 3, "Spell_Arcane_StarFire.png", "", "", "ʹ����ǻ���ʩ��ʱ����� {0} �룬������ {1} �ļ��ʽ�Ŀ�����3�롣", new Array(), new Array());
	talents[214] = new Talent( "ǿ��������", "ƽ��", 3, 1, "Spell_Nature_Thorns.png", "", "", "ʹ��ľ������Ե�����ɵ��˺���� {0}", new Array(), new Array());
	talents[201] = new Talent( "ǿ������", "�ָ�", 5, 4, "Spell_Nature_Tranquility.png", "", "", "ʹ�������������������в�Ƚ��� {0}", new Array(), new Array());
	talents[780] = new Talent( "ǿ����ŭ", "ƽ��", 1, 1, "Spell_Nature_AbolishMagic.png", "", "", "ʹ��ķ�ŭ������ʩ��ʱ�����{0}", new Array(), new Array());
	talents[788] = new Talent( "Ѹ������", "�ָ�", 7, 2, "swiftmend.png", "", "20%��������ֵ<br>40����Ч����<br>˲��<br>15����ȴʱ��<br>", "���ѷ�Ŀ�����ϵĻش���������Ч��ת��Ϊ˲�����ƣ���������Ŀ���൱��12��Ļش���������������15���������������", new Array(), new Array(new TalentRequirement(529, 5)));
	talents[534] = new Talent( "��ŭ", "ƽ��", 6, 2, "Spell_Nature_MoonGlow.png", "", "", "ʹ����ǻ������»����ͷ�ŭ������ɵ��˺���� {0}", new Array(), new Array(new TalentRequirement(544, 1)));
	talents[215] = new Talent( "�¹�", "ƽ��", 5, 3, "Spell_Nature_Sentinal.png", "", "", "ʹ����»������ǻ�������ŭ������֮�������Ϻͻش��������ĵķ���ֵ���� {0}��", new Array(), new Array());
	talents[528] = new Talent( "��Ȼ�͸�", "�ָ�", 5, 3, "Spell_Nature_ProtectionformNature.png", "", "", "ʹ������Ʒ�����Ч����� {0}", new Array(), new Array(new TalentRequirement(527, 1)));
	talents[191] = new Talent( "��Ȼ����", "�ָ�", 2, 2, "Spell_Nature_HealingWaveGreater.png", "", "", "ʹ����ʩ������֮�����ش���������ʱ�� {0} �ļ��ʲ������ܵ��˺�������ϡ�", new Array(), new Array());
	talents[544] = new Talent( "��Ȼ֮��", "ƽ��", 5, 2, "Spell_Nature_NaturesBlessing.png", "", "", "����ʹ���κη�����Ŀ���������һ��Ч��֮��ʹ������Ȼ�Ĵ͸���ʹ�����һ������ʩ��ʱ����� 0.5 �롣", new Array(), new Array());
	talents[781] = new Talent( "��Ȼ֮��", "ƽ��", 1, 2, "Spell_Nature_NaturesWrath.png", "", "50����ֵ<br>˲��<br>1����ȴʱ��<br>", "����֮���κλ���ʩ���ߵĵ��˶���35%�ļ��ʱ�ʩչ�������루�ȼ� 1����ֻ���ڻ���ʹ�ã�����Ч1�Σ�����45�롣<br><br>18�����������루�ȼ� 1��<br>28�����������루�ȼ� 2��<br>38�����������루�ȼ� 3��<br>48�����������루�ȼ� 4��<br>58�����������루�ȼ� 5��", new Array(), new Array());
	talents[209] = new Talent( "��Ȼ����", "ƽ��", 3, 4, "Spell_Nature_NatureTouchGrow.png", "", "", "ʹ��ķ�ŭ���������롢����֮������״̬�£����»������ǻ������������{0}", new Array(), new Array());
	talents[199] = new Talent( "��ȻѸ��", "�ָ�", 5, 1, "Spell_Nature_RavenForm.png", "", "˲������<br>3������ȴʱ��<br>", "����֮�������һ����Ȼ�������Ϊ˲��������", new Array(), new Array(new TalentRequirement(192, 5)));
	talents[543] = new Talent( "����Ԥ��", "ƽ��", 3, 3, "INV_Misc_Orb_01.png", "", "120����ֵ<br>˲��<br>", "����Ȼ������ǿ����³����������ÿ�λ��е��˶���һ���������³���������ʩ��״̬����״̬�����������һ���˺������Ʒ��������ĵķ���ֵ����100%������5���ӡ�", new Array(), new Array(new TalentRequirement(546, 5)));
	talents[536] = new Talent( "���޹���", "Ұ��ս��", 4, 2, "Ability_Hunter_Pet_Cat.png", "", "", "ʹ�����Ա����ܺ;�����̬�µĹ���ǿ�ȼӳ���ߣ���ֵ�൱����ĵ�ǰ�ȼ��� {0}", new Array(), new Array());
	talents[787] = new Talent( "ԭʼ��ŭ", "Ұ��ս��", 4, 4, "Ability_Racial_Cannibalize.png", "", "", "ʹ��������̬�;�����̬�¶�Ŀ���������һ������ {0} �ļ��ʻ�� 5 ��ŭ��ֵ", new Array(), new Array(new TalentRequirement(223, 3)));
	talents[234] = new Talent( "Ұ�Ա���", "Ұ��ս��", 2, 1, "Ability_Ambush.png", "", "", "ʹ��������̬�;�����̬�²�������в����� {0}�����ҵ�����Ǳ��ʱ�ɽ��͵���������ļ��ʡ�", new Array(), new Array());
	talents[530] = new Talent( "����", "�ָ�", 3, 2, "Spell_Frost_WindWalkOn.png", "", "", "ʹ����ʩ��ʱ�Ա��� {0} �ķ����ظ��ٶȡ�", new Array(), new Array());
	talents[223] = new Talent( "������צ", "Ұ��ս��", 3, 3, "INV_Misc_MonsterClaw_04.png", "", "", "ʹ�����ܡ����ܻ���̬�µ�����һ��������� {0}", new Array(), new Array());
	talents[541] = new Talent( "Ұ��֮��", "Ұ��ս��", 6, 2, "Spell_Holy_BlessingOfAgility.png", "", "", "ʹ���������� {0}�����⣬�����ܻ������̬��������� {1}�����ڱ���̬��������� {2}", new Array(), new Array(new TalentRequirement(536, 3)));
	talents[531] = new Talent( "΢��", "�ָ�", 3, 4, "Ability_EyeOfTheOwl.png", "", "", "ʹ������Ʒ�����ɵ���вֵ���� {0}��", new Array(), new Array());
	talents[783] = new Talent( "��Ȼ����", "ƽ��", 2, 4, "Spell_Nature_WispSplode.png", "", "", "ʹ������б��η��������ĵķ���ֵ���� {0}", new Array(), new Array());
	talents[539] = new Talent( "��Ƥ", "Ұ��ս��", 2, 3, "INV_Misc_Pelt_Bear_03.png", "", "", "ʹ���װ���ϻ�õĻ���ֵ��� {0}", new Array(), new Array());
	talents[545] = new Talent( "����", "ƽ��", 4, 2, "Spell_Nature_Purge.png", "", "", "ʹ����ǻ������»����ͷ�ŭ������һ���˺���� {0}��", new Array(), new Array(new TalentRequirement(208, 5)));
	talents[546] = new Talent( "��Ȼ����", "ƽ��", 2, 3, "INV_Staff_01.png", "", "", "ʹ����������̬�µ�����ɵ��������˺���� {0}", new Array(), new Array());
	talents[527] = new Talent( "��Ⱥ", "�ָ�", 3, 3, "Spell_Shadow_Contagion.png", "", "45�㷨��ֵ<br>30����Ч����<br>˲��<br>", "���˱��ɳ�Χ�ƣ����������ʽ���2%����12�����ܵ��ܼ�66����Ȼ�˺���<br><br>Rank 2: 85����ֵ��138���˺�<br>Rank 3: 100����ֵ��174���˺�<br>Rank 4: 140����ֵ��264���˺�<br>Rank 5: 160����ֵ��324���˺�", new Array(), new Array());
	talents[529] = new Talent( "����֮��", "�ָ�", 4, 2, "Ability_Druid_Tranquil_Spirit.png", "", "", "ʹ�������֮�������������ĵķ���ֵ���� {0}��", new Array(), new Array());
	talents[225].Info[0] = new TalentInfo(1, "50%", "", "");
	talents[225].Info[1] = new TalentInfo(2, "100%", "", "");
	talents[537].Info[0] = new TalentInfo(1, "", "", "");
	talents[540].Info[0] = new TalentInfo(1, "", "", "");
	talents[786].Info[0] = new TalentInfo(1, "", "", "");
	talents[220].Info[0] = new TalentInfo(1, "1", "", "");
	talents[220].Info[1] = new TalentInfo(2, "2", "", "");
	talents[220].Info[2] = new TalentInfo(3, "3", "", "");
	talents[220].Info[3] = new TalentInfo(4, "4", "", "");
	talents[220].Info[4] = new TalentInfo(5, "5", "", "");
	talents[190].Info[0] = new TalentInfo(1, "20%", "", "");
	talents[190].Info[1] = new TalentInfo(2, "40%", "", "");
	talents[190].Info[2] = new TalentInfo(3, "60%", "", "");
	talents[190].Info[3] = new TalentInfo(4, "80%", "", "");
	talents[190].Info[4] = new TalentInfo(5, "100%", "", "");
	talents[528].Info[0] = new TalentInfo(1, "2%", "", "");
	talents[528].Info[1] = new TalentInfo(2, "4%", "", "");
	talents[528].Info[2] = new TalentInfo(3, "6%", "", "");
	talents[528].Info[3] = new TalentInfo(4, "8%", "", "");
	talents[528].Info[4] = new TalentInfo(5, "10%", "", "");
	talents[784].Info[0] = new TalentInfo(1, "", "", "");
	talents[222].Info[0] = new TalentInfo(1, "0.5 ��", "", "");
	talents[222].Info[1] = new TalentInfo(2, "1 ��", "", "");
	talents[221].Info[0] = new TalentInfo(1, "8%,3%", "", "");
	talents[221].Info[1] = new TalentInfo(2, "16%,6%", "", "");
	talents[221].Info[2] = new TalentInfo(3, "24%,9%", "", "");
	talents[221].Info[3] = new TalentInfo(4, "32%,12%", "", "");
	talents[221].Info[4] = new TalentInfo(5, "40%,15%", "", "");
	talents[526].Info[0] = new TalentInfo(1, "5 ��", "", "");
	talents[526].Info[1] = new TalentInfo(2, "10 ��", "", "");
	talents[207].Info[0] = new TalentInfo(1, "40%", "", "");
	talents[207].Info[1] = new TalentInfo(2, "70%", "", "");
	talents[207].Info[2] = new TalentInfo(3, "100%", "", "");
	talents[192].Info[0] = new TalentInfo(1, "0.1 ��", "", "");
	talents[192].Info[1] = new TalentInfo(2, "0.2 ��", "", "");
	talents[192].Info[2] = new TalentInfo(3, "0.3 ��", "", "");
	talents[192].Info[3] = new TalentInfo(4, "0.4 ��", "", "");
	talents[192].Info[4] = new TalentInfo(5, "0.5 ��", "", "");
	talents[189].Info[0] = new TalentInfo(1, "7%", "", "");
	talents[189].Info[1] = new TalentInfo(2, "14%", "", "");
	talents[189].Info[2] = new TalentInfo(3, "21%", "", "");
	talents[189].Info[3] = new TalentInfo(4, "28%", "", "");
	talents[189].Info[4] = new TalentInfo(5, "35%", "", "");
	talents[208].Info[0] = new TalentInfo(1, "2%", "", "");
	talents[208].Info[1] = new TalentInfo(2, "4%", "", "");
	talents[208].Info[2] = new TalentInfo(3, "6%", "", "");
	talents[208].Info[3] = new TalentInfo(4, "8%", "", "");
	talents[208].Info[4] = new TalentInfo(5, "10%", "", "");
	talents[782].Info[0] = new TalentInfo(1, "15%", "", "");
	talents[782].Info[1] = new TalentInfo(2, "30%", "", "");
	talents[782].Info[2] = new TalentInfo(3, "45%", "", "");
	talents[782].Info[3] = new TalentInfo(4, "65%", "", "");
	talents[235].Info[0] = new TalentInfo(1, "", "", "");
	talents[542].Info[0] = new TalentInfo(1, "10%", "", "");
	talents[542].Info[1] = new TalentInfo(2, "20%", "", "");
	talents[532].Info[0] = new TalentInfo(1, "10%", "", "");
	talents[532].Info[1] = new TalentInfo(2, "20%", "", "");
	talents[532].Info[2] = new TalentInfo(3, "30%", "", "");
	talents[532].Info[3] = new TalentInfo(4, "40%", "", "");
	talents[532].Info[4] = new TalentInfo(5, "50%", "", "");
	talents[198].Info[0] = new TalentInfo(1, "5%", "", "");
	talents[198].Info[1] = new TalentInfo(2, "10%", "", "");
	talents[198].Info[2] = new TalentInfo(3, "15%", "", "");
	talents[227].Info[0] = new TalentInfo(1, "6 ��", "", "");
	talents[227].Info[1] = new TalentInfo(2, "12 ��", "", "");
	talents[211].Info[0] = new TalentInfo(1, "0.1,3%", "", "");
	talents[211].Info[1] = new TalentInfo(2, "0.2,6%", "", "");
	talents[211].Info[2] = new TalentInfo(3, "0.3,9%", "", "");
	talents[211].Info[3] = new TalentInfo(4, "0.4,12%", "", "");
	talents[211].Info[4] = new TalentInfo(5, "0.5,15%", "", "");
	talents[214].Info[0] = new TalentInfo(1, "25%", "", "");
	talents[214].Info[1] = new TalentInfo(2, "50%", "", "");
	talents[214].Info[2] = new TalentInfo(3, "75%", "", "");
	talents[201].Info[0] = new TalentInfo(1, "40%", "", "");
	talents[201].Info[1] = new TalentInfo(2, "80%", "", "");
	talents[780].Info[0] = new TalentInfo(1, "0.1 ��", "", "");
	talents[780].Info[1] = new TalentInfo(2, "0.2 ��", "", "");
	talents[780].Info[2] = new TalentInfo(3, "0.3 ��", "", "");
	talents[780].Info[3] = new TalentInfo(4, "0.4 ��", "", "");
	talents[780].Info[4] = new TalentInfo(5, "0.5 ��", "", "");
	talents[788].Info[0] = new TalentInfo(1, "", "", "");
	talents[534].Info[0] = new TalentInfo(1, "2%", "", "");
	talents[534].Info[1] = new TalentInfo(2, "4%", "", "");
	talents[534].Info[2] = new TalentInfo(3, "6%", "", "");
	talents[534].Info[3] = new TalentInfo(4, "8%", "", "");
	talents[534].Info[4] = new TalentInfo(5, "10%", "", "");
	talents[215].Info[0] = new TalentInfo(1, "3%", "", "");
	talents[215].Info[1] = new TalentInfo(2, "6%", "", "");
	talents[215].Info[2] = new TalentInfo(3, "9%", "", "");
	talents[191].Info[0] = new TalentInfo(1, "14%", "", "");
	talents[191].Info[1] = new TalentInfo(2, "28%", "", "");
	talents[191].Info[2] = new TalentInfo(3, "42%", "", "");
	talents[191].Info[3] = new TalentInfo(4, "56%", "", "");
	talents[191].Info[4] = new TalentInfo(5, "70%", "", "");
	talents[544].Info[0] = new TalentInfo(1, "", "", "");
	talents[781].Info[0] = new TalentInfo(1, "", "", "");
	talents[209].Info[0] = new TalentInfo(1, "10%", "", "");
	talents[209].Info[1] = new TalentInfo(2, "20%", "", "");
	talents[199].Info[0] = new TalentInfo(1, "", "", "");
	talents[543].Info[0] = new TalentInfo(1, "", "", "");
	talents[536].Info[0] = new TalentInfo(1, "50%", "", "");
	talents[536].Info[1] = new TalentInfo(2, "100%", "", "");
	talents[536].Info[2] = new TalentInfo(3, "150%", "", "");
	talents[787].Info[0] = new TalentInfo(1, "50%", "", "");
	talents[787].Info[1] = new TalentInfo(2, "100%", "", "");
	talents[234].Info[0] = new TalentInfo(1, "25%", "", "");
	talents[530].Info[0] = new TalentInfo(1, "5%", "", "");
	talents[530].Info[1] = new TalentInfo(2, "10%", "", "");
	talents[530].Info[2] = new TalentInfo(3, "15%", "", "");
	talents[223].Info[0] = new TalentInfo(1, "2%", "", "");
	talents[223].Info[1] = new TalentInfo(2, "4%", "", "");
	talents[223].Info[2] = new TalentInfo(3, "6%", "", "");
	talents[234].Info[0] = new TalentInfo(1, "3%", "", "");
	talents[234].Info[1] = new TalentInfo(2, "6%", "", "");
	talents[234].Info[2] = new TalentInfo(3, "9%", "", "");
	talents[234].Info[3] = new TalentInfo(4, "12%", "", "");
	talents[234].Info[4] = new TalentInfo(5, "15%", "", "");
	talents[541].Info[0] = new TalentInfo(1, "4%,4%,4%", "", "");
	talents[541].Info[1] = new TalentInfo(2, "8%,8%,8%", "", "");
	talents[541].Info[2] = new TalentInfo(3, "12%,12%,12%", "", "");
	talents[541].Info[3] = new TalentInfo(4, "16%,16%,16%", "", "");
	talents[541].Info[4] = new TalentInfo(5, "20%,20%,20%", "", "");
	talents[531].Info[0] = new TalentInfo(1, "4%", "", "");
	talents[531].Info[1] = new TalentInfo(2, "8%", "", "");
	talents[531].Info[2] = new TalentInfo(3, "12%", "", "");
	talents[531].Info[3] = new TalentInfo(4, "16%", "", "");
	talents[531].Info[4] = new TalentInfo(5, "20%", "", "");
	talents[783].Info[0] = new TalentInfo(1, "10%", "", "");
	talents[783].Info[1] = new TalentInfo(2, "20%", "", "");
	talents[783].Info[2] = new TalentInfo(3, "30%", "", "");
	talents[539].Info[0] = new TalentInfo(1, "2%", "", "");
	talents[539].Info[1] = new TalentInfo(2, "4%", "", "");
	talents[539].Info[2] = new TalentInfo(3, "6%", "", "");
	talents[539].Info[3] = new TalentInfo(4, "8%", "", "");
	talents[539].Info[4] = new TalentInfo(5, "10%", "", "");
	talents[545].Info[0] = new TalentInfo(1, "20%", "", "");
	talents[545].Info[1] = new TalentInfo(2, "40%", "", "");
	talents[545].Info[2] = new TalentInfo(3, "60%", "", "");
	talents[545].Info[3] = new TalentInfo(4, "80%", "", "");
	talents[545].Info[4] = new TalentInfo(5, "100%", "", "");
	talents[546].Info[0] = new TalentInfo(1, "2%", "", "");
	talents[546].Info[1] = new TalentInfo(2, "4%", "", "");
	talents[546].Info[2] = new TalentInfo(3, "6%", "", "");
	talents[546].Info[3] = new TalentInfo(4, "8%", "", "");
	talents[546].Info[4] = new TalentInfo(5, "10%", "", "");	
	talents[540].Info[0] = new TalentInfo(1, "15%,2%", "", "");
	talents[540].Info[1] = new TalentInfo(2, "30%,4%", "", "");
	talents[527].Info[0] = new TalentInfo(2, "", "", "");
	talents[529].Info[0] = new TalentInfo(1, "2%", "", "");
	talents[529].Info[1] = new TalentInfo(2, "4%", "", "");
	talents[529].Info[2] = new TalentInfo(3, "6%", "", "");
	talents[529].Info[3] = new TalentInfo(4, "8%", "", "");
	talents[529].Info[4] = new TalentInfo(5, "10%", "", "");


//----8<-------------------------------------------

}
if (currentClass == classLst[1]) {

	talents[688] = new Talent( "��׼���", "���", 3, 1, "INV_Spear_07.png", "", "68 ����ֵ<br>3 ��ʩ��ʱ��<br>6 ������ȴʱ��<br>8-35����Ч����<br>��ҪԶ������<br>", "��׼Ŀ�������ʹԶ���˺����70�㡣", new Array(), new Array());
	talents[690] = new Talent( "��Ļ", "���", 5, 2, "Ability_UpgradeMoonGlaive.png", "", "", "ʹ��Ķ�����������䷨�����˺���� {0}", new Array(), new Array());
	talents[673] = new Talent( "Ұ�޽���", "Ұ������", 5, 4, "Spell_Nature_AbolishMagic.png", "", "", "ʹ��ĳ���ļ���ֵ�ظ��ٶ���� {0}��", new Array(), new Array());
	talents[675] = new Talent( "Ұ��Ѹ��", "Ұ������", 3, 2, "Ability_Druid_Dash.png", "", "", "ʹ��ĳ����ڻ�����ƶ��ٶ����30%��", new Array(), new Array());
	talents[711] = new Talent( "����", "����", 5, 3, "Ability_Warrior_Challange.png", "", "45 ����ֵ<br>˲������<br>5 ����ȴʱ��<br>5����Ч����<br>", "���мܵ��˵Ĺ���֮�����ʹ�õļ��ܣ��Ե������40���˺�����ʹ���޷��ж�������5�롣�����޷����񵲡��������мܡ�", new Array(), new Array(new TalentRequirement(705, 1)));
	talents[708] = new Talent( "ǿ������[Improved Feign Death]", "����", 4, 4, "ImprovedFeignDeath.png", "", "", "ʹ���˵ֿ���ļ������ܵļ��ʽ��� {0}��", new Array(), new Array());
	talents[705] = new Talent( "����", "����", 3, 3, "Ability_Whirlwind.png", "", "˲������<br>5������ȴʱ��<br>", "����֮��ʹ��Ķ������мܼ������25%������10�롣", new Array(), new Array());
	talents[685] = new Talent( "Ч��", "���", 1, 3, "Spell_Frost_WizardMark.png", "", "", "ʹ��ʩ������Ͷ��̼��������ĵķ���ֵ���� {0}", new Array(), new Array());
	talents[670] = new Talent( "�;�ѵ��", "Ұ������", 1, 3, "Spell_Nature_Reincarnation.png", "", "", "ʹ��ĳ��������ֵ���{0}", new Array(), new Array());
	talents[700] = new Talent( "�ղ�", "����", 2, 1, "Spell_Nature_StrangleVines.png", "", "", "ʹ����׼����塢��˪����ͱ�ը������ {0} �ļ�����סĿ�꣬�������޷��ƶ�������5�롣", new Array(), new Array());
	talents[680] = new Talent( "�ױ�", "Ұ������", 4, 3, "INV_Misc_MonsterClaw_04.png", "", "", "ʹ��ĳ���������һ���ļ������ {0}", new Array(), new Array());
	talents[682] = new Talent( "����", "Ұ������", 6, 3, "INV_Misc_MonsterClaw_03.png", "", "", "ʹ��ĳ�����{0}�ļ����ڶԵ����������һ�����ù����ٶ����30%��Ч��������8�롣", new Array(), new Array(new TalentRequirement(680, 5)));
	talents[694] = new Talent( "ӥ��", "���", 3, 4, "Ability_TownWatch.png", "", "", "ʹ���Զ������������ӳ� {0}", new Array(), new Array());
	talents[689] = new Talent( "ǿ���������", "���", 3, 2, "Ability_ImpalingBolt.png", "", "", "ʹ��İ����������ȴʱ�����{0}", new Array(), new Array());
	talents[669] = new Talent( "ǿ����ӥ�ػ�", "Ұ������", 1, 2, "Spell_Nature_RavenForm.png", "", "", "����ӥ�ػ����ڼ���״̬ʱ��������ͨ��Զ�̹�������{0}�ļ���ʹ���Զ�̹����ٶ����30%������8�롣", new Array(), new Array());
	talents[672] = new Talent( "ǿ������ػ�", "Ұ������", 2, 2, "Ability_Hunter_AspectOfTheMonkey.png", "", "", "ʹ�������ػ��ṩ{0}�Ķ���������ʡ�", new Array(), new Array());
	talents[684] = new Talent( "ǿ�������", "���", 1, 2, "Spell_Frost_Stun.png", "", "", "ʹ���������� {0} �ļ�����Ŀ�����3��", new Array(), new Array());
	talents[707] = new Talent( "�ȹ�[Surefooted]", "����", 4, 2, "Ability_Kick.png", "", "", "ʹ��Ĺ������е��˵ļ������ {0}����ʹ��ֿ��ƶ�����Ч���ļ������ {1}��", new Array(), new Array());
	talents[671] = new Talent( "ǿ��Ұ��֮��", "Ұ������", 2, 1, "Ability_EyeOfTheOwl.png", "", "", "ʹ���Ұ��֮�۵�Ч������ʱ���ӳ� {0}", new Array(), new Array());
	talents[706] = new Talent( "��������[Trap Mastery]", "����", 4, 1, "TrapMastery.png", "", "", "ʹ���˵ֿ��������Ч���ļ��ʽ��� {0}��", new Array(), new Array());
	talents[686] = new Talent( "ǿ������ӡ��", "���", 2, 2, "Ability_Hunter_SniperShot.png", "", "", "ʹ�������ӡ�Ƿ������ṩ��Զ�̹���ǿ�ȼӳ����{0}", new Array(), new Array());
	talents[703] = new Talent( "������Ч[Trap Efficiency]", "����", 3, 1, "TrapEfficiency.png", "", "", "ʹ��ı�������ͱ�˪�����Ч������ʱ����� {0}���׼�����ͱ�ը��������ɵ��˺���� {1}��", new Array(), new Array());
	talents[679] = new Talent( "ǿ�����Ƴ���", "Ұ������", 4, 2, "Ability_Hunter_MendPet.png", "", "", "ʹ������Ƴ��﷨����{0}�ļ���ÿ5����ɢ�������ϵ�1�����䡢������ħ�����ж�Ч����", new Array(), new Array());
	talents[704] = new Talent( "����ר��[Survivalist]", "����", 3, 2, "Survivalist.png", "", "", "ʹ��������������{0}", new Array(), new Array());
	talents[699] = new Talent( "ƫб", "����", 1, 3, "Ability_Parry.png", "", "", "ʹ����мܼ������ {0}��", new Array(), new Array());
	talents[674] = new Talent( "ǿ���������", "Ұ������", 2, 4, "Ability_Hunter_BeastSoothe.png", "", "", "ʹ��ĸ�����﷨����ʩ��ʱ�����{0}������ֵ���Ľ���{1}�����︴��������ֵ���{2}��", new Array(), new Array());
	talents[695] = new Talent( "ǿ����Ы����", "���", 5, 3, "Ability_Hunter_CriticalShot.png", "", "", "ʹĿ���������Ы���̵�Ч��������ʱ��������Ҳ��֮���͡������Ľ���ֵ�൱����������ֵ��{0}", new Array(), new Array());
	talents[691] = new Talent( "ǿ�����߶���", "���", 4, 2, "Ability_Hunter_Quickshot.png", "", "", "ʹ��Ķ��߶�������ɵ��˺����{0}", new Array(), new Array());
	talents[702] = new Talent( "ǿ��ˤ��", "����", 2, 3, "Ability_Rogue_Trip.png", "", "", "ʹ���ˤ������ {0} �ļ�����Ŀ����5�����޷��ƶ���", new Array(), new Array());
	talents[681] = new Talent( "в��", "Ұ������", 5, 2, "Ability_Devour.png", "", "137 ����ֵ<br>˲������<br>1 ������ȴʱ��<br>100����Ч����<br>", "������ĳ������´λ��е���ʱ����в�ȣ���ɴ�������вֵ����ʹĿ�����3�롣", new Array(), new Array());
	talents[714] = new Talent( "��������", "����", 7, 2, "WyvernSting.png", "", "115 ����ֵ<br>˲������<br>8-35 ����Ч����<br>2 ������ȴʱ��<br>", "����Ŀ�꣬ʹ���˯12�롣�κ��˺�����ȡ����˯Ч������Ŀ������ʱ�����̻���12���ڶ������300����Ȼ�˺���ֻ���ڷ�ս��״̬��ʹ�á�ÿ��������ͬһʱ����ֻ�ܶ�һ��Ŀ��ʹ��һ�ֶ��̣���ͬ�ඤ���޷����ӡ�", new Array(), new Array(new TalentRequirement(710, 3)));
	talents[687] = new Talent( "�������", "���", 2, 3, "Ability_SearingArrow.png", "", "", "ʹ���Զ�������������һ���ļ������{0}", new Array(), new Array());
	talents[701] = new Talent( "Ұ�����[Savage Strikes]", "����", 2, 2, "Ability_Racial_BloodRage.png", "", "", "ʹ�������һ����è��˺ҧ������һ��������� {0}��", new Array(), new Array());
	talents[713] = new Talent( "���練��[Lightning Refexes]", "����", 6, 3, "Spell_Nature_Invisibilty.png", "", "", "ʹ����������{0}", new Array(), new Array());
	talents[692] = new Talent( "�������", "���", 4, 3, "Ability_PierceDamage.png", "", "", "ʹ���Զ����������һ���˺����{0}", new Array(), new Array(new TalentRequirement(687, 5)));
	talents[677] = new Talent( "Ѱ·", "Ұ������", 3, 1, "Ability_Mount_JungleTiger.png", "", "", "ʹ����Ա��ػ��ͱ�Ⱥ�ػ����ٶȼӳ�Ч����� {0}��", new Array(), new Array());
	talents[698] = new Talent( "��������ɱ��[Humanoid Slaying]", "����", 1, 2, "HumanoidSlaying.png", "", "", "ʹ���������������ɵ������˺���� {0}����������������ɵ�����һ���˺���� {1}��", new Array(), new Array());
	talents[696] = new Talent( "Զ������ר��", "���", 6, 3, "INV_Weapon_Rifle_06.png", "", "", "ʹ���Զ��������ɵ��˺����{0}", new Array(), new Array());
	talents[710] = new Talent( "ɱ¾����[Killer Instinct]", "����", 5, 2, "Spell_Holy_BlessingOfStamina.png", "", "", "ʹ������й����������һ���ļ������ {0}��", new Array(), new Array());
	talents[693] = new Talent( "��ɢ���", "���", 5, 1, "Ability_GolemStormBolt.png", "", "123 ����ֵ<br>˲������<br>30 ����ȴʱ��<br>15 ����Ч����<br>��ҪԶ������<br>", "�̳��������Ŀ�����50%�������˺�����ʹ���Ի�4�롣�κ��˺����������Ч����", new Array(), new Array());
	talents[683] = new Talent( "�������", "Ұ������", 5, 1, "Ability_Druid_DemoralizingRoar.png", "", "", "����ĳ��ﱻ����������ĳ��ﶼ��ÿ10��ظ� {0} ������ֵ��", new Array(), new Array());
	talents[678] = new Talent( "��Ƥ", "Ұ������", 2, 3, "INV_Misc_Pelt_Bear_03.png", "", "", "ʹ��ĳ���Ļ���ֵ���{0}", new Array(), new Array());
	talents[697] = new Talent( "ǿ���⻷", "���", 7, 2, "Ability_TrueShot.png", "", "325 ����ֵ<br>˲������<br>", "ʹ�뾶45�뷶Χ�ڵ�С�ӳ�Ա��Զ�̺ͽ�ս����ǿ�����50�㣬����30���ӡ�", new Array(), new Array(new TalentRequirement(694, 3)));
	talents[676] = new Talent( "��ŭ�ͷ�", "Ұ������", 3, 3, "Ability_BullRush.png", "", "", "ʹ��ĳ�������ɵ��˺����{0}", new Array(), new Array());
	talents[836] = new Talent( "��Ұŭ��", "Ұ������", 7, 2, "BestialWrath.png", "", "12% ��������ֵ<br>˲������<br>2 ������ȴʱ��<br>100 ����Ч����<br>", "ʹ���������״̬����Ŀ����ɵ��˺����50%������18�롣������״̬�£����ﲻ�����κο־��������Ҳ�޷�ֹͣ���������Ǳ�ɱ����", new Array(), new Array(new TalentRequirement(681, 1)));
	talents[837] = new Talent( "Ұ��ɱ��[Monster Slaying]", "����", 1, 1, "MonsterSlaying.png", "", "", "ʹ���Ұ�ޡ����˺���������ɵ������˺���� {0}����Ұ�ޡ����˺���������ɵ�����һ���˺���� {1}��", new Array(), new Array());
	talents[837].Info[0] = new TalentInfo(1, "1%,1%", "", "");
	talents[837].Info[1] = new TalentInfo(2, "2%,2%", "", "");
	talents[837].Info[2] = new TalentInfo(3, "3%,3%", "", "");
	talents[836].Info[0] = new TalentInfo(1, "", "", "");
	talents[688].Info[0] = new TalentInfo(1, "", "", "");
	talents[683].Info[0] = new TalentInfo(1, "1%", "", "");
	talents[683].Info[1] = new TalentInfo(2, "2%", "", "");
	talents[690].Info[0] = new TalentInfo(1, "5%", "", "");
	talents[690].Info[1] = new TalentInfo(2, "10%", "", "");
	talents[690].Info[2] = new TalentInfo(3, "15%", "", "");
	talents[673].Info[0] = new TalentInfo(1, "10%", "", "");
	talents[673].Info[1] = new TalentInfo(2, "20%", "", "");
	talents[675].Info[0] = new TalentInfo(1, "30%", "", "");
	talents[711].Info[0] = new TalentInfo(1, "", "", "");
	talents[708].Info[0] = new TalentInfo(1, "2%", "", "");
	talents[708].Info[1] = new TalentInfo(2, "4%", "", "");
	talents[705].Info[0] = new TalentInfo(1, "", "", "");
	talents[685].Info[0] = new TalentInfo(1, "2%", "", "");
	talents[685].Info[1] = new TalentInfo(2, "4%", "", "");
	talents[685].Info[2] = new TalentInfo(3, "6%", "", "");
	talents[685].Info[3] = new TalentInfo(4, "8%", "", "");
	talents[685].Info[4] = new TalentInfo(5, "10%", "", "");
	talents[670].Info[0] = new TalentInfo(1, "3%", "", "");
	talents[670].Info[1] = new TalentInfo(2, "6%", "", "");
	talents[670].Info[2] = new TalentInfo(3, "9%", "", "");
	talents[670].Info[3] = new TalentInfo(4, "12%", "", "");
	talents[670].Info[4] = new TalentInfo(5, "15%", "", "");
	talents[700].Info[0] = new TalentInfo(1, "5%", "", "");
	talents[700].Info[1] = new TalentInfo(2, "10%", "", "");
	talents[700].Info[2] = new TalentInfo(3, "15%", "", "");
	talents[700].Info[3] = new TalentInfo(4, "20%", "", "");
	talents[700].Info[4] = new TalentInfo(5, "25%", "", "");
	talents[680].Info[0] = new TalentInfo(1, "3%", "", "");
	talents[680].Info[1] = new TalentInfo(2, "6%", "", "");
	talents[680].Info[2] = new TalentInfo(3, "9%", "", "");
	talents[680].Info[3] = new TalentInfo(4, "12%", "", "");
	talents[680].Info[4] = new TalentInfo(5, "15%", "", "");
	talents[682].Info[0] = new TalentInfo(1, "20%", "", "");
	talents[682].Info[1] = new TalentInfo(2, "40%", "", "");
	talents[682].Info[2] = new TalentInfo(3, "60%", "", "");
	talents[682].Info[3] = new TalentInfo(4, "80%", "", "");
	talents[682].Info[4] = new TalentInfo(5, "100%", "", "");
	talents[694].Info[0] = new TalentInfo(1, "2 ��", "", "");
	talents[694].Info[1] = new TalentInfo(2, "4 ��", "", "");
	talents[694].Info[2] = new TalentInfo(3, "6 ��", "", "");
	talents[689].Info[0] = new TalentInfo(1, "0.2 ��", "", "");
	talents[689].Info[1] = new TalentInfo(2, "0.4 ��", "", "");
	talents[689].Info[2] = new TalentInfo(3, "0.6 ��", "", "");
	talents[689].Info[3] = new TalentInfo(4, "0.8 ��", "", "");
	talents[689].Info[4] = new TalentInfo(5, "1 ��", "", "");
	talents[669].Info[0] = new TalentInfo(1, "1%", "", "");
	talents[669].Info[1] = new TalentInfo(2, "2%", "", "");
	talents[669].Info[2] = new TalentInfo(3, "3%", "", "");
	talents[669].Info[3] = new TalentInfo(4, "4%", "", "");
	talents[669].Info[4] = new TalentInfo(5, "5%", "", "");
	talents[672].Info[0] = new TalentInfo(1, "1%", "", "");
	talents[672].Info[1] = new TalentInfo(2, "2%", "", "");
	talents[672].Info[2] = new TalentInfo(3, "3%", "", "");
	talents[672].Info[3] = new TalentInfo(4, "4%", "", "");
	talents[672].Info[4] = new TalentInfo(5, "5%", "", "");
	talents[684].Info[0] = new TalentInfo(1, "4%", "", "");
	talents[684].Info[1] = new TalentInfo(2, "8%", "", "");
	talents[684].Info[2] = new TalentInfo(3, "12%", "", "");
	talents[684].Info[3] = new TalentInfo(4, "16%", "", "");
	talents[684].Info[4] = new TalentInfo(5, "20%", "", "");
	talents[707].Info[0] = new TalentInfo(1, "1%,5%", "", "");
	talents[707].Info[1] = new TalentInfo(2, "2%,10%", "", "");
	talents[707].Info[2] = new TalentInfo(3, "3%,15%", "", "");
	talents[671].Info[0] = new TalentInfo(1, "30 ��", "", "");
	talents[671].Info[1] = new TalentInfo(2, "60 ��", "", "");
	talents[706].Info[0] = new TalentInfo(1, "5%", "", "");
	talents[706].Info[1] = new TalentInfo(2, "10%", "", "");
	talents[686].Info[0] = new TalentInfo(1, "3%", "", "");
	talents[686].Info[1] = new TalentInfo(2, "6%", "", "");
	talents[686].Info[2] = new TalentInfo(3, "9%", "", "");
	talents[686].Info[3] = new TalentInfo(4, "12%", "", "");
	talents[686].Info[4] = new TalentInfo(5, "15%", "", "");
	talents[703].Info[0] = new TalentInfo(1, "15%,15%", "", "");
	talents[703].Info[1] = new TalentInfo(2, "30%,30%", "", "");
	talents[679].Info[0] = new TalentInfo(1, "15%", "", "");
	talents[679].Info[1] = new TalentInfo(2, "50%", "", "");
	talents[704].Info[0] = new TalentInfo(1, "2%", "", "");
	talents[704].Info[1] = new TalentInfo(2, "4%", "", "");
	talents[704].Info[2] = new TalentInfo(3, "6%", "", "");
	talents[704].Info[3] = new TalentInfo(4, "8%", "", "");
	talents[704].Info[4] = new TalentInfo(5, "10%", "", "");
	talents[699].Info[0] = new TalentInfo(1, "1%", "", "");
	talents[699].Info[1] = new TalentInfo(2, "2%", "", "");
	talents[699].Info[2] = new TalentInfo(3, "3%", "", "");
	talents[699].Info[3] = new TalentInfo(4, "4%", "", "");
	talents[699].Info[4] = new TalentInfo(5, "5%", "", "");
	talents[674].Info[0] = new TalentInfo(1, "3 ��,20%,15%", "", "");
	talents[674].Info[1] = new TalentInfo(2, "6 ��,40%,30%", "", "");
	talents[695].Info[0] = new TalentInfo(1, "10%", "", "");
	talents[695].Info[1] = new TalentInfo(2, "20%", "", "");
	talents[695].Info[2] = new TalentInfo(3, "30%", "", "");
	talents[691].Info[0] = new TalentInfo(1, "2%", "", "");
	talents[691].Info[1] = new TalentInfo(2, "4%", "", "");
	talents[691].Info[2] = new TalentInfo(3, "6%", "", "");
	talents[691].Info[3] = new TalentInfo(4, "8%", "", "");
	talents[691].Info[4] = new TalentInfo(5, "10%", "", "");
	talents[702].Info[0] = new TalentInfo(1, "4%", "", "");
	talents[702].Info[1] = new TalentInfo(2, "8%", "", "");
	talents[702].Info[2] = new TalentInfo(3, "12%", "", "");
	talents[702].Info[3] = new TalentInfo(4, "16%", "", "");
	talents[702].Info[4] = new TalentInfo(5, "20%", "", "");
	talents[681].Info[0] = new TalentInfo(1, "", "", "");
	talents[714].Info[0] = new TalentInfo(1, "", "", "");
	talents[687].Info[0] = new TalentInfo(1, "1%", "", "");
	talents[687].Info[1] = new TalentInfo(2, "2%", "", "");
	talents[687].Info[2] = new TalentInfo(3, "3%", "", "");
	talents[687].Info[3] = new TalentInfo(4, "4%", "", "");
	talents[687].Info[4] = new TalentInfo(5, "5%", "", "");
	talents[701].Info[0] = new TalentInfo(1, "10%", "", "");
	talents[701].Info[1] = new TalentInfo(2, "20%", "", "");
	talents[713].Info[0] = new TalentInfo(1, "3%", "", "");
	talents[713].Info[1] = new TalentInfo(2, "6%", "", "");
	talents[713].Info[2] = new TalentInfo(3, "9%", "", "");
	talents[713].Info[3] = new TalentInfo(4, "12%", "", "");
	talents[713].Info[4] = new TalentInfo(5, "15%", "", "");
	talents[692].Info[0] = new TalentInfo(1, "6%", "", "");
	talents[692].Info[1] = new TalentInfo(2, "12%", "", "");
	talents[692].Info[2] = new TalentInfo(3, "18%", "", "");
	talents[692].Info[3] = new TalentInfo(4, "24%", "", "");
	talents[692].Info[4] = new TalentInfo(5, "30%", "", "");
	talents[677].Info[0] = new TalentInfo(1, "3%", "", "");
	talents[677].Info[1] = new TalentInfo(2, "6%", "", "");
	talents[698].Info[0] = new TalentInfo(1, "1%,1%", "", "");
	talents[698].Info[1] = new TalentInfo(2, "2%,2%", "", "");
	talents[698].Info[2] = new TalentInfo(3, "3%,3%", "", "");
	talents[696].Info[0] = new TalentInfo(1, "1%", "", "");
	talents[696].Info[1] = new TalentInfo(2, "2%", "", "");
	talents[696].Info[2] = new TalentInfo(3, "3%", "", "");
	talents[696].Info[3] = new TalentInfo(4, "4%", "", "");
	talents[696].Info[4] = new TalentInfo(5, "5%", "", "");
	talents[710].Info[0] = new TalentInfo(1, "1%", "", "");
	talents[710].Info[1] = new TalentInfo(2, "2%", "", "");
	talents[710].Info[2] = new TalentInfo(3, "3%", "", "");
	talents[693].Info[0] = new TalentInfo(1, "", "", "");
	talents[678].Info[0] = new TalentInfo(1, "10%", "", "");
	talents[678].Info[1] = new TalentInfo(2, "20%", "", "");
	talents[678].Info[2] = new TalentInfo(3, "30%", "", "");
	talents[697].Info[0] = new TalentInfo(1, "", "", "");
	talents[676].Info[0] = new TalentInfo(1, "4%", "", "");
	talents[676].Info[1] = new TalentInfo(2, "8%", "", "");
	talents[676].Info[2] = new TalentInfo(3, "12%", "", "");
	talents[676].Info[3] = new TalentInfo(4, "16%", "", "");
	talents[676].Info[4] = new TalentInfo(5, "20%", "", "");
//----8<-------------------------------------------[


}
if (currentClass == classLst[2]) {
	talents[313] = new Talent( "ǿ�������ɵ�", "����", 1, 3, "Spell_Nature_StarFall.png", "", "", "ʹ����{0}�ļ�����ʩ�Ű����ɵ�ʱ������Ϊ�ܵ��˺����ж�ʩ����", new Array(), new Array());
	
	talents[487] = new Talent( "��������", "����", 1, 1, "Spell_Holy_DispelMagic.png", "", "", "ʹ���Ŀ���������з������Խ��� {0}����ʹ��İ���ϵ��������ɵ���вֵ���� {1} ��", new Array(), new Array());
	
	talents[315] = new Talent( "����רע", "����", 2, 3, "Spell_Shadow_ManaBurn.png", "", "", "ʹ���� {0} �ļ�����ʩ���κ�һ���˺��Է���֮��������ʩ��״̬������ʩ��״̬����ʹ�����һ���˺��Է��������ĵķ���ֵ����100%��", new Array(), new Array());
	
	talents[314] = new Talent( "ħ��ר��", "����", 2, 1, "INV_Wand_01.png", "", "", "ʹ���ħ����ɵ��˺���� {0}", new Array(), new Array());
	
	talents[312] = new Talent( "��������", "����", 1, 2, "Spell_Holy_Devotion.png", "", "", "ʹ��ĵ��˵ֿ���İ���ħ���ļ��ʽ��� {0}", new Array(), new Array());
	
	talents[563] = new Talent( "ħ��Э��", "����", 3, 1, "Spell_Nature_AbolishMagic.png", "", "", "ʹ���ħ����Ч��ħ�����Ƶ�Ч����� {0}��", new Array(), new Array());
	
	talents[564] = new Talent( "ǿ��ħ����", "����", 3, 2, "Spell_Nature_WispSplode.png", "", "", "ʹ���ħ����������һ������� {0}��", new Array(), new Array());
	
	talents[759] = new Talent( "��������", "����", 3, 3, "arcaneresilience.png", "", "", "ʹ��Ļ���ֵ��ߣ���ֵ�൱��������50%��", new Array(), new Array());
	
	talents[566] = new Talent( "ǿ����������", "����", 4, 1, "Spell_Shadow_DetectLesserInvisibility.png", "", "", "ʹ��ķ������������յ��˺�ֵ��� {0}��", new Array(), new Array());
	
	talents[567] = new Talent( "ǿ����������", "����", 4, 2, "Spell_Frost_IceShock.png", "", "", "ʹ��ķ��������� {0} �ļ���ʹĿ���Ĭ4�롣", new Array(), new Array());
	
	talents[760] = new Talent( "����ڤ��", "����", 4, 4, "Spell_Shadow_SiphonMana.png", "", "", "ʹ����ʩ��ʱ�Ա��� {0} �ķ����ظ��ٶȡ�", new Array(), new Array());
	
	talents[569] = new Talent( "��������", "����", 5, 2, "Spell_Nature_EnchantArmor.png", "", "˲������<br>3������ȴʱ��<br>", "����֮�������һ��ʩ��ʱ�����10��ķ�ʦ�������Ϊ˲��������", new Array(), new Array());
	
	talents[761] = new Talent( "��������", "����", 5, 3, "Spell_Shadow_Charm.png", "", "", "ʹ��ķ���ֵ�������{0}��", new Array(), new Array(new TalentRequirement(759, 1)));
	
	talents[571] = new Talent( "������Ч", "����", 6, 2, "Spell_Shadow_Teleport.png", "", "", "ʹ��ķ����˺����ػ��������{0}", new Array(), new Array(new TalentRequirement(569, 1)));
	
	talents[572] = new Talent( "��������", "����", 7, 2, "Spell_Nature_Lightning.png", "", "˲������<br>3������ȴʱ��<br>", "����֮����ķ����˺����30%����������Ҳ���30%����Ч������15�롣", new Array(), new Array(new TalentRequirement(571, 3)));
	
	talents[840] = new Talent( "ħ������", "����", 2, 2, "Spell_Nature_AstralRecal.png", "", "", "ʹ�������ħ��������� {0}�����ҵ���ֿ���һ��ħ������ķ������ظ��㷨��ֵ���޵� {1}��", new Array(), new Array());
	
	talents[236] = new Talent( "ǿ��������", "����", 1, 2, "Spell_Fire_FlameBolt.png", "", "", "ʹ��Ļ�������ʩ��ʱ�����{0}", new Array(), new Array());
	
	talents[237] = new Talent( "���", "����", 1, 3, "Spell_Fire_MeteorStorm.png", "", "", "ʹ��Ļ���ħ���� {0} �ļ�����Ŀ�����2�롣", new Array(), new Array());
	
	talents[547] = new Talent( "��ȼ", "����", 2, 1, "Spell_Fire_Incinerate.png", "", "", "��Ļ��淨�����������һ����ʹĿ��ȼ�գ�������4���ڳ����൱�ڸ÷����˺� {0} �Ķ����˺���", new Array(), new Array());
	
	talents[548] = new Talent( "����Ͷ��", "����", 2, 2, "Spell_Fire_Flare.png", "", "", "ʹ��Ļ��淨����������� {0}��", new Array(), new Array());
	
	talents[238] = new Talent( "ǿ��������", "����", 2, 3, "Spell_Fire_Fireball.png", "", "", "ʹ��Ļ���������ȴʱ����� {0}��", new Array(), new Array());
	
	talents[549] = new Talent( "�վ�", "����", 3, 1, "Spell_Fire_FlameShock.png", "", "", "ʹ��Ļ����������շ���������һ�������{0}", new Array(), new Array());
	
	talents[550] = new Talent( "�ױ���", "����", 3, 3, "Spell_Fire_Fireball02.png", "", "125 ����ֵ<br>6 ��ʩ��ʱ��<br>35����Ч����<br>", "����һö�޴�Ļ��򣬶�Ŀ�����148��195������˺�������12��������ܼ�56������˺���", new Array(), new Array());
	
	talents[240] = new Talent( "ǿ������籩", "����", 3, 2, "Spell_Fire_SelfDestruct.png", "", "", "ʹ�������籩�������һ���ļ������{0}��", new Array(), new Array());
	
	talents[241] = new Talent( "ȼ��֮��", "����", 3, 4, "Spell_Fire_Fire.png", "", "", "ʹ��Ļ���ϵ������ {0} �ļ������ܵ��˺�ʱ�������Ŷ�����ʩ��ʱ�䣬����������л���ϵ��������������вֵ���� {1}��", new Array(), new Array());
	
	talents[493] = new Talent( "ǿ������", "����", 4, 1, "Spell_Fire_SoulBurn.png", "", "", "ʹ������շ����� {0} �ļ�����Ŀ��������ܵ������˺��������ܵ�����ϵ����ʱ���ܵ��˺����3%������30�롣���ɵ���5�Ρ�", new Array(), new Array());
	
	talents[551] = new Talent( "ǿ������������", "����", 4, 2, "Spell_Fire_FireArmor.png", "", "", "ʹ��Ļ����������� {0} �ļ��ʷ������ϵ������", new Array(), new Array());
	
	talents[611] = new Talent( "Ԫ�ش�ʦ", "����", 4, 4, "masterofelements.png", "", "", "��Ļ���ϵ�ͱ�˪ϵ������������һ����᷵�� {0} �ķ���ֵ���ġ�", new Array(), new Array());
	
	talents[552] = new Talent( "�����ػ�", "����", 5, 2, "Spell_Nature_WispHeal.png", "", "", "ʹ��Ļ��淨���������һ���ļ������{0}��", new Array(), new Array());
	
	talents[553] = new Talent( "�����", "����", 5, 3, "Spell_Holy_Excorcism_02.png", "", "215�㷨��ֵ<br>˲������<br>45����ȴʱ��<br>", "ʩ���߷ų�һ���������������б�����������ĵ��˶����ܵ�160��192������˺���ѣ��6�롣", new Array(), new Array(new TalentRequirement(550, 1)));
	
	talents[554] = new Talent( "����ǿ��", "����", 6, 3, "Spell_Fire_Immolation.png", "", "", "ʹ��Ļ��淨����ɵ��˺����{0}��", new Array(), new Array());
	
	talents[555] = new Talent( "ȼ��", "����", 7, 2, "Spell_Fire_SealOfFire.png", "", "˲������<br>3������ȴʱ��<br>", "����֮����ʩ�ŵ�ÿ������ϵ�˺�����������Ļ���ϵ�˺�����������һ������������10%����Ч������������Ļ���ϵ�������3������һ����", new Array(), new Array(new TalentRequirement(552, 3)));
	
	talents[248] = new Talent( "ǿ����˪����", "��˪", 2, 3, "Spell_Frost_FrostNova.png", "", "", "ʹ��ı�˪���ǵ���ȴʱ����� {0}��", new Array(), new Array());
	
	talents[24] = new Talent( "ǿ��������", "��˪", 1, 2, "Spell_Frost_FrostBolt02.png", "", "", "ʹ��ĺ�������ʩ��ʱ����� {0}��", new Array(), new Array());
	
	talents[245] = new Talent( "������˪", "��˪", 2, 4, "Spell_Frost_Wisp.png", "", "", "ʹ��ı���Ч���ĳ���ʱ���ӳ� {0}����Ŀ����ٵ�Ч����� {1}��", new Array(), new Array());
	
	talents[762] = new Talent( "������Ƭ", "��˪", 2, 1, "Spell_Frost_IceShard.png", "", "", "ʹ��ı�˪��������һ������ɵ��˺����{0}", new Array(), new Array());
	
	talents[255] = new Talent( "��˪�ϱ�", "��˪", 1, 1, "Spell_Frost_FrostWard.png", "", "", "ʹ���˪�����ͱ��������ṩ�Ļ���ֵ�Ϳ���ֵЧ����� {0} �����⣬��ķ�����˪����� {1} �ļ��ʽ���˪ϵ������ħ��Ч�������ʩ���ߡ�", new Array(), new Array());
	
	talents[258] = new Talent( "˪���̹�", "��˪", 2, 2, "Spell_Frost_FrostArmor.png", "", "", "ʹ��ĺ���Ч���� {0} �ļ��ʽ�Ŀ�궳��5�롣", new Array(), new Array());
	
	talents[556] = new Talent( "�̹Ǻ���", "��˪", 3, 1, "Spell_Frost_Frostbolt.png", "", "", "ʹ��ı�˪��������ɵ��˺����{0}", new Array(), new Array());
	
	talents[557] = new Talent( "������ȴ", "��˪", 3, 2, "Spell_Frost_WizardMark.png", "", "˲������<br>10������ȴʱ��<br>", "����֮��ʹ������б�˪��������ȴʱ�������", new Array(), new Array());
	
	talents[562] = new Talent( "ǿ������ѩ", "��˪", 3, 4, "Spell_Frost_IceStorm.png", "", "", "Ϊ��ı���ѩ�������ӱ���Ч����ʹĿ����ƶ��ٶȽ��� {0}������ 1.50 �롣", new Array(), new Array());
	
	talents[558] = new Talent( "��������", "��˪", 4, 1, "Spell_Shadow_DarkRitual.png", "", "", "ʹ��ı�˪���Ǻͱ�׶������Ч�뾶�Լ�����������̺ͱ���ѩ�ķ�����Χ���� {0}��", new Array(), new Array());
	
	talents[559] = new Talent( "��˪����", "��˪", 4, 2, "Spell_Frost_Stun.png", "", "", "ʹ������б�˪���������ĵķ���ֵ���� {0} ����˪��������ɵ���вֵ���� {1} ��", new Array(), new Array());
	
	talents[789] = new Talent( "���", "��˪", 4, 3, "Spell_Frost_FrostShock.png", "", "", "ʹ������з����ڻ��б������ĵ���ʱ�������һ���ļ������ {0}��", new Array(), new Array(new TalentRequirement(248, 2)));
	
	talents[560] = new Talent( "��������", "��˪", 5, 2, "Spell_Frost_Frost.png", "", "15 ����ֵ<br>˲������<br>5������ȴʱ��<br>", "�㱻һ���������������֣���10���ڲ����ܵ��κ�����ͷ����˺������������ڼ���Ҳ�޷��������ƶ���ʩ����", new Array(), new Array());
	
	talents[256] = new Talent( "ǿ����׶��", "��˪", 5, 3, "Spell_Frost_Glacier.png", "", "", "ʹ��ı�׶������ɵ��˺����{0}", new Array(), new Array());
	
	talents[561] = new Talent( "��������", "��˪", 7, 2, "Spell_Ice_Lament.png", "", "305 ����ֵ<br>˲������<br>30����ȴʱ��<br>", "����ΪĿ�����ħ�����ܣ�������438���˺�������1���ӡ�ֻҪ���ܴ��ڣ��ܱ����ߵ�ʩ���Ͳ��ᱻ��ϡ�<br><br>Rank 2: ����549���˺�<br>Rank 3: ����678���˺�<br>Rank 4: ����818���˺�", new Array(), new Array(new TalentRequirement(560, 1)));
	
	talents[247] = new Talent( "�֮��", "��˪", 6, 3, "Spell_Frost_ChillingBlast.png", "", "", "ʹ��ı�˪ϵ�˺������� {0} �ļ��ʸ����֮����Ч�������˪ϵ������Ŀ���������һ���ļ������2%����Ч������15�롣�ɵ������5�Ρ�", new Array(), new Array());
	
	talents[841] = new Talent( "Ԫ��רע", "��˪", 1, 3, "Spell_Ice_MagicDamage.png", "", "", "ʹ���Ŀ��ֿ�����ͱ�˪ϵ�����ļ��ʽ��� {0}��", new Array(), new Array());
	
	talents[315].Info[0] = new TalentInfo(1, "2%", "", "");
	talents[315].Info[1] = new TalentInfo(2, "4%", "", "");
	talents[315].Info[2] = new TalentInfo(3, "6%", "", "");
	talents[315].Info[3] = new TalentInfo(4, "8%", "", "");
	talents[315].Info[4] = new TalentInfo(5, "10%", "", "");
	talents[312].Info[0] = new TalentInfo(1, "2%", "", "");
	talents[312].Info[1] = new TalentInfo(2, "4%", "", "");
	talents[312].Info[2] = new TalentInfo(3, "6%", "", "");
	talents[312].Info[3] = new TalentInfo(4, "8%", "", "");
	talents[312].Info[4] = new TalentInfo(5, "10%", "", "");
	talents[487].Info[0] = new TalentInfo(1, "5 ��,20%", "", "");
	talents[487].Info[1] = new TalentInfo(2, "10 ��,40%", "", "");
	talents[571].Info[0] = new TalentInfo(1, "1%", "", "");
	talents[571].Info[1] = new TalentInfo(2, "2%", "", "");
	talents[571].Info[2] = new TalentInfo(3, "3%", "", "");
	talents[760].Info[0] = new TalentInfo(1, "5%", "", "");
	talents[760].Info[1] = new TalentInfo(2, "10%", "", "");
	talents[760].Info[2] = new TalentInfo(3, "15%", "", "");
	talents[761].Info[0] = new TalentInfo(1, "2%", "", "");
	talents[761].Info[1] = new TalentInfo(2, "4%", "", "");
	talents[761].Info[2] = new TalentInfo(3, "6%", "", "");
	talents[761].Info[3] = new TalentInfo(4, "8%", "", "");
	talents[761].Info[4] = new TalentInfo(5, "10%", "", "");
	talents[572].Info[0] = new TalentInfo(1, "", "", "");
	talents[558].Info[0] = new TalentInfo(1, "10%", "", "");
	talents[558].Info[1] = new TalentInfo(2, "20%", "", "");
	talents[553].Info[0] = new TalentInfo(1, "", "", "");
	talents[557].Info[0] = new TalentInfo(1, "", "", "");
	talents[555].Info[0] = new TalentInfo(1, "", "", "");
	talents[551].Info[0] = new TalentInfo(1, "10%", "", "");
	talents[551].Info[1] = new TalentInfo(2, "20%", "", "");
	talents[552].Info[0] = new TalentInfo(1, "2%", "", "");
	talents[552].Info[1] = new TalentInfo(2, "4%", "", "");
	talents[552].Info[2] = new TalentInfo(3, "6%", "", "");
	talents[759].Info[0] = new TalentInfo(1, "", "", "");
	talents[554].Info[0] = new TalentInfo(1, "2%", "", "");
	talents[554].Info[1] = new TalentInfo(2, "4%", "", "");
	talents[554].Info[2] = new TalentInfo(3, "6%", "", "");
	talents[554].Info[3] = new TalentInfo(4, "8%", "", "");
	talents[554].Info[4] = new TalentInfo(5, "10%", "", "");
	talents[548].Info[0] = new TalentInfo(1, "3 ��", "", "");
	talents[548].Info[1] = new TalentInfo(2, "6 ��", "", "");
	talents[559].Info[0] = new TalentInfo(1, "5%,10%", "", "");
	talents[559].Info[1] = new TalentInfo(2, "10%,20%", "", "");
	talents[559].Info[2] = new TalentInfo(3, "15%,30%", "", "");
	talents[611].Info[0] = new TalentInfo(1, "10%", "", "");
	talents[611].Info[1] = new TalentInfo(2, "20%", "", "");
	talents[611].Info[2] = new TalentInfo(3, "30%", "", "");
	talents[258].Info[0] = new TalentInfo(1, "5%", "", "");
	talents[258].Info[1] = new TalentInfo(2, "10%", "", "");
	talents[258].Info[2] = new TalentInfo(3, "15%", "", "");
	talents[561].Info[0] = new TalentInfo(1, "", "", "");
	talents[560].Info[0] = new TalentInfo(1, "", "", "");
	talents[762].Info[0] = new TalentInfo(1, "20%", "", "");
	talents[762].Info[1] = new TalentInfo(2, "40%", "", "");
	talents[762].Info[2] = new TalentInfo(3, "60%", "", "");
	talents[762].Info[3] = new TalentInfo(4, "80%", "", "");
	talents[762].Info[4] = new TalentInfo(5, "100%", "", "");
	talents[547].Info[0] = new TalentInfo(1, "8%", "", "");
	talents[547].Info[1] = new TalentInfo(2, "16%", "", "");
	talents[547].Info[2] = new TalentInfo(3, "24%", "", "");
	talents[547].Info[3] = new TalentInfo(4, "32%", "", "");
	talents[547].Info[4] = new TalentInfo(5, "40%", "", "");
	talents[237].Info[0] = new TalentInfo(1, "2%", "", "");
	talents[237].Info[1] = new TalentInfo(2, "4%", "", "");
	talents[237].Info[2] = new TalentInfo(3, "6%", "", "");
	talents[237].Info[3] = new TalentInfo(4, "8%", "", "");
	talents[237].Info[4] = new TalentInfo(5, "10%", "", "");
	talents[238].Info[0] = new TalentInfo(1, "0.5 ��", "", "");
	talents[238].Info[1] = new TalentInfo(2, "1 ��", "", "");
	talents[238].Info[2] = new TalentInfo(3, "1.5 ��", "", "");
	talents[563].Info[0] = new TalentInfo(1, "25%", "", "");
	talents[563].Info[1] = new TalentInfo(2, "50%", "", "");
	talents[564].Info[0] = new TalentInfo(1, "2%", "", "");
	talents[564].Info[1] = new TalentInfo(2, "4%", "", "");
	talents[564].Info[2] = new TalentInfo(3, "6%", "", "");
	talents[313].Info[0] = new TalentInfo(1, "20%", "", "");
	talents[313].Info[1] = new TalentInfo(2, "40%", "", "");
	talents[313].Info[2] = new TalentInfo(3, "60%", "", "");
	talents[313].Info[3] = new TalentInfo(4, "80%", "", "");
	talents[313].Info[4] = new TalentInfo(5, "100%", "", "");
	talents[562].Info[0] = new TalentInfo(1, "30%", "", "");
	talents[562].Info[1] = new TalentInfo(2, "50%", "", "");
	talents[562].Info[2] = new TalentInfo(3, "65%", "", "");
	talents[256].Info[0] = new TalentInfo(1, "15%", "", "");
	talents[256].Info[1] = new TalentInfo(2, "25%", "", "");
	talents[256].Info[2] = new TalentInfo(3, "35%", "", "");
	talents[566].Info[0] = new TalentInfo(1, "10%", "", "");
	talents[566].Info[1] = new TalentInfo(2, "20%", "", "");
	talents[567].Info[0] = new TalentInfo(1, "50%", "", "");
	talents[567].Info[1] = new TalentInfo(2, "100%", "", "");
	talents[236].Info[0] = new TalentInfo(1, "0.1 ��", "", "");
	talents[236].Info[1] = new TalentInfo(2, "0.2 ��", "", "");
	talents[236].Info[2] = new TalentInfo(3, "0.3 ��", "", "");
	talents[236].Info[3] = new TalentInfo(4, "0.4 ��", "", "");
	talents[236].Info[4] = new TalentInfo(5, "0.5 ��", "", "");
	talents[240].Info[0] = new TalentInfo(1, "5%", "", "");
	talents[240].Info[1] = new TalentInfo(2, "10%", "", "");
	talents[240].Info[2] = new TalentInfo(3, "15%", "", "");
	talents[241].Info[0] = new TalentInfo(1, "35%,15%", "", "");
	talents[241].Info[1] = new TalentInfo(2, "70%,30%", "", "");
	talents[248].Info[0] = new TalentInfo(1, "2 ��", "", "");
	talents[248].Info[1] = new TalentInfo(2, "4 ��", "", "");
	talents[255].Info[0] = new TalentInfo(1, "15%,10%", "", "");
	talents[255].Info[1] = new TalentInfo(2, "30%,20%", "", "");
	talents[24].Info[0] = new TalentInfo(1, "0.1 ��", "", "");
	talents[24].Info[1] = new TalentInfo(2, "0.2 ��", "", "");
	talents[24].Info[2] = new TalentInfo(3, "0.3 ��", "", "");
	talents[24].Info[3] = new TalentInfo(4, "0.4 ��", "", "");
	talents[24].Info[4] = new TalentInfo(5, "0.5 ��", "", "");
	talents[493].Info[0] = new TalentInfo(1, "33%", "", "");
	talents[493].Info[1] = new TalentInfo(2, "66%", "", "");
	talents[493].Info[2] = new TalentInfo(3, "100%", "", "");
	talents[549].Info[0] = new TalentInfo(1, "2%", "", "");
	talents[549].Info[1] = new TalentInfo(2, "4%", "", "");
	talents[245].Info[0] = new TalentInfo(1, "1 ��,4%", "", "");
	talents[245].Info[1] = new TalentInfo(2, "2 ��,7%", "", "");
	talents[245].Info[2] = new TalentInfo(3, "3 ��,10%", "", "");
	talents[556].Info[0] = new TalentInfo(1, "2%", "", "");
	talents[556].Info[1] = new TalentInfo(2, "4%", "", "");
	talents[556].Info[2] = new TalentInfo(3, "6%", "", "");
	talents[569].Info[0] = new TalentInfo(1, "", "", "");
	talents[550].Info[0] = new TalentInfo(1, "", "", "");
	talents[789].Info[0] = new TalentInfo(1, "10%", "", "");
	talents[789].Info[1] = new TalentInfo(2, "20%", "", "");
	talents[789].Info[2] = new TalentInfo(3, "30%", "", "");
	talents[789].Info[3] = new TalentInfo(4, "40%", "", "");
	talents[789].Info[4] = new TalentInfo(5, "50%", "", "");
	talents[314].Info[0] = new TalentInfo(1, "13%", "", "");
	talents[314].Info[1] = new TalentInfo(2, "25%", "", "");
	talents[247].Info[0] = new TalentInfo(1, "20%", "", "");
	talents[247].Info[1] = new TalentInfo(2, "40%", "", "");
	talents[247].Info[2] = new TalentInfo(3, "60%", "", "");
	talents[247].Info[3] = new TalentInfo(4, "80%", "", "");
	talents[247].Info[4] = new TalentInfo(5, "100%", "", "");
	talents[840].Info[0] = new TalentInfo(1, "2 ��,1%", "", "");
	talents[840].Info[1] = new TalentInfo(2, "4 ��,2%", "", "");
	talents[840].Info[2] = new TalentInfo(3, "6 ��,3%", "", "");
	talents[840].Info[3] = new TalentInfo(4, "8 ��,4%", "", "");
	talents[840].Info[4] = new TalentInfo(5, "10 ��,5%", "", "");
	talents[841].Info[0] = new TalentInfo(1, "2%", "", "");
	talents[841].Info[1] = new TalentInfo(2, "4%", "", "");
	talents[841].Info[2] = new TalentInfo(3, "6%", "", "");

//----8<-------------------------------------------[


}
if (currentClass == classLst[3]) {
	talents[753] = new Talent( "����׷��", "�ͽ�", 3, 4, "Paladin_Pursuit_of_Justice.png", "", "", "ʹʥ��ʿ���ƶ��ٶȺͳ����ٶ����{0}�����Ч�����ܺ���������Ч�����ӡ�", new Array(), new Array());
	talents[747] = new Talent( "��", "�ͽ�", 1, 3, "Spell_Frost_WindWalkOn.png", "", "", "ʹ��ĳͽ�ϵ���������ĵķ���ֵ����{0}", new Array(), new Array());
	talents[758] = new Talent( "����ף��", "����", 3, 1, "Spell_Magic_MageArmor.png", "", "75 ����ֵ<br>˲������<br>30 ����Ч����<br>", "Ϊ�ѷ�Ŀ��ʩ��ף����ʹ������������� 10%������ 5 ���ӡ�ÿ��ʥ��ʿ��ͬһʱ����ֻ�ܸ�Ŀ��ʩ��һ��ף����ͬ���͵�ף�������ص���", new Array(), new Array());
	talents[734] = new Talent( "�ӻ�ף��", "����", 5, 2, "Spell_Nature_LightningShield.png", "", "45 ����ֵ<br>˲������<br>30����Ч����<br>", "Ϊ�ѷ�Ŀ��ʩ��ף����ʹ�����ܵ����������͵��˺����������7�㣬����5���ӡ����⣬��Ŀ��ɹ���סһ�ν�ս�����󹥻��߽��ܵ� 10 ����ʥ�˺���ÿ��ʥ��ʿ��ͬһʱ����ֻ�ܸ�Ŀ��ʩ��һ��ף����ͬ���͵�ף�������ص���", new Array(), new Array());
	talents[756] = new Talent( "����", "��ʥ", 3, 2, "Spell_Holy_InnerFire.png", "", "135 ����ֵ<br>˲������<br>8����ȴʱ��<br>", "��ʥ�����������ʥ��ʿ���µ����أ��� 8 ���ڶԽ������������е������ 64 ����ʥ�˺���", new Array(), new Array());
	talents[757] = new Talent( "����", "�ͽ�", 3, 2, "Spell_Holy_RetributionAura.png", "", "", "ʹ���ý�ս�����Ե����������һ���ļ������ {0}��", new Array(), new Array());
	talents[750] = new Talent( "ƫб", "�ͽ�", 2, 3, "Ability_Parry.png", "", "", "ʹ����мܼ������ {0}��", new Array(), new Array());
	talents[728] = new Talent( "��ʥ֮��", "��ʥ", 1, 2, "Ability_GolemThunderClap.png", "", "", "ʹ���������� {0}", new Array(), new Array());
	talents[725] = new Talent( "��ʥ�ǻ�", "��ʥ", 1, 3, "Spell_Nature_Sleep.png", "", "", "ʹ�������������� {0}", new Array(), new Array());
	talents[742] = new Talent( "��ʥ֮��", "����", 7, 2, "Spell_Holy_BlessingOfProtection.png", "", "140 ����ֵ<br>˲������<br>10����ȴʱ��<br>��Ҫ����<br>", "ʹ��ĸ񵲼������30%������10�롣�ڴ��ڼ�ÿ�γɹ��񵲶���Թ��������50����ʥ�˺���ÿ�γɹ��񵲻����ĵ�һ�θ񵲻��ᣬ���ɸ�4�Ρ�", new Array(), new Array(new TalentRequirement(734, 1)));
	talents[729] = new Talent( "��ʥ���", "��ʥ", 7, 2, "Spell_Holy_SearingLight.png", "", "255����ֵ<br>˲������<br>30����ȴʱ��<br>20����Ч����<br>", "����ʥ���������Ŀ�꣬�Ե������204��220����ʥ�˺������߶��ѷ����204��220�����ơ�", new Array(), new Array(new TalentRequirement(721, 1)));
	talents[719] = new Talent( "����", "��ʥ", 4, 2, "Spell_Holy_GreaterHeal.png", "", "", "�����ʥ�����ֻ�ʥ������ɼ�Ч����Ч��֮��ʹ���� {0} �ļ��ʻظ�ʩ�������ĵķ���ֵ��", new Array(), new Array());
	talents[737] = new Talent( "Ԥ֪", "����", 3, 4, "Spell_Magic_LesserInvisibilty.png", "", "", "ʹ��ķ���������� {0}��", new Array(), new Array());
	talents[746] = new Talent( "ǿ������ף��", "�ͽ�", 1, 2, "Spell_Holy_FistOfJustice.png", "", "", "ʹ�������ף�����ṩ�Ĺ���ǿ�ȼӳ����{0}", new Array(), new Array());
	talents[732] = new Talent( "�ػ��ߵĳ谮", "����", 2, 2, "Spell_Holy_SealOfProtection.png", "", "", "ʹ��ı���ף������ȴʱ�����{0}����ʹ�������ף���ĳ���ʱ���ӳ�{1}��", new Array(), new Array());
	talents[743] = new Talent( "ǿ���Ʋ�֮��", "����", 4, 2, "Spell_Holy_SealOfProtection.png", "", "", "ʹ����Ʋ�֮������ȴʱ����� {0}��", new Array(), new Array());
	talents[720] = new Talent( "ǿ���ǻ�ף��", "��ʥ", 4, 3, "Spell_Holy_SealOfWisdom.png", "", "", "ʹ����ǻ�ף����Ч����� {0}��", new Array(), new Array());
	talents[730] = new Talent( "ǿ���Ϲ⻷", "����", 1, 2, "Spell_Holy_DevotionAura.png", "", "", "ʹ����Ϲ⻷�ṩ���⻤��ֵ��Ч����ǿ{0}", new Array(), new Array());
	talents[723] = new Talent( "��������", "��ʥ", 3, 4, "Paladin_Unyielding_Faith.png", "", "", "ʹ��ֿ��־���Ȼ�Ч���ļ������ {0}��", new Array(), new Array());
	talents[717] = new Talent( "����֮��", "��ʥ", 3, 1, "Spell_Holy_HolyBolt.png", "", "", "ʹ���ʥ������ʥ�����ֵ���������� {0}", new Array(), new Array());
	talents[715] = new Talent( "ǿ��ʥ����", "��ʥ", 3, 3, "Spell_Holy_LayOnHands.png", "", "", "�����ʥ�������Ƶ�Ŀ����װ������õĻ���ֵ��� {0}������ 5 ���ӡ����⣬���ʥ�����ķ�����ȴʱ�佫���� {1} ���ӡ�", new Array(), new Array());
	talents[754] = new Talent( "ǿ���ͽ�⻷", "�ͽ�", 4, 3, "Spell_Holy_AuraOfLight.png", "", "", "ʹ��ĳͽ�⻷������ɵ��˺����{0}", new Array(), new Array(new TalentRequirement(752, 1)));
	talents[735] = new Talent( "ǿ������֮ŭ", "����", 3, 2, "Spell_Holy_SealOfFury.png", "", "", "ʹ�������֮ŭ����������вֵ��� {0}��", new Array(), new Array());
	talents[738] = new Talent( "��ȷ", "����", 2, 1, "Ability_Rogue_Ambush.png", "", "", "ʹ��Ľ�ս�������е��˵ļ������ {0}��", new Array(), new Array());
	talents[727] = new Talent( "�־�����", "��ʥ", 5, 3, "Spell_Holy_HealingAura.png", "", "", "ʹ��Ĺ������к��ǻ����еĳ���ʱ���ӳ� {0}��", new Array(), new Array());
	talents[722] = new Talent( "ǿ������ʥӡ", "��ʥ", 2, 3, "Ability_ThunderBolt.png", "", "", "ʹ�������ʥӡ������ɵ��˺���� {0}", new Array(), new Array());
	talents[749] = new Talent( "ǿ��ʮ�־�ʥӡ", "�ͽ�", 2, 2, "Spell_Holy_HolySmite.png", "", "", "ʹ���ʮ�־�ʥӡ�Ĺ���ǿ�ȼӳɺ�ʮ�־�����������ɵ���ʥ�˺���� {0}��", new Array(), new Array());
	talents[744] = new Talent( "��������ר��", "����", 6, 3, "INV_Sword_20.png", "", "", "ʹ��ĵ��ֽ�ս����������ɵ��˺����{0}", new Array(), new Array());
	talents[755] = new Talent( "˫������ר��", "�ͽ�", 5, 1, "INV_Hammer_04.png", "", "", "ʹ���˫�ֽ�ս������ɵ��˺���� {0}��", new Array(), new Array());
	talents[741] = new Talent( "����", "����", 5, 3, "Spell_Holy_BlessingOfStrength.png", "", "", "ʹ������������һ��֮����{0}�ļ��ʻ��һ�ζ���Ĺ������ᡣ", new Array(), new Array());
	talents[731] = new Talent( "���Ʊ���", "����", 1, 3, "Ability_Defend.png", "", "", "ʹ������������һ��֮��ʹ�ö��Ƹ񵲹����ļ������{0}������10����5�ι�����", new Array(), new Array());
	talents[745] = new Talent( "���", "�ͽ�", 7, 2, "Spell_Holy_PrayerOfHealing.png", "", "60 ����ֵ<br>˲������<br>1������ȴʱ��<br>20����Ч����<br>", "ʹĿ�����ڤ��״̬��������6�롣�κ��˺����ỽ��Ŀ�ꡣֻ������������Ч��", new Array(), new Array());
	talents[718] = new Talent( "��ʥǿ��", "��ʥ", 6, 3, "Paladin_Holy_Power.png", "", "", "ʹ�����ʥϵ�����������һ���ļ������ {0}��", new Array(), new Array());
	talents[752] = new Talent( "����ʥӡ", "�ͽ�", 3, 3, "Ability_Warrior_InnerRage.png", "", "63����ֵ<br>˲������<br>", "����֮�����ʥ��ʿ�����ڣ�����30�룬ʹ����һ�����ʶ�Ŀ������൱����ʥ��ʿ�������˺�����70%����ʥ�˺���ʥ��ʿ��ͬһʱ����ֻ�ܼ���һ��ʥӡ��<br><br>�ͷ�����ʥӡ����������Ŀ���������Ч�����������45��49����ʥ�˺�������ڴ��ڼ��Ŀ�걻���裬���ͻ��ܵ�137��147����ʥ�˺���", new Array(), new Array());
	talents[736] = new Talent( "����ר��", "����", 3, 3, "INV_Shield_06.png", "", "", "ʹ��Ķ����������յ��˺���� {0}��", new Array(), new Array(new TalentRequirement(731, 5)));
	talents[716] = new Talent( "������", "��ʥ", 2, 2, "Spell_Arcane_Blink.png", "", "", "ʹ���ʥ�����ֺ�ʥ������ {0} �ļ������ܵ��˺�ʱ�����ӳ�ʩ��ʱ�䡣", new Array(), new Array());
	talents[733] = new Talent( "����", "����", 2, 4, "Spell_Holy_Devotion.png", "", "", "ʹ����װ������õĻ���ֵ���{0}", new Array(), new Array());
	talents[748] = new Talent( "�绤", "�ͽ�", 3, 1, "Paladin_Vindication.png", "", "", "ʥ��ʿ�Ľ�ս�����п���ʹĿ������������ݽ��� {0}������10���ӡ�", new Array(), new Array());
	talents[751] = new Talent( "����", "�ͽ�", 6, 2, "Ability_Racial_Avatar.png", "", "", "ʹ���ڶԵ����������һ��֮���� {0} ���������ʥ�˺��ӳɣ�����8�롣", new Array(), new Array(new TalentRequirement(757, 5)));
	talents[724] = new Talent( "ǿ��רע�⻷", "����", 4, 3, "Spell_Holy_MindSooth.png", "", "", "ʹ���רע�⻷��Ч����� {0}�����������õ��ѷ�Ŀ��ֿ���Ĭ�ʹ��ʩ�����ܵ�������� {1}��", new Array(), new Array());
	talents[709] = new Talent( "ǿ������", "�ͽ�", 2, 1, "Spell_Holy_RighteousFury.png", "", "", "ʹ������еķ�����ȴʱ����� {0}��", new Array(), new Array());
	talents[712] = new Talent( "���ۻ���", "�ͽ�", 4, 1, "Paladin_Eye_for_an_Eye.png", "", "", "ʥ��ʿ���ܵ���������һ���󣬽���{0}���˺�������ʩ���ߡ����ü��ܲ������˺���ֵ���ᳬ��ʥ��ʿ����ֵ������50%��", new Array(), new Array());
	talents[721] = new Talent( "�����", "��ʥ", 5, 2, "Spell_Holy_Heal.png", "", "60 ����ֵ<br>˲������<br>2������ȴʱ��<br>", "����֮��ʹ�����һ��ʥ�����ֻ�ʥ������ 100% �ļ�����ɼ�Ч����Ч����", new Array(), new Array(new TalentRequirement(719, 5)));
	talents[726] = new Talent( "ʥ��⻷", "�ͽ�", 5, 3, "Spell_Holy_MindVision.png", "", "˲������", "ʹ�뾶 30 �뷶Χ�ڵĶ��ѵ���ʥϵ�����Ե�����ɵ��˺���� 10%��ÿ��ʥ��ʿ��ͬһʱ����ֻ�ܿ���һ�ֹ⻷����ͬ��⻷��Ч���޷����ӡ�", new Array(), new Array());
	talents[726].Info[0] = new TalentInfo(1, "", "", "");
	talents[753].Info[0] = new TalentInfo(1, "4%", "", "");
	talents[753].Info[1] = new TalentInfo(2, "8%", "", "");
	talents[747].Info[0] = new TalentInfo(1, "3%", "", "");
	talents[747].Info[1] = new TalentInfo(2, "6%", "", "");
	talents[747].Info[2] = new TalentInfo(3, "9%", "", "");
	talents[747].Info[3] = new TalentInfo(4, "12%", "", "");
	talents[747].Info[4] = new TalentInfo(5, "15%", "", "");
	talents[758].Info[0] = new TalentInfo(1, "", "", "");
	talents[734].Info[0] = new TalentInfo(1, "", "", "");
	talents[756].Info[0] = new TalentInfo(1, "", "", "");
	talents[721].Info[0] = new TalentInfo(1, "", "", "");
	talents[757].Info[0] = new TalentInfo(1, "1%", "", "");
	talents[757].Info[1] = new TalentInfo(2, "2%", "", "");
	talents[757].Info[2] = new TalentInfo(3, "3%", "", "");
	talents[757].Info[3] = new TalentInfo(4, "4%", "", "");
	talents[757].Info[4] = new TalentInfo(5, "5%", "", "");
	talents[750].Info[0] = new TalentInfo(1, "1%", "", "");
	talents[750].Info[1] = new TalentInfo(2, "2%", "", "");
	talents[750].Info[2] = new TalentInfo(3, "3%", "", "");
	talents[750].Info[3] = new TalentInfo(4, "4%", "", "");
	talents[750].Info[4] = new TalentInfo(5, "5%", "", "");
	talents[728].Info[0] = new TalentInfo(1, "2%", "", "");
	talents[728].Info[1] = new TalentInfo(2, "4%", "", "");
	talents[728].Info[2] = new TalentInfo(3, "6%", "", "");
	talents[728].Info[3] = new TalentInfo(4, "8%", "", "");
	talents[728].Info[4] = new TalentInfo(5, "10%", "", "");
	talents[725].Info[0] = new TalentInfo(1, "2%", "", "");
	talents[725].Info[1] = new TalentInfo(2, "4%", "", "");
	talents[725].Info[2] = new TalentInfo(3, "6%", "", "");
	talents[725].Info[3] = new TalentInfo(4, "8%", "", "");
	talents[725].Info[4] = new TalentInfo(5, "10%", "", "");
	talents[742].Info[0] = new TalentInfo(1, "", "", "");
	talents[729].Info[0] = new TalentInfo(1, "", "", "");
	talents[719].Info[0] = new TalentInfo(1, "20%", "", "");
	talents[719].Info[1] = new TalentInfo(2, "40%", "", "");
	talents[719].Info[2] = new TalentInfo(3, "60%", "", "");
	talents[719].Info[3] = new TalentInfo(4, "80%", "", "");
	talents[719].Info[4] = new TalentInfo(5, "100%", "", "");
	talents[737].Info[0] = new TalentInfo(1, "2", "", "");
	talents[737].Info[1] = new TalentInfo(2, "4", "", "");
	talents[737].Info[2] = new TalentInfo(3, "6", "", "");
	talents[737].Info[3] = new TalentInfo(4, "8", "", "");
	talents[737].Info[4] = new TalentInfo(5, "10", "", "");
	talents[746].Info[0] = new TalentInfo(1, "4%", "", "");
	talents[746].Info[1] = new TalentInfo(2, "8%", "", "");
	talents[746].Info[2] = new TalentInfo(3, "12%", "", "");
	talents[746].Info[3] = new TalentInfo(4, "16%", "", "");
	talents[746].Info[4] = new TalentInfo(5, "20%", "", "");
	talents[732].Info[0] = new TalentInfo(1, "60��,3��", "", "");
	talents[732].Info[1] = new TalentInfo(2, "120��,6��", "", "");
	talents[743].Info[0] = new TalentInfo(1, "5 ��", "", "");
	talents[743].Info[1] = new TalentInfo(2, "10 ��", "", "");
	talents[743].Info[2] = new TalentInfo(3, "15 ��", "", "");
	talents[720].Info[0] = new TalentInfo(1, "10%", "", "");
	talents[720].Info[1] = new TalentInfo(2, "20%", "", "");
	talents[730].Info[0] = new TalentInfo(1, "5%", "", "");
	talents[730].Info[1] = new TalentInfo(2, "10%", "", "");
	talents[730].Info[2] = new TalentInfo(3, "15%", "", "");
	talents[730].Info[3] = new TalentInfo(4, "20%", "", "");
	talents[730].Info[4] = new TalentInfo(5, "25%", "", "");
	talents[723].Info[0] = new TalentInfo(1, "5%", "", "");
	talents[723].Info[1] = new TalentInfo(2, "10%", "", "");
	talents[717].Info[0] = new TalentInfo(1, "4%", "", "");
	talents[717].Info[1] = new TalentInfo(2, "8%", "", "");
	talents[717].Info[2] = new TalentInfo(3, "12%", "", "");
	talents[715].Info[0] = new TalentInfo(1, "25%,10", "", "");
	talents[715].Info[1] = new TalentInfo(2, "50%,20", "", "");
	talents[754].Info[0] = new TalentInfo(1, "25%", "", "");
	talents[754].Info[1] = new TalentInfo(2, "50%", "", "");
	talents[735].Info[0] = new TalentInfo(1, "16%", "", "");
	talents[735].Info[1] = new TalentInfo(2, "33%", "", "");
	talents[735].Info[2] = new TalentInfo(3, "50%", "", "");
	talents[738].Info[0] = new TalentInfo(1, "1%", "", "");
	talents[738].Info[1] = new TalentInfo(2, "2%", "", "");
	talents[738].Info[2] = new TalentInfo(3, "3%", "", "");
	talents[727].Info[0] = new TalentInfo(1, "10 ��", "", "");
	talents[727].Info[1] = new TalentInfo(2, "20 ��", "", "");
	talents[727].Info[2] = new TalentInfo(3, "30 ��", "", "");
	talents[722].Info[0] = new TalentInfo(1, "3%", "", "");
	talents[722].Info[1] = new TalentInfo(2, "6%", "", "");
	talents[722].Info[2] = new TalentInfo(3, "9%", "", "");
	talents[722].Info[3] = new TalentInfo(4, "12%", "", "");
	talents[722].Info[4] = new TalentInfo(5, "15%", "", "");
	talents[749].Info[0] = new TalentInfo(1, "5%", "", "");
	talents[749].Info[1] = new TalentInfo(2, "10%", "", "");
	talents[749].Info[2] = new TalentInfo(3, "15%", "", "");
	talents[744].Info[0] = new TalentInfo(1, "2%", "", "");
	talents[744].Info[1] = new TalentInfo(2, "4%", "", "");
	talents[744].Info[2] = new TalentInfo(3, "6%", "", "");
	talents[744].Info[3] = new TalentInfo(4, "8%", "", "");
	talents[744].Info[4] = new TalentInfo(5, "10%", "", "");
	talents[755].Info[0] = new TalentInfo(1, "2%", "", "");
	talents[755].Info[1] = new TalentInfo(2, "4%", "", "");
	talents[755].Info[2] = new TalentInfo(3, "6%", "", "");
	talents[741].Info[0] = new TalentInfo(1, "20%", "", "");
	talents[741].Info[1] = new TalentInfo(2, "40%", "", "");
	talents[741].Info[2] = new TalentInfo(3, "60%", "", "");
	talents[741].Info[3] = new TalentInfo(4, "80%", "", "");
	talents[741].Info[4] = new TalentInfo(5, "100%", "", "");
	talents[731].Info[0] = new TalentInfo(1, "6%", "", "");
	talents[731].Info[1] = new TalentInfo(2, "12%", "", "");
	talents[731].Info[2] = new TalentInfo(3, "18%", "", "");
	talents[731].Info[3] = new TalentInfo(4, "24%", "", "");
	talents[731].Info[4] = new TalentInfo(5, "30%", "", "");
	talents[745].Info[0] = new TalentInfo(1, "", "", "");
	talents[718].Info[0] = new TalentInfo(1, "1%", "", "");
	talents[718].Info[1] = new TalentInfo(2, "2%", "", "");
	talents[718].Info[2] = new TalentInfo(3, "3%", "", "");
	talents[718].Info[3] = new TalentInfo(4, "4%", "", "");
	talents[718].Info[4] = new TalentInfo(5, "5%", "", "");
	talents[752].Info[0] = new TalentInfo(1, "", "", "");
	talents[736].Info[0] = new TalentInfo(1, "10%", "", "");
	talents[736].Info[1] = new TalentInfo(2, "20%", "", "");
	talents[736].Info[2] = new TalentInfo(3, "30%", "", "");
	talents[716].Info[0] = new TalentInfo(1, "14%", "", "");
	talents[716].Info[1] = new TalentInfo(2, "28%", "", "");
	talents[716].Info[2] = new TalentInfo(3, "42%", "", "");
	talents[716].Info[3] = new TalentInfo(4, "56%", "", "");
	talents[716].Info[4] = new TalentInfo(5, "70%", "", "");
	talents[733].Info[0] = new TalentInfo(1, "2%", "", "");
	talents[733].Info[1] = new TalentInfo(2, "4%", "", "");
	talents[733].Info[2] = new TalentInfo(3, "6%", "", "");
	talents[733].Info[3] = new TalentInfo(4, "8%", "", "");
	talents[733].Info[4] = new TalentInfo(5, "10%", "", "");
	talents[748].Info[0] = new TalentInfo(1, "5%", "", "");
	talents[748].Info[1] = new TalentInfo(2, "10%", "", "");
	talents[748].Info[2] = new TalentInfo(3, "15%", "", "");
	talents[751].Info[0] = new TalentInfo(1, "3%", "", "");
	talents[751].Info[1] = new TalentInfo(2, "6%", "", "");
	talents[751].Info[2] = new TalentInfo(3, "9%", "", "");
	talents[751].Info[3] = new TalentInfo(4, "12%", "", "");
	talents[751].Info[4] = new TalentInfo(5, "15%", "", "");
	talents[724].Info[0] = new TalentInfo(1, "5%,5%", "", "");
	talents[724].Info[1] = new TalentInfo(2, "10%,10%", "", "");
	talents[724].Info[2] = new TalentInfo(3, "15%,15%", "", "");
	talents[709].Info[0] = new TalentInfo(1, "1 ��", "", "");
	talents[709].Info[1] = new TalentInfo(2, "2 ��", "", "");
	talents[712].Info[0] = new TalentInfo(1, "15%", "", "");
	talents[712].Info[1] = new TalentInfo(2, "30%", "", "");


//----8<-------------------------------------------[


}
if (currentClass == classLst[4]) {
	talents[161] = new Talent( "����", "��Ӱ", 1, 3, "Spell_Shadow_GatherShadows.png", "", "", "ʹ��İ�Ӱϵ�˺��Է�����{0}�ļ�����Ŀ�����3�롣", new Array(), new Array());
	talents[774] = new Talent( "�ڰ�", "��Ӱ", 6, 3, "Spell_Shadow_Twilight.png", "", "", "ʹ��İ�Ӱ�����˺����{0}", new Array(), new Array());
	talents[769] = new Talent( "��ʥ����", "��ʥ", 4, 1, "holyreach.png", "", "", "ʹ��ĳͻ�����ʥ֮�����̡����Ƶ��Ժ���ʥ���ǵ����ð뾶���{0}", new Array(), new Array());
	talents[659] = new Talent( "������ע", "����", 7, 2, "powerinfusion.png", "", "182�㷨��ֵ<br>˲��<br>30��<br>3������ȴ<br>", "������עĿ��ȫ��ʹ�䷨���˺�������Ч�����20%������15�롣", new Array(), new Array(new TalentRequirement(654, 5)));
	talents[651] = new Talent( "��ʥ֮��", "����", 5, 3, "divinespirit.png", "", "285�㷨��ֵ<br>˲��<br>30��<br>", "��ʥ����������ȫ�����侫�����17�㣬����30���ӡ�", new Array(), new Array(new TalentRequirement(656, 3)));
	talents[658] = new Talent( "��־֮��", "����", 6, 3, "Spell_Nature_SlowingTotem.png", "", "", "ʹ��ķ����˺����{0}�������Է���������һ���������{1}", new Array(), new Array());
	talents[767] = new Talent( "��ʥ����", "��ʥ", 3, 1, "holynova.png", "", "230�㷨��ֵ<br>˲��<br>", "����һ����ʩ����Ϊ���ĵ����˱�ը���԰뾶10���ڵ�����Ŀ�����36��40����ʥ�˺�����Ϊ�뾶19�뷶Χ�ڵ�����С�ӳ�Ա�ָ�65��70������ֵ����ЩЧ�����Թ�������κ���вֵ��", new Array(), new Array());
	talents[646] = new Talent( "����֮Ȫ", "��ʥ", 7, 2, "lightwell.png", "", "225�㷨��ֵ<br>3��ʩ��ʱ��<br>10������ȴ<br>", "����ʦ�������һ������֮Ȫ���ѷ���λ���Ե������֮Ȫ����10���ڻָ�800������ֵ�����������ж����Ч��������֮Ȫ��2���ӻ����ڱ�ʹ��5�κ���ʧ��", new Array(), new Array(new TalentRequirement(770, 1)));
	talents[764] = new Talent( "��ʥר��", "��ʥ", 1, 3, "Spell_Holy_SealOfSalvation.png", "", "", "��������ʥ�����������һ���ļ���{0}", new Array(), new Array());
	talents[662] = new Talent( "ǿ��������", "��Ӱ", 4, 2, "Spell_Magic_LesserInvisibilty.png", "", "", "ʹ��Ľ���������ȴʱ�����{0}��", new Array(), new Array());
	talents[643] = new Talent( "��������", "��ʥ", 2, 2, "spellwarding.png", "", "", "ʹ���ܵ������з����˺�����{0}��", new Array(), new Array());
	talents[642] = new Talent( "ǿ��������", "��ʥ", 4, 2, "Spell_Holy_Heal.png", "", "", "ʹ��Ĵμ�����������������ǿЧ�������ķ���ֵ���Ľ���{0}", new Array(), new Array());
	talents[653] = new Talent( "ǿ������֮��", "����", 4, 1, "Spell_Holy_InnerFire.png", "", "", "ʹ�������֮���Ч�����{0}", new Array(), new Array());
	talents[655] = new Talent( "ǿ������ȼ��", "����", 4, 4, "Spell_Shadow_ManaBurn.png", "", "", "ʹ��ķ���ȼ�յ�ʩ��ʱ�����{0}", new Array(), new Array());
	talents[166] = new Talent( "ǿ��������", "��Ӱ", 3, 2, "Spell_Shadow_SpectralSight.png", "", "", "ʹ��������𱬵���ȴʱ�����{0}", new Array(), new Array());
	talents[650] = new Talent( "ǿ������������", "����", 2, 2, "Spell_Holy_WordFortitude.png", "", "", "ʹ������������͵�Ч�����{0}", new Array(), new Array());
	talents[649] = new Talent( "ǿ������������", "����", 2, 3, "Spell_Holy_PowerWordShield.png", "", "", "ʹ������������������յ��˺������{0}", new Array(), new Array());
	talents[483] = new Talent( "ǿ�����Ƶ���", "��ʥ", 5, 1, "Spell_Holy_PrayerOfHealing02.png", "", "", "ʹ������Ƶ��������ĵķ���ֵ����{0}", new Array(), new Array());
	talents[660] = new Talent( "ǿ�������Х", "��Ӱ", 3, 1, "Spell_Shadow_PsychicScream.png", "", "", "ʹ��������Х����ȴʱ�����{0}", new Array(), new Array());
	talents[763] = new Talent( "ǿ���ָ�", "��ʥ", 1, 2, "Spell_Holy_Renew.png", "", "", "ʹ��Ļָ�����������Ч�����{0}", new Array(), new Array());
	talents[163] = new Talent( "ǿ����������ʹ", "��Ӱ", 2, 2, "Spell_Shadow_ShadowWordPain.png", "", "", "ʹ��İ�������ʹ�ĳ���ʱ���ӳ�{0}", new Array(), new Array());
	talents[766] = new Talent( "��ʥ֮ŭ", "��ʥ", 2, 3, "divinefury.png", "", "", "ʹ��ĳͻ�����ʥ֮����������ǿЧ��������ʩ��ʱ�����{0}��", new Array(), new Array());
	talents[657] = new Talent( "����רע", "����", 3, 2, "Spell_Frost_WindWalkOn.png", "", "˲��<br>3������ȴ<br>", "����֮�������һ�����������ĵķ���ֵ����100%���������һ����Ч���Ƶļ������25%��������п��������ЩЧ���Ļ�����", new Array(), new Array());
	talents[768] = new Talent( "���", "��ʥ", 3, 4, "Spell_Holy_LayOnHands.png", "", "", "����Ŀ������ơ���������ǿЧ�����������Ƶ��Զ�Ŀ����ɼ�Ч����Ч����ʹĿ��Ļ���ֵ���{0}������15�롣", new Array(), new Array());
	talents[648] = new Talent( "ѳ��", "����", 2, 4, "Spell_Nature_Tranquility.png", "", "", "ʹ����{0}�ļ������ܵ����˽�ս��Զ������һ����õ�רעʩ��Ч��������6�롣רעʩ��Ч������������ʩ��ʱ������Ϊ�ܵ��˺����ӳ�ʩ��ʱ�䣬������ֿ����Ч���ļ������{1}��", new Array(), new Array());
	talents[771] = new Talent( "����ظ�", "��ʥ", 3, 2, "blessedrecovery.png", "", "", "�����ܽ�ս��Զ�̹���������һ����Ϊ����6���ڻָ��൱�ڸ��˺�����{0}������ֵ��", new Array(), new Array());
	talents[656] = new Talent( "ڤ��", "����", 3, 3, "Spell_Nature_Sleep.png", "", "", "ʹ����ʩ��ʱ�Ա���{0}�ķ����ظ��ٶȡ�", new Array(), new Array());
	talents[652] = new Talent( "��������", "����", 4, 2, "Ability_Hibernation.png", "", "", "ʹ���˲�����������ĵķ���ֵ����{0}", new Array(), new Array());
	talents[654] = new Talent( "����֮��", "����", 5, 2, "Spell_Nature_EnchantArmor.png", "", "", "ʹ��ķ���ֵ�������{0}", new Array(), new Array());
	talents[661] = new Talent( "�������", "��Ӱ", 3, 3, "Spell_Shadow_SiphonMana.png", "", "45�㷨��ֵ<br>˲��<br>20��<br>������<br>", "�԰�Ӱ��������Ŀ�����꣬��3���ڶ�������ܼ�75�㰵Ӱ�˺�����ʹ���ƶ��ٶȽ��͵���ͨ�ٶȵ�50%��", new Array(), new Array());
	talents[162] = new Talent( "��Ӱ�׺�", "��Ӱ", 2, 1, "Spell_Shadow_ShadowWard.png", "", "", "ʹ��İ�Ӱ������ɵ���вֵ����{0}", new Array(), new Array());
	talents[164] = new Talent( "��Ӱ����", "��Ӱ", 2, 3, "Spell_Shadow_BurningSpirit.png", "", "", "ʹĿ��ֿ���İ�Ӱ�����Ļ����½�{0}", new Array(), new Array());
	talents[421] = new Talent( "��Ӱ����", "��Ӱ", 4, 3, "Spell_Shadow_ChillTouch.png", "", "", "ʹ��İ�Ӱϵ�˺��Է�����������{0}", new Array(), new Array());
	talents[773] = new Talent( "��Ӱ֮��", "��Ӱ", 4, 4, "Spell_Shadow_ShadeTrueSight.png", "", "", "��İ�Ӱϵ�˺��Է�����{0}�Ļ���ʹ���Ŀ�����ܵ���Ӱϵ����ʱ���������ܵ����˺����3%������15�롣��Ч�����ɵ���5�Ρ�", new Array(), new Array());
	talents[775] = new Talent( "��Ӱ��̬", "��Ӱ", 7, 2, "Spell_Shadow_Shadowform.png", "", "550�㷨��ֵ<br>˲��<br>1.5����ȴʱ��<br>", "���밵Ӱ��̬��ʹ������ɵİ�Ӱ�˺����15%���ܵ�������ʱ���ܵ��˺�����15%�������������̬�£��㲻��ʩ����ʥϵ�ķ�����", new Array(), new Array(new TalentRequirement(664, 1)));
	talents[663] = new Talent( "��Ĭ", "��Ӱ", 5, 1, "Spell_Shadow_ImpPhaseShift.png", "", "225 ����ֵ<br>˲������<br>45����ȴʱ��<br>20����Ч����", "ʹĿ���Ĭ����5���ڲ���ʩ����", new Array(), new Array(new TalentRequirement(660, 2)));
	talents[175] = new Talent( "��������", "����", 2, 1, "Spell_Nature_ManaRegenTotem.png", "", "", "ʹ��ķ�����ɵ���вֵ����{0}", new Array(), new Array());
	talents[770] = new Talent( "����֮��", "��ʥ", 5, 2, "INV_Enchant_EssenceEternalLarge.png", "", "", "������ʱ����ʦ���һ������֮�꣬����10���ӡ�����֮���޷��ƶ���������Ҳ�����ܵ��κη�����Ч����Ӱ�졣�����״̬�£���ʦ����ʩ���κ����Ʒ���������Ҫ�κη���ֵ��������֮��Ч������ʱ����ʦ������", new Array(), new Array());
	talents[160] = new Talent( "�������", "��Ӱ", 1, 2, "Spell_Shadow_Requiem.png", "", "", "ʹ����{0}�ļ�����ɱ��һ�����˲���˻�þ���ֵ֮�����������100%�������ʱ�����ķ���ֵ������ʩ��ʱ�Ա���50%�Ļظ��ٶȡ�����15�롣", new Array(), new Array());
	talents[765] = new Talent( "��������", "��ʥ", 6, 3, "Spell_Nature_MoonGlow.png", "", "", "ʹ������Ʒ���������Ч�����{0}", new Array(), new Array());
	talents[640] = new Talent( "����רע", "��ʥ", 1, 1, "healingfocus.png", "", "", "ʹ����{0}�ļ�����ʩ���κ����Ʒ���ʱ������Ϊ�ܵ��˺����ж�ʩ����", new Array(), new Array());
	talents[174] = new Talent( "�ᶨ��־", "����", 1, 2, "Spell_Magic_MageArmor.png", "", "", "ʹ��ֿ����ԡ��־�ͳ�ĬЧ���ļ������{0}", new Array(), new Array());
	talents[664] = new Talent( "��Ѫ���ӵ��", "��Ӱ", 5, 2, "Spell_Shadow_UnsummonBuilding.png", "", "40�㷨��ֵ<br>˲��<br>10������ȴ<br>30����Ч����<br>", "��Ӱħ���������������Ŀ�꣬ʹ�������ɵİ�Ӱ�˺�������20%ת���������ж��ѡ�Ч������1���ӡ�", new Array(), new Array());
	talents[467] = new Talent( "ħ��ר��", "����", 1, 3, "INV_Wand_01.png", "", "", "ʹ���ħ����ɵ��˺����{0}", new Array(), new Array());
	talents[838] = new Talent( "����֮��", "��ʥ", 4, 3, "searinglight.png", "", "", "ʹ��ĳͽ����ʥ֮����ɵ��˺����{0}", new Array(), new Array(new TalentRequirement(766, 5)));
	talents[772] = new Talent( "����ָ��", "��ʥ", 5, 3, "spiritualguidance.png", "", "", "ʹ��ķ������˺�������Ч����ߣ���ֵ����൱���㾫��ֵ��{0}", new Array(), new Array());
	talents[839] = new Talent( "ǿ����Ѫ���ӵ��", "��Ӱ", 5, 3, "improvedvampiricembrace.png", "", "", "ʹ��Ѫ���ӵ���ָ������İٷֱ����{0}", new Array(), new Array(new TalentRequirement(664, 1)));
	
	talents[161].Info[0] = new TalentInfo(1, "2%", "",  "");
	talents[161].Info[1] = new TalentInfo(2, "4%", "",  "");
	talents[161].Info[2] = new TalentInfo(3, "6%", "",  "");
	talents[161].Info[3] = new TalentInfo(4, "8%", "",  "");
	talents[161].Info[4] = new TalentInfo(5, "10%", "", "");
	talents[774].Info[0] = new TalentInfo(1, "2%", "", "");
	talents[774].Info[1] = new TalentInfo(2, "4%", "", "");
	talents[774].Info[2] = new TalentInfo(3, "6%", "", "");
	talents[774].Info[3] = new TalentInfo(4, "8%", "", "");
	talents[774].Info[4] = new TalentInfo(5, "10%", "", "");
	talents[769].Info[0] = new TalentInfo(1, "10%", "", "");
	talents[769].Info[1] = new TalentInfo(2, "20%", "", "");
	talents[659].Info[0] = new TalentInfo(1, "", "", "");
	talents[651].Info[0] = new TalentInfo(1, "", "", "");
	talents[658].Info[0] = new TalentInfo(1, "1%, 1%", "", "");
	talents[658].Info[1] = new TalentInfo(2, "2%, 2%", "", "");
	talents[658].Info[2] = new TalentInfo(3, "3%, 3%", "", "");
	talents[658].Info[3] = new TalentInfo(4, "4%, 4%", "", "");
	talents[658].Info[4] = new TalentInfo(5, "5%, 5%", "", "");
	talents[767].Info[0] = new TalentInfo(1, "", "", "");
	talents[646].Info[0] = new TalentInfo(1, "", "", "");
	talents[772].Info[0] = new TalentInfo(1, "", "", "");
	talents[764].Info[0] = new TalentInfo(1, "1%", "", "");
	talents[764].Info[1] = new TalentInfo(2, "2%", "", "");
	talents[764].Info[2] = new TalentInfo(3, "3%", "", "");
	talents[764].Info[3] = new TalentInfo(4, "4%", "", "");
	talents[764].Info[4] = new TalentInfo(5, "5%", "", "");
	talents[662].Info[0] = new TalentInfo(1, "3��", "", "");
	talents[662].Info[1] = new TalentInfo(2, "6��", "", "");
	talents[643].Info[0] = new TalentInfo(1, "2%", "", "");
	talents[643].Info[1] = new TalentInfo(2, "4%", "", "");
	talents[643].Info[2] = new TalentInfo(3, "6%", "", "");
	talents[643].Info[3] = new TalentInfo(4, "8%", "", "");
	talents[643].Info[4] = new TalentInfo(5, "10%", "", "");
	talents[642].Info[0] = new TalentInfo(1, "5%", "", "");
	talents[642].Info[1] = new TalentInfo(2, "10%", "", "");
	talents[642].Info[2] = new TalentInfo(3, "15%", "", "");
	talents[653].Info[0] = new TalentInfo(1, "10%", "", "");
	talents[653].Info[1] = new TalentInfo(2, "20%", "", "");
	talents[653].Info[2] = new TalentInfo(3, "30%", "", "");
	talents[655].Info[0] = new TalentInfo(1, "0.25 ��", "", "");
	talents[655].Info[1] = new TalentInfo(2, "0.5 ��", "", "");
	talents[166].Info[0] = new TalentInfo(1, "0.5 ��", "", "");
	talents[166].Info[1] = new TalentInfo(2, "1 ��", "", "");
	talents[166].Info[2] = new TalentInfo(3, "1.5 ��", "", "");
	talents[166].Info[3] = new TalentInfo(4, "2 ��", "", "");
	talents[166].Info[4] = new TalentInfo(5, "2.5 ��", "", "");
	talents[650].Info[0] = new TalentInfo(1, "15%", "", "");
	talents[650].Info[1] = new TalentInfo(2, "30%", "", "");
	talents[649].Info[0] = new TalentInfo(1, "5%", "", "");
	talents[649].Info[1] = new TalentInfo(2, "10%", "", "");
	talents[649].Info[2] = new TalentInfo(3, "15%", "", "");
	talents[483].Info[0] = new TalentInfo(1, "10%", "", "");
	talents[483].Info[1] = new TalentInfo(2, "20%", "", "");
	talents[660].Info[0] = new TalentInfo(1, "2 ��", "", "");
	talents[660].Info[1] = new TalentInfo(2, "4 ��", "", "");
	talents[763].Info[0] = new TalentInfo(1, "5%", "", "");
	talents[763].Info[1] = new TalentInfo(2, "10%", "", "");
	talents[763].Info[2] = new TalentInfo(3, "15%", "", "");
	talents[163].Info[0] = new TalentInfo(1, "3 ��", "", "");
	talents[163].Info[1] = new TalentInfo(2, "6 ��", "", "");
	talents[766].Info[0] = new TalentInfo(1, "0.1��", "", "");
	talents[766].Info[1] = new TalentInfo(2, "0.2��", "", "");
	talents[766].Info[2] = new TalentInfo(3, "0.3��", "", "");
	talents[766].Info[3] = new TalentInfo(4, "0.4��", "", "");
	talents[766].Info[4] = new TalentInfo(5, "0.5��", "", "");
	talents[657].Info[0] = new TalentInfo(1, "", "", "");
	talents[768].Info[0] = new TalentInfo(1, "8%", "", "");
	talents[768].Info[1] = new TalentInfo(2, "16%", "", "");
	talents[768].Info[2] = new TalentInfo(3, "25%", "", "");
	talents[648].Info[0] = new TalentInfo(1, "50%,10%", "", "");
	talents[648].Info[1] = new TalentInfo(2, "100%,20%", "", "");
	talents[771].Info[0] = new TalentInfo(1, "8%", "", "");
	talents[771].Info[1] = new TalentInfo(2, "16%", "", "");
	talents[771].Info[2] = new TalentInfo(3, "25%", "", "");
	talents[656].Info[0] = new TalentInfo(1, "5%", "", "");
	talents[656].Info[1] = new TalentInfo(2, "10%", "", "");
	talents[656].Info[2] = new TalentInfo(3, "15%", "", "");
	talents[652].Info[0] = new TalentInfo(1, "2%", "", "");
	talents[652].Info[1] = new TalentInfo(2, "4%", "", "");
	talents[652].Info[2] = new TalentInfo(3, "6%", "", "");
	talents[652].Info[3] = new TalentInfo(4, "8%", "", "");
	talents[652].Info[4] = new TalentInfo(5, "10%", "", "");
	talents[654].Info[0] = new TalentInfo(1, "2%", "", "");
	talents[654].Info[1] = new TalentInfo(2, "4%", "", "");
	talents[654].Info[2] = new TalentInfo(3, "6%", "", "");
	talents[654].Info[3] = new TalentInfo(4, "8%", "", "");
	talents[654].Info[4] = new TalentInfo(5, "10%", "", "");
	talents[661].Info[0] = new TalentInfo(1, "", "", "");
	talents[162].Info[0] = new TalentInfo(1, "8%", "", "");
	talents[162].Info[1] = new TalentInfo(2, "16%", "", "");
	talents[162].Info[2] = new TalentInfo(3, "25%", "", "");
	talents[164].Info[0] = new TalentInfo(1, "2%", "", "");
	talents[164].Info[1] = new TalentInfo(2, "4%", "", "");
	talents[164].Info[2] = new TalentInfo(3, "6%", "", "");
	talents[164].Info[3] = new TalentInfo(4, "8%", "", "");
	talents[164].Info[4] = new TalentInfo(5, "10%", "", "");
	talents[421].Info[0] = new TalentInfo(1, "6%", "", "");
	talents[421].Info[1] = new TalentInfo(2, "13%", "", "");
	talents[421].Info[2] = new TalentInfo(3, "20%", "", "");
	talents[773].Info[0] = new TalentInfo(1, "20%", "", "");
	talents[773].Info[1] = new TalentInfo(2, "40%", "", "");
	talents[773].Info[2] = new TalentInfo(3, "60%", "", "");
	talents[773].Info[3] = new TalentInfo(4, "80%", "", "");
	talents[773].Info[4] = new TalentInfo(5, "100%", "", "");
	talents[775].Info[0] = new TalentInfo(1, "", "", "");
	talents[663].Info[0] = new TalentInfo(1, "", "", "");
	talents[175].Info[0] = new TalentInfo(1, "4%", "", "");
	talents[175].Info[1] = new TalentInfo(2, "8%", "", "");
	talents[175].Info[2] = new TalentInfo(3, "12%", "", "");
	talents[175].Info[3] = new TalentInfo(4, "16%", "", "");
	talents[175].Info[4] = new TalentInfo(5, "20%", "", "");
	talents[770].Info[0] = new TalentInfo(1, "", "", "");
	talents[160].Info[0] = new TalentInfo(1, "20%", "",  "");
	talents[160].Info[1] = new TalentInfo(2, "40%", "",  "");
	talents[160].Info[2] = new TalentInfo(3, "60%", "",  "");
	talents[160].Info[3] = new TalentInfo(4, "80%", "",  "");
	talents[160].Info[4] = new TalentInfo(5, "100%", "", "");
	talents[765].Info[0] = new TalentInfo(1, "2%", "", "");
	talents[765].Info[1] = new TalentInfo(2, "4%", "", "");
	talents[765].Info[2] = new TalentInfo(3, "6%", "", "");
	talents[765].Info[3] = new TalentInfo(4, "8%", "", "");
	talents[765].Info[4] = new TalentInfo(5, "10%", "", "");
	talents[640].Info[0] = new TalentInfo(1, "35%", "", "");
	talents[640].Info[1] = new TalentInfo(2, "70%", "", "");
	talents[174].Info[0] = new TalentInfo(1, "3%", "", "");
	talents[174].Info[1] = new TalentInfo(2, "6%", "", "");
	talents[174].Info[2] = new TalentInfo(3, "9%", "", "");
	talents[174].Info[3] = new TalentInfo(4, "12%", "", "");
	talents[174].Info[4] = new TalentInfo(5, "15%", "", "");
	talents[664].Info[0] = new TalentInfo(1, "", "", "");
	talents[467].Info[0] = new TalentInfo(1, "5%", "", "");
	talents[467].Info[1] = new TalentInfo(2, "10%", "", "");
	talents[467].Info[2] = new TalentInfo(3, "15%", "", "");
	talents[467].Info[3] = new TalentInfo(4, "20%", "", "");
	talents[467].Info[4] = new TalentInfo(5, "25%", "", "");
	talents[838].Info[0] = new TalentInfo(1, "5%", "", "");
	talents[838].Info[1] = new TalentInfo(2, "10%", "", "");
	talents[772].Info[0] = new TalentInfo(1, "5%", "", "");
	talents[772].Info[1] = new TalentInfo(2, "10%", "", "");
	talents[772].Info[2] = new TalentInfo(3, "15%", "", "");
	talents[772].Info[3] = new TalentInfo(4, "20%", "", "");
	talents[772].Info[4] = new TalentInfo(5, "25%", "", "");
	talents[839].Info[0] = new TalentInfo(1, "5%", "", "");
	talents[839].Info[1] = new TalentInfo(2, "10%", "", "");


//----8<-------------------------------------------[

}

if (currentClass == classLst[5]) {
	talents[358] = new Talent("�嶯", "ս��", 7, 2, "Spell_Shadow_ShadowWordDominate.png", "", "˲��<br>5������ȴʱ��", "ʹ�������ֵ�ظ��ٶ����100%������15�롣", new Array(), new Array());
	talents[833] = new Talent("����", "ս��", 6, 3, "Ability_Racial_Avatar.png", "", "", "ʹ���а�񹥻����޹Ǽ��ܵ��˺����{0}��", new Array(), new Array());
	talents[581] = new Talent("��������", "ս��", 5, 2, "Ability_Warrior_PunishingBlow.png", "", "25 ����<br>˲��<br>2������ȴʱ��<br>��Ҫ��ս����", "ʹ��Ĺ����ٶ����20%�����⻹���ԶԸ�����һ������ĵ�������˺�������15�롣", new Array(), new Array());
	talents[359] = new Talent("�Ż�����", "����", 1, 3, "Ability_Warrior_WarCry.png", "", "", "ʹ���ڴӱ���ʹ�ñ��̡��ʺ���������͵Ϯ����ʱ����ɵ��˺�ֵ���{0}��", new Array(), new Array());
	talents[829] = new Talent("��Ѫ", "��ɱ", 5, 2, "Spell_Ice_Lament.png", "", "˲��<br>3 ������ȴʱ��", "����֮�������һ��а�񹥻������̡��������޹��������һ���ļ������100%��", new Array(), new Array());
	talents[580] = new Talent("ذ��ר��", "ս��", 4, 2, "INV_Weapon_ShortBlade_05.png", "", "", "ʹ���ذ���������һ���ļ������{0}��", new Array(), new Array());
	talents[576] = new Talent("ƫб", "ս��", 2, 2, "Ability_Parry.png", "", "", "ʹ����мܼ������{0}��", new Array(), new Array());
	talents[352] = new Talent("˫����ר��", "ս��", 4, 3, "Ability_DualWield.png", "", "", "ʹ��ĸ���������ɵ��˺����{0}��", new Array(), new Array(new TalentRequirement(347, 5)));
	talents[589] = new Talent("Ʈ������", "����", 2, 2, "Spell_Magic_LesserInvisibilty.png", "", "", "ʹ�����ʧ����ä���ܵ���ȴʱ������{0}��", new Array(), new Array());
	talents[110] = new Talent("ȭ��ר��", "ս��", 5, 4, "INV_Gauntlets_04.png", "", "", "ʹ���ȭ���������һ���ļ������{0}��", new Array(), new Array());
	talents[590] = new Talent("���ȹ���", "����", 3, 2, "Spell_Shadow_Curse.png", "", "40 ����<br>˲��<br>20 ����ȴʱ��<br>5 ����Ч����", "�Ե������125%�����˺�����ʹ����������ļ������15%������7�롣����1������������", new Array(), new Array());
	talents[594] = new Talent("��Ѫ", "����", 5, 4, "Spell_Shadow_LifeDrain.png", "", "35 ����<br>˲��<br>5 ����Ч����<br>��Ҫ��ս����", "������Ŀ������˺���������Ѫ��ֹ��ʹ�����ܵ�������ʱ�����ܵ��˺�������3�㡣�������Ч30�Σ����߳���15�롣����1������������", new Array(), new Array(new TalentRequirement(591,3)));
	talents[363] = new Talent("ǿ������", "����", 3, 3, "Ability_Rogue_Ambush.png", "", "", "ʹ��ķ��������������һ���ļ������{0}��", new Array(), new Array());
	talents[575] = new Talent("ǿ������", "ս��", 2, 1, "Ability_BackStab.png", "", "", "ʹ��ı��̼����������һ���ļ������{0}��", new Array(), new Array());
	talents[369] = new Talent("����", "����", 5, 3, "dirtydeeds.png", "", "", "ʹ���͵Ϯ�ͽʺ��������ĵ�����ֵ����{0}��", new Array(), new Array());
	talents[339] = new Talent("����", "����", 6, 3, "deadliness.png", "", "", "����ǿ�����{0}��", new Array(), new Array());
	talents[592] = new Talent("ǿ������", "����", 5, 4, "Ability_Rogue_Distract.png", "", "", "ʹ������Ҽ��ܵ����ð뾶����{0}��", new Array(), new Array());
	talents[577] = new Talent("�;�", "ս��", 3, 1, "Spell_Shadow_ShadowWard.png", "", "", "ʹ��ļ���/���ܼ��ܵ���ȴʱ�併��{0}��", new Array(), new Array());
	talents[326] = new Talent("ǿ���޹�", "��ɱ", 1, 1, "Ability_Rogue_Eviscerate.png", "", "", "ʹ����޹Ǽ�������ɵ��˺����{0}��", new Array(), new Array());
	talents[332] = new Talent("ǿ���Ƽ�", "��ɱ", 3, 2, "Ability_Warrior_Riposte.png", "", "", "���������Ƽ׼��ܵĻ���ֵ������{0}��", new Array(), new Array());
	talents[362] = new Talent("���", "����", 5, 1, "Ability_Ambush.png", "", "", "���������Ǳ�е��������������㱻������Զ�̹������еļ���{0}��", new Array(), new Array());
	talents[573] = new Talent("ǿ�����", "ս��", 1, 1, "Ability_Gouge.png", "", "", "ʹ���������ܵ�Ч������ʱ���ӳ�{0}��", new Array(), new Array());
	talents[337] = new Talent("ǿ����Ч��ҩ", "��ɱ", 4, 3, "Ability_Poisons.png", "", "", "ʹ��Ķ�ҩ�Ե�����Ч�ļ������{0}��", new Array(), new Array());
	talents[579] = new Talent("ǿ������", "ս��", 4, 1, "Ability_Kick.png", "", "", "ʹ��Ľ��߼�����{0}�ļ�����Ŀ���Ĭ2�롣", new Array(), new Array());
	talents[585] = new Talent("ǿ������", "��ɱ", 5, 3, "Ability_Rogue_KidneyShot.png", "", "", "Ŀ���ܵ������������Ӱ��֮���κι����߶�������ɵ��˺��������{0}��", new Array(), new Array());
	talents[591] = new Talent("�������", "����", 4, 3, "serratedblades.png", "", "", "ʹ��Ĺ�������Ŀ��ÿ�ȼ�{0}�㻤�ף���ʹ��ĸ��Ѽ�������ɵ��˺����{1}������Ŀ�껤�׵�Ч��������ĵȼ���߶���ߡ���", new Array(), new Array());
	talents[367] = new Talent("ǿ���ƹ�", "����", 4, 2, "Ability_Sap.png", "", "", "ʹ����{0}�ļ�����ʹ���ƹ�����֮������ת��Ǳ��ģʽ��", new Array(), new Array());
	talents[574] = new Talent("ǿ��а�񹥻�", "ս��", 1, 2, "Spell_Shadow_RitualOfSacrifice.png", "", "", "ʹ���а�񹥻����������ĵ�����ֵ���� {0}��", new Array(), new Array());
	talents[331] = new Talent("ǿ���и�", "��ɱ", 2, 4, "Ability_Rogue_SliceDice.png", "", "", "ʹ����и�ܵ�Ч������ʱ���ӳ�{0}��", new Array(), new Array());
	talents[350] = new Talent("ǿ������", "ս��", 3, 4, "Ability_Rogue_Sprint.png", "", "", "���㼤��ܼ��ܵ�ʱ��ʹ����{0}�ļ����Ƴ������ƶ�����Ч����", new Array(), new Array());
	talents[360] = new Talent("�ȷ�����", "����", 3, 1, "Spell_Shadow_Fumble.png", "", "", "ʹ����{0}�ļ�����ʹ�÷������ʺ��͵Ϯ���ܺ���1�����������������", new Array(), new Array());
	talents[828] = new Talent("����͵Ϯ", "��ɱ", 3, 3, "Ability_CriticalStrike.png", "", "", "ʹ���а�񹥻����ʺ����̡����ȹ������Ѫ���ܵ�����һ������ɵĶ����˺����{0}��", new Array(), new Array(new TalentRequirement(328, 5)));
	talents[96] = new Talent("���練��", "ս��", 1, 3, "Spell_Nature_Invisibilty.png", "", "", "ʹ��Ķ����������{0}��", new Array(), new Array());
	talents[353] = new Talent("��������ר��", "ս��", 5, 1, "INV_Mace_01.png", "", "", "ʹ��Ĵ��������������{0}�㣬ʹ�ô�����������Ŀ��ʱ��{1}�ļ��ʽ������3�롣", new Array(), new Array());
	talents[328] = new Talent("����", "��ɱ", 1, 3, "Ability_Racial_BloodRage.png", "", "", "ʹ�������һ���������{0}��", new Array(), new Array());
	talents[587] = new Talent("��թ��ʦ", "����", 1, 2, "Spell_Shadow_Charm.png", "", "", "������Ǳ��״̬��ʱ�����͵�����⵽��ļ��ʡ�{0}", new Array(), new Array());
	talents[330] = new Talent("ıɱ", "��ɱ", 2, 2, "Spell_Shadow_DeathScream.png", "", "", "ʹ�������������ˡ�Ұ�޺�����Ŀ����ɵ������˺����{0}��", new Array(), new Array());
	talents[588] = new Talent("αװ", "����", 2, 3, "Ability_Stealth.png", "", "", "ʹ����Ǳ�к���ƶ��ٶ���� {0}����ʹ���Ǳ�м��ܵ���ȴʱ����� {1}��", new Array(), new Array());
	talents[347] = new Talent("��ȷ", "ս��", 2, 3, "Ability_Marksmanship.png", "", "", "ʹ��Ľ�ս��������Ŀ��ļ������{0}��", new Array(), new Array());
	talents[834] = new Talent("Ԥı", "����", 7, 2, "Spell_Shadow_Possession.png", "", "10 ����<br>1 ��ʩ��ʱ��<br>2 ������ȴʱ��<br>15 ����Ч����<br>��ҪǱ��<br>", "ʹ�ô˼��ܺ�Ϊ��ĵ�ǰĿ������2�������������������10�������ĵ���Щ�������������Ǿͻ���ʧ��", new Array(), new Array(new TalentRequirement(368,1)));
	talents[368] = new Talent("�Ż�����", "����", 5, 2, "Spell_Shadow_AntiShadow.png", "", "˲��<br>10 ������ȴʱ��<br>", "����֮���������������������������ܵ���ȴʱ�������", new Array(), new Array());
	talents[586] = new Talent("ǿ����", "����", 2, 1, "sleightofhand.png", "", "", "ʹ����𹥼��ܼ�����вֵ��Ч�����{0}����ʹ�㱻��ս��Զ�̹�������һ���ļ��ʽ���{1}��", new Array(), new Array());
	talents[584] = new Talent("������", "��ɱ", 3, 1, "Ability_Warrior_DecisiveStrike.png", "", "", "����սἼ��ÿ��������20%�ļ��ʻָ�25������ֵ��", new Array(), new Array());
	talents[827] = new Talent("��ṥ��", "��ɱ", 1, 2, "Ability_FiegnDead.png", "", "", "����ɱ��һ�����˲��õ�����ֵ�������һ��а�񹥻������̡���������ȹ�����{0}�Ķ��⼸���������һ����Ч������20�롣", new Array(), new Array());
	talents[831] = new Talent("����", "ս��", 3, 2, "Ability_Warrior_Challange.png", "", "10 ����<br>˲������<br>6������ȴʱ��<br>5 ����Ч����", "���м��˵��˵Ĺ���֮�����ʹ�õļ��ܣ���Ŀ�����150%�������˺�����ʹ�䱻��е������6�롣", new Array(), new Array(new TalentRequirement(576, 5)));
	talents[329] = new Talent("����", "��ɱ", 2, 1, "Ability_Druid_Disembowel.png", "", "", "ʹ����սἼ��{0}�ļ���ΪĿ������һ������������", new Array(), new Array());
	talents[830] = new Talent("��ӡ����", "��ɱ", 6, 2, "Spell_Shadow_ChillTouch.png", "", "", "������ĳ�������������������ļ������������һ������ô������{0}�ļ�������һ�����������������", new Array(), new Array(new TalentRequirement(829, 1)));
	talents[593] = new Talent("����", "����", 4, 1, "Spell_Nature_MirrorImage.png", "", "", "ʹ����{0}�ļ����ڳɹ��ֿ����˵Ĺ���֮����һ������������", new Array(), new Array());
	talents[355] = new Talent("��������ר��", "ս��", 5, 3, "INV_Sword_27.png", "", "", "ʹ�����ý����������е��˺���{0}�ļ��ʽ���һ�ζ���Ĺ�����", new Array(), new Array());
	talents[832] = new Talent("������ʦ", "ս��", 6, 2, "weaponexpertise.png", "", "", "ʹ��ĵ��ֽ���ذ������������� {0}��", new Array(), new Array());
	talents[342] = new Talent("����", "��ɱ", 7, 2, "Spell_Nature_EarthBindTotem.png", "", "", "ʹ�������ֵ�������10�㡣", new Array(), new Array());
	talents[336] = new Talent("���Զ�ҩ", "��ɱ", 4, 2, "Ability_Rogue_FeignDeath.png", "", "", "ʹ��Ķ�ҩ����ɵ��˺����{0}����ʹ����{1}�Ķ��⼸�ʵֿ�һ����ɢЧ����", new Array(), new Array());
	talents[358].Info[0] = new TalentInfo(1, "", "", "");
	talents[833].Info[0] = new TalentInfo(1, "2%", "", "");
	talents[833].Info[1] = new TalentInfo(2, "4%", "", "");
	talents[833].Info[2] = new TalentInfo(3, "6%", "", "");
	talents[581].Info[0] = new TalentInfo(1, "", "", "");
	talents[588].Info[0] = new TalentInfo(1, "3%,1��", "", "");
	talents[588].Info[1] = new TalentInfo(2, "6%,2��", "", "");
	talents[588].Info[2] = new TalentInfo(3, "9%,3��", "", "");
	talents[588].Info[3] = new TalentInfo(4, "12%,4��", "", "");
	talents[588].Info[4] = new TalentInfo(5, "15%,5��", "", "");
	talents[829].Info[0] = new TalentInfo(1, "", "", "");
	talents[580].Info[0] = new TalentInfo(1, "1%", "", "");
	talents[580].Info[1] = new TalentInfo(2, "2%", "", "");
	talents[580].Info[2] = new TalentInfo(3, "3%", "", "");
	talents[580].Info[3] = new TalentInfo(4, "4%", "", "");
	talents[580].Info[4] = new TalentInfo(5, "5%", "", "");
	talents[576].Info[0] = new TalentInfo(1, "1%", "", "");
	talents[576].Info[1] = new TalentInfo(2, "2%", "", "");
	talents[576].Info[2] = new TalentInfo(3, "3%", "", "");
	talents[576].Info[3] = new TalentInfo(4, "4%", "", "");
	talents[576].Info[4] = new TalentInfo(5, "5%", "", "");
	talents[352].Info[0] = new TalentInfo(1, "10%", "", "");
	talents[352].Info[1] = new TalentInfo(2, "20%", "", "");
	talents[352].Info[2] = new TalentInfo(3, "30%", "", "");
	talents[352].Info[3] = new TalentInfo(4, "40%", "", "");
	talents[352].Info[4] = new TalentInfo(5, "50%", "", "");
	talents[589].Info[0] = new TalentInfo(1, "45��", "", "");
	talents[589].Info[1] = new TalentInfo(2, "90��", "", "");
	talents[110].Info[0] = new TalentInfo(1, "1%", "", "");
	talents[110].Info[1] = new TalentInfo(2, "2%", "", "");
	talents[110].Info[2] = new TalentInfo(3, "3%", "", "");
	talents[110].Info[3] = new TalentInfo(4, "4%", "", "");
	talents[110].Info[4] = new TalentInfo(5, "5%", "", "");
	talents[590].Info[0] = new TalentInfo(1, "", "", "");
	talents[594].Info[0] = new TalentInfo(1, "", "", "");
	talents[363].Info[0] = new TalentInfo(1, "15%", "", "");
	talents[363].Info[1] = new TalentInfo(2, "30%", "", "");
	talents[363].Info[2] = new TalentInfo(3, "40%", "", "");
	talents[575].Info[0] = new TalentInfo(1, "10%", "", "");
	talents[575].Info[1] = new TalentInfo(2, "20%", "", "");
	talents[575].Info[2] = new TalentInfo(3, "30%", "", "");
	talents[369].Info[0] = new TalentInfo(1, "10��", "", "");
	talents[369].Info[1] = new TalentInfo(2, "20��", "", "");
	talents[339].Info[0] = new TalentInfo(1, "2%", "", "");
	talents[339].Info[1] = new TalentInfo(2, "4%", "", "");
	talents[339].Info[2] = new TalentInfo(3, "6%", "", "");
	talents[339].Info[3] = new TalentInfo(4, "8%", "", "");
	talents[339].Info[4] = new TalentInfo(5, "10%", "", "");
	talents[592].Info[0] = new TalentInfo(1, "3 ��", "", "");
	talents[592].Info[1] = new TalentInfo(2, "5 ��", "", "");
	talents[577].Info[0] = new TalentInfo(1, "45 ��", "", "");
	talents[577].Info[1] = new TalentInfo(2, "90 ��", "", "");
	talents[326].Info[0] = new TalentInfo(1, "5%", "", "");
	talents[326].Info[1] = new TalentInfo(2, "10%", "", "");
	talents[326].Info[2] = new TalentInfo(3, "15%", "", "");
	talents[332].Info[0] = new TalentInfo(1, "6%", "", "");
	talents[332].Info[1] = new TalentInfo(2, "12%", "", "");
	talents[362].Info[0] = new TalentInfo(1, "2%", "", "");
	talents[362].Info[1] = new TalentInfo(2, "4%�� �Ȳ�����ȼ�1����Ϊ��Ч", "", "");
	talents[573].Info[0] = new TalentInfo(1, "0.5 ��", "", "");
	talents[573].Info[1] = new TalentInfo(2, "1 ��", "", "");
	talents[573].Info[2] = new TalentInfo(3, "1.5 ��", "", "");
	talents[337].Info[0] = new TalentInfo(1, "2%", "", "");
	talents[337].Info[1] = new TalentInfo(2, "4%", "", "");
	talents[337].Info[2] = new TalentInfo(3, "6%", "", "");
	talents[337].Info[3] = new TalentInfo(4, "8%", "", "");
	talents[337].Info[4] = new TalentInfo(5, "10%", "", "");
	talents[579].Info[0] = new TalentInfo(1, "50%", "", "");
	talents[579].Info[1] = new TalentInfo(2, "100%", "", "");
	talents[585].Info[0] = new TalentInfo(1, "3%", "", "");
	talents[585].Info[1] = new TalentInfo(2, "6%", "", "");
	talents[585].Info[2] = new TalentInfo(3, "9%", "", "");
	talents[591].Info[0] = new TalentInfo(1, "1.7,10%", "", "");
	talents[591].Info[1] = new TalentInfo(2, "3.3,20%", "", "");
	talents[591].Info[2] = new TalentInfo(3, "5,30%", "", "");
	talents[367].Info[0] = new TalentInfo(1, "30%", "", "");
	talents[367].Info[1] = new TalentInfo(2, "60%", "", "");
	talents[367].Info[2] = new TalentInfo(3, "90%", "", "");
	talents[574].Info[0] = new TalentInfo(1, "3 ��", "", "");
	talents[574].Info[1] = new TalentInfo(2, "5 ��", "", "");
	talents[331].Info[0] = new TalentInfo(1, "15%", "", "");
	talents[331].Info[1] = new TalentInfo(2, "30%", "", "");
	talents[331].Info[2] = new TalentInfo(3, "45%", "", "");
	talents[350].Info[0] = new TalentInfo(1, "50%", "", "");
	talents[350].Info[1] = new TalentInfo(2, "100%", "", "");
	talents[360].Info[0] = new TalentInfo(1, "25%", "", "");
	talents[360].Info[1] = new TalentInfo(2, "50%", "", "");
	talents[360].Info[2] = new TalentInfo(3, "75%", "", "");
	talents[828].Info[0] = new TalentInfo(1, "6%", "", "");
	talents[828].Info[1] = new TalentInfo(2, "12%", "", "");
	talents[828].Info[2] = new TalentInfo(3, "18%", "", "");
	talents[828].Info[3] = new TalentInfo(4, "24%", "", "");
	talents[828].Info[4] = new TalentInfo(5, "30%", "", "");
	talents[96].Info[0] = new TalentInfo(1, "1%", "", "");
	talents[96].Info[1] = new TalentInfo(2, "2%", "", "");
	talents[96].Info[2] = new TalentInfo(3, "3%", "", "");
	talents[96].Info[3] = new TalentInfo(4, "4%", "", "");
	talents[96].Info[4] = new TalentInfo(5, "5%", "", "");
	talents[353].Info[0] = new TalentInfo(1, "1,1%", "", "");
	talents[353].Info[1] = new TalentInfo(2, "2,2%", "", "");
	talents[353].Info[2] = new TalentInfo(3, "3,3%", "", "");
	talents[353].Info[3] = new TalentInfo(4, "4,4%", "", "");
	talents[353].Info[4] = new TalentInfo(5, "5,5%", "", "");
	talents[328].Info[0] = new TalentInfo(1, "1%", "", "");
	talents[328].Info[1] = new TalentInfo(2, "2%", "", "");
	talents[328].Info[2] = new TalentInfo(3, "3%", "", "");
	talents[328].Info[3] = new TalentInfo(4, "4%", "", "");
	talents[328].Info[4] = new TalentInfo(5, "5%", "", "");
	talents[587].Info[0] = new TalentInfo(1, " ", "", "");
	talents[587].Info[1] = new TalentInfo(2, "�� ��թ��ʦ���ȼ�1������Ч", "", "");
	talents[587].Info[2] = new TalentInfo(3, "�� ��թ��ʦ���ȼ�2������Ч", "", "");
	talents[587].Info[3] = new TalentInfo(4, "�� ��թ��ʦ���ȼ�3������Ч", "", "");
	talents[587].Info[4] = new TalentInfo(5, "�� ��թ��ʦ���ȼ�4������Ч", "", "");
	talents[330].Info[0] = new TalentInfo(1, "1%", "", "");
	talents[330].Info[1] = new TalentInfo(2, "2%", "", "");
	talents[359].Info[0] = new TalentInfo(1, "4%", "", "");
	talents[359].Info[1] = new TalentInfo(2, "8%", "", "");
	talents[359].Info[2] = new TalentInfo(3, "12%", "", "");
	talents[359].Info[3] = new TalentInfo(4, "16%", "", "");
	talents[359].Info[4] = new TalentInfo(5, "20%", "", "");
	talents[347].Info[0] = new TalentInfo(1, "1%", "", "");
	talents[347].Info[1] = new TalentInfo(2, "2%", "", "");
	talents[347].Info[2] = new TalentInfo(3, "3%", "", "");
	talents[347].Info[3] = new TalentInfo(4, "4%", "", "");
	talents[347].Info[4] = new TalentInfo(5, "5%", "", "");
	talents[834].Info[0] = new TalentInfo(1, "", "", "");
	talents[368].Info[0] = new TalentInfo(1, "", "", "");
	talents[586].Info[0] = new TalentInfo(1, "10%,1%", "", "");
	talents[586].Info[1] = new TalentInfo(2, "20%,2%", "", "");
	talents[584].Info[0] = new TalentInfo(1, "20%", "", "");
	talents[827].Info[0] = new TalentInfo(1, "20%", "", "");
	talents[827].Info[1] = new TalentInfo(5, "40%", "", "");
	talents[831].Info[0] = new TalentInfo(1, "", "", "");
	talents[329].Info[0] = new TalentInfo(1, "20%", "", "");
	talents[329].Info[1] = new TalentInfo(2, "40%", "", "");
	talents[329].Info[2] = new TalentInfo(3, "60%", "", "");
	talents[830].Info[0] = new TalentInfo(1, "20%", "", "");
	talents[830].Info[1] = new TalentInfo(2, "40%", "", "");
	talents[830].Info[2] = new TalentInfo(3, "60%", "", "");
	talents[830].Info[3] = new TalentInfo(4, "80%", "", "");
	talents[830].Info[4] = new TalentInfo(5, "100%", "", "");
	talents[593].Info[0] = new TalentInfo(1, "15%", "", "");
	talents[593].Info[1] = new TalentInfo(2, "30%", "", "");
	talents[593].Info[2] = new TalentInfo(3, "45%", "", "");
	talents[355].Info[0] = new TalentInfo(1, "1%", "", "");
	talents[355].Info[1] = new TalentInfo(2, "2%", "", "");
	talents[355].Info[2] = new TalentInfo(3, "3%", "", "");
	talents[355].Info[3] = new TalentInfo(4, "4%", "", "");
	talents[355].Info[4] = new TalentInfo(5, "5%", "", "");
	talents[832].Info[0] = new TalentInfo(1, "3 ��", "", "");
	talents[832].Info[1] = new TalentInfo(2, "5 ��", "", "");
	talents[342].Info[0] = new TalentInfo(1, "10", "", "");
	talents[336].Info[0] = new TalentInfo(1, "3%,8%", "", "");
	talents[336].Info[1] = new TalentInfo(2, "6%,16%", "", "");
	talents[336].Info[2] = new TalentInfo(3, "9%,24%", "", "");
	talents[336].Info[3] = new TalentInfo(4, "12%,32%", "", "");
	talents[336].Info[4] = new TalentInfo(5, "15%,40%", "", "");
}


if (currentClass == classLst[6]) {
	talents[262] = new Talent( "����", "Ԫ��", 1, 2, "Spell_Nature_WispSplode.png", "", "", "ʹ������������������������������ĵķ���ֵ���� {0}��", new Array(), new Array());
	
	talents[263] = new Talent( "��", "Ԫ��", 1, 3, "Spell_Fire_Fireball.png", "", "", "ʹ�����������������������������ɵ��˺���� {0}��", new Array(), new Array());
	
	talents[264] = new Talent( "���֮��", "Ԫ��", 2, 1, "Spell_Nature_StoneClawTotem.png", "", "", "ʹ���ʯצͼ�ڵ�����ֵ��� {0}���ظ�ͼ�ڵ�Ӱ�췶Χ��� {1}��", new Array(), new Array());
	
	talents[265] = new Talent( "�����ٻ�", "Ԫ��", 2, 3, "Spell_Fire_Immolation.png", "", "", "ʹ��Ļ�ϵͼ��������ɵ��˺���� {0}��", new Array(), new Array());
	
	talents[266] = new Talent( "Ԫ�ط���", "Ԫ��", 2, 2, "elementalwarding.png", "", "", "ʹ�����ܵ����桢��˪����Ȼϵ��������ʱ���ܵ����˺������� {0}��", new Array(), new Array());
	
	talents[596] = new Talent( "Ԫ�ؼ���", "Ԫ��", 3, 1, "Spell_Shadow_ManaBurn.png", "", "", "ʹ����10%�ļ�����ʩ���κλ��桢��˪����Ȼϵ���˺��Է���֮��������ʩ��״̬�����״̬����ʹ�����һ���˺��Է��������ĵķ���ֵ����100%��", new Array(), new Array());
	
	talents[269] = new Talent( "����", "Ԫ��", 3, 2, "Spell_Frost_FrostWard.png", "", "", "ʹ��������������ȴʱ����� {0}��", new Array(), new Array());
	
	talents[268] = new Talent( "�����ٻ�", "Ԫ��", 3, 3, "Spell_Nature_CallStorm.png", "", "", "ʹ���������������������������һ���ļ������ {0}��", new Array(), new Array());
	
	talents[271] = new Talent( "ǿ������ͼ��", "Ԫ��", 4, 1, "Spell_Fire_SealOfFire.png", "", "", "ʹ��Ļ�������ͼ�ڼ���������ӳ�ʱ����� {0}������ͼ������ɵ���вֵ���� {1}��", new Array(), new Array());
	
	talents[267] = new Talent( "�籩֮��", "Ԫ��", 4, 2, "eyeofthestorm.png", "", "", "ʹ���� {0} �ļ������ܵ���ս��Զ������һ��֮���ó���6���רעʩ��Ч�����ڴ��ڼ䣬�㲻����Ϊ�ܵ��˺����ӳ�ʩ��ʱ�䡣", new Array(), new Array());
	
	talents[273] = new Talent( "�籩����", "Ԫ��", 5, 1, "stormreach.png", "", "", "ʹ����������������������ӳ� {0}��", new Array(), new Array());
	
	talents[597] = new Talent( "Ԫ�غƽ�", "Ԫ��", 4, 4, "elementaldevastation.png", "", "", "ʹ��Ĺ����Է������������һ��������Ľ�ս����������һ������� {0}������10�롣", new Array(), new Array());
	
	talents[272] = new Talent( "Ԫ��֮ŭ", "Ԫ��", 5, 2, "Spell_Fire_Volcano.png", "", "", "ʹ��Ļ��桢��˪����Ȼ����������һ���˺��ӳ����100%��", new Array(), new Array());
	
	talents[275] = new Talent( "��������", "Ԫ��", 6, 3, "Spell_Lightning_LightningBolt01.png", "", "", "ʹ������������������ʩ��ʱ����� {0}��", new Array(), new Array(new TalentRequirement(268, 5)));
	
	talents[598] = new Talent( "Ԫ������", "Ԫ��", 7, 2, "Spell_Nature_WispHeal.png", "", "˲��<br>3������ȴʱ��<br>", "����֮��ʹ�����һ���˺��ԵĻ��桢��˪����Ȼ������100%�ļ����������һ�����ҷ���ֵ���Ľ���100%��", new Array(), new Array(new TalentRequirement(272, 1)));
	
	talents[292] = new Talent( "����ר��", "��ǿ", 1, 3, "INV_Shield_06.png", "", "", "ʹ���ö��Ƹ񵲹����ļ������ {0}���񵲳ɹ�����������˺������ {1}��", new Array(), new Array());
	
	talents[293] = new Talent( "�ػ�ͼ��", "��ǿ", 2, 1, "Spell_Nature_StoneSkinTotem.png", "", "", "ʹ���ʯ��ͼ�ںͷ�ǽͼ���������յ��˺���� {0}������ͼ�ڵ���ȴʱ����� {1}��", new Array(), new Array());
	
	talents[297] = new Talent( "ǿ��ͼ��", "��ǿ", 3, 1, "Spell_Nature_EarthBindTotem.png", "", "", "ʹ��Ĵ��֮��ͼ�ںͷ�֮����ͼ�ڵ�Ч����� {0}��", new Array(), new Array());
	
	talents[610] = new Talent( "����", "��ǿ", 4, 3, "Spell_Holy_Devotion.png", "", "", "ʹ����װ������õĻ���ֵ���{0}��", new Array(), new Array());
	
	talents[299] = new Talent( "����", "��ǿ", 4, 2, "Ability_GhoulFrenzy.png", "", "", "����������һ��֮��ʹ�����3�ν�ս�����ٶ���� {0}��", new Array(), new Array(new TalentRequirement(294, 5)));
	
	talents[607] = new Talent( "ǿ������ͼ��", "��ǿ", 5, 1, "INV_Axe_02.png", "", "", "ʹ��ķ�ŭͼ�����ṩ�Ľ�ս����ǿ�ȼӳ���� {0}������ͼ������ɵ��˺���� {1}��", new Array(), new Array());
	
	talents[608] = new Talent( "Ԫ������", "��ǿ", 5, 2, "Spell_Fire_FlameTounge.png", "", "", "ʹ���ʯ���������ṩ�Ľ�ս����ǿ�ȼӳ���� {0}����ŭ�������ṩ�Ľ�ս����ǿ�ȼӳ���� {1}�����������ͱ�����������ɵ��˺���� {2}��", new Array(), new Array());
	
	talents[609] = new Talent( "�м�", "��ǿ", 5, 3, "Ability_Parry.png", "", "", "��һ�������мܵ��˵Ľ�ս������", new Array(), new Array());
	
	talents[303] = new Talent( "��������", "��ǿ", 6, 3, "Ability_Hunter_SwiftStrike.png", "", "", "ʹ��������������ɵ��˺������{0}��", new Array(), new Array());
	
	talents[296] = new Talent( "ǿ������֮��", "��ǿ", 2, 4, "Spell_Nature_LightningShield.png", "", "", "ʹ�������֮�ܷ�������ɵ��˺���� {0}��", new Array(), new Array());
	
	talents[294] = new Talent( "�����ͻ�", "��ǿ", 2, 2, "Ability_ThunderBolt.png", "", "", "ʹ�������������һ���ļ������ {0}��", new Array(), new Array());
	
	talents[291] = new Talent( "����֪ʶ", "��ǿ", 1, 2, "Spell_Shadow_GrimWard.png", "", "", "ʹ��ķ���ֵ������� {0}��", new Array(), new Array());
	
	talents[295] = new Talent( "ǿ������֮��", "��ǿ", 2, 3, "Spell_Nature_SpiritWolf.png", "", "", "ʹ����Ļ�֮�Ƿ�����ʩ��ʱ�����{0}��", new Array(), new Array());
	
	talents[612] = new Talent( "�籩���", "��ǿ", 7, 2, "Spell_Holy_SealOfMight.png", "", "204�㷨��ֵ<br>˲������<br>20 ����ȴʱ��<br>9����Ч����<br>", "ʹ����һ�ζ���Ĺ������ᡣ���⣬�����2�ι����Ե�����ɵ���Ȼ�˺����20%������12�롣", new Array(), new Array(new TalentRequirement(608, 3)));
	
	talents[606] = new Talent( "Ԥ֪", "��ǿ", 3, 4, "Spell_Nature_MirrorImage.png", "", "", "ʹ��Ķ���������� {0}��", new Array(), new Array());
	
	talents[605] = new Talent( "˫�ָ��ʹ�", "��ǿ", 3, 3, "INV_Axe_10.png", "", "", "ʹ�����ʹ��˫�ָ���˫�ִ���", new Array(), new Array());
	
	talents[599] = new Talent( "��ϫ����", "�ָ�", 1, 3, "Spell_Frost_ManaRecharge.png", "", "", "ʹ������Ʒ��������ĵķ���ֵ����{0}��", new Array(), new Array());
	
	talents[277] = new Talent( "ǿ�����Ʋ�", "�ָ�", 1, 2, "Spell_Nature_ResistMagic.png", "", "", "ʹ������Ʋ���ʩ��ʱ����� {0}��", new Array(), new Array());
	
	talents[778] = new Talent( "ǿ������", "�ָ�", 2, 1, "Spell_Nature_Reincarnation.png", "", "", "ʹ��ĸ�����������ȴʱ����� {0}����ʹ��������������õ�����ֵ�ͷ���ֵ��� {1}��", new Array(), new Array());
	
	talents[280] = new Talent( "��������", "�ָ�", 2, 2, "Spell_Nature_UndyingStrength.png", "", "", "������κ�һ�����Ʒ�����Ŀ����ɼ�Ч����Ч����ʹĿ����װ������õĻ���ֵ��� {0}������15�롣", new Array(), new Array());
	
	talents[600] = new Talent( "ͼ�ڼ���", "�ָ�", 2, 3, "Spell_Nature_MoonGlow.png", "", "", "ʹ��ʩ��ͼ�������ĵķ���ֵ���� {0}��", new Array(), new Array());
	
	talents[601] = new Talent( "��Ȼָ��", "�ָ�", 3, 1, "Spell_Frost_Stun.png", "", "", "ʹ��ķ����ͽ�ս��������Ŀ��ļ������ {0}��", new Array(), new Array());
	
	talents[283] = new Talent( "����רע", "�ָ�", 3, 2, "Spell_Nature_HealingWaveLesser.png", "", "", "ʹ����ʩ���������Ʒ�����ʱ���� {0} �ļ��ʱ������ܵ��˺�������ϡ�", new Array(), new Array());
	
	talents[282] = new Talent( "ͼ������", "�ָ�", 3, 3, "Spell_Nature_NullWard.png", "", "", "ʹ���ͼ�ڶ��ѷ�Ŀ���Ӱ��뾶�ӳ� {0}��", new Array(), new Array());
	
	talents[777] = new Talent( "����֮��", "�ָ�", 3, 4, "Spell_Nature_HealingTouch.png", "", "", "ʹ����������Ʒ�������ɵ���вֵ���� {0}��", new Array(), new Array());
	
	talents[287] = new Talent( "�ָ�ͼ��", "�ָ�", 4, 2, "Spell_Nature_ManaRegenTotem.png", "", "", "ʹ��ķ���֮Ȫͼ�ں�����֮Ȫͼ�ڵ�Ч����� {0}��", new Array(), new Array());
	
	talents[779] = new Talent( "����֮��ͼ��", "�ָ�", 7, 2, "Spell_Frost_SummonWaterElemental.png", "", "20 ����ֵ<br>˲������<br>5 ������ȴʱ��<br>����: ˮ֮ͼ��[Water Totem]<br>", "��ʩ��������ٻ�һ������ֵΪ5��ķ���֮��ͼ�ڣ�����12�롣������Ϊ�뾶20�뷶Χ�ڵ�С�ӳ�Աÿ3��ظ�170�㷨��ֵ��<br><br>Rank 2: 40�㷨��ֵ���ظ�230�㷨��ֵ<br>Rank 3: 60�㷨��ֵ���ظ�290�㷨��ֵ", new Array(), new Array(new TalentRequirement(287, 5)));
	
	talents[603] = new Talent( "��ȻѸ��", "�ָ�", 5, 3, "Spell_Nature_RavenForm.png", "", "˲������<br>3������ȴʱ��<br>", "����֮�������һ��ʩ��ʱ����10��֮�ڵ���Ȼ�������Ϊ˲��������", new Array(), new Array());
	
	talents[613] = new Talent( "����", "�ָ�", 6, 3, "Spell_Frost_WizardMark.png", "", "", "ʹ������Ʒ�����Ч����� {0}��", new Array(), new Array());
	
	talents[602] = new Talent( "��ϫ����", "�ָ�", 4, 3, "Spell_Nature_Tranquility.png", "", "", "ʹ������Ʒ���������Ч���Ƶ�Ч�������編���������һ����Ч�����{0}��", new Array(), new Array());
	
	talents[309] = new Talent( "����֮��", "�ָ�", 5, 1, "healingway.png", "", "", "������Ʋ��� {0} �ļ��������Ŀ�����Ժ�����Ʋ���ö��������Ч�������Ч��ʹĿ�����ܵ������Ʋ�����Ч�����6%������15�룬���ɵ���3�Ρ�", new Array(), new Array());
	
	talents[265].Info[0] = new TalentInfo(1, "5%", "", "");
	talents[265].Info[1] = new TalentInfo(2, "10%", "", "");
	talents[265].Info[2] = new TalentInfo(3, "15%", "", "");
	talents[268].Info[0] = new TalentInfo(1, "1%", "", "");
	talents[268].Info[1] = new TalentInfo(2, "2%", "", "");
	talents[268].Info[2] = new TalentInfo(3, "3%", "", "");
	talents[268].Info[3] = new TalentInfo(4, "4%", "", "");
	talents[268].Info[4] = new TalentInfo(5, "6%", "", "");
	talents[262].Info[0] = new TalentInfo(1, "2%", "", "");
	talents[262].Info[1] = new TalentInfo(2, "4%", "", "");
	talents[262].Info[2] = new TalentInfo(3, "6%", "", "");
	talents[262].Info[3] = new TalentInfo(4, "8%", "", "");
	talents[262].Info[4] = new TalentInfo(5, "10%", "", "");
	talents[263].Info[0] = new TalentInfo(1, "1%", "", "");
	talents[263].Info[1] = new TalentInfo(2, "2%", "", "");
	talents[263].Info[2] = new TalentInfo(3, "3%", "", "");
	talents[263].Info[3] = new TalentInfo(4, "4%", "", "");
	talents[263].Info[4] = new TalentInfo(5, "5%", "", "");
	talents[264].Info[0] = new TalentInfo(1, "25%,10%", "", "");
	talents[264].Info[1] = new TalentInfo(2, "50%,20%", "", "");
	talents[266].Info[0] = new TalentInfo(1, "4%", "", "");
	talents[266].Info[1] = new TalentInfo(2, "7%", "", "");
	talents[266].Info[2] = new TalentInfo(3, "10%", "", "");
	talents[267].Info[0] = new TalentInfo(1, "33%", "", "");
	talents[267].Info[1] = new TalentInfo(2, "66%", "", "");
	talents[267].Info[2] = new TalentInfo(3, "100%", "", "");
	talents[269].Info[0] = new TalentInfo(1, "0.2 ��", "", "");
	talents[269].Info[1] = new TalentInfo(2, "0.4 ��", "", "");
	talents[269].Info[2] = new TalentInfo(3, "0.6 ��", "", "");
	talents[269].Info[3] = new TalentInfo(4, "0.8 ��", "", "");
	talents[269].Info[4] = new TalentInfo(5, "1 ��", "", "");
	talents[271].Info[0] = new TalentInfo(1, "1��,25%", "", "");
	talents[271].Info[1] = new TalentInfo(2, "2��,50%", "", "");
	talents[272].Info[0] = new TalentInfo(1, "", "", "");
	talents[273].Info[0] = new TalentInfo(1, "3��", "", "");
	talents[273].Info[1] = new TalentInfo(2, "6��", "", "");
	talents[275].Info[0] = new TalentInfo(1, "0.2��", "", "");
	talents[275].Info[1] = new TalentInfo(2, "0.4��", "", "");
	talents[275].Info[2] = new TalentInfo(3, "0.6��", "", "");
	talents[275].Info[3] = new TalentInfo(4, "0.8��", "", "");
	talents[275].Info[4] = new TalentInfo(5, "1��", "", "");
	talents[277].Info[0] = new TalentInfo(1, "0.1 ��", "", "");
	talents[277].Info[1] = new TalentInfo(2, "0.2 ��", "", "");
	talents[277].Info[2] = new TalentInfo(3, "0.3 ��", "", "");
	talents[277].Info[3] = new TalentInfo(4, "0.4 ��", "", "");
	talents[277].Info[4] = new TalentInfo(5, "0.5 ��", "", "");
	talents[280].Info[0] = new TalentInfo(1, "8%", "",  "");
	talents[280].Info[1] = new TalentInfo(2, "16%", "", "");
	talents[280].Info[2] = new TalentInfo(3, "25%", "", "");
	talents[282].Info[0] = new TalentInfo(1, "5 ��", "", "");
	talents[283].Info[0] = new TalentInfo(1, "14%", "", "");
	talents[283].Info[1] = new TalentInfo(2, "28%", "", "");
	talents[283].Info[2] = new TalentInfo(3, "42%", "", "");
	talents[283].Info[3] = new TalentInfo(4, "56%", "", "");
	talents[283].Info[4] = new TalentInfo(5, "70%", "", "");
	talents[287].Info[0] = new TalentInfo(1, "5%", "", "");
	talents[287].Info[1] = new TalentInfo(2, "10%", "", "");
	talents[287].Info[2] = new TalentInfo(3, "15%", "", "");
	talents[287].Info[3] = new TalentInfo(4, "20%", "", "");
	talents[287].Info[4] = new TalentInfo(5, "25%", "", "");
	talents[291].Info[0] = new TalentInfo(1, "1%", "", "");
	talents[291].Info[1] = new TalentInfo(2, "2%", "", "");
	talents[291].Info[2] = new TalentInfo(3, "3%", "", "");
	talents[291].Info[3] = new TalentInfo(4, "4%", "", "");
	talents[291].Info[4] = new TalentInfo(5, "5%", "", "");
	talents[292].Info[0] = new TalentInfo(1, "1%,5%", "", "");
	talents[292].Info[1] = new TalentInfo(2, "2%,10%", "", "");
	talents[292].Info[2] = new TalentInfo(3, "3%,15%", "", "");
	talents[292].Info[3] = new TalentInfo(4, "4%,20%", "", "");
	talents[292].Info[4] = new TalentInfo(5, "5%,25%", "", "");
	talents[293].Info[0] = new TalentInfo(1, "10%,1��", "", "");
	talents[293].Info[1] = new TalentInfo(2, "20%,2��", "", "");
	talents[296].Info[0] = new TalentInfo(1, "5%", "", "");
	talents[296].Info[1] = new TalentInfo(2, "10%", "", "");
	talents[296].Info[2] = new TalentInfo(3, "15%", "", "");
	talents[297].Info[0] = new TalentInfo(1, "8%", "", "");
	talents[297].Info[1] = new TalentInfo(2, "15%", "", "");
	talents[295].Info[0] = new TalentInfo(1, "1 ��", "", "");
	talents[295].Info[1] = new TalentInfo(2, "2 ��", "", "");
	talents[299].Info[0] = new TalentInfo(1, "10%", "", "");
	talents[299].Info[1] = new TalentInfo(2, "15%", "", "");
	talents[299].Info[2] = new TalentInfo(3, "20%", "", "");
	talents[299].Info[3] = new TalentInfo(4, "25%", "", "");
	talents[299].Info[4] = new TalentInfo(5, "30%", "", "");
	talents[303].Info[0] = new TalentInfo(1, "2%", "", "");
	talents[303].Info[1] = new TalentInfo(2, "4%", "", "");
	talents[303].Info[2] = new TalentInfo(3, "6%", "", "");
	talents[303].Info[3] = new TalentInfo(4, "8%", "", "");
	talents[303].Info[4] = new TalentInfo(5, "10%", "", "");
	talents[309].Info[0] = new TalentInfo(1, "33%", "", "");
	talents[309].Info[1] = new TalentInfo(2, "66%", "", "");
	talents[309].Info[2] = new TalentInfo(3, "100%", "", "");
	talents[596].Info[0] = new TalentInfo(1, "10%", "", "");
	talents[598].Info[0] = new TalentInfo(1, "", "", "");
	talents[601].Info[0] = new TalentInfo(1, "1%", "", "");
	talents[601].Info[1] = new TalentInfo(2, "2%", "", "");
	talents[601].Info[2] = new TalentInfo(3, "3%", "", "");
	talents[606].Info[0] = new TalentInfo(1, "1%", "", "");
	talents[606].Info[1] = new TalentInfo(2, "2%", "", "");
	talents[606].Info[2] = new TalentInfo(3, "3%", "", "");
	talents[606].Info[3] = new TalentInfo(4, "4%", "", "");
	talents[606].Info[4] = new TalentInfo(5, "5%", "", "");
	talents[608].Info[0] = new TalentInfo(1, "7%,13%,5%", "", "");
	talents[608].Info[1] = new TalentInfo(2, "14%,27%,10%", "", "");
	talents[608].Info[2] = new TalentInfo(3, "20%,40%,15%", "", "");
	talents[777].Info[0] = new TalentInfo(1, "5%", "", "");
	talents[777].Info[1] = new TalentInfo(2, "10%", "", "");
	talents[777].Info[2] = new TalentInfo(3, "15%", "", "");
	talents[607].Info[0] = new TalentInfo(1, "15%,6%", "", "");
	talents[607].Info[1] = new TalentInfo(2, "30%,12%", "", "");
	talents[778].Info[0] = new TalentInfo(1, "10����,10%", "", "");
	talents[778].Info[1] = new TalentInfo(2, "20����,20%", "", "");
	talents[597].Info[0] = new TalentInfo(1, "3%", "", "");
	talents[597].Info[1] = new TalentInfo(2, "6%", "", "");
	talents[597].Info[2] = new TalentInfo(3, "9%", "", "");
	talents[779].Info[0] = new TalentInfo(1, "", "", "");
	talents[603].Info[0] = new TalentInfo(1, "", "", "");
	talents[609].Info[0] = new TalentInfo(1, "", "", "");
	talents[613].Info[0] = new TalentInfo(1, "2%", "", "");
	talents[613].Info[1] = new TalentInfo(2, "4%", "", "");
	talents[613].Info[2] = new TalentInfo(3, "6%", "", "");
	talents[613].Info[3] = new TalentInfo(4, "8%", "", "");
	talents[613].Info[4] = new TalentInfo(5, "10%", "", "");
	talents[612].Info[0] = new TalentInfo(1, "", "", "");
	talents[294].Info[0] = new TalentInfo(1, "1%", "", "");
	talents[294].Info[1] = new TalentInfo(2, "2%", "", "");
	talents[294].Info[2] = new TalentInfo(3, "3%", "", "");
	talents[294].Info[3] = new TalentInfo(4, "4%", "", "");
	talents[294].Info[4] = new TalentInfo(5, "5%", "", "");
	talents[599].Info[0] = new TalentInfo(1, "1%", "", "");
	talents[599].Info[1] = new TalentInfo(2, "2%", "", "");
	talents[599].Info[2] = new TalentInfo(3, "3%", "", "");
	talents[599].Info[3] = new TalentInfo(4, "4%", "", "");
	talents[599].Info[4] = new TalentInfo(5, "5%", "", "");
	talents[602].Info[0] = new TalentInfo(1, "1%", "", "");
	talents[602].Info[1] = new TalentInfo(2, "2%", "", "");
	talents[602].Info[2] = new TalentInfo(3, "3%", "", "");
	talents[602].Info[3] = new TalentInfo(4, "4%", "", "");
	talents[602].Info[4] = new TalentInfo(5, "5%", "", "");
	talents[600].Info[0] = new TalentInfo(1, "5%", "", "");
	talents[600].Info[1] = new TalentInfo(2, "10%", "", "");
	talents[600].Info[2] = new TalentInfo(3, "15%", "", "");
	talents[600].Info[3] = new TalentInfo(4, "20%", "", "");
	talents[600].Info[4] = new TalentInfo(5, "25%", "", "");
	talents[610].Info[0] = new TalentInfo(1, "2%", "", "");
	talents[610].Info[1] = new TalentInfo(2, "4%", "", "");
	talents[610].Info[2] = new TalentInfo(3, "6%", "", "");
	talents[610].Info[3] = new TalentInfo(4, "8%", "", "");
	talents[610].Info[4] = new TalentInfo(5, "10%", "", "");
	talents[605].Info[0] = new TalentInfo(1, "", "", "");


//----8<-------------------------------------------[


}
if (currentClass == classLst[7]) {
	talents[428] = new Talent( "����", "����", 2, 3, "Spell_Fire_Fire.png", "", "", "ʹ��Ļ���ϵ������{0}�ļ�����Ŀ��ѣ��5�롣", new Array(), new Array());
	talents[790] = new Talent( "��������", "ʹ��", 3, 3, "Spell_Shadow_Contagion.png", "", "˲��<br>3������ȴʱ��", "ʹ�����һ�����������ʹ�������Ч�����50%����ʹ�����һ��ƣ�������Ч�����20%��", new Array(), new Array());
	talents[429] = new Talent( "�ֻ�", "����", 2, 2, "Spell_Shadow_DeathPact.png", "", "", "ʹ��ĵ������桢��Ӱ�����׼���ʩ��ʱ����� {0}�����֮���ʩ��ʱ����� {1}��", new Array(), new Array());
	talents[427] = new Talent( "�ֱ�", "����", 1, 3, "Spell_Fire_WindsofWoe.png", "", "", "ʹ��Ļ���ϵ���������ĵķ���ֵ����{0}��", new Array(), new Array());
	talents[797] = new Talent( "ȼ��", "����", 7, 2, "Spell_Fire_Fireball.png", "", "165 ����ֵ<br>˲������<br>10����ȴʱ��<br>30����Ч����<br>", "��ȼһ���Ѿ��ܵ��׼�Ч��Ӱ���Ŀ�꣬�������240��306������˺����������׼�������Ч����<br><br>�ȼ�2��200�㷨�����ģ�316��396������˺�����Ҫ�ȼ�48��<br>�ȼ�3��230�㷨�����ģ�383��479������˺�����Ҫ�ȼ�54��<br>�ȼ�4��255�㷨�����ģ�447��557������˺�����Ҫ�ȼ�60��", new Array(), new Array(new TalentRequirement(438, 5)));
	talents[791] = new Talent( "ƣ������", "ʹ��", 5, 3, "Spell_Shadow_GrimWard.png", "", "108�㷨��ֵ<br>˲������<br>30����Ч����<br>", "ʹĿ����ٶȽ��͵���ͨ�ٶȵ�90%������12�롣ÿ����ʿֻ�ܶ�һ��Ŀ��ʩ��һ�����䣬��ͬ�����䲻�ܵ��ӡ�", new Array(), new Array(new TalentRequirement(790, 1)));
	talents[793] = new Talent( "�ڰ���Լ", "ʹ��", 7, 2, "Spell_Shadow_DarkRitual.png", "", "˲��<br>20����Ч����<br>", "����ĳ������ϳ�ȡ150�㷨��ֵ��ȫ��ת�����㡣<br><br>�ȼ�50��200�㷨��ֵ<br>�ȼ�60��250�㷨��ֵ", new Array(), new Array());
	talents[498] = new Talent( "��ħ֮ӵ", "��ħѧʶ", 1, 3, "Spell_Shadow_Metamorphosis.png", "", "", "ʹ����������{0}��ͬʱʹ��ľ��񽵵�{1}��", new Array(), new Array());
	talents[508] = new Talent( "��ħ����", "��ħѧʶ", 5, 2, "Spell_Shadow_PsychicScream.png", "", "˲��<br>100����Ч����<br>", "����֮�������㵱ǰ���ٻ��Ķ�ħ��ʹ����һ������Ч��������30���ӡ�����ڴ��ڼ����ٻ�����һ����ħ����Ч���ͻᱻȡ����<br><br>С��ʹ��Ļ��漼���˺����15%��<br><br>������ߣ�ʹ��ÿ4��ظ�3%������ֵ��<br>��ħ��ʹ��İ�Ӱ�����˺����15%��<br>����Ȯ��ʹ��ÿ4��ظ�2%�ķ���ֵ��", new Array(), new Array());
	talents[514] = new Talent( "��������", "����", 4, 2, "Spell_Shadow_CorpseExplode.png", "", "", "ʹ��Ļ���ϵ�������������{0}��", new Array(), new Array());
	talents[431] = new Talent( "�ƻ�", "����", 3, 3, "Spell_Fire_FlameShock.png", "", "", "ʹ��Ļ���ϵ����������һ��������� {0}", new Array(), new Array());
	talents[444] = new Talent( "��ħרע", "ʹ��", 3, 2, "Spell_Shadow_FingerOfDeath.png", "", "", "ʹ����{0}�ļ�����ʩ����ȡ��������ȡ��������ȡ��귨��ʱ�������ܵ��˺�������ϡ�", new Array(), new Array());
	talents[503] = new Talent( "��ħ֧��", "��ħѧʶ", 3, 2, "Spell_Nature_RemoveCurse.png", "", "˲��<br>15������ȴʱ��", "�����һ���ٻ�С��������ߡ���ħ�������Ȯ�ķ���ʩ��ʱ�����5.5�룬�������ļ���50%��", new Array(), new Array());
	talents[501] = new Talent( "��ħ�ǻ�", "��ħѧʶ", 2, 3, "Spell_Holy_MagicalSentry.png", "", "", "ʹ���С��������ߡ���ħ�͵�����Ȯ�ķ���ֵ�������{0}��", new Array(), new Array());
	talents[504] = new Talent( "��ħ����", "��ħѧʶ", 3, 3, "Spell_Shadow_AntiShadow.png", "", "", "ʹ���С��������ߡ���ħ�͵�����Ȯ������ֵ�������{0}��", new Array(), new Array());
	talents[446] = new Talent( "��������", "ʹ��", 4, 1, "Spell_Shadow_CallofBone.png", "", "", "ʹ���ʹ��ϵ����������ӳ�{0}��", new Array(), new Array());
	talents[440] = new Talent( "ǿ����ʴ��", "ʹ��", 1, 3, "Spell_Shadow_AbominationExplosion.png", "", "", "ʹ��ĸ���������ʩ��ʱ�����{0}��", new Array(), new Array());
	talents[517] = new Talent( "ǿ��ʹ������", "ʹ��", 3, 1, "Spell_Shadow_CurseOfSargeras.png", "", "", "ʹ���ʹ����������ɵ��˺����{0}��", new Array(), new Array());
	talents[792] = new Talent( "ǿ��ƣ������", "ʹ��", 5, 4, "Spell_Shadow_GrimWard.png", "", "", "ʹ���ƣ������ļ���Ч�����{0}��", new Array(), new Array(new TalentRequirement(791, 1)));
	talents[515] = new Talent( "ǿ����������", "ʹ��", 2, 1, "Spell_Shadow_CurseOfMannoroth.png", "", "", "ʹ������������Ч�����{0}��", new Array(), new Array());
	talents[442] = new Talent( "ǿ����ȡ����", "ʹ��", 2, 4, "Spell_Shadow_LifeDrain02.png", "", "", "ʹ�����ȡ������������ȡ������ֵ���{0}��", new Array(), new Array());
	talents[520] = new Talent( "ǿ����ȡ����", "ʹ��", 4, 4, "Spell_Shadow_SiphonMana.png", "", "", "ʹ�����ȡ������������ȡ�ķ���ֵ��{0}��Ŀ����ɵ����˺���", new Array(), new Array());
	talents[516] = new Talent( "ǿ����ȡ���", "ʹ��", 2, 2, "Spell_Shadow_Haunting.png", "", "", "��Ŀ�����������ȡ��������ʱ������{0}�ļ��ʻ��100%�ķ���ֵ�ظ��ٶȼӳɣ�����10�롣�ڴ��ڼ䣬����ʩ��ʱҲ�ɱ���50%�ķ���ֵ�ظ��ٶȡ�", new Array(), new Array());
	talents[507] = new Talent( "ǿ��ū�۶�ħ", "��ħѧʶ", 5, 1, "Spell_Shadow_UnsummonBuilding.png", "", "", "ʹ���ū�۶�ħ�����Ĺ����ٶȺ�ʩ���ٶȳͷ�����{0}����ħ�ֿ�ū��Ч���ļ��ʽ���{1}", new Array(), new Array());
	talents[433] = new Talent( "ǿ�������", "����", 3, 1, "Spell_Fire_FireBolt.png", "", "", "ʹС��Ļ������ʩ��ʱ�����{0}��", new Array(), new Array());
	talents[509] = new Talent( "ǿ������ʯ", "��ħѧʶ", 5, 4, "INV_Ammo_FireTar.png", "", "", "ʹ��Ļ���ʯ��Ч�����˺��ӳ����{0}��", new Array(), new Array());
	talents[499] = new Talent( "ǿ������ͨ��", "��ħѧʶ", 2, 1, "Spell_Shadow_LifeDrain.png", "", "", "ʹ�������ͨ��������ת��������ֵ���{0}��", new Array(), new Array());
	talents[496] = new Talent( "ǿ������ʯ", "��ħѧʶ", 1, 1, "INV_Stone_04.png", "", "", "ʹ�������ʯ���ָ�������ֵ����{0}��", new Array(), new Array());
	talents[438] = new Talent( "ǿ���׼�", "����", 5, 2, "Spell_Fire_Immolation.png", "", "", "ʹ����׼������ĳ�ʼ�˺����{0}��", new Array(), new Array());
	talents[497] = new Talent( "ǿ��С��", "��ħѧʶ", 1, 2, "Spell_Shadow_SummonImp.png", "", "", "ʹС��Ļ����������֮�ܺ�Ѫ֮��ӡ��Ч�����{0}��", new Array(), new Array());
	talents[432] = new Talent( "ǿ����ʹ����", "����", 3, 2, "Spell_Holy_RemoveCurse.png", "", "", "ʹ��ħ�ľ�ʹ���׵���ȴʱ�����{0}��", new Array(), new Array());
	talents[443] = new Talent( "ǿ����������", "ʹ��", 2, 3, "Spell_Shadow_BurningSpirit.png", "", "", "ʹ�����������������ת���ķ���ֵ���{0}��", new Array(), new Array());
	talents[434] = new Talent( "ǿ������֮ʹ", "����", 4, 4, "Spell_Fire_SoulBurn.png", "", "", "ʹ�������֮ʹ�������һ���ļ������{0}��", new Array(), new Array());
	talents[426] = new Talent( "ǿ����Ӱ��", "����", 1, 2, "Spell_Shadow_ShadowBolt.png", "", "", "����İ�Ӱ����Ŀ���������һ�����������ɵĽ���4�ΰ�Ӱ�˺�������� {0}��<br>Ч��������12�롣", new Array(), new Array());
	talents[512] = new Talent( "ǿ������ʯ", "��ħѧʶ", 7, 3, "INV_Misc_Gem_Sapphire_01.png", "", "", "ʹ��ķ���ʯ�������յ��˺��������{0}��", new Array(), new Array());
	talents[502] = new Talent( "ǿ����ħ", "��ħѧʶ", 3, 1, "Spell_Shadow_SummonSuccubus.png", "", "", "ʹ�����ħ�ľ�ʹ���׺Ͱ���֮�Ƿ�����Ч�����{0}����ʹ�����ħ���ջ�ʹμ��������ĳ���ʱ���ӳ�{1}��", new Array(), new Array());
	talents[500] = new Talent( "ǿ���������", "��ħѧʶ", 2, 2, "Spell_Shadow_SummonVoidWalker.png", "", "", "ʹ���������ߵ���ĥ�����ɰ�Ӱ�����������ѷ�����Ч�����{0}��", new Array(), new Array());
	talents[454] = new Talent( "����籩", "����", 6, 3, "Spell_Fire_SelfDestruct.png", "", "", "ʹ��Ļ��淨����ɵ��˺����{0}��", new Array(), new Array());
	talents[436] = new Talent( "ǿ��", "����", 4, 1, "Spell_Fire_LavaSpawn.png", "", "", "ʹ����{0}�ļ�����ʩ�Ż���֮���������淨��ʱ�������ܵ��˺�������ϡ�", new Array(), new Array());
	talents[506] = new Talent( "а��ǿ��", "��ħѧʶ", 4, 3, "Spell_Shadow_ShadowWordDominate.png", "", "", "ʹ���������ߡ���ħ�͵�����Ȯ�Ľ�ս�˺����{0}��", new Array(), new Array());
	talents[505] = new Talent( "�ٻ���ʦ", "��ħѧʶ", 4, 2, "Spell_Shadow_ImpPhaseShift.png", "", "", "ʹ���ٻ�С��������ߡ���ħ�͵�����Ȯ��ʩ��ʱ�����{0}������ֵ���Ľ���{1}", new Array(), new Array(new TalentRequirement(503, 1)));
	talents[519] = new Talent( "ҹĻ", "ʹ��", 4, 2, "Spell_Shadow_Twilight.png", "", "", "ʹ��ĸ�ʴ������ȡ����������{0}�ļ����ڶԵ�������˺�֮��������밵Ӱڤ˼״̬����Ӱڤ˼״�����������һ����Ӱ��������ʩ��ʱ�����100%��", new Array(), new Array());
	talents[439] = new Talent( "������", "����", 5, 1, "Spell_Fire_Volcano.png", "", "", "ʹ��Ļ���֮��͵������淨����{0}�ļ���ʹĿ�����3�롣", new Array(), new Array(new TalentRequirement(436, 2)));
	talents[796] = new Talent( "����", "����", 5, 3, "Spell_Shadow_ShadowWordPain.png", "", "", "ʹ��Ļ���ϵ����������һ���˺��ӳ����100%��", new Array(), new Array(new TalentRequirement(431, 5)));
	talents[524] = new Talent( "��Ӱ����", "ʹ��", 6, 2, "Spell_Shadow_ShadeTrueSight.png", "", "", "ʹ��İ�Ӱ��������ɵ��˺�����ȡ������ֵ���{0}��", new Array(), new Array(new TalentRequirement(521, 1)));
	talents[795] = new Talent( "��Ӱ����", "����", 3, 4, "Spell_Shadow_ScourgeBuild.png", "", "105 ����ֵ<br>˲������<br>15����ȴʱ��<br>20����Ч����<br><br>��Ҫ���ϣ������Ƭ<br>", "����ʹ�ð�Ӱ�������Ŀ�꣬�������91��104�㰵Ӱ�˺������Ŀ�����ڰ�Ӱ���գ���ʩ������˻�þ���ֵ����������ʩ���߻��һ�������Ƭ��", new Array(), new Array());
	talents[521] = new Talent( "��������", "ʹ��", 5, 2, "Spell_Shadow_Requiem.png", "", "150 ����ֵ<br>˲��<br>30����Ч����<br>", "ÿ 3 �뽫Ŀ��� 15 ������ֵת�Ƹ�ʩ���ߣ����� 30 �롣<br><br>�ȼ�38��ÿ 3 �� 22 ������<br>�ȼ�48��ÿ 3 �� 33 ������<br>�ȼ�58��ÿ 3 �� 45 ������", new Array(), new Array());
	talents[794] = new Talent( "�������", "��ħѧʶ", 7, 2, "Spell_Shadow_GatherShadows.png", "", "270����ֵ<br>˲��<br>100����Ч����<br>", "�����ʩ�����ܵ��˺���30%��ת�����ٻ������Ķ�ħ������⣬��ħ�����ʩ�������ܵ����˺�������3%����Ч��һֱ��������ħ������ʧ�Żᱻȡ����", new Array(), new Array(new TalentRequirement(508, 1)));
	talents[441] = new Talent( "��ѹ", "ʹ��", 1, 2, "Spell_Shadow_UnsummonBuilding.png", "", "", "ʹ���˵ֿ����ʹ��ϵ�����ļ��ʽ���{0}��", new Array(), new Array());
	talents[510] = new Talent( "��ħѧʶ��ʦ", "��ħѧʶ", 6, 3, "Spell_Shadow_ShadowPact.png", "", "", "ʹ��ʿ�������ٻ��Ķ�ħ�����һ������Ч����ֻҪ�ö�ħ���ڼ���״̬�Ͳ�����ʧ��<br>С�� - �Ե�����ɵ���в����{0}��<br>��������ܵ�������ʱ���ܵ��˺�����{1}��<br>��ħ�Ե�����ɵ������˺����{2}��<br>������Ȯ - ÿ�ȼ����п������{3}��<br>", new Array(), new Array(new TalentRequirement(506, 5)));
	talents[428].Info[0] = new TalentInfo(1, "2%", "", "");
	talents[428].Info[1] = new TalentInfo(2, "4%", "", "");
	talents[428].Info[2] = new TalentInfo(3, "6%", "", "");
	talents[428].Info[3] = new TalentInfo(4, "8%", "", "");
	talents[428].Info[4] = new TalentInfo(5, "10%", "", "");
	talents[790].Info[0] = new TalentInfo(1, "", "", "");
	talents[429].Info[0] = new TalentInfo(1, "0.1 ��,0.4 ��", "", "");
	talents[429].Info[1] = new TalentInfo(2, "0.2 ��,0.8 ��", "", "");
	talents[429].Info[2] = new TalentInfo(3, "0.3 ��,1.2 ��", "", "");
	talents[429].Info[3] = new TalentInfo(4, "0.4 ��,1.6 ��", "", "");
	talents[429].Info[4] = new TalentInfo(5, "0.5 ��,2.0 ��", "", "");
	talents[427].Info[0] = new TalentInfo(1, "1%", "", "");
	talents[427].Info[1] = new TalentInfo(2, "2%", "", "");
	talents[427].Info[2] = new TalentInfo(3, "3%", "", "");
	talents[427].Info[3] = new TalentInfo(4, "4%", "", "");
	talents[427].Info[4] = new TalentInfo(5, "5%", "", "");
	talents[797].Info[0] = new TalentInfo(1, "", "", "");
	talents[791].Info[0] = new TalentInfo(1, "", "", "");
	talents[793].Info[0] = new TalentInfo(1, "", "", "");
	talents[498].Info[0] = new TalentInfo(1, "3%, 1%", "", "");
	talents[498].Info[1] = new TalentInfo(2, "6%, 2%", "", "");
	talents[498].Info[2] = new TalentInfo(3, "9%, 3%", "", "");
	talents[498].Info[3] = new TalentInfo(4, "12%, 4%", "", "");
	talents[498].Info[4] = new TalentInfo(5, "15%, 5%", "", "");
	talents[508].Info[0] = new TalentInfo(1, "", "", "");
	talents[514].Info[0] = new TalentInfo(1, "10%", "", "");
	talents[514].Info[1] = new TalentInfo(2, "20%", "", "");
	talents[431].Info[0] = new TalentInfo(1, "1%", "", "");
	talents[431].Info[1] = new TalentInfo(2, "2%", "", "");
	talents[431].Info[2] = new TalentInfo(3, "3%", "", "");
	talents[431].Info[3] = new TalentInfo(4, "4%", "", "");
	talents[431].Info[4] = new TalentInfo(5, "5%", "", "");
	talents[444].Info[0] = new TalentInfo(1, "14%", "", "");
	talents[444].Info[1] = new TalentInfo(2, "28%", "", "");
	talents[444].Info[2] = new TalentInfo(3, "42%", "", "");
	talents[444].Info[3] = new TalentInfo(4, "56%", "", "");
	talents[444].Info[4] = new TalentInfo(5, "70%", "", "");
	talents[503].Info[0] = new TalentInfo(1, "5.5 ��, 50%", "", "");
	talents[501].Info[0] = new TalentInfo(1, "3%", "", "");
	talents[501].Info[1] = new TalentInfo(2, "6%", "", "");
	talents[501].Info[2] = new TalentInfo(3, "9%", "", "");
	talents[501].Info[3] = new TalentInfo(4, "12%", "", "");
	talents[501].Info[4] = new TalentInfo(5, "15%", "", "");
	talents[504].Info[0] = new TalentInfo(1, "3%", "", "");
	talents[504].Info[1] = new TalentInfo(2, "6%", "", "");
	talents[504].Info[2] = new TalentInfo(3, "9%", "", "");
	talents[504].Info[3] = new TalentInfo(4, "12%", "", "");
	talents[504].Info[4] = new TalentInfo(5, "15%", "", "");
	talents[446].Info[0] = new TalentInfo(1, "10%", "", "");
	talents[446].Info[1] = new TalentInfo(2, "20%", "", "");
	talents[440].Info[0] = new TalentInfo(1, "0.4 ��", "", "");
	talents[440].Info[1] = new TalentInfo(2, "0.8 ��", "", "");
	talents[440].Info[2] = new TalentInfo(3, "1.2 ��", "", "");
	talents[440].Info[3] = new TalentInfo(4, "1.6 ��", "", "");
	talents[440].Info[4] = new TalentInfo(5, "2 ��", "", "");
	talents[517].Info[0] = new TalentInfo(1, "2%", "", "");
	talents[517].Info[1] = new TalentInfo(2, "4%", "", "");
	talents[517].Info[2] = new TalentInfo(3, "6%", "", "");
	talents[792].Info[0] = new TalentInfo(1, "5%", "", "");
	talents[792].Info[1] = new TalentInfo(2, "10%", "", "");
	talents[792].Info[2] = new TalentInfo(3, "15%", "", "");
	talents[792].Info[3] = new TalentInfo(4, "20%", "", "");
	talents[515].Info[0] = new TalentInfo(1, "6%", "", "");
	talents[515].Info[1] = new TalentInfo(2, "13%", "", "");
	talents[515].Info[2] = new TalentInfo(3, "20%", "", "");
	talents[442].Info[0] = new TalentInfo(1, "2%", "", "");
	talents[442].Info[1] = new TalentInfo(2, "4%", "", "");
	talents[442].Info[2] = new TalentInfo(3, "6%", "", "");
	talents[442].Info[3] = new TalentInfo(4, "8%", "", "");
	talents[442].Info[4] = new TalentInfo(5, "10%", "", "");
	talents[520].Info[0] = new TalentInfo(1, "15%", "", "");
	talents[520].Info[1] = new TalentInfo(2, "30%", "", "");
	talents[516].Info[0] = new TalentInfo(1, "50%", "", "");
	talents[516].Info[1] = new TalentInfo(2, "100%", "", "");
	talents[507].Info[0] = new TalentInfo(1, "2%,2%", "", "");
	talents[507].Info[1] = new TalentInfo(2, "4%,4%", "", "");
	talents[507].Info[2] = new TalentInfo(3, "6%,6%", "", "");
	talents[507].Info[3] = new TalentInfo(4, "8%,8%", "", "");
	talents[507].Info[4] = new TalentInfo(5, "10%,10%", "", "");
	talents[433].Info[0] = new TalentInfo(1, "0.5 ��", "", "");
	talents[433].Info[1] = new TalentInfo(2, "1 ��", "", "");
	talents[509].Info[0] = new TalentInfo(1, "15%", "", "");
	talents[509].Info[1] = new TalentInfo(2, "30%", "", "");
	talents[499].Info[0] = new TalentInfo(1, "10%", "", "");
	talents[499].Info[1] = new TalentInfo(2, "20%", "", "");
	talents[496].Info[0] = new TalentInfo(1, "10%", "", "");
	talents[496].Info[1] = new TalentInfo(2, "20%", "", "");
	talents[438].Info[0] = new TalentInfo(1, "5%", "", "");
	talents[438].Info[1] = new TalentInfo(2, "10%", "", "");
	talents[438].Info[2] = new TalentInfo(3, "15%", "", "");
	talents[438].Info[3] = new TalentInfo(4, "20%", "", "");
	talents[438].Info[4] = new TalentInfo(5, "25%", "", "");
	talents[497].Info[0] = new TalentInfo(1, "10%", "", "");
	talents[497].Info[1] = new TalentInfo(2, "20%", "", "");
	talents[497].Info[2] = new TalentInfo(3, "30%", "", "");
	talents[432].Info[0] = new TalentInfo(1, "3 ��", "", "");
	talents[432].Info[1] = new TalentInfo(2, "6 ��", "", "");
	talents[443].Info[0] = new TalentInfo(1, "10%", "", "");
	talents[443].Info[1] = new TalentInfo(2, "20%", "", "");
	talents[434].Info[0] = new TalentInfo(1, "2%", "", "");
	talents[434].Info[1] = new TalentInfo(2, "4%", "", "");
	talents[434].Info[2] = new TalentInfo(3, "6%", "", "");
	talents[434].Info[3] = new TalentInfo(4, "8%", "", "");
	talents[434].Info[4] = new TalentInfo(5, "10%", "", "");
	talents[426].Info[0] = new TalentInfo(1, "4%", "", "");
	talents[426].Info[1] = new TalentInfo(2, "8%", "", "");
	talents[426].Info[2] = new TalentInfo(3, "12%", "", "");
	talents[426].Info[3] = new TalentInfo(4, "16%", "", "");
	talents[426].Info[4] = new TalentInfo(5, "20%", "", "");
	talents[512].Info[0] = new TalentInfo(1, "15%", "", "");
	talents[512].Info[1] = new TalentInfo(2, "30%", "", "");
	talents[502].Info[0] = new TalentInfo(1, "10%, 10%", "", "");
	talents[502].Info[1] = new TalentInfo(2, "20%, 20%", "", "");
	talents[502].Info[2] = new TalentInfo(3, "30%, 30%", "", "");
	talents[500].Info[0] = new TalentInfo(1, "10%", "", "");
	talents[500].Info[1] = new TalentInfo(2, "20%", "", "");
	talents[500].Info[2] = new TalentInfo(3, "30%", "", "");
	talents[454].Info[0] = new TalentInfo(1, "2%", "", "");
	talents[454].Info[1] = new TalentInfo(2, "4%", "", "");
	talents[454].Info[2] = new TalentInfo(3, "6%", "", "");
	talents[454].Info[3] = new TalentInfo(4, "8%", "", "");
	talents[454].Info[4] = new TalentInfo(5, "10%", "", "");
	talents[436].Info[0] = new TalentInfo(1, "35%", "", "");
	talents[436].Info[1] = new TalentInfo(2, "70%", "", "");
	talents[506].Info[0] = new TalentInfo(1, "4%", "", "");
	talents[506].Info[1] = new TalentInfo(2, "8%", "", "");
	talents[506].Info[2] = new TalentInfo(3, "12%", "", "");
	talents[506].Info[3] = new TalentInfo(4, "16%", "", "");
	talents[506].Info[4] = new TalentInfo(5, "20%", "", "");
	talents[505].Info[0] = new TalentInfo(1, "2 ��,20%", "", "");
	talents[505].Info[1] = new TalentInfo(2, "4 ��,40%", "", "");
	talents[519].Info[0] = new TalentInfo(1, "2%", "", "");
	talents[519].Info[1] = new TalentInfo(2, "4%", "", "");
	talents[439].Info[0] = new TalentInfo(1, "13%", "", "");
	talents[439].Info[1] = new TalentInfo(2, "26%", "", "");
	talents[796].Info[0] = new TalentInfo(1, "", "", "");
	talents[524].Info[0] = new TalentInfo(1, "2%", "", "");
	talents[524].Info[1] = new TalentInfo(2, "4%", "", "");
	talents[524].Info[2] = new TalentInfo(3, "6%", "", "");
	talents[524].Info[3] = new TalentInfo(4, "8%", "", "");
	talents[524].Info[4] = new TalentInfo(5, "10%", "", "");
	talents[795].Info[0] = new TalentInfo(1, "", "", "");
	talents[521].Info[0] = new TalentInfo(1, "", "", "");
	talents[794].Info[0] = new TalentInfo(1, "", "", "");
	talents[441].Info[0] = new TalentInfo(1, "2%", "", "");
	talents[441].Info[1] = new TalentInfo(2, "4%", "", "");
	talents[441].Info[2] = new TalentInfo(3, "6%", "", "");
	talents[441].Info[3] = new TalentInfo(4, "8%", "", "");
	talents[441].Info[4] = new TalentInfo(5, "10%", "", "");
	talents[510].Info[0] = new TalentInfo(1, "4%,2%,2%,0.2", "", "");
	talents[510].Info[1] = new TalentInfo(2, "8%,4%,4%,0.4", "", "");
	talents[510].Info[2] = new TalentInfo(3, "12%,6%,6%,0.6", "", "");
	talents[510].Info[3] = new TalentInfo(4, "16%,8%,8%,0.8", "", "");
	talents[510].Info[4] = new TalentInfo(5, "20%,10%,10%,1", "", "");

//----8<-------------------------------------------[
}
if (currentClass == classLst[8]) {
	talents[798] = new Talent( "��ŭ�ƿ�", "����", 3, 2, "Spell_Holy_BlessingOfStamina.png", "", "", "������ս����ʹ���ŭ�������ٶȽ��� 30%��", new Array(), new Array(new TalentRequirement(376, 5)));
	talents[815] = new Talent( "Ԥ֪", "����", 1, 3, "Spell_Nature_MirrorImage.png", "", "", "ʹ��ķ���������� {0}��", new Array(), new Array());
	talents[383] = new Talent( "��ר��", "����", 5, 1, "INV_Axe_06.png", "", "", "ʹ��ĸ��������������һ���ļ������{0}��", new Array(), new Array());
	talents[805] = new Talent( "Ѫ֮����", "��ŭ", 3, 3, "Spell_Shadow_SummonImp.png", "", "", "���ܵ�����һ��֮���6���ڻָ�����ֵ������{0}��", new Array(), new Array());
	talents[813] = new Talent( "��Ѫ", "��ŭ", 7, 2, "Spell_Nature_BloodLust.png", "", "30ŭ��<br>˲��<br>5����Ч����<br>6����ȴʱ��<br>", "��������Ŀ�꣬��������൱����Ĺ���ǿ��40%���˺������⣬�����5�γɹ��Ľ�ս����ÿ�ζ�������ظ�10��������Ч������8�롣", new Array(), new Array(new TalentRequirement(809, 1)));
	talents[803] = new Talent( "���ɤ��", "��ŭ", 1, 2, "Spell_Nature_Purge.png", "", "", "ʹ���ս��ŭ��ʹ�־ŭ��Ч�������÷�Χ�ͳ���ʱ�����{0}��", new Array(), new Array());
	talents[825] = new Talent( "���ͻ�", "����", 5, 3, "Ability_ThunderBolt.png", "", "15 ŭ��<br>˲��<br>45 ����ȴʱ��<br>��Ҫ��ս����", "Ұ���Ĺ�������Ŀ�����5�롣", new Array(), new Array());
	talents[66] = new Talent( "����", "��ŭ", 1, 3, "Ability_Rogue_Eviscerate.png", "", "", "ʹ���ý�ս�����Ե����������һ���ļ������{0}��", new Array(), new Array());
	talents[809] = new Talent( "����֮Ը", "��ŭ", 5, 2, "Spell_Shadow_DeathPact.png", "", "10 ŭ��<br>˲��<br>3������ȴʱ��<br>", "����֮������������˺����20%�������߿־�Ч�������Ƕ����й����ķ�����������20%������30�롣", new Array(), new Array());
	talents[459] = new Talent( "����", "����", 3, 3, "Ability_BackStab.png", "", "", "�������һ������Ŀ����Ѫ��ʹ����12���������൱���������ƽ���˺�ֵ��{0}���˺���", new Array(), new Array(new TalentRequirement(375, 3)));
	talents[820] = new Talent( "����", "����", 3, 4, "Ability_Warrior_InnerRage.png", "", "", "ʹ���ڷ�����̬�����ڹ�������ɵ���вֵ���{0}��", new Array(), new Array());
	talents[374] = new Talent( "ƫб", "����", 1, 2, "Ability_Parry.png", "", "", "ʹ����мܼ������ {0}��", new Array(), new Array());
	talents[835] = new Talent( "˫����ר��", "��ŭ", 4, 1, "Ability_DualWield.png", "", "", "ʹ��ĸ�����������ɵ��˺����{0}", new Array(), new Array());
	talents[376] = new Talent( "ս������", "����", 2, 2, "Spell_Nature_EnchantArmor.png", "", "", "�ڸı���̬��ʱ����Ա������ {0}��", new Array(), new Array());
	talents[808] = new Talent( "��ŭ", "��ŭ", 4, 3, "Spell_Shadow_UnholyFrenzy.png", "", "", "ʹ�����⵽���˵�����һ��֮�������е�12�ν�ս���������{0}�Ķ����˺���ֵ��Ч������12�롣", new Array(), new Array());
	talents[812] = new Talent( "����", "��ŭ", 6, 3, "Ability_GhoulFrenzy.png", "", "", "����Ľ�ս�����������һ��֮�������3�ν�ս�����ٶȽ���� {0}��", new Array(), new Array(new TalentRequirement(808, 5)));
	talents[460] = new Talent( "����", "����", 4, 3, "Ability_SearingArrow.png", "", "", "ʹ����ս����̬��������̬�Ϳ���̬�µĸ��ּ��ܵ�����һ���˺��ӳ����{0}��", new Array(), new Array(new TalentRequirement(459, 3)));
	talents[375] = new Talent( "ǿ��˺��", "����", 1, 3, "Ability_Gouge.png", "", "", "ʹ���˺�Ѽ��ܵ���Ѫ�˺�Ч��ÿ����Чʱ����� {0}", new Array(), new Array());
	talents[82] = new Talent( "ǿ�����", "����", 2, 1, "Ability_Warrior_Charge.png", "", "", "ʹ��ĳ�漼�ܻ��ܵ�ŭ��ֵ��� {0}��", new Array(), new Array());
	talents[806] = new Talent( "ǿ��ս��ŭ��", "��ŭ", 3, 4, "Ability_Warrior_BattleShout.png", "", "", "ʹ���ս��ŭ����߹���ǿ�ȵ�Ч����ǿ{0}", new Array(), new Array());
	talents[811] = new Talent( "ǿ����֮ŭ", "��ŭ", 6, 1, "Spell_Nature_AncestralGuardian.png", "", "", "��ʹ�ÿ�֮ŭ����֮����{0}ŭ��ֵ��", new Array(), new Array());
	talents[619] = new Talent( "ǿ��Ѫ�Կ�", "����", 2, 1, "Ability_Racial_BloodRage.png", "", "", "ʹ���Ѫ�Կ񱩼�����������ŭ��ֵ��� {0}��", new Array(), new Array());
	talents[804] = new Talent( "ǿ��˳��ն", "��ŭ", 3, 1, "Ability_Warrior_Cleave.png", "", "", "ʹ���˳��ն���ܸ��ӵ��˺����{0}��", new Array(), new Array());
	talents[403] = new Talent( "ǿ����־ŭ��", "��ŭ", 2, 2, "Ability_Warrior_WarCry.png", "", "", "ʹ��Ĵ�־ŭ���ܽ��͵��˹���ǿ�ȵ�Ч�����{0}��", new Array(), new Array());
	talents[821] = new Talent( "ǿ����е", "����", 4, 2, "Ability_Warrior_Disarm.png", "", "", "ʹ��Ľ�е���ܵ�Ч������ʱ���ӳ�{0}��", new Array(), new Array());
	talents[807] = new Talent( "ǿ��նɱ", "��ŭ", 4, 2, "INV_Sword_48.png", "", "", "ʹ���նɱ���ܵ�ŭ��ֵ���ļ���{0}��", new Array(), new Array());
	talents[388] = new Talent( "ǿ���Ͻ�", "����", 6, 3, "Ability_ShockWave.png", "", "", "ʹ��ĶϽ���� {0} �ļ�����Ŀ���޷��ƶ�������5�롣", new Array(), new Array());
	talents[373] = new Talent( "ǿ��Ӣ�´��", "����", 1, 1, "Ability_Rogue_Ambush.png", "", "", "ʹ���Ӣ�´�����������ĵ�ŭ��ֵ���� {0}��", new Array(), new Array());
	talents[810] = new Talent( "ǿ������", "��ŭ", 5, 4, "Ability_Rogue_Sprint.png", "", "", "ʹ������ؼ��ܵ���ȴʱ�����{0}��", new Array(), new Array());
	talents[378] = new Talent( "ǿ��ѹ��", "����", 3, 1, "INV_Sword_05.png", "", "", "ʹ���ѹ�Ƽ����������һ���ļ������{0}��", new Array(), new Array());
	talents[819] = new Talent( "ǿ������", "����", 3, 3, "Ability_Warrior_Revenge.png", "", "", "ʹ��ĸ������� {0} �ļ�����Ŀ�����3�롣", new Array(), new Array());
	talents[824] = new Talent( "ǿ���ܻ�", "����", 5, 2, "Ability_Warrior_ShieldBash.png", "", "", "ʹ��Ķܻ�������{0}�ļ���ʹĿ���Ĭ3�롣", new Array(), new Array());
	talents[818] = new Talent( "ǿ�����Ƹ�", "����", 3, 2, "Ability_Defend.png", "", "", "ʹ��Ķ��Ƹ񵵼��ܿ��Զ����һ�ι�������ʹ����Чʱ���ӳ�{0}��", new Array(), new Array(new TalentRequirement(814, 5)));
	talents[823] = new Talent( "ǿ����ǽ", "����", 5, 1, "Ability_Warrior_ShieldWall.png", "", "", "ʹ��Ķ�ǽ���ܵ���Чʱ���ӳ�{0}��", new Array(), new Array());
	talents[632] = new Talent( "ǿ���ͻ�", "��ŭ", 5, 1, "Ability_Warrior_DecisiveStrike.png", "", "", "ʹ����ͻ����ܵ�ʩ��ʱ�����{0}��", new Array(), new Array());
	talents[623] = new Talent( "ǿ���Ƽ׹���", "����", 4, 1, "Ability_Warrior_Sunder.png", "", "", "�����Ƽ׼��������ĵ�ŭ�� {0}��", new Array(), new Array());
	talents[822] = new Talent( "ǿ������", "����", 4, 3, "Spell_Nature_Reincarnation.png", "", "", "ʹ��ĳ����ܵ���ȴʱ�����{0}��", new Array(), new Array());
	talents[377] = new Talent( "ǿ������һ��", "����", 2, 4, "Ability_ThunderClap.png", "", "", "ʹ�������һ�����������ĵ�ŭ��ֵ���� {0}��", new Array(), new Array());
	talents[49] = new Talent( "������־", "����", 2, 4, "Spell_Magic_MageArmor.png", "", "", "ʹ��ֿ����Ժ��Ȼ�Ч���ļ������{0}��", new Array(), new Array());
	talents[817] = new Talent( "�Ƹ�����", "����", 3, 1, "Spell_Holy_AshesToAshes.png", "", "˲��<br>10������ȴʱ��", "����֮��ʹ����ʱ���30%������ֵ������20�롣��Ч�����֮����Щ����ֵ�ᱻ�۳���", new Array(), new Array(new TalentRequirement(619, 2)));
	talents[461] = new Talent( "��������ר��", "����", 5, 3, "INV_Mace_01.png", "", "", "ʹ��ĵ��ִ��ڻ���Ŀ��ʱ�� {0} �Ļ��Ὣ�����3�롣", new Array(), new Array());
	talents[802] = new Talent( "�������", "����", 7, 2, "Ability_Warrior_SavageBlow.png", "", "30ŭ��<br>˲��<br>6����ȴʱ��<br>5����Ч����<br>��Ҫ��ս����<br>", "һ��а��Ĺ�������Ŀ����������˺����85���˺�����ʹ�κ���ʽ�����ƶ��������Ч������50%������10�롣<br><br>�����ܵȼ��������Ч����<br>���ȼ�2��+110�˺�<br>���ȼ�3��+135�˺�<br>���ȼ�4��+160�˺�", new Array(), new Array(new TalentRequirement(799, 1)));
	talents[400] = new Talent( "��������ר��", "����", 6, 2, "INV_Sword_20.png", "", "", "ʹ��ĵ��ֽ�ս����������ɵ��˺����{0}��", new Array(), new Array());
	talents[628] = new Talent( "�̶�ŭ��", "��ŭ", 3, 2, "Spell_Shadow_DeathScream.png", "", "10 ŭ��<br>˲��<br>", "ʹսʿ���������е�������6�롣", new Array(), new Array());
	talents[801] = new Talent( "��������ר��", "����", 6, 1, "INV_Weapon_Halbard_01.png", "", "", "ʹ���ì�ͳ��������������һ���ļ������{0}��", new Array(), new Array());
	talents[826] = new Talent( "�����ͻ�", "����", 7, 3, "INV_Shield_05.png", "", "30 ŭ��<br>˲��<br>5����Ч����<br>6����ȴʱ��<br>", "�ö��ƻ���Ŀ�꣬�������288��352���˺�������50%�ļ�����ɢĿ�����ϵ�1��ħ��Ч����ͬʱ����һ��������вֵ��", new Array(), new Array(new TalentRequirement(825, 1)));
	talents[814] = new Talent( "����ר��", "����", 1, 2, "INV_Shield_06.png", "", "", "ʹ���ö��Ƹ񵲹����ļ������{0}���ڳɹ��񵲺���{1}�ļ��ʵõ�1��ŭ����", new Array(), new Array());
	talents[799] = new Talent( "��ɨ����", "����", 5, 2, "Ability_Rogue_SliceDice.png", "", "30ŭ��<br>˲��<br>30����ȴʱ��<br>��Ҫ��ս����<br>��Ҫս����̬<br>", "���ڽ�������5�ν�ս�����п��Թ�����һ������ĵ��ˡ�", new Array(), new Array());
	talents[800] = new Talent( "��������ר��", "����", 5, 4, "INV_Sword_27.png", "", "", "ʹ�����ý����������е��˺���{0}�ļ��ʽ���һ�ζ���Ĺ�����", new Array(), new Array());
	talents[816] = new Talent( "����", "����", 2, 3, "Spell_Holy_Devotion.png", "", "", "ʹ����װ������õĻ���ֵ���{0}��", new Array(), new Array());
	talents[615] = new Talent( "˫������ר��", "����", 4, 2, "INV_Axe_09.png", "", "", "ʹ���˫�ֽ�ս������ɵ��˺����{0}��", new Array(), new Array());
	talents[404] = new Talent( "ŭ���ɶ�", "��ŭ", 2, 3, "Spell_Nature_StoneClawTotem.png", "", "", "ʹ����{0}�ļ����ڶԵ�����ɽ�ս�˺�֮����1�������ŭ��������", new Array(), new Array());
	talents[835].Info[0] = new TalentInfo(1, "5%", "", "");
	talents[835].Info[1] = new TalentInfo(2, "10%", "", "");
	talents[835].Info[2] = new TalentInfo(3, "15%", "", "");
	talents[835].Info[3] = new TalentInfo(4, "20%", "", "");
	talents[835].Info[4] = new TalentInfo(5, "25%", "", "");
	talents[798].Info[0] = new TalentInfo(1, "", "", "");
	talents[815].Info[0] = new TalentInfo(1, "2 ��", "", "");
	talents[815].Info[1] = new TalentInfo(2, "4 ��", "", "");
	talents[815].Info[2] = new TalentInfo(3, "6 ��", "", "");
	talents[815].Info[3] = new TalentInfo(4, "8 ��", "", "");
	talents[815].Info[4] = new TalentInfo(5, "10 ��", "", "");
	talents[383].Info[0] = new TalentInfo(1, "1%", "", "");
	talents[383].Info[1] = new TalentInfo(2, "2%", "", "");
	talents[383].Info[2] = new TalentInfo(3, "3%", "", "");
	talents[383].Info[3] = new TalentInfo(4, "4%", "", "");
	talents[383].Info[4] = new TalentInfo(5, "5%", "", "");
	talents[805].Info[0] = new TalentInfo(1, "1%", "", "");
	talents[805].Info[1] = new TalentInfo(2, "2%", "", "");
	talents[805].Info[2] = new TalentInfo(3, "3%", "", "");
	talents[813].Info[0] = new TalentInfo(1, "", "", "");
	talents[803].Info[0] = new TalentInfo(1, "10%", "", "");
	talents[803].Info[1] = new TalentInfo(2, "20%", "", "");
	talents[803].Info[2] = new TalentInfo(3, "30%", "", "");
	talents[803].Info[3] = new TalentInfo(4, "40%", "", "");
	talents[803].Info[4] = new TalentInfo(5, "50%", "", "");
	talents[825].Info[0] = new TalentInfo(1, "", "", "");
	talents[66].Info[0] = new TalentInfo(1, "1%", "", "");
	talents[66].Info[1] = new TalentInfo(2, "2%", "", "");
	talents[66].Info[2] = new TalentInfo(3, "3%", "", "");
	talents[66].Info[3] = new TalentInfo(4, "4%", "", "");
	talents[66].Info[4] = new TalentInfo(5, "5%", "", "");
	talents[809].Info[0] = new TalentInfo(1, "", "", "");
	talents[459].Info[0] = new TalentInfo(1, "20%", "", "");
	talents[459].Info[1] = new TalentInfo(2, "40%", "", "");
	talents[459].Info[2] = new TalentInfo(3, "60%", "", "");
	talents[820].Info[0] = new TalentInfo(1, "3%", "", "");
	talents[820].Info[1] = new TalentInfo(2, "6%", "", "");
	talents[820].Info[2] = new TalentInfo(3, "9%", "", "");
	talents[820].Info[3] = new TalentInfo(4, "12%", "", "");
	talents[820].Info[4] = new TalentInfo(5, "15%", "", "");
	talents[374].Info[0] = new TalentInfo(1, "1%", "", "");
	talents[374].Info[1] = new TalentInfo(2, "2%", "", "");
	talents[374].Info[2] = new TalentInfo(3, "3%", "", "");
	talents[374].Info[3] = new TalentInfo(4, "4%", "", "");
	talents[374].Info[4] = new TalentInfo(5, "5%", "", "");
	talents[808].Info[0] = new TalentInfo(1, "5%", "", "");
	talents[808].Info[1] = new TalentInfo(2, "10%", "", "");
	talents[808].Info[2] = new TalentInfo(3, "15%", "", "");
	talents[808].Info[3] = new TalentInfo(4, "20%", "", "");
	talents[808].Info[4] = new TalentInfo(5, "25%", "", "");
	talents[812].Info[0] = new TalentInfo(1, "10%", "", "");
	talents[812].Info[1] = new TalentInfo(2, "15%", "", "");
	talents[812].Info[2] = new TalentInfo(3, "20%", "", "");
	talents[812].Info[3] = new TalentInfo(4, "25%", "", "");
	talents[812].Info[4] = new TalentInfo(5, "30%", "", "");
	talents[460].Info[0] = new TalentInfo(1, "10%", "", "");
	talents[460].Info[1] = new TalentInfo(2, "20%", "", "");
	talents[806].Info[0] = new TalentInfo(1, "5%", "", "");
	talents[806].Info[1] = new TalentInfo(2, "10%", "", "");
	talents[806].Info[2] = new TalentInfo(3, "15%", "", "");
	talents[806].Info[3] = new TalentInfo(4, "20%", "", "");
	talents[806].Info[4] = new TalentInfo(5, "25%", "", "");
	talents[811].Info[0] = new TalentInfo(1, "5 ��", "", "");
	talents[811].Info[1] = new TalentInfo(2, "10 ��", "", "");
	talents[619].Info[0] = new TalentInfo(1, "2 ��", "", "");
	talents[619].Info[1] = new TalentInfo(2, "5 ��", "", "");
	talents[82].Info[0] = new TalentInfo(1, "3 ��", "", "");
	talents[82].Info[1] = new TalentInfo(2, "6 ��", "", "");
	talents[804].Info[0] = new TalentInfo(1, "40%", "", "");
	talents[804].Info[1] = new TalentInfo(2, "80%", "", "");
	talents[804].Info[2] = new TalentInfo(3, "120%", "", "");
	talents[403].Info[0] = new TalentInfo(1, "8%", "", "");
	talents[403].Info[1] = new TalentInfo(2, "16%", "", "");
	talents[403].Info[2] = new TalentInfo(3, "24%", "", "");
	talents[403].Info[3] = new TalentInfo(4, "32%", "", "");
	talents[403].Info[4] = new TalentInfo(5, "40%", "", "");
	talents[821].Info[0] = new TalentInfo(1, "1 ��", "", "");
	talents[821].Info[1] = new TalentInfo(2, "2 ��", "", "");
	talents[821].Info[2] = new TalentInfo(3, "3 ��", "", "");
	talents[807].Info[0] = new TalentInfo(1, "2��", "", "");
	talents[807].Info[1] = new TalentInfo(2, "5��", "", "");
	talents[388].Info[0] = new TalentInfo(1, "5%", "", "");
	talents[388].Info[1] = new TalentInfo(2, "10%", "", "");
	talents[388].Info[2] = new TalentInfo(3, "15%", "", "");
	talents[373].Info[0] = new TalentInfo(1, "1 ��", "", "");
	talents[373].Info[1] = new TalentInfo(2, "2 ��", "", "");
	talents[373].Info[2] = new TalentInfo(3, "3 ��", "", "");
	talents[810].Info[0] = new TalentInfo(1, "5 ��", "", "");
	talents[810].Info[1] = new TalentInfo(2, "10 ��", "", "");
	talents[378].Info[0] = new TalentInfo(1, "25%", "", "");
	talents[378].Info[1] = new TalentInfo(2, "50%", "", "");
	talents[375].Info[0] = new TalentInfo(1, "15%", "", "");
	talents[375].Info[1] = new TalentInfo(2, "25%", "", "");
	talents[375].Info[2] = new TalentInfo(3, "35%", "", "");
	talents[819].Info[0] = new TalentInfo(1, "15%", "", "");
	talents[819].Info[1] = new TalentInfo(2, "30%", "", "");
	talents[819].Info[2] = new TalentInfo(3, "45%", "", "");
	talents[824].Info[0] = new TalentInfo(1, "50%", "", "");
	talents[824].Info[1] = new TalentInfo(2, "100%", "", "");
	talents[818].Info[0] = new TalentInfo(1, "0.5 ��", "", "");
	talents[818].Info[1] = new TalentInfo(2, "1 ��", "", "");
	talents[818].Info[2] = new TalentInfo(3, "2 ��", "", "");
	talents[823].Info[0] = new TalentInfo(1, "3 ��", "", "");
	talents[823].Info[1] = new TalentInfo(2, "5 ��", "", "");
	talents[632].Info[0] = new TalentInfo(1, "0.1 ��", "", "");
	talents[632].Info[1] = new TalentInfo(2, "0.2 ��", "", "");
	talents[632].Info[2] = new TalentInfo(3, "0.3 ��", "", "");
	talents[632].Info[3] = new TalentInfo(4, "0.4 ��", "", "");
	talents[632].Info[4] = new TalentInfo(5, "0.5 ��", "", "");
	talents[623].Info[0] = new TalentInfo(1, "1 ��", "", "");
	talents[623].Info[1] = new TalentInfo(2, "2 ��", "", "");
	talents[623].Info[2] = new TalentInfo(3, "3 ��", "", "");
	talents[822].Info[0] = new TalentInfo(1, "1 ��", "", "");
	talents[822].Info[1] = new TalentInfo(2, "2 ��", "", "");
	talents[377].Info[0] = new TalentInfo(1, "1 ��", "", "");
	talents[377].Info[1] = new TalentInfo(2, "2 ��", "", "");
	talents[377].Info[2] = new TalentInfo(3, "4 ��", "", "");
	talents[49].Info[0] = new TalentInfo(1, "3%", "", "");
	talents[49].Info[1] = new TalentInfo(2, "6%", "", "");
	talents[49].Info[2] = new TalentInfo(3, "9%", "", "");
	talents[49].Info[3] = new TalentInfo(4, "12%", "", "");
	talents[49].Info[4] = new TalentInfo(5, "15%", "", "");
	talents[817].Info[0] = new TalentInfo(1, "", "", "");
	talents[461].Info[0] = new TalentInfo(1, "1%", "", "");
	talents[461].Info[1] = new TalentInfo(2, "2%", "", "");
	talents[461].Info[2] = new TalentInfo(3, "3%", "", "");
	talents[461].Info[3] = new TalentInfo(4, "4%", "", "");
	talents[461].Info[4] = new TalentInfo(5, "6%", "", "");
	talents[802].Info[0] = new TalentInfo(1, "", "", "");
	talents[400].Info[0] = new TalentInfo(1, "2%", "", "");
	talents[400].Info[1] = new TalentInfo(2, "4%", "", "");
	talents[400].Info[2] = new TalentInfo(3, "6%", "", "");
	talents[400].Info[3] = new TalentInfo(4, "8%", "", "");
	talents[400].Info[4] = new TalentInfo(5, "10%", "", "");
	talents[628].Info[0] = new TalentInfo(1, "", "", "");
	talents[801].Info[0] = new TalentInfo(1, "1%", "", "");
	talents[801].Info[1] = new TalentInfo(2, "2%", "", "");
	talents[801].Info[2] = new TalentInfo(3, "3%", "", "");
	talents[801].Info[3] = new TalentInfo(4, "4%", "", "");
	talents[801].Info[4] = new TalentInfo(5, "5%", "", "");
	talents[826].Info[0] = new TalentInfo(1, "", "", "");
	talents[814].Info[0] = new TalentInfo(1, "1%,20%", "", "");
	talents[814].Info[1] = new TalentInfo(2, "2%,40%", "", "");
	talents[814].Info[2] = new TalentInfo(3, "3%,60%", "", "");
	talents[814].Info[3] = new TalentInfo(4, "4%,80%", "", "");
	talents[814].Info[4] = new TalentInfo(5, "5%,100%", "", "");
	talents[799].Info[0] = new TalentInfo(1, "", "", "");
	talents[800].Info[0] = new TalentInfo(1, "1%", "", "");
	talents[800].Info[1] = new TalentInfo(2, "2%", "", "");
	talents[800].Info[2] = new TalentInfo(3, "3%", "", "");
	talents[800].Info[3] = new TalentInfo(4, "4%", "", "");
	talents[800].Info[4] = new TalentInfo(5, "5%", "", "");
	talents[376].Info[0] = new TalentInfo(1, "5��ŭ��", "", "");
	talents[376].Info[1] = new TalentInfo(2, "10��ŭ��", "", "");
	talents[376].Info[2] = new TalentInfo(3, "15��ŭ��", "", "");
	talents[376].Info[3] = new TalentInfo(4, "20��ŭ��", "", "");
	talents[376].Info[4] = new TalentInfo(5, "25��ŭ��", "", "");
	talents[816].Info[0] = new TalentInfo(1, "2%", "", "");
	talents[816].Info[1] = new TalentInfo(2, "4%", "", "");
	talents[816].Info[2] = new TalentInfo(3, "6%", "", "");
	talents[816].Info[3] = new TalentInfo(4, "8%", "", "");
	talents[816].Info[4] = new TalentInfo(5, "10%", "", "");
	talents[615].Info[0] = new TalentInfo(1, "1%", "", "");
	talents[615].Info[1] = new TalentInfo(2, "2%", "", "");
	talents[615].Info[2] = new TalentInfo(3, "3%", "", "");
	talents[615].Info[3] = new TalentInfo(4, "4%", "", "");
	talents[615].Info[4] = new TalentInfo(5, "5%", "", "");
	talents[404].Info[0] = new TalentInfo(1, "8%", "", "");
	talents[404].Info[1] = new TalentInfo(2, "16%", "", "");
	talents[404].Info[2] = new TalentInfo(3, "24%", "", "");
	talents[404].Info[3] = new TalentInfo(4, "32%", "", "");
	talents[404].Info[4] = new TalentInfo(5, "40%", "", "");
}
}

function talents_main(){
	className = currentClass;
	masteries = new Array();
	for(var i in types)
	{
		masteries[types[i]] = 0;
	}
	resetTalents();
	learned = new Array();
	currentTalent = 0;

	var tmpTalList ;
	if (chinese) {
		tmpTalList = "����鿴�����츳";
	}else{
		tmpTalList = "Click to Show All Talentes";
	}

	setInnerHTML(document.getElementById("curClass"), "["+currentClass+"]:<span class=\"accent\"onmouseover=\"this.style.cursor='hand'\" onclick=\"talList();\">"+tmpTalList+"</span>");
	
	mozilla = false;
	if(/Netscape/.test(navigator.appName))
	{
		mozilla = true;
		document.write("<div id=\"tooltip\" class=\"tooltip\" style=\"z-index: 3; position: absolute; width:250; visibility: hidden;\"></div>");
	}
	
	changeTree();
	icons = new Array();
	loadImages();
	setLevel(60);
	refreshTemplateDetails();
	changeType(currentType);
//	chkNoInfoId();
}
//--add change the tree name in html
function changeTree(){
	var tmp_id;
	for (var i=0;i<=2;i++) {
	tmp_id = document.getElementById("Atype_"+i);
	setInnerHTML(tmp_id, "<b>"+types[i]+"</b>");
	tmp_id = document.getElementById("type_"+i);
	setInnerHTML(tmp_id, "<b>"+types[i]+":&nbsp;</b>");
	}
}
function refreshTemplateDetails()
{
	var talentHtml = "<table cellspacing=0 cellpadding=2 border=0 width=100% height=100%>";
	
	talentHtml += "<tr><td valign=top>";
    talentHtml += "<div width=100% style=\"overflow: auto; height: 310; scrollbar-base-color: black; scrollbar-arrow-color: #999999\">";
    
    talentHtml += getLearnedText();
	talentHtml += "</div>";
	talentHtml += "</td></tr>";
	talentHtml += "</table>";
	var descDiv = document.getElementById("talent_description");
	setInnerHTML(descDiv, talentHtml);
	
	refreshTemplateData();
}
function refreshTemplateData()
{
    var formTemplate = document.getElementById("DataDetail_Template");
    if(formTemplate != null)
    {
	formTemplate.value = getTemplateData();
    }
    
    var templateUnspent = document.getElementById("DataDetail_Unspent");
    if(templateUnspent != null)
    {
	templateUnspent.value = talentPoints;
    }
}
function showTalent(e, id)
{
	var learn = canLearn(id);
	var html = "<table cellspacing=0 cellpadding=2 border=0>";
	html += "<tr><td><nobr><span class=\"accent\"><b>" + talents[id].Name + "</b></span></nobr>";
	if(chinese){
		html += "<br><nobr><b>�ȼ� ";
	}else{
		html += "<br><nobr><b>Rank ";
	}
	if(learned[id] == null)
	{
		html += "0";
	}
	else
	{
		html += learned[id];
	}
	html += "/" + talents[id].Info.length + "</b></nobr>";
	for(var i in talents[id].Requirements)
	{
		var req = talents[id].Requirements[i];
		html += "<br><nobr><span class=\"smalltext\"";
		if(learned[req.Id] == null || learned[req.Id] < req.Amount)
		{
			html += " style=\"color: red;\"";
		}
		if(chinese){
			html += ">��Ҫ " + req.Amount + " ��";
		}else{
			html += ">Req " + req.Amount + " Point";
			if(req.Amount != 1)
			{			html += "s";		}
		}
		if(chinese){
		html += " �� " + talents[req.Id].Name + "</span></nobr>";
		}else{
		html += " in " + talents[req.Id].Name + "</span></nobr>";
		}
	}
	if(talents[id].Tier > 1)
	{
		var typereq = (talents[id].Tier - 1) * 5;
		html += "<br><nobr><span class=\"smalltext\"";
		if(masteries[talents[id].Type] < typereq)
		{
			html += " style=\"color: red;\"";
		}
		if(chinese){
		html += ">��Ҫ " + typereq + " ��";
		}else{
		html += ">Req " + typereq + " Point";
		if(talents[id].TypeReq != 1)
		{
			html += "s";
		}
		}
		if(chinese){
		html += " �� " + talents[id].Type + " �츳</span></nobr>";
		}else{
		html += " in " + talents[id].Type + " Talent</span></nobr>";
		}
	}
	var minLevel = getMinLevel(id);
	html += "<br><nobr><span class=\"smalltext\"";
	if(currentLevel < minLevel)
	{
	    html += " style=\"color: red;\"";
	}
	if(chinese){
	html += ">��͵ȼ�: " + minLevel;
	}else{
	html += ">Min Level: " + minLevel;
	}
	html += "</span></nobr>";
    html += "<br><br>";
    if(talents[id].Info.length > 0)
    {
	if(talents[id].Info.length != 1)
	{
	    if(chinese){
	    html += "<b>�ȼ� 1:</b> ";
	    }else{
	    html += "<b>Rank 1:</b> ";
	    }
	}
	var details = talents[id].Details;
	if(details == "")
	{
	    details = talents[id].Info[0].Details;
	}
	if(details != "")
	{
	    html += "<span class=\"smalltext\">" + details + "</span><br>";
	}
	html += "<span class=\"accent\">" + getTalentDescription(id, 1) + "</span><br>";
    }
    if(talents[id].Info.length > 1)
    {
	for(var i = 1; i < talents[id].Info.length; i++)
	{
	    if(chinese){html += "<b>�ȼ� " + talents[id].Info[i].Rank + ":</b> <span class=\"accent\">";
	    }else{html += "<b>Rank " + talents[id].Info[i].Rank + ":</b> <span class=\"accent\">";}
	    if(talents[id].Info[i].Amount == "")
	    {
		html += "?";
	    }
	    else
	    {
		html += talents[id].Info[i].Amount;
	    }
	    html += "</span><br>";
	}
    }
	
	if(learn)
	{
		if(chinese){html += "<br><nobr><span class=\"smalltext\"><span style=\"color:LimeGreen\"><b>������ѧϰ ˫��ѧ��ͷ</b></span></span></nobr>";
		}else{html += "<br><nobr><span class=\"smalltext\"><span style=\"color:LimeGreen\"><b>OnClick to Learn; Double Click to Learn Max</b></span></span></nobr>";}
	}
	if(canUnlearn(id))
	{
	    if(chinese){html += "<br><nobr><span class=\"smalltext\"><span style=\"color:Red\"><b>�Ҽ���� ��ȴ</b></span></span></nobr>";
	    }else{html += "<br><nobr><span class=\"smalltext\"><span style=\"color:Red\"><b>Right Click to Unlearn</b></span></span></nobr>";}
	}
	html += "</td></tr>";
	html += "</table>";
	var toolTipDiv = document.getElementById("tooltip");
	setInnerHTML(toolTipDiv, html);
	
	moveTalent(e);
}
function moveTalent(e, id)
{
	var toolTipDiv = document.getElementById("tooltip");
	if(toolTipDiv != null)
	{
		if(getInnerHTML(toolTipDiv) != "")
		{
			if(e != null)
			{
				toolTipDiv.style.visibility = "visible";
				toolTipDiv.style.left = window.scrollX + e.clientX + 10;
				toolTipDiv.style.top = window.scrollY + e.clientY + 10;
			}
			else
			{
				toolTipDiv.style.visibility = "visible";
				toolTipDiv.style.bottom = 439 - event.offsetY + 5;
				toolTipDiv.style.left = event.offsetX + 5;
			}
		}
		else
		{
			showTalent(e, id);
		}
	}
}
function hideTalent()
{
	var toolTipDiv = document.getElementById("tooltip");
	toolTipDiv.style.visibility = "hidden";
	setInnerHTML(toolTipDiv, "");
}
function showTalentMap(type)
{
    if(talentImages[currentClass+type] != null)
    {
	var talentDiv = document.getElementById("talents");
	if(talentDiv != null)
	{
	    var imageHtml = "<img src=\"" + talentImages[currentClass+type] + "\" usemap=\"#Talent_" + type + "\" border=0 onContextMenu=\"return false;\">";
	    imageHtml += "<map name=\"Talent_" + type + "\">";
	    for(var i in talents)
	    {
		if(talents[i] != null && talents[i].Type == type)
		{
					talents[i].Coords = calculateImageCoords(talents[i].Tier, talents[i].Column, talents[i].Coords);
					if(talents[i].Coords != "")
					{
						imageHtml += "<area id=\"area_" + talents[i].Id + "\" shape=rect coords=\"";
						imageHtml += talents[i].Coords;
						imageHtml += "\" onMouseOver=\"showTalent(arguments[0], " + i + ");\" onMouseMove=\"moveTalent(arguments[0], " + i + ");\" OnMouseOut=\"hideTalent();\" onClick=\"learnTalent(" + i + "); showTalent(arguments[0], " + i + ");\" ondblClick=\"learnTalent2(" + i + "); showTalent(arguments[0], " + i + ");\" onMouseDown=\"onClickTalent(" + i + "); showTalent(arguments[0], " + i + ");\" onContextMenu=\"unlearnTalent(" + i + "); showTalent(arguments[0], " + i + "); return false;\">";
					}
		}
	    }
	    imageHtml += "</map>";
	    
	    for(var i in talents)
	    {
		if(talents[i] != null && talents[i].Type == type && talents[i].Coords != "")
		{
		    var x, y;
					if(build == "b4")
					{
						x = getX1Coord(talents[i].Coords)*1.0 + 36;
		    	y = getY1Coord(talents[i].Coords)*1.0 + 31;
					}
					else
					{
						x = getX1Coord(talents[i].Coords)*1.0 + 39;
		    	y = getY1Coord(talents[i].Coords)*1.0 + 34;
					}
		    imageHtml += "<div id=\"inc_" + i + "\" style=\"z-index: 2; position:absolute; left: " + x + "; top: " + y + ";\"><span style=\"color:Red\">+</span></div>";
		}
	    }
	    
			if(!mozilla)
			{
		    imageHtml += "<div id=\"tooltip\" class=\"tooltip\" style=\"z-index: 3; position: absolute; width:250; visibility: hidden;\"></div>";
			}
	    
	    setInnerHTML(talentDiv, imageHtml);
	}
    }
    
    refreshTalents();
}
function calculateImageCoords(tier, column, coords)
{
	if(build == "b4" || column == 0)
	{
		return coords;
	}
	else
	{
		var baseX = 36;
		var baseY = 7;
		var width = 44;
		var height = 44;
		
		var x1 = (column - 1) * 66 + baseX;
		var y1 = (tier - 1) * 63 + baseY;
		var x2 = x1 + width - 1;
		var y2 = y1 + height - 1;
		
		return x1 + "," + y1 + "," + x2 + "," + y2;
	}
}
function getX1Coord(coords)
{
    if(coords.indexOf(",") > 0)
    {
	return coords.substring(0, coords.indexOf(","));
    }
}
function getY1Coord(coords)
{
    if(coords.indexOf(",") > 0)
    {
	var index = coords.indexOf(",");
	var newIndex = coords.indexOf(",", index + 1);
	if(newIndex > 0)
	{
	    return coords.substring(index + 1, newIndex);
	}
    }
}
function changeType(type)
{//
    showTalentMap(type);
	var oldType;
	var newType;
	for (var aId in types) {
		if ( types[aId] == currentType) { oldType = aId;}
		if ( types[aId] == type) { newType = aId;}
	}
	
	var oldTabDiv = document.getElementById("Atype_"+oldType);
	if(oldTabDiv != null)
	{
		setInnerHTML(oldTabDiv, "<b>" + currentType + "</b>");
	}
	
	var newTabDiv = document.getElementById("Atype_"+newType);
	if(newTabDiv != null)
	{
		setInnerHTML(newTabDiv, "<b><span class=\"accent\"> " + type + "</span></b>");
	}
	
	currentType = type;
	
	refreshTalents();
}
function onType(type)
{
	var tabDiv = document.getElementById(type);
	if(tabDiv != null)
	{
		setInnerHTML(tabDiv, "<b><span class=\"accent\">" + type + "</span></b>");
	}
}
function offType(type)
{
//	var tabDiv = document.getElementById(type);
//	if(tabDiv != null)
//	{
//		tabDiv.innerHTML = "<b>" + type + "</b>";
//	}
}
function canLearn(talent_id)
{
	var canLearn = true;
	
	// Must have enough talent points
	if(talentPoints == 0)
	{
		canLearn = false;
	}
	// Must have the required mastery
	else if(masteries[talents[talent_id].Type] < ((talents[talent_id].Tier - 1) * 5))
	{
		canLearn = false;
	}
	// Must not have talent maxed
	else if(isMaxed(talent_id))
	{
		canLearn = false;
	}
	// Must have prerequisite skills
	else
	{
		for(var i in talents[talent_id].Requirements)
		{
			var req = talents[talent_id].Requirements[i];
			if((learned[req.Id] == null) ||
				(learned[req.Id] < req.Amount))
			{
				canLearn = false;
				break;
			}
		}
	}
	
	return canLearn;
}
function canUnlearn(id)
{
    if(learned[id] != null && learned[id] > 0)
    {
		var type = talents[id].Type;
		// Make sure no skills depend on it as a prereq
	for(var i in talents)
	{
			// Direct prereq
	    for(var j in talents[i].Requirements)
	    {
		var req = talents[i].Requirements[j];
				
		if(req.Id == id && learned[i] != null && learned[i] > 0)
		{
		    return false;
		}
	    }
	}
	
		// Mastery prereq
		for(var i in learned)
		{
			var typeReq = (talents[i].Tier - 1) * 5.0;
			if((i != id) && (learned[i] != null) && (learned[i] != 0) && (talents[i].Type == type))
			{
				if(talents[i].Tier > talents[id].Tier)
				{
					var masteryTier = 0;
					for(var j in learned)
					{
						if((learned[j] != null) && (talents[j].Type == type) && (talents[j].Tier < talents[i].Tier))
						{
							masteryTier += learned[j];
						}
					}
					if(masteryTier - 1 < typeReq)
					{
						return false;
					}
				}
			}
		}
	return true;
    }
    
    return false;
}
function isMaxed(id)
{
    if((learned[id] == talents[id].Info.length) ||
	    (learned[id] == null && talents[id].Info.length == 0))
	{
	    return true;
	}
}
function getMinLevel(id)
{
    var minTalentPoints = getMinTalentPoints(id);
    return minTalentPoints + 9;
}
function getMinTalentPoints(id)
{
    var minTalentPoints = 1;
    
    minTalentPoints = (talents[id].Tier - 1) * 5 + 1;
    if(talents[id].Requirements.length > 0)
    {
	for(var i in talents[id].Requirements)
	{
	    var req = talents[id].Requirements[i];
	    var reqTalentPoints = getMinTalentPoints(req.Id) + req.Amount;
	    if(reqTalentPoints > minTalentPoints)
	    {
		minTalentPoints = reqTalentPoints;
	    }
	}
    }
    
    return minTalentPoints;
}
function doAction()
{
	var actionSelect = document.getElementById("action");
	if(actionSelect != null)
	{
		if(actionSelect.value == "+1")
		{
			setLevel(currentLevel + 1);
		}
		else if(actionSelect.value == "+5")
		{
			setLevel(currentLevel + 5);
		}
		else if(actionSelect.value == "+10")
		{
			setLevel(currentLevel + 10);
		}
		else if(actionSelect.value == "max")
		{
			setLevel(maxLevel);
		}
		else if(actionSelect.value == "reset")
		{
		    resetTalents();
		}
		else if(actionSelect.value == "save")
		{
		    saveTemplate();
		}
	}
}
function setLevel(value)
{
	var levelDiv = document.getElementById("player_level");
	if(levelDiv != null && value <= maxLevel)
	{
		currentLevel = value * 1.0;
		setInnerHTML(levelDiv, currentLevel);
		setTalentPoints();
		
		var levelText = document.getElementById("level_text");
		if(levelText != null)
		{
		    levelText.value = currentLevel;
		}
		refreshTalents();
	}
    var templateLevel = document.getElementById("DataDetail_Level");
    if(templateLevel != null)
    {
	templateLevel.value = currentLevel;
    }
}
function setMastery(mastery, value)
{
	var typeIdx = new Array();
	typeIdx[types[0]]= 0;
	typeIdx[types[1]]= 1;
	typeIdx[types[2]]= 2;
	
	var masteryDiv = document.getElementById("mastery_" + typeIdx[mastery]);
	if(masteryDiv != null)
	{
		masteries[mastery] = value;
		setInnerHTML(masteryDiv, masteries[mastery]);
	}
}
function setTalentPoints()
{
	var talentDiv = document.getElementById("talent_points");
	if(talentDiv != null)
	{
		talentPoints = currentLevel - 9 - getSpentTalentPoints();
		if(talentPoints < 0)
		{
		    talentPoints = 0;
		}
		setInnerHTML(talentDiv, talentPoints);
	}
}
function resetTalents()
{
	learned = new Array();
	for(var index in types)
	{
		setMastery(types[index], 0);
	}
	talentPoints = currentLevel - 1;
	setTalentPoints();
	refreshTalents();
}
function resetCurrentTree()
{
	for(var index in learned)
	{
		if(talents[index].Type == currentType)
		{
			learned[index] = 0;
		}
	}
	
	talentPoints = talentPoints - masteries[currentType];
	setMastery(currentType, 0);
	
	setTalentPoints();
	refreshTalents();
}
function getSpentTalentPoints()
{
	var spent = 0;
	for(var i in learned)
	{
		spent += learned[i];
	}
	return spent;
}
function learnTalent(id)
{
    if(!canLearn(id))
    {
	return;
    }
	if(learned[id] == null && talents[id].Info.length > 0)
	{
		learned[id] = 1;
	}
	else if(learned[id] < talents[id].Info.length)
	{
		learned[id]++;
	}
	
	talentPoints--;
	setTalentPoints();
	setMastery(talents[id].Type, masteries[talents[id].Type] + 1);
    refreshTalents();
}
function learnTalent2(id)	//learn all
{
    if(!canLearn(id))
    {
	return;
    }
	if(learned[id] == null && talents[id].Info.length > 0)
	{
		learned[id] = 0;
	}
	var addPoints = talents[id].Info.length - learned[id];
	
	if(talentPoints < addPoints)
	{addPoints = talentPoints;}
	learned[id]+= addPoints;
	talentPoints -= addPoints;
	setTalentPoints();
	setMastery(talents[id].Type, masteries[talents[id].Type] + addPoints);
    refreshTalents();
}
function unlearnTalent(id)
{
    if(!canUnlearn(id))
    {
        return;
    }
    
    learned[id]--;
    talentPoints++;
    setTalentPoints();
    
    setMastery(talents[id].Type, masteries[talents[id].Type] - 1);
    
    refreshTalents();
}

function onClickTalent(id)
{
	if(event == null)
	{
		learnTalent(id);
	}
    else if(event.button == 2)
    {
	unlearnTalent(id);
    }
}
function refreshTalents()
{
    for(var i in talents)
    {
	if(talents[i].Type == currentType)
	{
	    var talentDiv = document.getElementById("inc_" + i);
	    if(talentDiv != null)
	    {
		var talentHtml = "";
		var level = learned[i];
		if(level == null)
		{
		    level = 0;
		}
		if(canLearn(i))
		{
		    talentHtml = "<span style=\"color: LimeGreen\">" + level + "</span>";
		}
		else if(isMaxed(i))
		{
		    talentHtml = "<span style=\"color: White\">" + level + "</span>";
		}
		else
		{
		    talentHtml = "<span style=\"color: Red\">" + level + "</span>";
		}
		
		setInnerHTML(talentDiv, talentHtml);
	    }
	}
    }
    
    refreshTemplateDetails();
}
function loadImages()
{
    for(var i in talentImages)
    {
	for(var j in types)
	{
	    if(j == i)
	    {
		var image = new Image();
		image.src = talentImages[i];
	    }
	}
    }
    for(var i in talents)
    {
	icons[i] = new Image();
	icons[i].src = iconUrl + talents[i].Icon;
    }
}
function saveTemplate()
{

    var win = window.open("","","resizable=1,toolbar=0,width=825,height=450,status=0,scrollbars=1,menubar=0");
	if(win != null)
	{
		//win.document.write("<HTML><HEAD><LINK REL=\"stylesheet\" TYPE=\"text/css\" HREF=\"wwv/vault.css\"><TITLE>WoW Talent Template</TITLE></HEAD>\n");
		var tmp = iconEnable ;
		iconEnable = 0;
		win.document.write("<BODY BGCOLOR=\"#FFFFFF\" TEXT=\"000000\">\n");
		
		win.document.write(getTemplateText());
		
		win.document.write("</BODY></HTML>");
		win.document.execCommand ("SaveAs",true,"");    
		win.document.close();
		iconEnable = tmp;
	}
	else
	{
		alert("An error occurred when displaying the save template window. If you do not allow popup windows, you must copy/paste the info in the talent window to save the template.");
	}
}
function getTemplateText()
{
    if(chinese) {
    var template = "<b>����ģ��</b><br><br>\n";
    template += "ְҵ: " + className + "<br>\n";
    template += "�ȼ�: " + currentLevel + "<br>\n";
    }else {
    var template = "<b>Save Template</b><br><br>\n";
    template += "Class: " + className + "<br>\n";
    template += "Level: " + currentLevel + "<br>\n";
    }
    
    
    template += "<br><hr><br>\n";
    if(chinese){template += "<b>�����ַ�:</b> " + "<br>\n";}
    else{template += "<b>Build Strings:</b> " + "<br>\n";}
    template += getTemplateStr();
    template += "<br><hr><br>\n";
    
    template += getLearnedText();
    
    if(talentPoints != 0)
    {
	template += "<br><br>\n";
	if (chinese) {template += "<b>ʣ���츳����: " + talentPoints + "</b>";}
	else {template += "<b>Unused Talent Points: " + talentPoints + "</b>";
	}
                                                                
    }
    return template;
}
function getLearnedText()
{
    var template = "";
    for(var i in types)
    {
	if(chinese) {template += "<b><u>" + types[i] + " �츳</u></b> ";}
	else  {template += "<b><u>" + types[i] + " Talent</u></b> ";}
	
	var masteryPoints = masteries[types[i]];
	if(masteryPoints != null)
	{
	    if(chinese) {template += "(" + masteryPoints + " ��";} 
	    else{
	    	template += "(" + masteryPoints + " Point";
	    	if(masteryPoints != 1)
	    	{
			template += "s";
	    	}
	    }
	    template += ")";
	}
	template += "<br><br>";
	
	var typeUsed = false;
	for(var tier = 1; tier <= 7; tier++)
	{
	    for(var j in learned)
	    {
		if(talents[j].Tier == tier && talents[j].Type == types[i] && learned[j] != 0)
		{
		    
		    if (iconEnable && !document.getElementById("simpleOutput").checked) {
		    template += "<img src="+ iconUrl + talents[j].Icon + ">";
		    }else {template += "<li>";}
		    template += "<b>" + talents[j].Name + "</b> - " + learned[j] + "/";
		    template += talents[j].Info.length;

		    if (chinese) {
	    		template += " ��";
		    } else {
		    	template += " Point";
			    if(learned[j] != 1)
			    {
				template += "s";
			    }
			    if(talents[j].Info.length == learned[j])
			    {
				template += " (max)";
			    }
			}

		if( !document.getElementById("simpleOutput").checked){
		    template += "<br>\n";
		    template += getTalentDescription(j, learned[j]);
		    template += "<br>\n";
		    }
		    template += "<br></li>\n";
		    typeUsed = true;
		}
	    }
	}
	
	if(!typeUsed)
	{
	    if(chinese) {
	    	template += "<li>��</li>\n";
	    	} else {
	    	template += "<li>None</li>\n";
	    	}
	}
	template += "<br><br>\n";
    }
    
    return template;
}
function levelKeyPressed()
{
    var key = event.keyCode;
    if(key == 13)
    {
	validateLevel();
    }
}
function validateLevel()
{
    var levelTextBox = document.getElementById("level_text");
    var level = (levelTextBox.value * 1.0).toFixed(0);
    
    if(level == "" || level == null || isNaN(level))
    {
	levelTextBox.value = currentLevel;
	return;
    }
    
    if(level == currentLevel)
    {
	return;
    }
    
    if(level < 1 || level > 60)
    {
	alert("Player level must be between 1 and 60.");
	levelTextBox.value = currentLevel;
	return;
    }
    
    var newLevel = level;
    if(newLevel < 10)
    {
	newLevel = 9;
    }
    if((level < currentLevel) && 
	(currentLevel - newLevel > talentPoints))
    {
	alert("You must unlearn some talents before decreasing your level. Use the Reset Talents button to unlearn all talents.");
	levelTextBox.value = currentLevel;
	return;
    }
    
    setLevel(level);
}
function getTemplateData()
{
    var templateText = "";
    var first = true;
    for(var j in learned)
    {
	if(learned[j] != 0)
	{
	    if(!first)
	    {
		templateText += ",";
	    }
	    first = false;
	    templateText += j + "=" + learned[j];
	}
    }
    
    return templateText;
}
function getTalentDescription(id, rank)
{
    if(talents[id].Description == "")
    {
	return talents[id].Info[rank - 1].Description;
    }
    else
    {
	var description = talents[id].Description;
	var i = 0;
	var rankInfo = talents[id].Info[rank - 1].Amount;
	var amounts = rankInfo.split(",");
	var found = false;
	if(description.indexOf("{" + i + "}") >= 0)
	{
	    found = true;
	}
	while(found)
	{
	    if((amounts.length <= i) || amounts[i] == "")
	    {
		description = description.replace("{" + i + "}", "?");
	    }
	    else
	    {
		description = description.replace("{" + i + "}", amounts[i]);
	    }
	    i++;
	    if(description.indexOf("{" + i + "}") == -1)
	    {
		found = false;
	    }
	}
//	for(var i = 0; i < amounts.length; i++)
//	{
//	    if(amounts[i] == null || amounts[i] == "")
//	    {
//		description = description.replace("{" + i + "}", "?");
//	    }
//	    else
//	    {
//		description = description.replace("{" + i + "}", amounts[i]);
//	    }
//	}
	
	return description;
    }
}
function setInnerHTML(object, html)
{
	if(mozilla)
	{
		var r = object.ownerDocument.createRange();
		r.selectNodeContents(object);
		r.deleteContents();
		var df = r.createContextualFragment(html);
		object.appendChild(df);
	}
	else if(navigator.appName == "Microsoft Internet Explorer")
	{
		object.innerHTML = html;
	}
}
function getInnerHTML(object)
{
	if(mozilla)
	{
		if(object.childNodes.length == 0)
		{
			return "";
		}
		else
		{
			return object.childNodes[0];
		}
	}
	else if(navigator.appName == "Microsoft Internet Explorer")
	{
		return object.innerHTML;
	}
}

//	output str to ID:profileStringOut
/*
**	use tier * col to save the current setting
*/
function getTemplateStr ()
{
	//Class|lvl|tree1:xxxxx|tree2:xxxx|tree3:xxxx
	var strA = new Array(27);
	var strB = new Array(27);
	var strC = new Array(27);
	for (var i = 0; i < 28; i++) {
   		strA[i] = 0;
   		strB[i] = 0;
   		strC[i] = 0;
   	}
	for (var id in talents) {
		if (null != learned[id]) {
			if (talents[id].Type == types[0])
				strA[(talents[id].Tier - 1) * 4 + talents[id].Column - 1] = learned[id];
			if (talents[id].Type == types[1])
				strB[(talents[id].Tier - 1) * 4 + talents[id].Column - 1] = learned[id];
			if (talents[id].Type == types[2])
				strC[(talents[id].Tier - 1) * 4 + talents[id].Column - 1] = learned[id];
		}
	}
	//get the ID from classLst
	//currentClass->	classId[currentClass] -> classLstEn[classId[currentClass]]
	var str2 = classLstEn[classId[currentClass]]+"%7C"+currentLevel+"%7C"+typesIdEn[3*classId[currentClass]]+"%3A"+strA+"%7C"+typesIdEn[3*classId[currentClass]+1]+"%3A"+strB+"%7C"+typesIdEn[3*classId[currentClass]+2]+"%3A"+strC;
	str2 = str2.replace(/,/g,"");
	str2 = str2.replace(/ /g, "%20");
	return str2;
}
function encodeCustomProfileString(){
	document.getElementById("profileStringOut").value=getTemplateStr();
}
    
    /**
     * ���ַ����н������츳�ӵ����ݡ����������ļ����кϷ��Լ�顣
     * �˷������Զ����������ļ�����������ٴε��ü��������ļ�����ط�����
     */
    function decodeCustomProfileString(str)
    {
	if ( null == str )
	{
	    str = document.getElementById("profileString").value;
	}
	if ( str.length <= 0 ){
	    return;
	}
	//check string
	if (! decodeFromString(str)) {return;}
	
    }
    /**	class|level|type1:xxxx|type2:xxxx|type3:xxxx
     * ���ַ����н������츳�ӵ����ݡ����������ļ����кϷ��Լ�顣
     * �˷������Զ����������ļ�����������ٴε��ü��������ļ�����ط�����
     * @param str �ַ�����
     * @return ����ַ�����ʽ�Ϸ������� true�����򷵻� false ��
     * @create 2004-10-30 source0
     */
    function decodeFromString (str)
    {	
	str = unescape(str);
	str = str.replace(/%7C/g, "|");
	str = str.replace(/%3A/g, ":");
	str = str.replace(/%20/g, " ");
	var info = str.split("|");

	/* ������Ҫ����ְҵID���ļ���ַ��һ���츳ϵID*/
	if ( info.length < 3 )
	{
	    alert ("���ݸ�ʽ����������Ҫ����ְҵID���ļ���ַ��һ���츳ϵID�������������ݣ�\n" + str);
	    return false;
	}

	//class|level|type1:xxxx|type2:xxxx|type3:xxxx
	/* ���ְҵID ��*/
	if (  classIdEn[info[0]] == null ){
	    alert ("�����ļ����������ݲ�ƥ�䣺\n�����ļ�ְҵID��"+ classStr + "\n��������ְҵID��" + info[0]);
	    return false;
	}

	var tmpLvl= parseInt(info[1]);

	if (isNaN(tmpLvl) || tmpLvl < 10 || tmpLvl > 60){
		alert("�������ݵȼ���Ч\n"+info[1]);
	    	return false;
	}
	/* ���������ݶΡ� */

	for ( var i = 2; i < info.length; i++ )
	{
	    /* ������ID ��*/
	    if ( info[i].indexOf(":") == 0 )
	    {
		alert ("���ݸ�ʽ���󣬱�������츳ϵID�������������ݣ�\n" + info[i]);
		return false;
	    }
	    /* �������ID����Ҫ���ID ��*/
	    else if ( info[i].indexOf(":") < 0 )
	    {
		if ( !/^\w+$/.test(info[i]) )
		//if ( !/^.*$/.test(info[i]) )	//maybe some chinese char
		{
		alert ("���ݸ�ʽ�����츳ϵID�ĸ�ʽ����ȷ�������������ݣ�\n" + info[i]);
		return false;
		}
	    }
	    /* ID:���� �ĸ�ʽ��*/
	    else
	    {
		//if ( !/^\w+:[0-5]{28}$/.test(info[i]) )
		if ( !/^.*:[0-5]{28}$/.test(info[i]) )
		{
		    alert ("���ݸ�ʽ���󣬼ӵ����ݲ���ȷ�������������ݣ�\n" + info[i]);
		    return false;
		}
	    }
	}
	//class sel
	currentClass = classLst[classIdEn[info[0]]];
	OnSelectType(currentClass);
	loadTalents();
	talents_main();

	var MAX_TIER = 7;
	var MAX_COLUMN = 4;
	var tmp_tal = new Array(6);
	//default
	tmp_tal[0] = types[0];
	tmp_tal[1] = "0000000000000000000000000000";
	tmp_tal[2] = types[1];
	tmp_tal[3] = "0000000000000000000000000000";
	tmp_tal[4] = types[2];
	tmp_tal[5] = "0000000000000000000000000000";
	//info[i] like combat:xxxx or combat
	for ( var i = 2; i < info.length; i++ )
	{
		var reg = new RegExp(".*:[0-5]{" + MAX_TIER * MAX_COLUMN + "}");
		if ( reg.test(info[i]) ){
			var tmpTypes = new Array(
			typesIdEn[classIdEn[info[0]]*3],
			typesIdEn[classIdEn[info[0]]*3+1],
			typesIdEn[classIdEn[info[0]]*3+2]
			);
		    if (tmpTypes[0] == info[i].substring(0, info[i].indexOf(":"))) {
		    	tmp_tal[1] = info[i].substring(parseInt(info[i].indexOf(":")) + 1, info[i].length);
		    }
		    else if (tmpTypes[1] == info[i].substring(0, info[i].indexOf(":"))) {
		    	tmp_tal[3] = info[i].substring(parseInt(info[i].indexOf(":")) + 1, info[i].length);
		    }
		    else if (tmpTypes[2] == info[i].substring(0, info[i].indexOf(":"))) {
		    	tmp_tal[5] = info[i].substring(parseInt(info[i].indexOf(":")) + 1, info[i].length);
		    } else {
		    	alert("�츳����ƥ��\n"+info[i].substring(0, info[i].indexOf(":")));
		    	return false;
		    }
		}
	}
	
	var tal_typ0 = new Array(28);
	var tal_typ1 = new Array(28);
	var tal_typ2 = new Array(28);
	var treePoints = new Array(2);
	var totalPoints;
	treePoints[0] = 0;
	treePoints[1] = 0;
	treePoints[2] = 0;
	totalPoints = 0;
	for (var i = 0; i < tmp_tal[1].length;i++) {
	    tal_typ0[i] = parseInt(tmp_tal[1].charAt(i));
	    totalPoints += tal_typ0[i];
	    treePoints[0] += tal_typ0[i];
	}
	for (var i = 0; i < tmp_tal[3].length;i++) {
	    tal_typ1[i] = parseInt(tmp_tal[3].charAt(i));
	    totalPoints += tal_typ1[i];
	    treePoints[1] += tal_typ1[i];
	}
	for (var i = 0; i < tmp_tal[5].length;i++) {
	    tal_typ2[i] = parseInt(tmp_tal[5].charAt(i));
	    totalPoints += tal_typ2[i];
	    treePoints[2] += tal_typ2[i];
	}
	if (treePoints[0] > tmpLvl - 9 || treePoints[1] > tmpLvl - 9 || treePoints[2] > tmpLvl - 9 || totalPoints > tmpLvl - 9 ){
	    alert ("���ݸ�ʽ���󣬼ӵ����ݳ��������ֵ�������������ݣ�\n" + str);
	    return false;
	}
	resetTalents();
	for (var id in talents) {
		if (talents[id].Type == types[0]) {
			learned[id]= tal_typ0[(talents[id].Tier-1)*4+talents[id].Column-1];
		}else if (talents[id].Type == types[1]) {
			learned[id]= tal_typ1[(talents[id].Tier-1)*4+talents[id].Column-1];
		}else if (talents[id].Type == types[2]) {
			learned[id]= tal_typ2[(talents[id].Tier-1)*4+talents[id].Column-1];
		}
	}
	//alert(tal_typ0+tal_typ1+tal_typ2);
	setLevel(tmpLvl)
	setMastery(types[0], treePoints[0]);
	setMastery(types[1], treePoints[1]);
	setMastery(types[2], treePoints[2]);
	showTalentMap(currentType);
	return true;
    }
    /**
     * ���ַ����н������츳�ӵ����ݡ�
     * @param str �ַ�����Ϊ28�ֽڳ������ֲ����ܺ�С��51��
     * @return ����ַ�����ʽ�Ϸ������� CTalentClassForProfile ʵ�������򷵻� null ��
     * @create 2004-10-30 source0
     */
    function decodeDataString(str)
    {
	var MAX_TIER = 7;
	var MAX_COLUMN = 4;
    
	var reg = new RegExp("[(a-z)(A-Z)_]+:[0-5]{" + MAX_TIER * MAX_COLUMN + "}");
	if ( !reg.test(str) )
	{
	    return null;
	}
	tc.id = str.substring(0, str.indexOf(":"));
	tc.talents = new Array();
	var data = str.substring(parseInt(str.indexOf(":")) + 1, str.length);
	/* ��������Ƿ���ȷ���粻��ȷ������ null�� */
	var count = 0;
	for ( var i = 0; i < MAX_TIER * MAX_COLUMN; i++ )
	{
	    count += parseInt(data.charAt(i));
	}
	if ( count > 51 )
	{
	    return null;
	}
	/* �����츳ϵ�����û�ҵ���˵���ǷǷ����ݡ� */
	var talentClassModel = null;
	for ( var i = 0; i < 3; i++ )
	{
	    if ( ROLE_FOR_PROFILE.talentClasses[i].id == tc.id )
	    {
		talentClassModel = ROLE_FOR_PROFILE.talentClasses[i];
		break;
	    }
	}
	if ( null == talentClassModel )
	{
	    return null;
	}
	/* ʹ�üӵ���Ϣ��ʼ���� */
	var tvs = talentClassModel.getTalentViews();
	for ( var key in tvs )
	{
	    var tv = tvs[key];
	    var rank = data.charAt(4 * tv.model.tier + parseInt(tv.column));
	    if ( rank > 0 )
	    {
		tc.add(tv.model.id, rank);
	    }
	}
	return tc;
    }