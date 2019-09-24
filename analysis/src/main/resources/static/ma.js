function GetAdapterInfo() {

    var locator = new ActiveXObject ("WbemScripting.SWbemLocator");
    var service = locator.ConnectServer("."); //连接本机服务器
    var properties = service.ExecQuery("SELECT * FROM Win32_NetworkAdapterConfiguration where IPEnabled=TRUE");
    //查询使用SQL标准
    var e = new Enumerator (properties);
    var msg="";
    for (;!e.atEnd();e.moveNext ())
    {
        var p = e.item ();
        msg+="Caption:" + p.Caption + " "; //网卡描述,也可以使用Description
        msg+="IP:" + p.IPAddress(0) + " ";//IP地址为数组类型,子网俺码及默认网关亦同
        msg+="MAC:" + p.MACAddress + " "; //网卡物理地址
    }
    return msg;

}
alert( GetAdapterInfo());