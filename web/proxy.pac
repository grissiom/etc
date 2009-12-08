// vim:ft=java
function FindProxyForURL(url, host) {
	//from http://ftofficer.spaces.live.com/blog/cns!423B72634E2F6B7E!1073.entry
	if (shExpMatch(host, "*.appspot.com")) {
		return "PROXY www.google.cn:80";
	}
	if (shExpMatch(host, "appengine.google.com")) {
		return "PROXY www.google.cn:80";
	}

	if (shExpMatch(host, "*.blogspot.com"))
		return "PROXY 127.0.0.1:8000"
	if (shExpMatch(url, "*code.google.com/p/gappproxy/*"))
		return "PROXY 127.0.0.1:8000"
	//if ( dnsDomainIs(host,  ".edu") )
		//return "PROXY 127.0.0.1:8000";
	//else if ( dnsDomainIs(host, "www.baidu.com") || shExpMatch(url, "*.gov.cn/*") )
		//return "SOCKS 127.0.0.1:9050";

	return "DIRECT";
}
