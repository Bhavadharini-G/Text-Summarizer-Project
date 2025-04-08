import streamlit as st
from textSummarizer.pipeline.prediction import PredictionPipeline

# Page config
st.set_page_config(
    page_title="Text Summarizer",
    page_icon="📝",
    layout="centered"
)

# Title
st.title("📝 Text Summarization App")

# Text input
input_text = st.text_area("Enter your text to summarize", height=300)

# Prediction
if st.button("Summarize"):
    if input_text.strip() == "":
        st.warning("Please enter some text to summarize.")
    else:
        with st.spinner("Generating summary..."):
            try:
                obj = PredictionPipeline()
                summary = obj.predict(input_text)
                st.success("Summary:")
                st.write(summary)
            except Exception as e:
                st.error(f"❌ Error during summarization: {e}")

# Optional: Footer
st.markdown("---")
st.caption("Made with ❤️ by Bhavadharini G")
