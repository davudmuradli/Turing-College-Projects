## In this graded task, you will be asked to create queries to solve specific business questions.

You will have to explore the [Adventureworks 2005 database](https://drive.google.com/file/d/1-Qsnn3bg0_PYgY5kKJOUDG8xdKLvOLPK/view?usp=sharing), identify the relevant data, and figure out how to retrieve and combine it effectively across different tables.

The database can be accessed [here](https://console.cloud.google.com/bigquery?project=tc-da-1&d=adwentureworks_db&p=tc-da-1) using the BigQuery account provided to you by Turing College via email.

<br>

## Tips:
* Use the [schema](https://drive.google.com/file/d/1-Qsnn3bg0_PYgY5kKJOUDG8xdKLvOLPK/view?usp=sharing) for guidance when exploring tables and pay attention to the primary & foreign keys when writing joins.
* If the query is running slower during reruns, limit the scope of output while writing & experimenting. After the query is done, then increase the scope to the intended one.
* Use Google to find functions and solutions you may need to solve these tasks; experimentation & curiosity are key to succeeding as a junior data analyst.

**There is no one right way to get the correct result.**

> Also, make sure to use 'adwentureworks_db' **not** the **v19** version.

<br>

## Evaluation Criteria

1. **Effort & Creativity**: Demonstrated effort and creativity in researching and implementing suitable solutions.

2. **Code Formatting & Readability**:
  - Consistent and clean code formatting to ensure readability and ease of collaboration.
  - Thoughtful use of comments to explain key parts of the code, making it easier for others to review and understand.
  - Attention to indentation, naming conventions, and overall structure to maintain a professional and clear coding style.

3. **Explanation & Validation**: Ability to clearly explain the logic behind the code and validate results, showing a solid understanding of the approach taken.

4. **Your general understanding of SQL**

5. **Common sense is used when reading and interpreting requirements:**

6. **Adherence to requirements**: How well the solution works.

<br>

## Task Review Information:

During the review session, you may be asked questions to assess your understanding of the concepts and approaches used throughout the tasks.

<br>

## Sample Questions to Expect:

- What were your initial steps when writing this query?
- Did you use joins based on foreign and primary keys in the tables? If so, how did you identify them?
- Why did you choose this specific logic? Could you have solved the task using a different approach?
- How did you validate the results of your query?
- Can you think of a scenario where your query might produce incorrect results or errors (e.g., if one of the tables contains bad data)?

Be prepared to explain your reasoning and thought process clearly.

<br>

## Task Completion Instructions:

1. Create a **Google Spreadsheet** to compile your results.
2. For each task section:
  - Copy your **query result** into one sheet.
  - Copy the corresponding **written query** into a separate sheet.
  - For example, after completing task **1.1**, create two sheets: "**1.1 result**" and "**1.1 query**", and continue this structure for the remaining tasks.
3. If you're unable to produce the correct result, include your approach or ideas in the query sheet. Your effort and logical approach will be taken into account during evaluation.

**Important Note**: During the review, please make sure your BigQuery GCP environment is open. You may be asked to:
- Re-run your queries live.
- Demonstrate how you validated your results using BigQuery.

<br>

## Tasks

### 1. An Overview of Customers

**1.1** You've been tasked with creating a detailed overview of all individual customers. Individual customers are defined by `CustomerType = 'I'` and/or are stored in the individual customer table.

The output should include the following columns:

**Column List:**
`CustomerId, FirstName, LastName, FullName, addressing_title, Email, Phone, AccountNumber, CustomerType, City, State, Country, Address, NumberOfOrders, TotalAmountWithTax, LastOrderDate`

**Notes:**

- `FullName` should be a concatenation of `FirstName` and `LastName`.
- `Addressing_Title` should display the customer's title followed by their last name (e.g., Mr. Achong). If the title is missing, default to "Dear {LastName}".
- Sales information should include the number of orders, total amount (including tax), and the date of the last order.
- Limit the final result to the **top 200 rows**, ordered by **TotalAmountWithTax** in descending order.

**Hint:** Few customers have multiple addresses; to avoid duplicate data, take their latest available address by choosing max(AddressId).

* Result Hint:
 <div><img src=" https://i.imgur.com/iHraymP.png"/></div>

<br>

**1.2** The business found the original query valuable and now wants to extend it. Specifically, they need the data for **the top 200 customers with the highest total amount (including tax) who have not placed an order in the last 365 days**.

How would you identify this segment?

**Hints:**
- You can use a temp table, CTE, and/or subquery of the 1.1 select.
- Note that the database is old and the current date should be defined by finding the latest order date in the orders table.

<br>

**1.3** Enhance your original **1.1 SELECT** by adding a new column that flags customers as **Active** or **Inactive**, based on whether they have placed an order within the last 365 days.

Return only the **top 500 rows**, ordered by `CustomerId` in descending order.

<br>

**1.4** The business requires data on all **active customers** from **North America**. Only include customers who meet *either* of the following criteria:
- Total amount (with tax) is **no less than 2500**, or
- They have placed **5 or more orders**.

Additionally, split the customers' address into two separate columns in the output.

<br>

| AddressLine1         | Address_No | Address_St    |
|----------------------|------------|---------------|
| '8603 Elmhurst Lane' | 8603       | Elmhurst Lane |

<br>

> Order the output by `country`, `state`, and `date_last_order`.

<br>

### 2. Reporting Sales Numbers

- **Main tables to start from:** salesorderheader.

**2.1** Create a query to report monthly sales figures by Country and Region. For each month, include:

- Number of orders
- Number of unique customers
- Number of salespersons
- Total amount (with tax) earned

> Sales data should cover all customer types.

* Result Hint:
<div><img src="https://i.imgur.com/J69Y2cP.png"/></div>

<br>

**2.2** Enhance the *2.1 query* by adding a **cumulative sum** of the total amount (with tax) earned, calculated per **Country** and **Region**.

**Hint**: Use a CTE or subquery to implement the cumulative sum.

* Result Hint:
<div><img src="https://i.imgur.com/wfljBpY.png" /></div>

<br>

**2.3** Enhance the *2.2 query* by adding a `sales_rank` column that ranks rows from highest to lowest total amount (with tax) earned **per country and month**.

For each country, assign rank 1 to the region with the highest total amount in a given month, and so on.

- **Hint**: For example, when filtering the region to **France**, the results should look like this:
<div><img src="https://i.imgur.com/ZFIFfjH.png" /></div>

<br>

**2.4** Enhance the *2.3 query* by adding country-level tax details. Since tax rates can vary by province, include the `mean_tax_rate` column to reflect the average tax rate per country. Additionally, for transparency, add the `perc_provinces_w_tax` column to show the percentage of provinces with available tax data for each country.

  - `mean_tax_rate`: The average tax rate per country.
If a province/state has multiple tax rates, use the **highest rate**.
Do not double-count provinces/states when calculating the average.
  - `perc_provinces_w_tax`: The percentage of provinces/states within each country that have available tax rates.
Example: If a country has 5 provinces and tax rates exist for 2, the value should be **0.40**.

* For example, when filtering the region to the US, the results should look like this:
<div><img src="https://i.imgur.com/WiUtAQX.png" /></div>

<br>

# Submission

To submit your project and enable the reviewer to preview your work, follow these steps:
  1. Click on the GitHub icon above to navigate to your GitHub repository.
  2. Once there, upload a **.sql** file along with other files relevant to your project as a spreadsheet link with query examples and results.
    
This process will allow the reviewer to access and evaluate your work in advance.

**You are expected to upload your solution immediately upon scheduling a review**. A reviewer, if they see an empty repository with no solution, is allowed to cancel the review.

After your first project review, you are encouraged to use the feedback received to make changes and improve your project. If you make the changes very close to the time of the second review, inform the reviewer at the start of the call that you have made some changes. Reviewers usually check your work in advance and might have only seen a previous version. To avoid this, you can schedule your two reviews with some time in between and make the updates as early as possible.

Read more about project reviews [here](https://turingcollege.atlassian.net/wiki/spaces/DLG/pages/537395951/Peer+expert+reviews+corrections).

P.S. As a suggested practice, save your queries within the BigQuery environment. This will ensure convenient access to your SQL code.

<br>

# Additional Resources

We hope this sprint has given you good starting knowledge for practicing SQL craft. We expect you will continue to improve your SQL skills throughout the whole Data Analytics course, as many future projects will require using it. Remember, practice is key.

To help you keep learning, here are some extra materials for you to check during your spare time between other sprints & modules.

* (Optional) [SQL vs. NoSQL Databases: What's the Difference?](https://www.ibm.com/cloud/blog/sql-vs-nosql)
* (Optional) [Google BigQuery: The Definitive Guide](https://www.oreilly.com/library/view/google-bigquery-the/9781492044451/)

Keep practicing and stay curious!

___

> When you pass the project reviews for this sprint, come back to this page to find a document containing suggested solutions for this project.

<br>

### Accessing the Next Sprint in Module 2:

[Here are the instructions](https://turingcollege.atlassian.net/wiki/spaces/DLG/pages/946864153/Sprint+material+access) for accessing the next module's learning material.


