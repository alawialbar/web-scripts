#!/usr/bin/perl
#
# Description:
# This Perl/CGI script prints standard HTML page with related HTTP headers for the connection path: Client -> Load Balancer -> Apache Host
# The following are the used HTTP headers:
#
# SERVER_ADDR: default HTTP header showing the IP Address of the Apache Web Server
# HOSTNAME: an exported environment variable (HOSTNAME) that is exposed as HTTP header inside httpd.conf using the PassEnv directive. It  shows the hostname of the Apache Web Server.
# HTTP_HOST: default HTTP header showing the web server Hostname/IP that is part of the URL (http://HTTP_HOST/PATH)
# REMOTE_ADDR: default HTTP header showing the IP Address of the connecting endpoint (either Client or Load Balancer)
# forwarded: a custom HTTP header configured in httpd.conf using SetEnvIf directive that extracts the IP Address from the X-Forwarded-For header if it's sent by the Load Balancer or Proxy server
# 
# How-to use:
# Copy the file into your cgi-bin directory (or any virtual directory with +ExecCGI option) and chmod a+x to enable script execution. You will need to update your httpd.conf file to enable the custom HTTP headers as follows:
#
# LogFormat "%{X-Forwarded-For}i %l %u %t \"%r\" %>s %O \"%{Referer}i\" \"%{User-Agent}i\"" proxy
# SetEnvIf X-Forwarded-For "^\b(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})\b" forwarded=$1
# PassEnv HOSTNAME
# CustomLog "logs/access_log" proxy env=forwarded

use strict;

print "Content-type: text/html\n\n";

print "<h2>Server IP = $ENV{'SERVER_ADDR'}</h2>";
print "<h3>Server Hostname = $ENV{'HOSTNAME'}</h3>";
print "<h3>Webserver Hostname = $ENV{'HTTP_HOST'}</h3>";
print "<h2>Remote IP = $ENV{'REMOTE_ADDR'}</h2>";
print "<h2>X-FORWARDED-FOR = $ENV{'forwarded'}</h2>";
print "<h3>Server Signature = $ENV{'SERVER_SIGNATURE'}</h3>";

