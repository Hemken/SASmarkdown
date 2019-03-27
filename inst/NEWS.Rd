\name{NEWS}
\title{News for Package 'SASmarkdown'}
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
