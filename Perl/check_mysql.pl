#!/usr/bin/perl
use Time::Local;
use DBI;
$now_string = localtime;

$db='mysql';
$host='localhost';
$user='user';
$pwd='pwd';
$log="/var/log/!_check.log";
open(STDERR, '>>', $log) or die "Can't open log";
$dbh = DBI->connect("dbi:mysql:$db:$host",$user,$pwd)
   or die $now_string." -> Connection Error: $DBI::errstr\n";
 $sql = "SHOW GLOBAL STATUS like 'Uptime';";
 $sth = $dbh->prepare($sql);
 $sth->execute
   or die "SQL Error: $DBI::errstr\n";
while (@row = $sth->fetchrow_array) {
#    print "@row\n";
    $cmd="echo '".$now_string."->".join(" ",@row)."'>>$log";
    $out=`$cmd`;
}

