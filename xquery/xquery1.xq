(: vytvori html tabulku se vsemy jizdami srovnane vzestupne podle data :)

<table>
	<tr>
    	<th>Date</th>
        <th>Duration (km)</th>
        <th>Distance</th>
        <th>Name</th>
    </tr>
    {
    for $r in /rental/rides/ride
	let $d := $r/date
    order by $d ascending
	return 
    <tr>
    	<td>{data($r/date)}</td>
        <td>{data($r/traces/trace/@duration)}</td>
        <td>{data($r/traces/trace/@distance)}</td>
        <td>{
        	if (data($r/traces/trace)) 
            then data($r/traces/trace)
            else "empty"
        }</td>
    </tr>
    }
</table>