function FindProxyForURL(url, host) {
	// Use ipv6 for them
	//from http://ftofficer.spaces.live.com/blog/cns!423B72634E2F6B7E!1073.entry
	//if (shExpMatch(host, "*.appspot.com")) {
		//return "PROXY www.google.cn:80";
	//}
	//if (shExpMatch(host, "appengine.google.com")) {
		//return "PROXY www.google.cn:80";
	//}
	//if (dnsDomainIs(host, "docs.google.com")) {
		//return "PROXY www.google.cn:443";
	//}

	if (shExpMatch(host, "*.blogspot.com") ||
	    shExpMatch(url, "*code.google.com/p/gappproxy/*") ||
	    shExpMatch(url, "*.facebook.com/*") ||
	    shExpMatch(url, "*.fbcdn.net/*") ||
	    shExpMatch(url, "*.amd.com/*") ||
	    shExpMatch(host, "*.blogger.com") ||
	    shExpMatch(host, "*.twitter.com") ||
	    shExpMatch(host, "twitter.com") ||
	    shExpMatch(host, "*.twimg.com") ||
	    shExpMatch(host, "*golang.org") ||
	    dnsDomainIs(host, "bit.ly") ||
	    dnsDomainIs(host, "twitpic.com") ||
	    dnsDomainIs(host, "hootsuite.com") ||
	    dnsDomainIs(host, "www.golang.org") ||
	    dnsDomainIs(url, "http://creativecommons.org/licenses/by-nc/2.5/cn/deed.en_US") ||
	    dnsDomainIs(host, "www.mail-archive.com") ||
	    dnsDomainIs(host, "tools.google.com")
	   )
		// Use ipv6 for them. They need https.
		//shExpMatch(host, "*.blogger.com")  ||
		return "PROXY 127.0.0.1:8000"

	//if ( dnsDomainIs(host,  ".edu") )
		//return "PROXY 127.0.0.1:8000";
	//else if ( dnsDomainIs(host, "www.baidu.com") || shExpMatch(url, "*.gov.cn/*") )
		//return "SOCKS 127.0.0.1:9050";

	return "DIRECT";
}
// vim:ft=java
