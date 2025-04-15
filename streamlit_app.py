import streamlit as st
import requests

# Streamlit UI
st.set_page_config(page_title="Text Summarizer", layout="centered")
st.title("📝 Text Summarizer")

# User Input
text_input = st.text_area("Enter text to summarize", height=200)

# API endpoint
API_URL = "http://localhost:8080/predict"  # change to deployed URL if hosted

if st.button("Summarize"):
    if text_input.strip() == "":
        st.warning("Please enter some text.")
    else:
        with st.spinner("Summarizing..."):
            try:
                response = requests.post(API_URL, json={"text": text_input})
                if response.status_code == 200:
                    summary = response.json().get("summary")
                    st.success("Summary:")
                    st.write(summary)
                else:
                    st.error(f"Error: {response.json().get('error')}")
            except Exception as e:
                st.error(f"Could not connect to the FastAPI server. Error: {e}")
