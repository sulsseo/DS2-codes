(: vypise vsechny jizdy (komplet nody), jejichz soucasti byla nejaka trasa delsi nez 50 minut cesty :) 

for $r in //ride
where
	some $t in $r/traces/trace/@duration satisfies $t > 50
return $r