function FindProxyForURL(url, host) {
	// Use ipv6 for them
	//from http://ftofficer.spaces.live.com/blog/cns!423B72634E2F6B7E!1073.entry
	//if (shExpMatch(host, "*.appspot.com")) {
		//return "PROXY www.google.cn:80";
	//}
	//if (shExpMatch(host, "appengine.google.com")) {
		//return "PROXY www.google.cn:80";
	//}

	if (shExpMatch(host, "*.blogspot.com") ||
	    shExpMatch(url, "*code.google.com/p/gappproxy/*") ||
	    dnsDomainIs(host, "bit.ly")
	    )
		// Use ipv6 for them. They need https.
		//shExpMatch(host, "*.blogger.com")  ||
		//shExpMatch(url, "*chrome.google.com/extensions*") ||
		//shExpMatch(host, "clients2.google.com") ||
		return "PROXY 127.0.0.1:8000"

	//if ( dnsDomainIs(host,  ".edu") )
		//return "PROXY 127.0.0.1:8000";
	//else if ( dnsDomainIs(host, "www.baidu.com") || shExpMatch(url, "*.gov.cn/*") )
		//return "SOCKS 127.0.0.1:9050";

	return "DIRECT";
}
// vim:ft=java
