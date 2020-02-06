#pierwszy przebieg

BEGIN{
#etykiety przed instrukcja !

	R2["r0,r0"]="0";
	R2["r0,r1"]="1";
	R2["r0,r2"]="2";
	R2["r0,r3"]="3";
	R2["r1,r0"]="4";
	R2["r1,r1"]="5";
	R2["r1,r2"]="6";
	R2["r1,r3"]="7";
	R2["r2,r0"]="8";
	R2["r2,r1"]="9";
	R2["r2,r2"]="A";
	R2["r2,r3"]="B";
	R2["r3,r0"]="C";
	R2["r3,r1"]="D";
	R2["r3,r2"]="E";
	R2["r3,r3"]="F";

	R2["(r0),r0"]="0";
	R2["(r0),r1"]="1";
	R2["(r0),r2"]="2";
	R2["(r0),r3"]="3";
	R2["(r1),r0"]="4";
	R2["(r1),r1"]="5";
	R2["(r1),r2"]="6";
	R2["(r1),r3"]="7";
	R2["(r2),r0"]="8";
	R2["(r2),r1"]="9";
	R2["(r2),r2"]="A";
	R2["(r2),r3"]="B";
	R2["(r3),r0"]="C";
	R2["(r3),r1"]="D";
	R2["(r3),r2"]="E";
	R2["(r3),r3"]="F";

	R2["r0,(r0)"]="0";
	R2["r0,(r1)"]="1";
	R2["r0,(r2)"]="2";
	R2["r0,(r3)"]="3";
	R2["r1,(r0)"]="4";
	R2["r1,(r1)"]="5";
	R2["r1,(r2)"]="6";
	R2["r1,(r3)"]="7";
	R2["r2,(r0)"]="8";
	R2["r2,(r1)"]="9";
	R2["r2,(r2)"]="A";
	R2["r2,(r3)"]="B";
	R2["r3,(r0)"]="C";
	R2["r3,(r1)"]="D";
	R2["r3,(r2)"]="E";
	R2["r3,(r3)"]="F";
	
	R1["r0"]="0";
	R1["r1"]="1";
	R1["r2"]="2";
	R1["r3"]="3";
	
	adres=0
}

/add/                          { print "000" R2[$2] 
                                 adres++}
/sub/                          { print "001" R2[$2] 
                                 adres++}
/and/                          { print "002" R2[$2] 
                                 adres++}
/or/                           { print "003" R2[$2] 
                                 adres++}

/move[ /t].*\(r[0-3]\),r[0-3]/ { print "004" R2[$2] 
                                 adres++}
/move[ /t].*r[0-3],\(r[0-3]\)/ { print "005" R2[$2] 
                                 adres++}
/move[ /t].*r[0-3],r[0-3]/     { print "006" R2[$2] 
                                 adres++}
/move[ /t].*#[0-9A-F][0-9A-F],r[0-3]/ { split($2,sep,"[,#]") 
                                        adres++
										#dznak = sprintf("%02x",strtonum(sep[2]));
										dznak=sep[2]
                                        print dznak "7" R1[sep[3]] }

/jeq[ /t].*r[0-3],/                   { split($2,sep,",") 
                                        adres++
                                        print sep[2] " " "8" R1[sep[1]] }
/jne[ /t].*r[0-3],/                   { split($2,sep,",") 
                                        adres++
                                        print sep[2] " " "9" R1[sep[1]] }
/jge[ /t].*r[0-3],/                   { split($2,sep,",") 
                                        adres++
                                        print sep[2] " " "A" R1[sep[1]] }
/jlt[ /t].*r[0-3],/                   { split($2,sep,",") 
                                        adres++
                                        print sep[2] " " "B" R1[sep[1]] }
/jmp[ /t].*/                          { adres++ 
                                        print $2 " " "F0"}

/[a-zA-Z0-9].*:/					  { split($1,sep,":")
                                        #print "ETYKIETA "  adres " " sep[1] 
										ETYKIETY[sep[1]]=adres}
										
END{
  for (i in ETYKIETY)
  {
    dznak = sprintf("%02x",ETYKIETY[i]);
    print i " " dznak > "skoki.txt"
  }
}
