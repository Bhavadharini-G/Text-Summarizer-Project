import streamlit as st
from textSummarizer.pipeline.prediction import PredictionPipeline

# ----------------------------------------
# Page Configuration
# ----------------------------------------
st.set_page_config(
    page_title="Text Summarizer",
    page_icon="📝",
    layout="centered",
    initial_sidebar_state="auto"
)

# ----------------------------------------
# Custom CSS Styling
# ----------------------------------------
st.markdown("""
    <style>
        .main {
            background-color: #f9f9f9;
        }
        .block-container {
            padding-top: 2rem;
            padding-bottom: 2rem;
        }
        .stTextArea textarea {
            font-size: 16px;
            line-height: 1.6;
        }
        .summary-box {
            background-color: #e8f0fe;
            padding: 1rem;
            border-radius: 10px;
            font-size: 17px;
            color: #333;
        }
        .footer {
            text-align: center;
            margin-top: 3rem;
            color: #888;
            font-size: 14px;
        }
    </style>
""", unsafe_allow_html=True)

# ----------------------------------------
# Title
# ----------------------------------------
st.title("📝 AI Text Summarizer")

st.markdown(
    """
    This app uses **Transformers** to generate concise summaries from your input text.  
    Paste your content below and hit **Summarize** to get started!
    """
)

# ----------------------------------------
# Input Text Area
# ----------------------------------------
input_text = st.text_area(
    "📌 Enter your text here:",
    placeholder="Paste any article, paragraph, or lengthy content...",
    height=300
)

# ----------------------------------------
# Prediction & Summary
# ----------------------------------------
if st.button("✨ Summarize"):
    if input_text.strip() == "":
        st.warning("⚠️ Please enter some text to summarize.")
    else:
        with st.spinner("🔄 Generating summary..."):
            try:
                obj = PredictionPipeline()
                summary = obj.predict(input_text)

                st.markdown("### ✅ Summary")
                st.markdown(f"<div class='summary-box'>{summary}</div>", unsafe_allow_html=True)

            except Exception as e:
                st.error(f"❌ Error during summarization: {e}")

# ----------------------------------------
# Footer
# ----------------------------------------
st.markdown("---")
st.markdown("<div class='footer'>Made with ❤️ by Bhavadharini G</div>", unsafe_allow_html=True)
