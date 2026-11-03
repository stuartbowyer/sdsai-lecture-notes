# TODO
Changes that are needed to the course material or ideas for general improvements

## Course-wide (2027)
*   Shift the balance of each session from methods towards data and judgement. Sort the code by what a student needs when stuck on it: method vocabulary (`sort_values`, string methods, plot styling, `fit`/`predict`) moves to run-before-class pre-work, where the docs or an assistant answer the question; the model-forming ideas (scope, a column is not a list, what a join keeps, groupby as a reduction, leakage) stay in class as Predicts; the integration tasks that chain methods into a feature or an analysis stay in class as the self-paced block, with support in the room.
*   Gate the pre-work: the first Predict of each session should only be answerable by someone who ran the pre-work cells, so the balance above holds through the course.
*   Decide the balance per session from the 2026 run: where pairs stalled in the self-paced block, which Predicts produced discussion, and whether the capstones came back done.
*   Diversify the activity types beyond Predict and Your Turn, following PRIMM. Together time is Run–Investigate: a worked example, then a question answered from the output or by changing one thing (locate the line, trace where the rows went, read the error). Predict only where the construct has already been met, answered silently in pairs. The self-paced block is mainly Modify: a working cell, then change it to answer the adjacent question; fill-the-blank only where the pattern has been seen twice. Make is homework and the capstone. Update the "How to use this notebook" slide to match.
*   One task per cell: never two independent `____` tasks in one code cell (the Session 2 CRP cell is the worst case). Audit every session.
*   Your Turns only in self-paced blocks or homework; audit every session for Your Turns inside together sections.

## 1 / Programming for DS and AI

## 2 / Manipulating and Visualising Data
*   Regroup into one together block, one practice block and a short close. Together block, in order: intro to functions and libraries, CRP loops, Miro presentations (in the middle, where the recipes lead into the five-verbs table), pandas basics, combining, plotting, as demos and Investigates only. Then a ~70-minute self-paced block covering everything taught (table basics through groupby, plus the two-patient CRP plot and the merge-types task from Additional work). Then the Closing: plots are opinionated, the checklist, wrap-up. Fast pairs start the capstone in the block.
*   Miro presentations stay at the 30 minutes they take; the time comes out of the teaching, not the prep.
*   Section 1 becomes a 10-minute intro of functions and libraries, no Your Turns: `def` and BMI, argument order as an Investigate, the scope cell as an error to read, defaults framed as reading a pandas call (`how=`, `bins=`, `index=False`), then imports with the four Predicts (these have ground). ILO 1 and the outline change to match.
*   Writing functions becomes homework, a block before the capstone and listed in Before Session 3: MAP, `bmi_category` (a literal BMI; chaining shown as a worked two-liner with an intermediate variable), wrapping the CRP loop in `count_results(name)` with the transformation shown step by step, then type hints and docstrings. The capstone stretch (`.apply` with a function) follows on. Session 3's first activity can gate it.
*   CRP results: the count and mean loops given complete, run and investigated in together time, so "No loops" still contrasts against them. The function wrap is the homework above.
*   Convert the groundless Predicts: concat of mismatched columns, the merge of ten rows (run both shapes, where did the 990 go, then change `how`), the index on the x-axis. Keep argument order, the imports, ward == Surgical, age over 100, the pie chart.
*   Write a minute budget per section before editing; only the self-paced block flexes.
*   Solutions notebook follows the moves.

## 3 / Accessing Data and Challenge
*   'The cohorts diagnoses' doesn't really fit. we say we're not teaching SQL but then asks them functions they don't know.
*   One of the exercises implied that the students needed to change it to use the full mimic rather than my small table. this needs clarifying.

## 4 / ML Foundations and Data Prep
*   The 2026 rewrite is over length: the lecture sections (2 to 6) and the practice block are both written in full. Decide what to drop, skim or demote to the appendix after the 2026 run.
*   The practice block's model (in-hospital death, ICU cohort) is a placeholder for the ICU-heavy middle of the course; revisit if Sessions 5 to 7 move to a non-ICU question.

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