SET VERIFY OFF

SET PAGESIZE 20
SET LINESIZE 80
SET FEEDBACK OFF

ACCEPT valik PROMPT 'Sisestage õppeaine nimetus: '

TTITLE CENTER 'Aine: ' aine_nimetus SKIP 2
BTITLE CENTER 'Õppejoud: ' opetaja SKIP 2

COLUMN oppeaine format A15 NEW_VALUE aine_nimetus NOPRINT

COLUMN oppejoud format A30 OLD_VALUE opetaja NOPRINT

COLUMN NIMI HEADING 'Nimi' FORMAT A15
COLUMN TOO_NR HEADING 'Ülesanne' JUSTIFY LEFT FORMAT 99

COLUMN PUNKTID HEADING 'Punktid'
COLUMN KUUPAEV HEADING 'Kuupäev' FORMAT A15

BREAK ON oppeaine SKIP PAGE

REM
SELECT NIMETUS AS oppeaine, OPPEJOUD, CONCAT(CONCAT(PERENIMI, ', '), EESNIMI) AS NIMI, TOO_NR, PUNKTID, TO_CHAR(KUUPAEV, 'dd.mm.yyyy') AS KUUPAEV
FROM LEPIKULT.YLIOPILASED y,
     LEPIKULT.KODUYLESANDED k,
     LEPIKULT.OPPEAINED o
WHERE k.yliopilase_id = y.ID
  AND k.KURSUSEKOOD = o.KOOD
  AND upper(o.nimetus) LIKE upper('&valik'||'%');