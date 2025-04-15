import sys
import os

# Add src to path
sys.path.append(os.path.join(os.getcwd(), "src"))

from textSummarizer.pipeline.stage_01_data_ingestion import DataIngestionTrainingPipeline
from textSummarizer.pipeline.stage_02_data_validation import DataValidationTrainingPipeline
from textSummarizer.pipeline.stage_03_data_transformation import DataTransformationTrainingPipeline
from textSummarizer.pipeline.stage_04_model_trainer import ModelTrainerTrainingPipeline
from textSummarizer.pipeline.stage_05_model_evaluation import ModelEvaluationTrainingPipeline
from textSummarizer.logging import logger

if __name__ == "__main__":
    
    stages = [
        ("Data Ingestion stage", DataIngestionTrainingPipeline),
        ("Data Validation stage", DataValidationTrainingPipeline),
        ("Data Transformation stage", DataTransformationTrainingPipeline),
        ("Model Trainer stage", ModelTrainerTrainingPipeline),
        ("Model Evaluation stage", ModelEvaluationTrainingPipeline)
    ]

    for stage_name, stage_class in stages:
        try:
            logger.info(f"\n\nx==========x\n>>>>> Stage: {stage_name} started <<<<<")
            stage = stage_class()
            stage.main()
            logger.info(f">>>>> Stage: {stage_name} completed <<<<<\n\nx==========x\n")
        except Exception as e:
            logger.exception(f"Exception in {stage_name}: {e}")
            raise e
