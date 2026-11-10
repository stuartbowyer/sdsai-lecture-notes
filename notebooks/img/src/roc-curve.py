# Draws ../Illustrations-SDSAI-04_ROC-Curve.svg. The ROC curve for the ten made-up patients.
# Data are made up. Run from anywhere: python roc-curve.py
from pathlib import Path

import matplotlib
matplotlib.use("Agg")
matplotlib.rcParams["svg.hashsalt"] = "sdsai"  # stable ids, so a re-run gives an identical file
import numpy as np
import matplotlib.pyplot as plt

died = np.array([0.90, 0.60, 0.35])
survived = np.array([0.80, 0.50, 0.30, 0.25, 0.20, 0.10, 0.05])

thresholds = np.sort(np.concatenate([died, survived, [1.01]]))[::-1]
tpr = np.array([(died >= t).mean() for t in thresholds])
fpr = np.array([(survived >= t).mean() for t in thresholds])

fig, ax = plt.subplots(figsize=(5.2, 4))
ax.fill_between(fpr, tpr, color='#0000cd', alpha=0.08, step='post')
ax.step(fpr, tpr, where='post', color='#0000cd', linewidth=2)
ax.plot([0, 1], [0, 1], color='#999999', linestyle='--', linewidth=1)
for t, x, y in [(0.7, 1 / 7, 1 / 3), (0.4, 2 / 7, 2 / 3), (0.15, 5 / 7, 1)]:
    ax.scatter([x], [y], color='#c0392b', zorder=3)
    ax.annotate(f'threshold {t}', (x, y), xytext=(8, -12), textcoords='offset points', fontsize=9)
ax.annotate('flag nobody', (0, 0), xytext=(0.04, 0.02), fontsize=9)
ax.annotate('flag everybody', (1, 1), xytext=(0.62, 1.02), fontsize=9)
ax.set_xlabel('False positive rate')
ax.set_ylabel('True positive rate')
ax.set_xlim(-0.02, 1.02)
ax.set_ylim(-0.02, 1.1)
for side in ['top', 'right']:
    ax.spines[side].set_visible(False)
plt.tight_layout()
plt.savefig(Path(__file__).parent.parent / 'Illustrations-SDSAI-04_ROC-Curve.svg', bbox_inches='tight', metadata={'Date': None})
