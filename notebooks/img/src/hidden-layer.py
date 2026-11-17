# Draws ../Illustrations-SDSAI-05_Hidden-Layer.svg. The network of Session 6's temperature
# example: one input, ten ReLU hidden neurons, one sigmoid output. Run from anywhere: python hidden-layer.py
from pathlib import Path

import matplotlib
matplotlib.use("Agg")
matplotlib.rcParams["svg.hashsalt"] = "sdsai"  # stable ids, so a re-run gives an identical file
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.patches import Circle

# Layer colours as in the other network illustrations
INPUT = ('#fff2cc', '#d6b656')
HIDDEN = ('#f8cecc', '#b85450')
OUTPUT = ('#d5e8d4', '#82b366')
RADIUS = 0.32

fig, ax = plt.subplots(figsize=(10, 4.6))
ax.set_xlim(-2.2, 12.4)
ax.set_ylim(-0.6, 7.6)
ax.set_aspect('equal')
ax.axis('off')

input_xy = (0, 3.15)
output_xy = (10, 3.15)
hidden_xy = [(5, y) for y in np.linspace(6.3, 0, 10)]


def neuron(xy, colours):
    ax.add_patch(Circle(xy, RADIUS, facecolor=colours[0], edgecolor=colours[1], linewidth=1.5, zorder=3))


def glyph(xy, curve):
    """A small activation curve drawn inside a neuron."""
    t = np.linspace(-1, 1, 50)
    x = xy[0] + 0.18 * t
    y = xy[1] - 0.15 + 0.3 * curve(t)
    ax.plot(x, y, color='#444444', linewidth=1.2, zorder=4)


def relu(t):
    return np.maximum(t, 0)


def sigmoid(t):
    return 1 / (1 + np.exp(-6 * t))


for xy in hidden_xy:
    ax.plot([input_xy[0], xy[0]], [input_xy[1], xy[1]], color='#888888', linewidth=0.8, zorder=1)
    ax.plot([xy[0], output_xy[0]], [xy[1], output_xy[1]], color='#888888', linewidth=0.8, zorder=1)
    neuron(xy, HIDDEN)
    glyph(xy, relu)

neuron(input_xy, INPUT)
neuron(output_xy, OUTPUT)
glyph(output_xy, sigmoid)

ax.annotate('', xy=(input_xy[0] - RADIUS, input_xy[1]), xytext=(-1.4, input_xy[1]),
            arrowprops=dict(arrowstyle='->', color='#444444'))
ax.text(-0.9, input_xy[1] + 0.45, 'Temperature', ha='center', fontsize=11)
ax.annotate('', xy=(11.4, output_xy[1]), xytext=(output_xy[0] + RADIUS, output_xy[1]),
            arrowprops=dict(arrowstyle='->', color='#444444'))
ax.text(11.0, output_xy[1] + 0.45, 'Risk of death', ha='center', fontsize=11)

ax.text(input_xy[0], 7.0, 'Input', ha='center', fontsize=11, color=INPUT[1], fontweight='bold')
ax.text(hidden_xy[0][0], 7.0, 'Hidden layer: 10 neurons, ReLU', ha='center', fontsize=11, color=HIDDEN[1], fontweight='bold')
ax.text(output_xy[0], 7.0, 'Output: sigmoid', ha='center', fontsize=11, color=OUTPUT[1], fontweight='bold')

plt.savefig(Path(__file__).parent.parent / 'Illustrations-SDSAI-05_Hidden-Layer.svg', bbox_inches='tight', metadata={'Date': None})
