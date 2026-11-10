# Draws ../Illustrations-SDSAI-04_Full-Pipeline.svg. Session 5 wrap-up: the whole process, from split to evaluation.
# A diagram, no data. Run from anywhere: python full-pipeline.py
from pathlib import Path

import matplotlib
matplotlib.use("Agg")
matplotlib.rcParams["svg.hashsalt"] = "sdsai"  # stable ids, so a re-run gives an identical file
import matplotlib.pyplot as plt
from matplotlib.patches import FancyBboxPatch

fig, ax = plt.subplots(figsize=(12, 4.2))
ax.set_xlim(0, 12)
ax.set_ylim(0, 4.6)
ax.axis('off')

def box(x, y, w, text, colour, h=0.8):
    ax.add_patch(FancyBboxPatch((x, y), w, h, boxstyle='round,pad=0.05', facecolor=colour, edgecolor='#444444'))
    ax.text(x + w / 2, y + h / 2, text, ha='center', va='center', fontsize=10)

def arrow(x1, y1, x2, y2, style='-'):
    ax.annotate('', xy=(x2, y2), xytext=(x1, y1), arrowprops=dict(arrowstyle='->', color='#444444', linestyle=style))

box(0.1, 1.9, 1.5, 'Feature\ntable', '#eeeeee')
box(2.1, 1.9, 1.5, 'Split by\npatient', '#eeeeee')
arrow(1.6, 2.3, 2.1, 2.3)

# Training branch
box(4.2, 3.3, 1.5, 'Training rows', '#dbe4f5')
box(6.2, 3.3, 1.2, 'Impute', '#f5e6c8')
box(7.7, 3.3, 1.2, 'Scale', '#f5e6c8')
box(9.2, 3.3, 1.2, 'Model', '#f5e6c8')
arrow(3.6, 2.5, 4.2, 3.6)
for x1, x2 in [(5.7, 6.2), (7.4, 7.7), (8.9, 9.2)]:
    arrow(x1, 3.7, x2, 3.7)
ax.text(7.55, 4.35, 'fit: every step learns from the training rows. Cross-validation compares models here', ha='center', fontsize=9.5, color='#0000cd')

# Test branch
box(4.2, 0.6, 1.5, 'Test rows', '#f5d6d6')
box(6.2, 0.6, 1.2, 'Impute', '#eeeeee')
box(7.7, 0.6, 1.2, 'Scale', '#eeeeee')
box(9.2, 0.6, 1.2, 'Predict', '#eeeeee')
box(10.7, 0.6, 1.2, 'Evaluate', '#f5d6d6')
arrow(3.6, 2.1, 4.2, 1.0)
for x1, x2 in [(5.7, 6.2), (7.4, 7.7), (8.9, 9.2), (10.4, 10.7)]:
    arrow(x1, 1.0, x2, 1.0)
for x in [6.8, 8.3, 9.8]:
    arrow(x, 3.3, x, 1.4, style='--')
ax.text(8.0, 0.1, 'once, at the end: against a baseline, with sensitivity, PPV and AUC', ha='center', fontsize=9.5, color='#c0392b')
ax.add_patch(FancyBboxPatch((6.0, 0.45), 4.6, 3.8, boxstyle='round,pad=0.05', facecolor='none', edgecolor='#999999', linestyle=':'))
ax.text(9.05, 2.35, 'one pipeline', ha='center', va='center', fontsize=9.5, color='#444444', style='italic')

plt.tight_layout()
plt.savefig(Path(__file__).parent.parent / 'Illustrations-SDSAI-04_Full-Pipeline.svg', bbox_inches='tight', metadata={'Date': None})
