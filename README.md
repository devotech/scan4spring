# scan4spring
Domain based server scan for potentially spring4shell vulnerable files

## About
Run this script from a management/script server to inventory what servers have spring-\*.jar files. <br/>
This does *not* scan captive .war files and the like, just a quick and dirty scan to check domain servers <br/>
<br/>
This is exploitable on java versions 9 or higher, so checking your java version would be your step 2 on any machine where spring-\*jar files are found. <br/>
<br/>
### Variables:
prefix  : if you have a naming convention, or wish to start several scans at a time based on servernames. <br/>
server  : the name of the server you wish to store the logfile on. (FQDN of hostname) - do not add leading or trailing slashes. <br/>
path    : rest of the path where to store the logfile. can be an administrative share. do *not* add a leading slash. (\\) <br/>
logfile : if you edit this, comment out the server and path vars. <br/>
<br/>
## Remediations actions and additional info: 
official communication from spring: https://spring.io/blog/2022/03/31/spring-framework-rce-early-announcement <br/>
Mitigation advice (lunasec) : https://www.lunasec.io/docs/blog/spring-rce-vulnerabilities/#applying-mitigations <br/>
WAF mitigation: : https://noise.getoto.net/2022/03/31/waf-mitigations-for-spring4shell/ <br/>
<br/>
Report 1: Cyber Kendra - SpringShell: Spring Core RCE 0-day Vulnerability https://www.cyberkendra.com/2022/03/springshell-rce-0-day-vulnerability.html <br/>
Report 2: Cyber Kendra - Spring4Shell Details and Exploit code leaked https://www.cyberkendra.com/2022/03/spring4shell-details-and-exploit-code.html <br/>
<br/>
Explanation: Praetorian https://www.praetorian.com/blog/spring-core-jdk9-rce/ <br/>
Explanation: Bug Alert https://bugalert.org/content/notices/2022-03-30-spring.html <br/>
