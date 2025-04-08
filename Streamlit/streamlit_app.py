import streamlit as st
from textSummarizer.pipeline.prediction import PredictionPipeline

st.set_page_config(page_title="Text Summarizer", page_icon="📝", layout="centered")

st.title("📝 AI Text Summarizer")
st.markdown("Paste your content and get an instant summary powered by Transformers!")

input_text = st.text_area("📌 Enter your text here:", height=300)

if st.button("✨ Summarize"):
    if not input_text.strip():
        st.warning("⚠️ Please enter some text.")
    else:
        with st.spinner("🔄 Generating summary..."):
            try:
                obj = PredictionPipeline()
                summary = obj.predict(input_text)

                st.markdown("### ✅ Summary")
                st.success(summary)
            except Exception as e:
                st.error(f"❌ Error: {e}")

st.markdown("---")
st.markdown("<div style='text-align:center;'>Made with ❤️ by Bhavadharini G</div>", unsafe_allow_html=True)
