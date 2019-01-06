CREATE 
(b1:BIKE { 
    id: "bike1", manufacturer:"Favorit", made: "2016-02-03",  station: "CZE"}),
(b2:BIKE { 
    id: "bike2", manufacturer:"Author", made: "2016-03-04", station: "CZE"}),
(b3:BIKE { 
    id: "bike3", manufacturer:"Author", made: "2017-02-12", station: "CZE"}),
(b4:BIKE { 
    id: "bike4", manufacturer:"Favorit", made: "2017-04-10", station: "CZE"}),
(b5:BIKE { 
    id: "bike5", manufacturer:"Specialized", made: "2018-02-09", station: "DEU"}),
(b6:BIKE { 
    id: "bike6", manufacturer:"KTM", made: "2018-03-11", station: "SVK"}),
(u1:USER {
    id: "user1", nickname: "elephant", registration: "2017-11-27", sex: "M"}),
(u2:USER {
    id: "user2", nickname: "hippo", registration: "2017-10-13", sex: "F"}),
(u3:USER {
    id: "user3", nickname: "pepa", registration: "2018-01-15", sex: "M"}),
(u4:USER {
    id: "user4", nickname: "ema", registration: "2017-12-31", sex: "F"}),
(u5:USER {
    id: "user5", nickname: "ignac", registration: "2018-07-03", sex: "M"}),
(e1:EMPLOYEE { 
    id: "employee1", name: "Dave", from: "2016-02-05", position: "repairman" }), 
(e2:EMPLOYEE { 
    id: "employee2", name: "Brent", from: "2015-03-07", position: "repairman" }), 
(u2)-[r1:RENTAL { 
    name: "My ride to office", date:"2016-12-31", 
    duration: 45, distance: 12}]->(b1),
(u3)-[r2:RENTAL {
    name: "My favourite ride", date:"2017-01-04", 
    duration: 34, distance: 4}]->(b1),
(u1)-[r3:RENTAL {
    name: "Funny ride", date:"2017-02-15", 
    duration: 15, distance: 2}]->(b4),
(u3)-[r4:RENTAL { 
    name: "My favourite ride 2", date:"2017-03-29", 
    duration: 95, distance: 42}]->(b2),
(u4)-[r5:RENTAL {
    name: "Ride my bike", date:"2017-03-30", 
    duration: 72, distance: 30}]->(b1),
(u4)-[r6:RENTAL {
    name: "Go to shop", date:"2017-04-11", 
    duration: 11, distance: 3}]->(b3),
(u3)-[r7:RENTAL {
    name: "Sunday trip", date:"2017-05-14", 
    duration: 83,  distance: 24 }]->(b1),
(e1)-[re1:REPAIR { date: "2016-06-10", type: "complete" }]->(b2),
(e1)-[re2:REPAIR { date: "2017-07-15", type: "partial" }]->(b3),
(e2)-[re3:REPAIR { date: "2018-11-11", type: "partial" }]->(b1),
(e2)-[re4:REPAIR { date: "2017-12-10", type: "complete" }]->(b3),
(e1)-[re5:REPAIR { date: "2018-05-07", type: "partial" }]->(b6),
(u1)-[k1:KNOWS]->(e1),
(u4)-[k2:KNOWS]->(e1),
(u2)-[k3:KNOWS]->(e2),
(u3)-[k4:KNOWS]->(e1);

// -----------------------------------------------------------------------------

// list vsech uzivatel z databaze
MATCH (n:USER) 
RETURN n.id, n.nickname;
