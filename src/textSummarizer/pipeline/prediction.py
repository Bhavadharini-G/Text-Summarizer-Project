from transformers import AutoTokenizer, pipeline

class PredictionPipeline:
    def __init__(self):
        # Use your Hugging Face model repo
        self.model_name = "Bhavadharini-G/text-summarizer-custom"
        
        # Load tokenizer and summarization pipeline
        self.tokenizer = AutoTokenizer.from_pretrained(self.model_name)
        self.pipe = pipeline("summarization", model=self.model_name, tokenizer=self.tokenizer)

    def predict(self, text):
        gen_kwargs = {
            "length_penalty": 0.8,
            "num_beams": 8,
            "max_length": 128
        }

        print("Dialogue:")
        print(text)

        output = self.pipe(text, **gen_kwargs)[0]["summary_text"]

        print("\nModel Summary:")
        print(output)

        return output
