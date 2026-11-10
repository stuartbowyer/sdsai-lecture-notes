# Draws ../Illustrations-SDSAI-04_ROC-Thresholds.svg. Ten made-up patients at three thresholds, for the ROC worked example.
# Data are made up. Run from anywhere: python roc-thresholds.py
from pathlib import Path

import matplotlib
matplotlib.use("Agg")
matplotlib.rcParams["svg.hashsalt"] = "sdsai"  # stable ids, so a re-run gives an identical file
import numpy as np
import matplotlib.pyplot as plt

# Ten made-up patients and their scores
died = np.array([0.90, 0.60, 0.35])
survived = np.array([0.80, 0.50, 0.30, 0.25, 0.20, 0.10, 0.05])

fig, axes = plt.subplots(1, 3, figsize=(11, 2.6), sharey=True)
for ax, threshold in zip(axes, [0.7, 0.4, 0.15]):
    ax.axvspan(threshold, 1, color='#0000cd', alpha=0.08)
    ax.axvline(threshold, color='#0000cd', linewidth=1.5)
    ax.scatter(survived, np.zeros(len(survived)), color='#444444', s=60, zorder=3)
    ax.scatter(died, np.ones(len(died)), color='#c0392b', s=60, zorder=3)
    ax.set_title(f'Threshold {threshold}: flag everyone to the right', fontsize=10)
    ax.set_xlim(0, 1)
    ax.set_ylim(-0.5, 1.5)
    ax.set_xlabel('Score')
    ax.set_yticks([0, 1])
    ax.set_yticklabels(['Survived', 'Died'])
    for side in ['top', 'right']:
        ax.spines[side].set_visible(False)
plt.tight_layout()
plt.savefig(Path(__file__).parent.parent / 'Illustrations-SDSAI-04_ROC-Thresholds.svg', bbox_inches='tight', metadata={'Date': None})
