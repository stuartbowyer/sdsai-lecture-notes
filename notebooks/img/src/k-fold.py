# Draws ../Illustrations-SDSAI-04_K-Fold.svg. Five-fold cross-validation.
# Data are made up. Run from anywhere: python k-fold.py
from pathlib import Path

import matplotlib
matplotlib.use("Agg")
matplotlib.rcParams["svg.hashsalt"] = "sdsai"  # stable ids, so a re-run gives an identical file
import numpy as np
import matplotlib.pyplot as plt

k = 5
grid = np.zeros((k, k))
np.fill_diagonal(grid, 1)

fig, ax = plt.subplots(figsize=(7, 2.4))
ax.imshow(grid, cmap='Blues', vmin=-0.4, vmax=1.6, aspect='auto')
ax.set_xticks(range(k))
ax.set_xticklabels([f'Fold {i + 1}' for i in range(k)])
ax.set_yticks(range(k))
ax.set_yticklabels([f'Round {i + 1}' for i in range(k)])
ax.set_xticks(np.arange(-0.5, k), minor=True)
ax.set_yticks(np.arange(-0.5, k), minor=True)
ax.grid(which='minor', color='white', linewidth=2)
ax.tick_params(which='both', length=0)
ax.set_title('Dark: evaluate on this fold. Light: train on the others', fontsize=10)
plt.tight_layout()
plt.savefig(Path(__file__).parent.parent / 'Illustrations-SDSAI-04_K-Fold.svg', bbox_inches='tight', metadata={'Date': None})
