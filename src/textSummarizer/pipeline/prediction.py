from transformers import AutoTokenizer, AutoModelForSeq2SeqLM, pipeline

class PredictionPipeline:
    def __init__(self):
        self.model_path = "artifacts/model_trainer/model"
        self.tokenizer_path = "artifacts/model_trainer/tokenizer"

    def predict(self, text):
        tokenizer = AutoTokenizer.from_pretrained(self.tokenizer_path)
        model = AutoModelForSeq2SeqLM.from_pretrained(self.model_path)

        summarizer = pipeline("summarization", model=model, tokenizer=tokenizer)

        gen_kwargs = {"length_penalty": 0.8, "num_beams": 8, "max_length": 128}
        summary = summarizer(text, **gen_kwargs)[0]["summary_text"]

        return summary
