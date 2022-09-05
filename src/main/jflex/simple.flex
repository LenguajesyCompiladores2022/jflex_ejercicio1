//ANOTACIONES Y CONFIGURACIONES DE JFLEX
%%

%public
%class Lexer
%unicode
%line
%column
%throws Exception
%standalone
//  no hace falta para esto, queremos mostrar solo por pantalla el token identificado
%{
    StringBuffer string = new StringBuffer();
%}

/* TOKENS */

DIGITO              =   [0-9]
LETRA               =   [A-Za-z]
OPERADORES          =   [\*\/\-\+]
PUNTO               =   "."
ESPACIO             =   " "
Identifier          =   {LETRA} ({LETRA}|{DIGITO})*
CONST_INT           =   0 | [1-9]{DIGITO}*
CONST_FLOAT         =   {DIGITO}+{PUNTO}{DIGITO}+
COMILLA             =   \"
CONST_STRING        =   [^\n\r\"\\]+
PARENTESIS_ABRE     =   "("
PARENTESIS_CIERRA   =   ")"
LLAVE_ABRE          =   "{"
LLAVE_CIERRA        =   "}"
OP_SUMA             =   "+"
OP_RESTA            =   "-"
OP_MULTIPLICA       =   "*"
OP_DIVISION         =   "/"
OP_IGUAL            =   ":"
OP_MENOR            =   "<"
OP_MAYOR            =   ">"
OP_MENOR_IGUAL      =   "<="
OP_MAYOR_IGUAL      =   ">="
OP_IGUAL_IGUAL      =   "=="
OP_NEGADO_IGUAL     =   "!="
OP_NEGADO           =   "!"
COMA                =   ","
BARRA               =   "/"
ASTERISCO           =   "*"
COMENTARIO          =   \/\*((\n|\r\n|\r)*([^*]*)(\n|\r\n|\r)*)*\*\/
TAB                 =   "\t"
PUNTO_COMA          =   ";"
SALTO_LINEA         =   \r|\n|\r\n
%state              STRING

/*palabras reservadas*/
ENTERO_DEC          =   "Integer"
FLOAT_DEC           =   "Float"
ESCRITURA           =   "WRITE"
DECVAR              =   "DECVAR"
ENDDEC              =   "ENDDEC"
WHILE               =   "WHILE"
CONDICION_IF        =   "if"
CONDICION_ELSE      =   "else"

%%


//REGLAS LEXICAS

<YYINITIAL> {
    {ENTERO_DEC}                            {System.out.println("declaracion de entero: " + yytext() + "\n");}
    {FLOAT_DEC}                             {System.out.println("declaracion de float: " + yytext() + "\n");}
    {ESCRITURA}                             {System.out.println("escritura: " + yytext() + "\n");}
    {DECVAR}                                {System.out.println("inicio de declaracion variables: " + yytext() + "\n");}
    {ENDDEC}                                {System.out.println("fin de declarcion variables: " + yytext() + "\n");}
    {WHILE}                                 {System.out.println("bucle while: " + yytext() + "\n");}
    {CONDICION_IF}                          {System.out.println("condicion if: " + yytext() + "\n");}
    {CONDICION_ELSE}                        {System.out.println("condicion else: " + yytext() + "\n");}
    {CONST_INT}                             {System.out.println("constante entera: " + yytext() + "\n");}
    {CONST_FLOAT}                           {System.out.println("constante float: " + yytext() + "\n");}
    {COMA}                                  {System.out.println("coma: " + yytext() + "\n");}
    {PUNTO_COMA}                            {System.out.println("punto y coma: " + yytext() + "\n");}
    {PARENTESIS_ABRE}                       {System.out.println("parentesis abre: " + yytext() + "\n");}
    {PARENTESIS_CIERRA}                     {System.out.println("parentesis cierra: " + yytext() + "\n");}
    {LLAVE_ABRE}                            {System.out.println("llave abre: " + yytext() + "\n");}
    {LLAVE_CIERRA}                          {System.out.println("llave cierra: " + yytext() + "\n");}
    {Identifier}                            {System.out.println("Identificador: " + yytext() + "\n");}
    {OP_SUMA}                               {System.out.println("operador suma: " + yytext() + "\n");}
    {OP_RESTA}                              {System.out.println("operador resta: " + yytext() + "\n");}
    {OP_MULTIPLICA}                         {System.out.println("operador multipicacion: " + yytext() + "\n");}
    {OP_DIVISION}                           {System.out.println("operador division: " + yytext() + "\n");}
    {OP_IGUAL}                              {System.out.println("operador igual: " + yytext() + "\n");}
    {OP_MENOR}                              {System.out.println("operador menor: " + yytext() + "\n");}
    {OP_MAYOR}                              {System.out.println("operador mayor: " + yytext() + "\n");}
    {OP_MENOR_IGUAL}                        {System.out.println("operador menor o igual: " + yytext() + "\n");}
    {OP_MAYOR_IGUAL}                        {System.out.println("operador mayor o igual: " + yytext() + "\n");}
    {OP_IGUAL_IGUAL}                        {System.out.println("operador igual condicional: " + yytext() + "\n");}
    {OP_NEGADO_IGUAL}                       {System.out.println("operador negado_igual: " + yytext() + "\n");}
    {OP_NEGADO}                             {System.out.println("operador negado: " + yytext() + "\n");}
    {COMENTARIO}                            {System.out.println("comentario:\n" + yytext());}
    {COMILLA}                               {yybegin(STRING); string.setLength(0);}

    {TAB}|{ESPACIO}|{SALTO_LINEA}           { /* ignore */ }
}

<STRING> {
    {COMILLA}                               {yybegin(YYINITIAL); System.out.println("string: " + string.toString());}
    {CONST_STRING}                          {string.append(yytext());}
}

/* error fallback */
[^]                                         {
                                              throw new Exception("Unknown character « " + yytext() + " »");
                                            }
