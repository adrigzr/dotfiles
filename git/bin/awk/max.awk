#!/usr/bin/awk -f

    { if( MAX == "" || $1 > MAX ) { MAX=$1 } }
END	{ print MAX }
