// JavaScript Document

/*dayArray = new Array(6)
dayArray[0]="������"
dayArray[1]="����һ"
dayArray[2]="���ڶ�"
dayArray[3]="������"
dayArray[4]="������"
dayArray[5]="������"
dayArray[6]="������"*/


function addZero(num)
{
	if(num>10)
		return num;
	else
		return "0"+num;
}

function showTime()
{
	var today = new Date();
	var year = today.getYear();
	var month = today.getMonth();
	var date = today.getDate();
	var hour = today.getHours();
	var minute = today.getMinutes();
	var second = today.getSeconds();
	//var day = today.getDay();
	
	document.getElementById("stime").innerHTML=year+"��"+(month+1)+"��"+date+"��    "+addZero(hour)+":"+addZero(minute)+":"+addZero(second);

	setTimeout("showTime()",1000);
}
//showTime()
setInterval("showTime()",1000)