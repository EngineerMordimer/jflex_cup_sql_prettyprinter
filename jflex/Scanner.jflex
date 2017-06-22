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
	private static final Boolean DEBUG=false;
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

nl				= [\n|\r|\r\n]
tab				= [\t\f]
space			= (" ")+
string			= [a-zA-Z0-9.,;:>=]+
select			= "SELECT"
from			= "FROM"
ljoin			= "LEFT"" "+"JOIN"
rjoin			= "RIGHT"" "+"JOIN"
njoin			= "JOIN"
union			= "UNION"


%%

{select}      	{	return superSymbol("SELECT", sym.SELECT, new String(yytext()));}
{from}      	{	return superSymbol("FROM", sym.FROM, new String(yytext()));}
{ljoin}      	{	return superSymbol("LJOIN", sym.LJOIN, new String(yytext()));}
{rjoin}      	{	return superSymbol("RJOIN", sym.RJOIN, new String(yytext()));}
{njoin}      	{	return superSymbol("NJOIN", sym.NJOIN, new String(yytext()));}
{union}      	{	return superSymbol("UNION", sym.UNION, new String(yytext()));}
{string}		{	return superSymbol("STRING", sym.STRING, new String(yytext()));}
{nl}			{	return superSymbol("NL", sym.NL);}
{space}			{	return superSymbol("SPACE", sym.SPACE,new String(yytext()));}
