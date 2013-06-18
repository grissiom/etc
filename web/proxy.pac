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
	//return "SOCKS 127.0.0.1:2012";

	if (shExpMatch(host, "*.blogspot.com") ||
	    shExpMatch(url, "*code.google.com/p/gappproxy/*") ||
	    shExpMatch(url, "*.facebook.com/*") ||
	    shExpMatch(url, "*.fbcdn.net/*") ||
	    shExpMatch(host, "*.blogger.com") ||
	    shExpMatch(host, "*.twitter.com") ||
	    shExpMatch(host, "twitter.com") ||
	    shExpMatch(host, "*.twimg.com") ||
	    shExpMatch(host, "*.ffmpeg.org") ||
	    shExpMatch(host, "*golang.org") ||
	    dnsDomainIs(host, "marguerite.su") ||
	    dnsDomainIs(host, "www.sysresccd.org") ||
	    dnsDomainIs(host, "bit.ly") ||
	    dnsDomainIs(host, "is.gd") ||
	    dnsDomainIs(host, "www.newyorker.com") ||
	    dnsDomainIs(host, "upload.wikimedia.org") ||
	    dnsDomainIs(host, "freemorenews.com") ||
	    dnsDomainIs(host, "codereview.chromium.org") ||
	    dnsDomainIs(host, "dev.chromium.org") ||
	    dnsDomainIs(host, "userscripts.wikidot.com") ||
	    dnsDomainIs(host, "twitpic.com") ||
	    dnsDomainIs(host, "hootsuite.com") ||
	    dnsDomainIs(host, "www.mail-archive.com") ||
	    dnsDomainIs(host, "feeds.feedburner.com") ||
	    dnsDomainIs(host, "docs.google.com") ||
	    dnsDomainIs(host, "www.­tumblr.­com") ||
	    dnsDomainIs(host, "www.20thingsilearned.com") ||
	    dnsDomainIs(host, "www.youtube.com")
	   ) {
		   return "SOCKS 127.0.0.1:2012";
	}

	//if ( dnsDomainIs(host,  ".edu") )
		//return "PROXY 127.0.0.1:8000";
	//else if ( dnsDomainIs(host, "www.baidu.com") || shExpMatch(url, "*.gov.cn/*") )
		//return "SOCKS 127.0.0.1:9050";

	return "DIRECT";
}
// vim:ft=java
