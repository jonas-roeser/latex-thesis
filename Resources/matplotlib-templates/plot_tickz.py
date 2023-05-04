import numpy as np
import pandas as pd
import matplotlib
import matplotlib.pyplot as plt
import tikzplotlib

# LaTeX Preamble:
# with open("preamble.txt", "w") as f:
#     f.write(tikzplotlib.Flavors.latex.preamble())
# ---
# % PGFPLOTS: native plots
# \RequirePackage{pgfplots}
#     \DeclareUnicodeCharacter{2212}{−}
#     \usepgfplotslibrary{groupplots,dateplot}
#     \usetikzlibrary{patterns,shapes.arrows}
#     \pgfplotsset{compat=1.18}

#     \pgfplotsset{trim axis left, trim axis right} % base alignment on axis area only
#     \pgfplotsset{every axis/.append style={line width=\heavyrulewidth, tick style={line width=\heavyrulewidth}}} % align line width with booktabs

# % TIKZSCALE: scale Tikz/Pgfplots without scaling text
# \RequirePackage{tikzscale}

# Usage:
# ---
# \includegraphics[width=.5\textwidth]{Resources/figure.tikz}

# Fix for compatibility issues as of tikzplotlib 0.10.1 and matplotlib >3.6.2:
from matplotlib.lines import Line2D
from matplotlib.legend import Legend
Line2D._us_dashSeq    = property(lambda self: self._dash_pattern[1])
Line2D._us_dashOffset = property(lambda self: self._dash_pattern[0])
Legend._ncol = property(lambda self: self._ncols)

# Generate sample dataset
df = pd.DataFrame({
    'col1': np.arange(11),
    'col2': np.arange(10, -1, -1)},
    index=pd.date_range('2000-01-01', periods=11).tz_localize('EST'))

# DatetimeIndex is converted into floats as of tikzplotlib 0.10.1 which leads to issues with axis labels and timezones
df.index = df.index.tz_convert(None)

# Initialise figure
textwidth = 6.3 # a4_width - 2 * margin = 8.3in - 2 * 2in = 6.3in
fig, ax = plt.subplots(figsize=(textwidth, 4))

# Plot data
ax.plot(df.col1)
ax.scatter(df.index, df.col2)

# Set labels
ax.set_xlabel('Wochentag')
ax.set_ylabel('Produktion')

# Set axis ticks
ax.xaxis.set_major_locator(matplotlib.dates.DayLocator(interval=1, tz='EST'))
ax.xaxis.set_major_formatter(matplotlib.dates.DateFormatter('%m-%d\n%a', usetex=False))

# Set axis limits
x_min = min(df.index)
x_max = max(df.index)
y_min = min(min(df.col1), min(df.col2))
y_max = max(max(df.col1), max(df.col2))
ax.set_xlim(x_min, x_max + pd.Timedelta(.5, 'days'))
ax.set_ylim(y_min - 0.1 * (y_max - y_min), y_max + 0.1 * (y_max - y_min))

# Save figure
# tikzplotlib.clean_figure(fig=fig) # results in IndexError as of tikzplotlib 0.10.1
tikzplotlib.save(
    'figure.tikz',
    dpi=300, # set dpi for any rasterized parts of figure
    strict=True, # retains tick positions of matplotlib figure

    # Export tikz with figure size retains the aspect ratio, but disables independent text scaling
    axis_width=str(fig.get_size_inches()[0]) + 'in',
    axis_height=str(fig.get_size_inches()[1]) + 'in'
    )
plt.show()
plt.close()