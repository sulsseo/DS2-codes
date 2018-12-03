Input
=====

Soubor s daty je strukturovaný soubor, který má na každém řádku jednu entitu. 
Informace o entitách jsou v řádku a rozdělené středníkem - klasické csv. Jednotlivé sloupce
poté drží tyto informace.

název;výrobce;stanice-země;stanice-město;datum_výroby;velikost_kola;pohlaví;

Job
===

MapReduce job počítá průměrné stáří kol různých výrobců

v map fázi:
 - najde výrobce kola a k němu spočítá stáří k dnešnímu datu
 - emituje dvojici (výrobce, stáří kola ve dnech)

v reduce fázi:
 - redukují se řádky podle výrobce a k nim se spočítá průměrné stáří 
   přes všechny záznamy
 - exportuje výsledek (výrobce, průmerné stáří všech kol ve dnech)