(: vypise stastistiky o jizdach, konkretne delku a jmeno u tras, ktere jsou nadprumerne dlouhe. :)

element statistics {
let $t := //ride/traces/trace/@distance
let $a := avg($t)
for $r in //ride
where 
	every $d in $r/traces/trace/@distance satisfies $d > $a
return 
    	element traces {
        	element trace {
            	element name {
                	$r/traces/trace/text()
                },
                
                element distance {
                	data($r/traces/trace/@distance)
                }
            }
        }
    }