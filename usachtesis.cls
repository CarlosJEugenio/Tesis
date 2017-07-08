\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{usachtesis}[2016/07/07 USACH thesis class]

\LoadClass[10pt,oneside]{book}
\RequirePackage[utf8]{inputenc}
\RequirePackage[spanish]{babel}
\RequirePackage{graphics}
\RequirePackage{pst-all,pstricks-add,pst-math}
\RequirePackage{tikz}
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
\RequirePackage[format=plain, font=small, labelfont=bf, margin=0cm]{caption}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax

\definecolor{orange}{RGB}{250,120,0}
\definecolor{Green}{RGB}{50,200,100}
\RequirePackage{helvet}
\renewcommand{\familydefault}{\sfdefault}
%\RequirePackage{sansmath} % Enables turning on sans-serif math mode, and using other environments

\renewcommand{\baselinestretch}{1.5}


\topmargin=0cm
\oddsidemargin=1.5cm

\crefname{equation}{ecuación}{ecuaciones}
\crefname{table}{tabla}{tablas}
\crefname{figure}{figura}{figuras}
\crefname{section}{sección}{Sección}
\crefname{chapter}{capítulo}{Capítulo}

\newcommand\facultad[1]{\renewcommand\@facultad{#1}}
\newcommand\@facultad{}

\newcommand\departamento[1]{\renewcommand\@departamento{#1}}
\newcommand\@departamento{}

\newcommand\tituloprofesional[1]{\renewcommand\@tituloprofesional{#1}}
\newcommand\@tituloprofesional{}

\newcommand\profesorguia[1]{\renewcommand\@profesorguia{#1}}
\newcommand\@profesorguia{}

\newcommand\anolol[1]{\renewcommand\@anolol{#1}}
\newcommand\@anolol{}

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
	\begin{center}
		\textbf{\@author}
	\end{center}
	
	\vspace*{3cm}
	\makebox[\textwidth]{
		\hspace{0.5\textwidth}
		\begin{tabular}{ll}
			\multicolumn{2}{l}{\textbf{Tesis para optar al Título Profesional de}}\\
			\multicolumn{2}{l}{\textbf{\@tituloprofesional}}\\
			\textbf{Profesor Guía:}& \textsc{\@profesorguia}
		\end{tabular}
	}
		\\\vspace{3cm}
		
	
	\vfill
	
	\begin{center}
		\textbf{Santiago -  Chile\\\@anolol}
	\end{center}
	}
	
\newcommand{\derechosdeautor}{
	\vfill
	\begin{center}
		\textbf{© \@author, \@anolol\\
			Licencia Creative Commons Atribución-NoComercial Chile 3.0}
		\\
	\end{center}
	
	}
	
\renewcommand{\contentsname}{Tabla de contenidos}
\renewcommand{\listfigurename}{Índice de Ilustraciones}
\renewcommand{\indexname}{Índice analítico}
\renewcommand{\listtablename}{Índice de tablas}
\renewcommand{\tablename}{Tabla}
