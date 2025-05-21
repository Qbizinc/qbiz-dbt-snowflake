The Silver layer, or Analytical/Warehouse area, is for data that has been transformed for analytical purposes. The primary purpose of these tables is to configure the source data in a way that is easily joinable and scalable for reporting performance.

QBiz best practices are for the bulk of data transformations to be done at this layer. In addition, we recommend that the schema be organized using a Star Schema (Fact & Dimension) or similar approach.

Note that we have Silver Dimensions, Fact tables, and PII related tables split into three separate folders here. This is not necessary for this tiny example project, but can be useful with very large projects to keep things more manageable.