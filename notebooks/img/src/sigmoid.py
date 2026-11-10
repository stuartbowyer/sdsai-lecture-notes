# Draws ../Illustrations-SDSAI-04_Sigmoid.svg. The sigmoid, with the 0.5 threshold.
# Data are made up. Run from anywhere: python sigmoid.py
from pathlib import Path

import matplotlib
matplotlib.use("Agg")
matplotlib.rcParams["svg.hashsalt"] = "sdsai"  # stable ids, so a re-run gives an identical file
import numpy as np
import matplotlib.pyplot as plt

score = np.linspace(-6, 6, 200)
probability = 1 / (1 + np.exp(-score))

fig, ax = plt.subplots(figsize=(8, 3))
ax.plot(score, probability, color='#0000cd', linewidth=2)
ax.axhline(0.5, color='#c0392b', linestyle='--', linewidth=1)
ax.annotate('threshold', xy=(-6, 0.53), color='#c0392b')
ax.set_xlabel('Weighted sum of the features')
ax.set_ylabel('Predicted probability')
for side in ['top', 'right']:
    ax.spines[side].set_visible(False)
plt.tight_layout()
plt.savefig(Path(__file__).parent.parent / 'Illustrations-SDSAI-04_Sigmoid.svg', bbox_inches='tight', metadata={'Date': None})
