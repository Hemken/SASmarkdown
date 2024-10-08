\name{NEWS}
\title{News for Package 'SASmarkdown'}
\section{Changes in 'SASmarkdown' version 0.8.6 (2024-09-25)}{
  \subsection{Bug fixes: }{
    \itemize{
      \item eval - fixed 'no out.log' when eval = FALSE
      \item collectcode - collecting code is now actually
      suppressed when collectcode = FALSE
    }
  }
}
\section{Changes in 'SASmarkdown' version 0.8.4 (2023-09-21)}{
  \subsection{Enhancement: }{
    \itemize{
      \item PDF tables - the 'saspdf' engine now includes SAS'
      LaTeX stylesheet, which is written to your project folder.
      Your document YAML should now include 'extra_dependencies: sasmarkdown'
      for 'pdf_document' output.
    }
  }
}
\section{Changes in 'SASmarkdown' version 0.8.3 (2023-09-13)}{
  \subsection{Bug fix: }{
    \itemize{
      \item collectcode() - now works with LaTeX output.
    }
  }
}
\section{Changes in 'SASmarkdown' version 0.8.0 (2022-09-01)}{
  \subsection{New features: }{
    \itemize{
      \item PDF tables - a new engine 'saspdf' produces
      LaTeX tables.
    }
  }
}
\section{Changes in 'SASmarkdown' version 0.7.3 (2022-08-17)}{
  \subsection{Other improvements}{
    \itemize{
      \item NLS - SAS National Language Support extended to
      HTML output.
      \item Unix support - now searches more directories
      for the SAS executable.
    }
  }
}
\section{Changes in 'SASmarkdown' version 0.7.1 (2022-08-11)}{
  \subsection{Other improvements}{
    \itemize{
      \item NLS - support for SAS National Language Support.
      There is now a chunk option, 'encoding=', to declare
      the language encoding used by SAS.  This defaults to
      "latin1".
      \item log cleanup - now handled through SAS options
      rather than log post-processing in R.  Fixes some
      bugs.
    }
  }
}
\section{Changes in 'SASmarkdown' version 0.5.2 (2019-05-13)}{
  \subsection{New features: }{
    \itemize{
      \item find_sas() - now runs onLoad, defines engine.path if 
      the SAS executable is found, and warns if not found.
      \item saslog_hookset() - enabled by default
    }
  }
  \subsection{Other improvements}{
    \itemize{
      \item spinsas - fixed bugs introduced by changes in knitr
    }
  }
}
\section{Changes in 'SASmarkdown' version 0.5.0 (2019-03-27)}{
  \subsection{New features: }{
    \itemize{
      \item sashtml5 - an engine for HTML5 output, with inline SVG graphs
      \item find_sas() - attempt to find the SAS executable
    }
  }
  \subsection{Other improvements}{
    \itemize{
      \item engine.path and engine.opts - takes advantage of knitr's newer
        approach to specifying engine paths and engine options
      }
  }
}
\section{Changes in 'SASmarkdown' version 0.4.2 (2017-11-29)}{
  \subsection{New features: }{
    \itemize{
      \item spinsas() - turns specially formatted .sas files into Markdown
    }
  }
  \subsection{Other improvements}{
    \itemize{
      \item sas_collectcode() - now handles pre-existing autoexec.sas files, called
        when the package is attached.
    }
  }
}
