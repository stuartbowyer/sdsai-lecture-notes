# Draws ../Illustrations-SDSAI-04_Preprocessing-Pipeline.svg. Session 5 section 4: a preprocessing pipeline, fitted on the training rows and applied to both.
# A diagram, no data. Run from anywhere: python preprocessing-pipeline.py
from pathlib import Path

import matplotlib
matplotlib.use("Agg")
matplotlib.rcParams["svg.hashsalt"] = "sdsai"  # stable ids, so a re-run gives an identical file
import matplotlib.pyplot as plt
from matplotlib.patches import FancyBboxPatch

fig, ax = plt.subplots(figsize=(11, 3.6))
ax.set_xlim(0, 11)
ax.set_ylim(0, 4)
ax.axis('off')

def box(x, y, w, text, colour):
    ax.add_patch(FancyBboxPatch((x, y), w, 0.8, boxstyle='round,pad=0.05', facecolor=colour, edgecolor='#444444'))
    ax.text(x + w / 2, y + 0.4, text, ha='center', va='center', fontsize=10)

def arrow(x1, y1, x2, y2, style='-'):
    ax.annotate('', xy=(x2, y2), xytext=(x1, y1), arrowprops=dict(arrowstyle='->', color='#444444', linestyle=style))

# Training rows: fit, then transform
box(0.2, 2.8, 1.8, 'Training rows', '#dbe4f5')
box(3.0, 2.8, 2.2, 'Impute\nlearn the medians', '#f5e6c8')
box(6.0, 2.8, 2.2, 'Scale\nlearn means, spreads', '#f5e6c8')
box(9.0, 2.8, 1.8, 'X_train', '#dbe4f5')
for x1, x2 in [(2.0, 3.0), (5.2, 6.0), (8.2, 9.0)]:
    arrow(x1, 3.2, x2, 3.2)
ax.text(5.6, 3.85, 'fit: every step learns from the training rows', ha='center', fontsize=10, color='#0000cd')

# Test rows: transform only, with what was learned
box(0.2, 0.6, 1.8, 'Test rows', '#f5d6d6')
box(3.0, 0.6, 2.2, 'Impute\nwith those medians', '#eeeeee')
box(6.0, 0.6, 2.2, 'Scale\nwith those means', '#eeeeee')
box(9.0, 0.6, 1.8, 'X_test', '#f5d6d6')
for x1, x2 in [(2.0, 3.0), (5.2, 6.0), (8.2, 9.0)]:
    arrow(x1, 1.0, x2, 1.0)
for x in [4.1, 7.1]:
    arrow(x, 2.8, x, 1.4, style='--')
ax.text(5.6, 0.15, 'transform: the test rows are changed, never learned from', ha='center', fontsize=10, color='#c0392b')

plt.tight_layout()
plt.savefig(Path(__file__).parent.parent / 'Illustrations-SDSAI-04_Preprocessing-Pipeline.svg', bbox_inches='tight', metadata={'Date': None})
