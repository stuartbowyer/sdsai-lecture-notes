# TODO
Changes that are needed to the course material or ideas for general improvements

## 1 / Programming for DS and AI

## 2 / Manipulating and Visualising Data
*   For the CRP example, it would be clearer for explanation and testing to just pick a name and run the function rather than using a loop
*   Cells fail if run out of order (54 of 64 code cells rely on earlier ones: `pd`/`plt` imports and `df_*` frames). Make each exercise cell load what it needs (imports and `pd.read_csv`) as done for lecture 1

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