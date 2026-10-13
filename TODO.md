# TODO
Changes that are needed to the course material or ideas for general improvements

## Course-wide (2027)
*   Shift the balance of each session from methods towards data and judgement. Sort the code by what a student needs when stuck on it: method vocabulary (`sort_values`, string methods, plot styling, `fit`/`predict`) moves to run-before-class pre-work, where the docs or an assistant answer the question; the model-forming ideas (scope, a column is not a list, what a join keeps, groupby as a reduction, leakage) stay in class as Predicts; the integration tasks that chain methods into a feature or an analysis stay in class as the self-paced block, with support in the room.
*   Gate the pre-work: the first Predict of each session should only be answerable by someone who ran the pre-work cells, so the balance above holds through the course.
*   Decide the balance per session from the 2026 run: where pairs stalled in the self-paced block, which Predicts produced discussion, and whether the capstones came back done.

## 1 / Programming for DS and AI

## 2 / Manipulating and Visualising Data

## 3 / Accessing Data and Challenge 1

## 4 / ML Foundations and Data Prep
*   Need to simplify the MIMIC access, too many issues with different versions and projects. This should be standardised and simplified.
*   Start with a simpler example for the MEWS, perhaps hint about the use of cut with labels
*   Cells fail if run out of order (`df_vitalsign`, `df_day1_vitalsign`, `df_bloodgas`, `df_messy`). The MIMIC query is too slow to repeat in every cell, so cache it once and have each exercise reload from the cache

## 5 / Supervised Learning
*   AUC ROC needs more explanation or detail or introduction
*   Some worked examples would make this smoother
*   Cells fail if run out of order (`df_day1_vitalsign`, train/test splits, fitted `model`). Each exercise cell should rebuild what it needs

## 6 / Neural Networks
*   Todo
*   Exercise cells rely on `df_day1_vitalsign` from an earlier cell (see lecture 4 note)

## 7 / Ensemble Methods Etc.
*   Todo
*   Exercise cells rely on `df_day1_vitalsign` from an earlier cell (see lecture 4 note)

## 8 / Summary
*   Summary of data pipeline (i.e. spliting, etc) at the end
*   Summary of data leakage