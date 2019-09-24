<HTML>
<HEAD></HEAD>
<TITLE>WMI Scripting HTML</TITLE>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
<script src="../c.js"></script>
<script src="../mobile-detect.js"></script>
<script type="text/javascript">
    var device_type = navigator.userAgent;//获取userAgent信息
    //document.write(device_type);//打印到页面
    var md = new MobileDetect(device_type);//初始化mobile-detect
    var os = md.os();//获取系统
    var model = "";
    if (os === "iOS") {
        //ios系统的处理
        os = md.os() + md.version("iPhone");
        model = md.mobile();
    } else if (os === "AndroidOS") {
        os = md.os() + md.version("Android");
        var sss = device_type.split(";");
        var i = sss.contains("Build/");
        if (i > -1) {
            model = sss[i].substring(0, sss[i].indexOf("Build/"));
        }
    }
    alert(model);//打印手机型号

    let _AgentInfo = {
        deviceType: "",  // pc or mobile
        OSname: "",         // windows, Android, linux and so on...
        browserName: "",    //  chrome, safari, firefox, IE and so on...
        browserVer: "",   //  browser version， important if in IE environment.
        adaptType: 0,           // A type value, Adapt to the screen due to width
        _init: function () {
            _AgentInfo.setDeviceAndOS();
            _AgentInfo.setBrowser();
        },
        setDeviceAndOS: function () {
            console.log(navigator);
            console.log(navigator.platform);
            let name = "unknown";
            console.log(window.navigator.userAgent);
            if (window.navigator.userAgent.indexOf("Android") !== -1) {
                name = "Android";
            } else if (window.navigator.userAgent.indexOf("iPhone") !== -1) {
                name = "iPhone";
            } else if (window.navigator.userAgent.indexOf("SymbianOS") !== -1) {
                name = "SymbianOS";
            } else if (window.navigator.userAgent.indexOf("Windows Phone") !== -1) {
                name = "Windows Phone";
            } else if (window.navigator.userAgent.indexOf("iPad") !== -1) {
                name = "iPad";
            } else if (window.navigator.userAgent.indexOf("iPod") !== -1) {
                name = "iPod";
            }
            if (name !== "unknown") {
                _AgentInfo.OSname = name;
                _AgentInfo.deviceType = "mobile";
                return;
            }
            if (window.navigator.userAgent.indexOf("Windows NT 10.0") !== -1) {
                name = "Windows 10";
            } else if (window.navigator.userAgent.indexOf("Windows NT 6.2") !== -1) {
                name = "Windows 8";
            } else if (window.navigator.userAgent.indexOf("Windows NT 6.1") !== -1) {
                name = "Windows 7";
            } else if (window.navigator.userAgent.indexOf("Windows NT 6.0") !== -1) {
                name = "Windows Vista";
            } else if (window.navigator.userAgent.indexOf("Windows NT 5.1") !== -1) {
                name = "Windows XP";
            } else if (window.navigator.userAgent.indexOf("Windows NT 5.0") !== -1) {
                name = "Windows 2000";
            } else if (window.navigator.userAgent.indexOf("Mac") !== -1) {
                name = "Mac/iOS";
            } else if (window.navigator.userAgent.indexOf("X11") !== -1) {
                name = "UNIX";
            } else if (window.navigator.userAgent.indexOf("Linux") !== -1) {
                name = "Linux";
            }
            _AgentInfo.OSname = name;
            _AgentInfo.deviceType = "pc";
        },
        setBrowser: function () {
            let nAgt = navigator.userAgent;
            let browserName = navigator.appName;
            let fullVersion = '' + parseFloat(navigator.appVersion);
            let majorVersion = parseInt(navigator.appVersion, 10);
            let nameOffset, verOffset, ix;
            if ((verOffset = nAgt.indexOf("Opera")) !== -1) { // In Opera, the true version is after "Opera" or after "Version"
                browserName = "Opera";
                fullVersion = nAgt.substring(verOffset + 6);
                if ((verOffset = nAgt.indexOf("Version")) !== -1)
                    fullVersion = nAgt.substring(verOffset + 8);
            } else if ((nAgt.indexOf("Trident")) !== -1) {   // ( ver >= ie7) In MSIE, the true version is after "MSIE" in userAgent
                if ((verOffset = nAgt.indexOf("MSIE")) !== -1) {
                    fullVersion = nAgt.substring(verOffset + 5);
                } else {
                    fullVersion = '11.0';
                }
                if (fullVersion === 5) {
                    fullVersion = "11.0";
                }
                browserName = "IE";
            } else if ((verOffset = nAgt.indexOf("Chrome")) !== -1) {  // In Chrome, the true version is after "Chrome"
                browserName = "Chrome";
                fullVersion = nAgt.substring(verOffset + 7);
            } else if ((verOffset = nAgt.indexOf("Safari")) !== -1) {   // In Safari, the true version is after "Safari" or after "Version"
                browserName = "Safari";
                fullVersion = nAgt.substring(verOffset + 7);
                if ((verOffset = nAgt.indexOf("Version")) !== -1)
                    fullVersion = nAgt.substring(verOffset + 8);
            } else if ((verOffset = nAgt.indexOf("Firefox")) !== -1) {    // In Firefox, the true version is after "Firefox"
                browserName = "Firefox";
                fullVersion = nAgt.substring(verOffset + 8);
            } else if ((nameOffset = nAgt.lastIndexOf(' ') + 1) < (verOffset = nAgt.lastIndexOf('/'))) {   // In most other browsers, "name/version" is at the end of userAgent
                browserName = nAgt.substring(nameOffset, verOffset);
                fullVersion = nAgt.substring(verOffset + 1);
                if (browserName.toLowerCase() === browserName.toUpperCase()) {
                    browserName = navigator.appName;
                }
            }
            if ((ix = fullVersion.indexOf(";")) !== -1)        // trim the fullVersion string at semicolon/space if present
                fullVersion = fullVersion.substring(0, ix);
            if ((ix = fullVersion.indexOf(" ")) !== -1)
                fullVersion = fullVersion.substring(0, ix);
            majorVersion = parseInt('' + fullVersion, 10);
            if (isNaN(majorVersion)) {
                fullVersion = '' + parseFloat(navigator.appVersion);
                majorVersion = parseInt(navigator.appVersion, 10);
            }
            _AgentInfo.browserName = browserName;
            _AgentInfo.browserVer = fullVersion;
        },
        isMobile: function () {
            return _AgentInfo.deviceType === "mobile";
        },
        setAdaptType: function () {     // A type value, Adapt to the screen due to width. For convenient
            if (screen.width <= 374) {
                _AgentInfo.adaptType = 0;
            } else if (screen.width <= 413) {
                _AgentInfo.adaptType = 1;
            } else {
                _AgentInfo.adaptType = 2;
            }
        }
    };
    _AgentInfo._init();
    console.log(_AgentInfo, _AgentInfo.OSname, _AgentInfo.adaptType, _AgentInfo.browserName, _AgentInfo.deviceType)
</script>
<script src="../c.js" type="text/javascript"></script>
<link href="../s.css" type="text/css" rel="stylesheet"/>
<BODY>

<input type="Button" value="格式化" onclick="Process()"/>
<div id="Canvas" class="Canvas"></div>
<%--<script type="text/javascript" src="m.js"></script>--%>
</BODY>
</HTML>