\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{ata}
  [2012/11/14 v1.0 Ata de Reunião Departamental -- fnaufel at gmail.com]


%%%%%%%%%% Pacotes necessários:
\RequirePackage{ifthen}
\RequirePackage{paralist}
\RequirePackage{lineno}
\RequirePackage{paralist}


%%%%%%%%%% Opções:

% Usar pacote beton (font)
\newboolean{@beton}
\setboolean{@beton}{false}
\DeclareOption{beton}%
    {\setboolean{@beton}{true}}

% Usar pacote euler (font matemático)
\newboolean{@euler}
\setboolean{@euler}{false}
\DeclareOption{euler}%
    {\setboolean{@euler}{true}}

% Encaminhar outras opções para a classe article.
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax


%%%%%%%%%% Carregar classe article.
\LoadClass{article}


%%%%%%%%%% Carregar pacotes opcionais (euler, beton):
\ifthenelse{\boolean{@beton}}{
  \RequirePackage{beton}
}
%else
{}

\ifthenelse{\boolean{@euler}}{
  \RequirePackage{euler}
}
%else
{}


%%%%%%%%%% Comandos para processar a data:

\newcounter{@dia}
\newcounter{@mes}
\newcounter{@ano}

\newcommand{\dia}[1]{%
  \setcounter{@dia}{#1}%
}

\newcommand{\mes}[1]{%
  \setcounter{@mes}{#1}%
}

\newcommand{\ano}[1]{%
  \setcounter{@ano}{#1}%
}

% Se estivermos usando euler, queremos que os números fiquem bonitos;
% então, usamos modo matemático.
\newcommand{\hoje}{%
  $\arabic{@dia}$/$\arabic{@mes}$/$\arabic{@ano}$%
}

\newcommand{\hojeporextenso}{%
  % Nomes dos meses.
  % É preciso defini-los aqui dentro deste \newcommand, para que 
  % apareçam com o font correto (concrete ou não).
  \expandafter\newbox\csname mes1\endcsname%
  \expandafter\newbox\csname mes2\endcsname%
  \expandafter\newbox\csname mes3\endcsname%
  \expandafter\newbox\csname mes4\endcsname%
  \expandafter\newbox\csname mes5\endcsname%
  \expandafter\newbox\csname mes6\endcsname%
  \expandafter\newbox\csname mes7\endcsname%
  \expandafter\newbox\csname mes8\endcsname%
  \expandafter\newbox\csname mes9\endcsname%
  \expandafter\newbox\csname mes10\endcsname%
  \expandafter\newbox\csname mes11\endcsname%
  \expandafter\newbox\csname mes12\endcsname%
  \expandafter\setbox\csname mes1\endcsname=\hbox{janeiro}%
  \expandafter\setbox\csname mes2\endcsname=\hbox{fevereiro}%
  \expandafter\setbox\csname mes3\endcsname=\hbox{março}%
  \expandafter\setbox\csname mes4\endcsname=\hbox{abril}%
  \expandafter\setbox\csname mes5\endcsname=\hbox{maio}%
  \expandafter\setbox\csname mes6\endcsname=\hbox{junho}%
  \expandafter\setbox\csname mes7\endcsname=\hbox{julho}%
  \expandafter\setbox\csname mes8\endcsname=\hbox{agosto}%
  \expandafter\setbox\csname mes9\endcsname=\hbox{setembro}%
  \expandafter\setbox\csname mes10\endcsname=\hbox{outubro}%
  \expandafter\setbox\csname mes11\endcsname=\hbox{novembro}%
  \expandafter\setbox\csname mes12\endcsname=\hbox{dezembro}%
  \ifthenelse{\the@dia = 1}{Ao}{Aos}
  $\arabic{@dia}$
  de 
  \expandafter\unhbox\csname mes\the@mes\endcsname
  \ de
  $\arabic{@ano}$%
}


%%%%%%%%%% Tipo de reunião:
\newcommand{\deftiporeuniao}[1]{
  \newbox\@tiporeuniao%
  \setbox\@tiporeuniao=\hbox{\ignorespaces #1\unskip}%
  \newcommand{\tiporeuniao}{\unskip{} \unhbox\@tiporeuniao}%
}


%%%%%%%%%% Tipo de reunião (advérbio):
\newcommand{\deftiporeuniaoadv}[1]{
  \newbox\@tiporeuniaoadv%
  \setbox\@tiporeuniaoadv=\hbox{\ignorespaces #1\unskip}%
  \newcommand{\tiporeuniaoadv}{\unskip{} \unhbox\@tiporeuniaoadv}%
}


%%%%%%%%%% Cabeçalho:
\newcommand{\cabecalho}[1]{%
  \title{\large #1}
  \author{}
  \date{}
  \maketitle
  \vskip -5ex

  \linenumbers
}


%%%%%%%%%% Nome de quem presidiu:
\newcommand{\defpresidiu}[1]{
  \newbox\@presidiu%
  \setbox\@presidiu=\hbox{\ignorespaces #1\unskip}%
  \newcommand{\presidiu}{\unskip{} \unhbox\@presidiu}%
}


%%%%%%%%%% Cargo de quem presidiu:
\newcommand{\defcargopresidiu}[1]{
  \newbox\@cargopresidiu%
  \setbox\@cargopresidiu=\hbox{\ignorespaces #1\unskip}%
  \newcommand{\cargopresidiu}{\unskip{} \unhbox\@cargopresidiu}%
}


%%%%%%%%%% Nome de quem secretariou:
\newcommand{\defsecretariou}[1]{
  \newbox\@secretariou%
  \setbox\@secretariou=\hbox{\ignorespaces #1\unskip}%
  \newcommand{\secretariou}{\unskip{} \unhbox\@secretariou}%
}


%%%%%%%%%% Presentes e ausentes:
\newcommand{\defpresentes}[1]{%
  \newbox\@presentes%
  \setbox\@presentes=\hbox{\ignorespaces #1\unskip}%
  \newcommand{\presentes}{\unskip{} \unhbox\@presentes}%
}

\newcommand{\defausentes}[1]{%
  \newbox\@ausentes%
  \setbox\@ausentes=\hbox{#1}%
  \newcommand{\ausentes}{\unskip\unhbox\@ausentes\unskip}%
}

\newcommand{\defjustif}[1]{%
  \newbox\@justificados%
  \setbox\@justificados=\hbox{#1}%
  \newcommand{\justificados}{\unskip\unhbox\@justificados\unskip}%
}


%%%%%%%%%% Pontos da pauta e seu desenvolvimento:

% Número do ponto:
\newcounter{@nponto}
\setcounter{@nponto}{0}


% Ambiente ponto. Argumento obrigatório é o nome do ponto.
\newenvironment{ponto}[1]
{%
  \stepcounter{@nponto}%
  % Cria caixa com o nome do ponto (em negrito).
  \global\expandafter\newbox\csname @ponto\the@nponto\endcsname%
  \global\expandafter\setbox\csname @ponto\the@nponto\endcsname=%
    \hbox{\bfseries\ignorespaces #1\unskip}%
  % Cria caixa com o corpo do ponto (em texto normal).
  \global\expandafter\newbox\csname @corpo\the@nponto\endcsname%
  \global\expandafter\setbox\csname @corpo\the@nponto\endcsname=%
    \hbox\bgroup\ignorespaces%
}%
{%
  \unskip%
  \egroup%
}%


% Comando \pauta. Gera lista dos nomes dos pontos:
\newcommand{\pauta}{%
  \newcounter{@iponto}%
  \setcounter{@iponto}{1}%
  \begin{inparaenum}[$1.$]
    \whiledo{\not \the@iponto>\the@nponto}%
    {%
      \textbf{\item%
        \unhcopy\csname @ponto\the@iponto\endcsname
          \ifthenelse{\the@iponto=\the@nponto}{. }{; }}%
      \stepcounter{@iponto}%
    }%
  \end{inparaenum}%
}


% Comando \desenvolvimento. Gera lista dos corpos dos pontos:
\newcommand{\desenvolvimento}{%
  \newcounter{@jponto}%
  \setcounter{@jponto}{1}%
  \begin{inparaenum}[$1.$]
    \whiledo{\not \the@jponto>\the@nponto}%
    {%
      \textbf{\item
        \unhbox\csname @ponto\the@jponto\endcsname:}
        \unhbox\csname @corpo\the@jponto\endcsname\ %
      \stepcounter{@jponto}%
    }%
  \end{inparaenum}
}


%%%%%%%%%% Redefinindo itemize e enumerate para versões in parágrafos:
\renewenvironment{enumerate}
{\begin{inparaenum}[(a)]}
{\unskip\end{inparaenum}}

\renewenvironment{itemize}
{\begin{inparaitem}}
{\unskip\end{inparaitem}}


%%%%%%%%%% Abreviaturas para Prof., Profa.
\newcommand{\prof}{Prof.~}
\newcommand{\profa}{Prof\textordfeminine~}


\endinput


