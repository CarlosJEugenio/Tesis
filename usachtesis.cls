\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{usachtesis}[2016/07/07 USACH thesis class]

\LoadClass[12pt,oneside]{book}
\RequirePackage[utf8]{inputenc}
\RequirePackage[spanish]{babel}
\RequirePackage{graphics}
\RequirePackage{pst-all,pstricks-add,pst-math}
\RequirePackage{tikz}
\RequirePackage{float}
\RequirePackage{textcomp}
\RequirePackage{dsfont}
\RequirePackage{booktabs}
\RequirePackage{makeidx}
\RequirePackage[colorlinks=true, pdfborder={0 100 100}, linkcolor=orange, linktoc=page, citecolor=Green]{hyperref}
\RequirePackage{microtype}
\RequirePackage{amssymb}
\RequirePackage{amsmath}
\RequirePackage{cleveref}
\RequirePackage{multirow}
\RequirePackage[format=hang, font=small, labelfont=bf, margin=1cm]{caption}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax

\definecolor{orange}{RGB}{250,120,0}
\definecolor{Green}{RGB}{50,200,100}

\renewcommand{\rmdefault}{phv}
\renewcommand{\sfdefault}{phv}
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
	\begin{flushright}
		\begin{tabular}{cl}
			&\multirow{4}{*}{\hspace{0cm}\includegraphics[width=2cm]{logoBN.png}}\\
			\large{\textbf{UNIVERSIDAD DE SANTIAGO DE CHILE}}&  \\
			\textbf{FACULTAD DE \@facultad}&\\
			\textbf{DEPARTAMENTO DE \@departamento}& \\
		\end{tabular}
	\end{flushright}
	
	\vspace*{3cm}
	
	\begin{center}
		\large{\textbf{\@title}}\\ %\vspace*{2cm}
	\end{center}
	\begin{center}
		\textbf{\@author}
	\end{center}
	
	\vspace*{1cm}
	
	\begin{flushright}
		\begin{tabular}{ll}
			\textbf{Profesor Guía:}& \textsc{\@profesorguia}
		\end{tabular}
		\\\vspace{3cm}
		
		\begin{center}
			\textbf{Trabajo de Titulación presentado en conformidad a los
				requisitos para obtener el título profesional de \@tituloprofesional.}
		\end{center}
	\end{flushright}
	
	\vfill
	
	\begin{center}
		\textbf{Santiago -  Chile\\\@anolol}
	\end{center}
	}
	
\newcommand{\derechosdeautor}{
	\vfill
	\begin{center}
		\textbf{© \@anolol, \@author\\
			Algunos  derechos  reservados. 
			Esta  obra  está  bajo  una  Licencia  Creative  Commons  Atribución-NoComercial-Compartir Igual  
			3.0. Sus condiciones de uso pueden ser revisadas 
			en: http://creativecommons.org/licenses/by-nc-sa/3.0/cl/.}
		\\
		\includegraphics[width=2cm]{by-nc-sa.png}
	\end{center}
	
	}
	
\renewcommand{\contentsname}{Tabla de contenidos}
\renewcommand{\listfigurename}{Índice de Ilustraciones}
\renewcommand{\indexname}{Índice analítico}
\renewcommand{\listtablename}{Índice de tablas}
\renewcommand{\tablename}{Tabla}