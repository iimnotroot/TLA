---- MODULE clock_2 ----
EXTENDS Naturals

VARIABLE hr

Init == hr = 1
Next == hr' = (hr % 12) + 1 


Spec == Init /\ [][Next]_hr /\ WF_hr(Next)

----

TypeOK == hr \in (1..12)
AlwaysCircle == []<>(hr = 12 /\ (hr = 12 ~> hr = 1))
OnlyPlusOne == []([(hr \in (1..11) => hr' = hr + 1) /\ (hr=12 => hr'= 1)]_hr) 


====