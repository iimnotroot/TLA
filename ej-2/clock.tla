---- MODULE clock ----

EXTENDS Naturals

VARIABLES hr, minutes, mode

AM == 0 \* AM con valor 0
PM == 1 \* PM con valor 1

RANGE_HR == (1..12)
RANGE_MIN == (0..59)
RANGE_MODE == {AM,PM}

Init == (hr \in RANGE_HR) /\ (minutes \in RANGE_MIN) /\ (mode \in RANGE_MODE)
Next == 
    \/(minutes = 59 /\ hr < 11 /\ minutes' = 0 /\ hr' = hr + 1 /\ mode'=mode)
    \/(minutes = 59 /\ hr = 11 /\ minutes' = 0 /\ hr' = 12 /\ IF mode = AM THEN mode' = PM ELSE mode' = AM)
    \/(minutes = 59 /\ hr = 12 /\ minutes' = 0 /\ hr' = 1 /\ mode' = mode)
    \/(minutes < 59 /\ minutes' = minutes + 1 /\ hr' = hr /\ mode'=mode)

\* Requisitos de aumento de minutos, horas y cambio de AM y PM

Spec == Init /\ [][Next]_<<hr,minutes,mode>> /\ WF_<<hr,minutes,mode>>(Next) 
----

TypeOK == hr \in RANGE_HR /\ minutes \in RANGE_MIN /\ mode \in RANGE_MODE \* Propiedad tipo Safety
ModeChange == (hr = 11 /\ minutes = 59) => (/\ hr' = 12 /\ minutes' = 0 /\ mode' # mode) \* Propiedad para comprobar que se cambia de AM a PM y viceversa a las 11:59
TwelveToOne == []<>((hr = 12 /\ minutes = 59) /\ ((hr = 12 /\ minutes = 59) ~> (hr = 1 /\ minutes = 0))) \* Propiedad liveness
AlwaysUpHr == [][(hr # 12 /\ hr' = hr + 1 ) \/ (hr=12 /\ hr' = 1)]_hr
AlwaysUpMin == [][(minutes # 59 /\ minutes' = minutes + 1 ) \/ (minutes=59 /\ minutes' = 0)]_minutes

====