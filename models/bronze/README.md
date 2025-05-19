The Bronze layer, or Staging area, is for raw or minimally transformed data. The primary purpose of these tables is as a source for data pipelines and exploratory queries.

QBiz best practices allow for basic deduplication and addition of audit columns to these tables, but all other actions should be saved for the Silver or Gold layers unless there is a pressing reason to do them here. 