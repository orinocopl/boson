#drugi przebieg
BEGIN{

       while ((getline < "skoki.txt") > 0)
	   {
#               print $1 " " $2
               ETYKIETY[$1]=$2
	   }
       close("skoki.txt")
	   
	print "v2.0 raw"
}

#// {print $0}

/^[0-9A-F][0-9A-F][0-9A-F][0-9A-F]$/ {
#print "instrukcja" 
print $0
}

/[0-9a-zA-Z].* [0-9A-F][0-9A-F]/ {
#print "instrukcja z etykieta" 
print ETYKIETY[$1] $2
}

