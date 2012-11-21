\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{ata}
  [2012/11/21 v1.0 Ata de Reunião Departamental -- fnaufel at gmail.com]


%%%%%%%%%% Pacotes necessários:
\RequirePackage{ifthen}
\RequirePackage{paralist}
\RequirePackage{lineno}


%%%%%%%%%% Opções de invocação:

% Usar pacote beton (usa fonts Concrete).
\newboolean{@beton}
\setboolean{@beton}{false}
\DeclareOption{beton}%
    {\setboolean{@beton}{true}}

% Usar pacote euler (usa fonts Euler para matemática).
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


%%%%%%%%%% Opções de configuração pelo usuário:

% Estilo do nome do ponto da pauta:
\newcommand{\@estilonomeponto}{\bfseries}


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
% então, usamos modo matemático para a data.
\newcommand{\hoje}{%
  $\arabic{@dia}$/$\arabic{@mes}$/$\arabic{@ano}$%
}

\newcommand{\hojeporextenso}{%
  % Nomes dos meses.
  % É preciso defini-los aqui dentro deste \newcommand, para que 
  % apareçam com o font correto (Concrete ou não).
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
  \ifthenelse{\the@dia=1}{Ao}{Aos}
  $\arabic{@dia}$
  de 
  \expandafter\unhbox\csname mes\the@mes\endcsname
  \ de
  $\arabic{@ano}$%
}


%%%%%%%%%% Tipo de reunião.
% Não usa caixas, pois poderia causar diferença de fonts.
\newcommand{\deftiporeuniao}[1]{%
  \newcommand{\tiporeuniao}[1]{#1}%
}


%%%%%%%%%% Tipo de reunião (advérbio).
% Não usa caixas, pois poderia causar diferença de fonts.
\newcommand{\deftiporeuniaoadv}[1]{%
  \newcommand{\tiporeuniaoadv}[1]{#1}%
}


%%%%%%%%%% Cabeçalho. Atenção para o vskip.
\newcommand{\cabecalho}[1]{%
  \title{\large #1}
  \author{}
  \date{}
  \maketitle
  \vskip -5ex

  \linenumbers
}


%%%%%%%%%% Nome de quem presidiu:
\newcommand{\defpresidiu}[1]{%
  \newcommand{\presidiu}{#1}%
}


%%%%%%%%%% Cargo de quem presidiu:
\newcommand{\defcargopresidiu}[1]{%
  \newcommand{\cargopresidiu}{#1}%
}


%%%%%%%%%% Nome de quem secretariou:
\newcommand{\defsecretariou}[1]{%
  \newcommand{\secretariou}{#1}%
}


%%%%%%%%%% Presentes e ausentes.

% Lista de presentes.
% Atenção: produz um espaço ANTES da lista. É intencional.
\newcommand{\defpresentes}[1]{%
  \newbox\@presentes%
  \setbox\@presentes=\hbox{\ignorespaces #1\unskip}%
  \newcommand{\presentes}{\unskip{} \unhbox\@presentes}%
}

% Lista de ausentes.
% Atenção: produz um espaço ANTES da lista. É intencional.
\newcommand{\defausentes}[1]{%
  \newbox\@ausentes%
  \setbox\@ausentes=\hbox{#1}%
  \newcommand{\ausentes}{\unskip\unhbox\@ausentes\unskip}%
}

% Lista de ausentes com justificativa..
% Atenção: produz um espaço ANTES da lista. É intencional.
\newcommand{\defjustif}[1]{%
  \newbox\@justificados%
  \setbox\@justificados=\hbox{#1}%
  \newcommand{\justificados}{\unskip\unhbox\@justificados\unskip}%
}


%%%%%%%%%% Pontos da pauta e seu desenvolvimento:

% Número do ponto:
\newcounter{@nponto}
\setcounter{@nponto}{0}


% Ambiente ponto. Argumento obrigatório: nome do ponto.
\newenvironment{ponto}[1]
{%
  \stepcounter{@nponto}%
  % Cria caixa com o nome do ponto (no estilo \@estilonomeponto).
  \global\expandafter\newbox\csname @ponto\the@nponto\endcsname%
  \global\expandafter\setbox\csname @ponto\the@nponto\endcsname=%
    \hbox{\@estilonomeponto\ignorespaces #1\unskip}%
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



%%%%%%%%%% Redefinindo itemize, enumerate, description in parágrafos:
\renewenvironment{enumerate}[1][\bfseries (a)]
{\begin{inparaenum}[#1]}
{\unskip\end{inparaenum}}

\renewenvironment{itemize}
{\begin{inparaitem}}
{\unskip\end{inparaitem}}

\renewenvironment{description}
{\begin{inparadesc}}
{\unskip\end{inparadesc}}


%%%%%%%%%% Abreviaturas para Prof., Profa.
\newcommand{\prof}{Prof.~}
\newcommand{\profa}{Prof\textordfeminine~}


\endinput


