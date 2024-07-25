
import sys
import json
import pyspark
from pyspark.sql.functions import col, collect_list, array_join,array_intersect,size,array,lit

from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job

from pyspark.sql.functions import array_contains
from functools import reduce


##### FROM FILES
mindease_dataset_path = "s3://mindease-data-24/respirazione.csv"

###### READ PARAMETERS
args = getResolvedOptions(sys.argv, ['JOB_NAME'])

##### START JOB CONTEXT AND JOB
sc = SparkContext()


glueContext = GlueContext(sc)
spark = glueContext.spark_session


    
job = Job(glueContext)
job.init(args['JOB_NAME'], args)


#### READ INPUT FILES TO CREATE AN INPUT DATASET
mindease_dataset = spark.read \
    .option("header","true") \
    .option("quote", "\"") \
    .option("escape", "\"") \
    .csv(mindease_dataset_path)

mindease_dataset.printSchema()




write_mongo_options = {
    "connectionName": "MindEase connection",
    "database": "Tesi_MindEase",
    "collection": "MindEase_Respirazione",
    "ssl": "true",
    "ssl.domain_match": "false"}
from awsglue.dynamicframe import DynamicFrame
mindease_dataset_dataset_dynamic_frame = DynamicFrame.fromDF(mindease_dataset, glueContext, "nested")

glueContext.write_dynamic_frame.from_options(mindease_dataset_dataset_dynamic_frame, connection_type="mongodb", connection_options=write_mongo_options)
