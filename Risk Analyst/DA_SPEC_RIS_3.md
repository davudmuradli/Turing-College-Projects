
As you know, the final Basel III framework will be implemented on 1 January 2024. Your manager asks you to calculate credit risk RWA and capital requirements for the bank's portfolio. You have to use data from the file [Mortgage_default](https://docs.google.com/spreadsheets/d/1BpIuN-rt2IvzCWiNhX7nwxl0vM9uEmM3MaIeenlBegg/edit?usp=sharing), which contains loans with a status indicator: defaulted(bad) or non-defaulted. Here is a short description of the data columns:

◾ BAD: 1 = applicant defaulted on loan or seriously delinquent; 0 = applicant paid loan.<br/>
◾ MORTDUE: Amount due on an existing mortgage.<br/>
◾ VALUE: Value of current property.<br/>
◾ JOB: Occupational categories.<br/>
◾ YOJ: Years at present job.<br/>
◾ DEROG: Number of major derogatory reports.<br/>
◾ DELINQ: Number of delinquent credit lines.<br/>
◾ CLAGE: Age of oldest credit line in months.<br/>
◾ NINQ: Number of recent credit inquiries.<br/>
◾ CLNO: Number of credit lines.<br/>
◾ DEBTINC: Debt-to-income ratio.<br/>

As you have practised in your hands-on task, now you have to calculate credit risk RWA for the given data under both standardized(follow the regulation, as in the hands-on task) and IRB approach and compare the results. For the PD model, the model's goodness of fit will not be evaluated. All given loans in the dataset are mortgage loans. If you have limitations in Google spreadsheets when calculating logistic regression with a full dataset, use less data or choose another tool. For the lines with missing collateral values, use default LTV = 0.45.

Create effective visualizations by using a tool that you are familiar with, such as Google Spreadsheets, Tableau, Looker Studio, or any other suitable data visualization tool, and briefly comment on your findings.


## Evaluation criteria for a Graded project submission:

- Correct columns were identified for calculating risk parameters and visual analyses.
- Correct calculation logic of risk parameters.
- Argumentation of chosen steps in your project.
- Visualization is clear and communicates the message/answer.
- Analysis, findings and main points clearly structured.


*During a task review, you may get asked questions that test your understanding of covered topics.*

**Sample questions:**

Why do you recommend this approach?
How can you decrease RWA?
What is the most/least risky in your portfolio?

## Submission:
- Learn more [here](https://turingcollege.atlassian.net/wiki/spaces/LG2/pages/2089484327/Passing+a+review#:~:text=Also%2C%20as%20you,be%20effectively%20communicated.) in a 'Passing a review' paragraph, about how the quality of your presentation can impact your success in passing the project.
- Please upload all solution files and .sql files for this graded task to your GitHub repository using the 'Add File' function. You can also include the necessary links in the repository's README field.
- As you are getting more and more comfortable with GitHub, a good practice is to include a comprehensive README file for your project. This file could contain code examples and other vital information for your project.
- When using projects for your **personal portfolio**, please adhere to the following [rules and guidelines](https://turingcollege.atlassian.net/wiki/x/BQAof)


