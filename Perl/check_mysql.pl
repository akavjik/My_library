#!/bin/perl
use DBI;
$db='mysql';
$host='localhost';
$user='user';
$pwd='pwd';

 $dbh = DBI->connect('dbi:mysql:$db:$host,$user,$pwd)
   or die "Connection Error: $DBI::errstr\n";
 $sql = "SHOW GLOBAL STATUS like 'Uptime';";
 $sth = $dbh->prepare($sql);
 $sth->execute
   or die "SQL Error: $DBI::errstr\n";
 while (@row = $sth->fetchrow_array) {
#   print "@row\n";
   $cmd="echo '".join(" ",@row)."'>>/var/log/!mysql_check.log";
   $out=`$cmd`;
 }
