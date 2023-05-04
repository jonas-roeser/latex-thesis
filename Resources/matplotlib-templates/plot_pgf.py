import numpy as np
import pandas as pd
import matplotlib
import matplotlib.pyplot as plt

# LaTeX Preamble:
# ---
# % PGF: required for inserting pgf files
# \RequirePackage{pgf}

# Usage:
# ---
# \resizebox{.5\textwidth}{!}{\input{Resources/figure.pgf}}

# Change font to LaTeX
plt.rcParams.update({
    'text.usetex': True,
    'font.family': 'serif',
    'font.serif': [],
    'pgf.texsystem': 'pdflatex',

    # Fine-tune font-size
    'font.size': 12.0, # 10.0
    'figure.titlesize': 14.4, # 'large' (12.0)
    'figure.labelsize': 12.0, # 'large' (12.0)
    'axes.titlesize': 12.0, # 'large' (12.0)
    'axes.labelsize': 10.95, # 'medium' (10.0)
    'legend.title_fontsize': 10.95, # None (10.0)
    'legend.fontsize': 10.0, # 'medium' (10.0)
    'xtick.labelsize': 10.0, # 'medium' (10.0)
    'ytick.labelsize': 10.0 # 'medium' (10.0)
    })

# Generate sample dataset
df = pd.DataFrame({
    'col1': np.arange(11),
    'col2': np.arange(10, -1, -1)},
    index=pd.date_range('2000-01-01', periods=11).tz_localize('EST'))

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

# Remove figure padding
plt.tight_layout(pad=0.1) # pad=0 can lead to text being cut off
left = max(fig.subplotpars.left, 1 - fig.subplotpars.right)
spine_top_rel_height = ax.spines['top'].get_linewidth() / 72 / fig.get_size_inches()[1]
fig.subplots_adjust( # does not work in .ipynb
    left=left,
    right=1 - left,
    top=1 - .5 * spine_top_rel_height if ax.get_title() == '' else fig.subplotpars.top)

# Save figure
fig.savefig('figure.pgf', dpi=300) # set dpi for any rasterized parts of figure
plt.show()
plt.close()