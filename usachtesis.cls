\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{usachtesis}[2016/07/07 USACH thesis class]

\LoadClass[10pt,oneside]{book}
\RequirePackage[utf8x]{inputenc}
\RequirePackage[spanish]{babel}
\RequirePackage{graphics}
\RequirePackage{pst-all,pstricks-add,pst-math}
\RequirePackage{tikz}
\RequirePackage{pgf}
\RequirePackage{float}
\RequirePackage{textcomp}
\RequirePackage{booktabs}
\RequirePackage{makeidx}
\RequirePackage[colorlinks=true, pdfborder={0 100 100}, linkcolor=black, linktoc=page, citecolor=black]{hyperref}
\RequirePackage{microtype}
\RequirePackage{amssymb}
\RequirePackage{amsmath}
\RequirePackage{cleveref}
\RequirePackage{multirow}
\RequirePackage[format=plain, font=small, labelfont=bf, justification=centering, margin=0cm]{caption}
\RequirePackage[]{tocloft}
\cftsetindents{figure}{0em}{3.5em}
\cftsetindents{table}{0em}{3.5em}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax

\definecolor{orange}{RGB}{250,120,0}
\definecolor{Green}{RGB}{50,200,100}
\RequirePackage{helvet}
\renewcommand{\familydefault}{\sfdefault}
%\RequirePackage{sansmath} % Enables turning on sans-serif math mode, and using other environments

\renewcommand{\baselinestretch}{1.5}

%% márgenes
\topmargin=0cm
\oddsidemargin=1.5cm

%% nombres tablas, figuras, etc
\crefname{equation}{ecuación}{ecuaciones}
\crefname{table}{tabla}{tablas}
\crefname{figure}{figura}{figuras}
\crefname{section}{sección}{Sección}
\crefname{chapter}{capítulo}{Capítulo}

%% macros
\newcommand\facultad[1]{\renewcommand\@facultad{#1}}
\newcommand\@facultad{}

\newcommand\departamento[1]{\renewcommand\@departamento{#1}}
\newcommand\@departamento{}

\newcommand\tituloprofesional[1]{\renewcommand\@tituloprofesional{#1}}
\newcommand\@tituloprofesional{}

\newcommand\profesorguia[1]{\renewcommand\@profesorguia{#1}}
\newcommand\@profesorguia{}

\newcommand\anno[1]{\renewcommand\@anno{#1}}
\newcommand\@anno{}

\newcommand\jefecarrera[1]{\renewcommand\@jefecarrera{#1}}
\newcommand\@jefecarrera{}

\newcommand\comision[3]{
	\renewcommand\@commisionFirst{#1}
	\renewcommand\@commisionSecond{#2}
	\renewcommand\@commisionThird{#3}}
\newcommand\@commisionFirst{}
\newcommand\@commisionSecond{}
\newcommand\@commisionThird{}

\newcommand{\@largoLinea}{4cm}
%% portada
\renewcommand{\maketitle}{
	\makebox[\textwidth]{
		\hspace{3cm}
		\begin{tabular}{cl}
			&\multirow{4}{*}{\hspace{0cm}\includegraphics[width=3cm]{logoBN.png}}\\
			\large{\textbf{UNIVERSIDAD DE SANTIAGO DE CHILE}}&  \\
			\textbf{FACULTAD DE \@facultad}&\\
			\textbf{DEPARTAMENTO DE \@departamento}& \\
		\end{tabular}
	}

	
	\vspace*{3cm}
	
	\begin{center}
		\large{\textbf{\@title}}\\ %\vspace*{2cm}
	\end{center}

	\vspace*{2cm}
	
	\begin{center}
		\textbf{\@author}
	\end{center}

		
	\hspace{6cm}\begin{tabular}{@{}l@{}}
			\textbf{Profesor Guía:}\\
			\textbf{\@profesorguia}
			\vspace*{1.5cm}\\
			\textbf{Tesis para optar al Título Profesional de}\\
			\textbf{\@tituloprofesional}
		\end{tabular}

		
	
	\vfill
	
	\begin{center}
		\textbf{Santiago -  Chile\\\@anno}
	\end{center}
	}
	
\newcommand{\derechosdeautor}{
	\vfill
	\begin{center}
		\textbf{© \@author, \@anno\\
			Licencia Creative Commons Atribución-NoComercial Chile 3.0}
		\\
	\end{center}
	
	}

\newcommand{\hojacalificacion}{
	\vfill
	\begin{center}
		\large{\textbf{\@title}}\\ %\vspace*{2cm}
	\end{center}
	\begin{center}
		\textbf{\@author}
	\end{center}
	\vfill
	Este trabajo de tesis fue elaborado bajo la supervisión del profesor Dr. \@profesorguia, que ha sido aprobado por la Comisión Calificadora:
	\vfill
	\begin{flushright}
		\@commisionFirst\quad\rule{\@largoLinea}{0.4pt}\\
		\vspace{1cm}
		\@commisionSecond\quad\rule{\@largoLinea}{0.4pt}\\
		\vspace{1cm}
		\@commisionThird\quad\rule{\@largoLinea}{0.4pt}\\
	\end{flushright}
	\vfill
	\begin{flushleft}
		\rule{\@largoLinea}{0.4pt}\\
		\@jefecarrera\\
		Jefe de Carrera
	\end{flushleft}
}

\addto\captionsspanish{
	\renewcommand{\contentsname}{Tabla de contenidos}
	\renewcommand{\listfigurename}{Índice de Ilustraciones}
	\renewcommand{\indexname}{Índice analítico}
	\renewcommand{\listtablename}{Índice de tablas}
	\renewcommand{\tablename}{Tabla}
	\renewcommand\bibname{Referencias bibliográficas}
}

