import streamlit as st
from transformers import pipeline
import torch

# Streamlit UI setup
st.set_page_config(page_title="Text Summarizer", layout="centered")
st.title("📝 Text Summarizer")

# Load summarizer pipeline
@st.cache_resource
def load_summarizer():
    device = 0 if torch.cuda.is_available() else -1
    return pipeline("summarization", model="facebook/bart-large-cnn", device=device)

summarizer = load_summarizer()

# Text input
text_input = st.text_area("Enter text to summarize", height=200)

# Summarize on button click
if st.button("Summarize"):
    if text_input.strip() == "":
        st.warning("Please enter some text.")
    else:
        with st.spinner("Summarizing..."):
            try:
                summary = summarizer(text_input, max_length=130, min_length=30, do_sample=False)
                st.success("Summary:")
                st.write(summary[0]['summary_text'])
            except Exception as e:
                st.error(f"Summarization failed. Error: {e}")
