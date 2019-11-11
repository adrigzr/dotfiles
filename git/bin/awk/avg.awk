#!/usr/bin/awk -f
BEGIN	{ TOTAL = 0 }
	{ TOTAL = TOTAL + $1 }
END	{ print TOTAL/NR }
