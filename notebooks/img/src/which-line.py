# Draws ../Illustrations-SDSAI-04_Which-Line.svg. "Which line?": two points, forty points, and least squares.
# Data are made up. Run from anywhere: python which-line.py
from pathlib import Path

import matplotlib
matplotlib.use("Agg")
matplotlib.rcParams["svg.hashsalt"] = "sdsai"  # stable ids, so a re-run gives an identical file
import numpy as np
import matplotlib.pyplot as plt

# Made-up patients: a straight relationship plus noise
rng = np.random.default_rng(123)
x = np.sort(rng.uniform(22, 88, 40))
y = 1.5 + 0.06 * x + rng.normal(0, 0.6, len(x))
slope, intercept = np.polyfit(x, y, 1)

# Random pairs of patients, the exact line through each pair, and its error on all forty
pairs = []
for _ in range(40):
    a, b = rng.choice(len(x), size=2, replace=False)
    m = (y[b] - y[a]) / (x[b] - x[a])
    c = y[a] - m * x[a]
    pairs.append((np.sum((y - (m * x + c)) ** 2), a, b, m, c))
pairs.sort()
middle_error, a, b, pair_slope, pair_intercept = pairs[len(pairs) // 2]
pair_x = x[[a, b]]
pair_y = y[[a, b]]

def tidy(ax, title):
    ax.set_title(title, fontsize=10)
    ax.set_xlabel('$x$')
    ax.set_xticks([])
    ax.set_yticks([])
    ax.set_ylim(y.min() - 1, y.max() + 1)
    for side in ['top', 'right']:
        ax.spines[side].set_visible(False)

fig, axes = plt.subplots(1, 3, figsize=(13, 3.4), sharex=True, sharey=True)

axes[0].scatter(pair_x, pair_y, color='#0000cd', s=40, zorder=3)
axes[0].plot(x, pair_slope * x + pair_intercept, color='#0000cd', linewidth=2)
tidy(axes[0], 'Two points: one exact line')

for _, _, _, m, c in pairs:
    axes[1].plot(x, m * x + c, color='#999999', linewidth=0.8, alpha=0.5)
pair_fitted = pair_slope * x + pair_intercept
axes[1].vlines(x, pair_fitted, y, color='#c0392b', linewidth=1)
axes[1].scatter(x, y, color='#444444', s=22, zorder=3)
axes[1].plot(x, pair_fitted, color='#0000cd', linewidth=2)
axes[1].scatter(pair_x, pair_y, color='#0000cd', s=40, zorder=4)
tidy(axes[1], f'Lines through {len(pairs)} random pairs\nthe middle one (blue): sum of squared errors {middle_error:.1f}')

fitted = slope * x + intercept
axes[2].vlines(x, fitted, y, color='#c0392b', linewidth=1)
axes[2].scatter(x, y, color='#444444', s=22, zorder=3)
axes[2].plot(x, fitted, color='#0000cd', linewidth=2)
tidy(axes[2], f'Least squares: the smallest possible sum\nsum of squared errors {np.sum((y - fitted) ** 2):.1f}')

axes[0].set_ylabel('$y$')
plt.tight_layout()
plt.savefig(Path(__file__).parent.parent / 'Illustrations-SDSAI-04_Which-Line.svg', bbox_inches='tight', metadata={'Date': None})
