from transformers import AutoTokenizer, pipeline

class PredictionPipeline:
    def __init__(self):
        self.model_name = "bhavadharinig/text-summarizer-custom"  # Your Hugging Face repo

    def predict(self, text):
        tokenizer = AutoTokenizer.from_pretrained(self.model_name)
        gen_kwargs = {"length_penalty": 0.8, "num_beams": 8, "max_length": 128}
        pipe = pipeline("summarization", model=self.model_name, tokenizer=tokenizer)
        output = pipe(text, **gen_kwargs)[0]["summary_text"]
        return output


model_name = "bhavadharinig/text-summarizer-custom"
tokenizer = AutoTokenizer.from_pretrained(model_name)
pipe = pipeline("summarization", model=model_name, tokenizer=tokenizer)

