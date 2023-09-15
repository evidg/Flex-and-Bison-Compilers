%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "code_parser.tab.h"
int line=1;
%}
ALPHA [a-zA-Z_]
DIGIT [0-9]
DIGITS {DIGIT}+
FRAC [.]{DIGITS}
EXP {E}{DIGITS}
E [eE][+-]?
HEX_DIGIT [0-9a-f]
UNESCAPEDCHAR [ -!#-\[\]-~]
ESCAPEDCHAR \\["\\bfnrt/]
UNICODECHAR \\u{HEX_DIGIT}{HEX_DIGIT}{HEX_DIGIT}{HEX_DIGIT}
CHAR {UNESCAPEDCHAR}|{ESCAPEDCHAR}|{UNICODECHAR} 
STR {CHAR}+	
%%
true			{printf("%s", yytext); return TRUE; }
false			{printf("%s", yytext); return FALSE; }
\"id\"			{printf("%s", yytext); return JSON_ID; }
\"id_str\"		{printf("%s", yytext); return JSON_IDSTR; }
\"text\"		{printf("%s", yytext); return JSON_TEXT; }
\"user\"		{printf("%s", yytext); return JSON_USER; }
\"name\"		{printf("%s", yytext); return JSON_NAME; }
\"screen_name\"		{printf("%s", yytext); return JSON_SCREENNAME; }	
\"location\"		{printf("%s", yytext); return JSON_LOCATION; }
\"tweet\"		{printf("%s", yytext); return JSON_TWEET; }
\"retweeted_status\"	{printf("%s", yytext); return JSON_RETWEETEDSTATUS; }
\"extended_tweet\"	{printf("%s", yytext); return JSON_EXTENDEDTWEET; }
\"created_at\"		{printf("%s", yytext); return JSON_CREATEDAT; }
Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec	{printf("%s",yytext); return JSON_MONTH;}
Mon|Thu|Wed|Tue|Fri|Sat|Sun { printf("%s", yytext); return JSON_DAY;}
\{	{printf("{"); return '{';}
\}	{printf("}"); return '}';}
\"	{printf("\""); return JSON_QUOT;}
,	{printf(","); return ',';}
:	{printf(":"); return ':';}	
\"{DIGITS}\"	{printf("%s", yytext); return JSON_STRNUM; }
\"{STR}\"	{printf("%s", yytext); return JSON_STRING; }	
{DIGITS}	{printf("%s", yytext); return JSON_NUM; }
\n 	{printf("%s",yytext); line++; }  
[ ] 	{printf("%s",yytext);};
[\t] 	{printf("%s",yytext);};
%%
