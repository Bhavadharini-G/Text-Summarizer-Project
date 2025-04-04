import sys
import os

# Add src to path
sys.path.append(os.path.join(os.getcwd(), "src"))

# Import pipeline
from textSummarizer.pipeline import stage_01_data_ingestion




from textSummarizer.pipeline.stage_01_data_ingestion import DataIngestionTrainingPipeline

from textSummarizer.logging import logger


STAGE_NAME = "Data Ingestion stage"
try:
   logger.info(f">>>>>> stage {STAGE_NAME} started <<<<<<") 
   data_ingestion = DataIngestionTrainingPipeline()
   data_ingestion.main()
   logger.info(f">>>>>> stage {STAGE_NAME} completed <<<<<<\n\nx==========x")
except Exception as e:
        logger.exception(e)
        raise e




