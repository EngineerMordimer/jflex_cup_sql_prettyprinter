package Example;

import java_cup.runtime.*;
import java_cup.runtime.ComplexSymbolFactory.Location;
import java.io.*;
%%
%cup
%line
%column
%char
%integer
%ignorecase
%yyeof

%class Scanner
%{
	private static final Boolean DEBUG=true;
	private ComplexSymbolFactory sf;

	public Scanner(java.io.InputStream r, ComplexSymbolFactory sf){
		this(new InputStreamReader(r));
		this.sf=sf;
	}
	public Symbol symbol(String plaintext,int code){
	    return sf.newSymbol(plaintext,code,new Location("",yyline+1, yycolumn +1,yychar), new Location("",yyline+1,yycolumn+yylength(),yychar));
	}
	public Symbol symbol(String plaintext,int code,Object value){
	    return sf.newSymbol(plaintext,code,new Location("",yyline+1, yycolumn +1,yychar), new Location("",yyline+1,yycolumn+yylength(),yychar),value);
	}
	public Integer getSpacesLength(String yytext){
	    int starIndex = yytext.indexOf("*");
	    String spacesPart = yytext.substring(0,starIndex-1);
	    return spacesPart.length();
	}

	public Symbol superSymbol(String plaintext,int code){
	    if(DEBUG){
        	System.out.printf(plaintext+" found [%s]\n",yytext());
        }
	    return sf.newSymbol(plaintext,code,new Location("",yyline+1,
	    yycolumn +1,
	    yychar),
	    new
	    Location("",yyline+1,yycolumn+yylength(),yychar));
	}

	public Symbol superSymbol(String plaintext,int code,Object value){
		if(DEBUG){
			System.out.printf(plaintext+" found [%s]\n",yytext());
		}
		return sf.newSymbol(plaintext,code,new Location("",yyline+1,
		yycolumn +1,yychar), new Location("",yyline+1,yycolumn+yylength(),yychar),value);
	}
%}
%eofval{
    return sf.newSymbol("EOF",sym.EOF);
%eofval}

nl				= [\n|\r|\r\n]+
tab				= [\t\f]
space			= (" ")+
comma           = ","
obracket        = "("
cbracket        = ")"
string			= [a-zA-Z0-9.;:>=_\-()'&%*]+

select			= "SELECT"
from			= "FROM"
ljoin			= "LEFT"" "+"JOIN"
rjoin			= "RIGHT"" "+"JOIN"
njoin			= "JOIN"
union			= "UNION"" ALL"?
where           = "WHERE"
and             = "AND"
or              = "OR"
between         = "BETWEEN".+"AND"
todate          = "TO_DATE(".+")"
coalesce        = "COALESCE(".+")"
case            = "CASE"
when            = "WHEN"
else            = "ELSE"
end             = "END"
group           = "GROUP"" "+"BY"
order           = "ORDER"" "+"BY"

%%

{select}      	{	return superSymbol("SELECT", sym.SELECT, new String(yytext()));}
{from}      	{	return superSymbol("FROM", sym.FROM, new String(yytext()));}
{ljoin}      	{	return superSymbol("LJOIN", sym.LJOIN, new String(yytext()));}
{rjoin}      	{	return superSymbol("RJOIN", sym.RJOIN, new String(yytext()));}
{njoin}      	{	return superSymbol("NJOIN", sym.NJOIN, new String(yytext()));}
{union}      	{	return superSymbol("UNION", sym.UNION, new String(yytext()));}
{where}      	{	return superSymbol("WHERE", sym.WHERE, new String(yytext()));}
{and}      	    {	return superSymbol("AND", sym.AND, new String(yytext()));}
{or}      	    {	return superSymbol("OR", sym.OR, new String(yytext()));}
{between}      	{	return superSymbol("BETWEEN", sym.BETWEEN, new String(yytext()));}
{todate}        {	return superSymbol("TODATE", sym.TODATE, new String(yytext()));}
{coalesce}      {	return superSymbol("COALESCE", sym.COALESCE, new String(yytext()));}
{case}          {	return superSymbol("CASE", sym.CASE, new String(yytext()));}
{when}          {	return superSymbol("WHEN", sym.WHEN, new String(yytext()));}
{else}          {	return superSymbol("ELSE", sym.ELSE, new String(yytext()));}
{end}           {	return superSymbol("END", sym.END, new String(yytext()));}
{group}           {	return superSymbol("GROUP", sym.GROUP, new String(yytext()));}
{order}           {	return superSymbol("ORDER", sym.ORDER, new String(yytext()));}


{nl}			{	return superSymbol("NL", sym.NL);}
{space}			{	return superSymbol("SPACE", sym.SPACE,new String(yytext()));}
{comma}			{	return superSymbol("COMMA", sym.COMMA, new String(yytext()));}
{obracket}		{	return superSymbol("OBRACKET", sym.OBRACKET, new String(yytext()));}
{cbracket}		{	return superSymbol("CBRACKET", sym.CBRACKET, new String(yytext()));}
{string}		{	return superSymbol("STRING", sym.STRING, new String(yytext()));}
