from fastapi import FastAPI, Request
from fastapi.responses import RedirectResponse, JSONResponse
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
import uvicorn
import os

from textSummarizer.pipeline.prediction import PredictionPipeline

# Text input model
class TextInput(BaseModel):
    text: str

app = FastAPI()

# Enable CORS (optional, useful if calling API from frontend like React/Streamlit)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Adjust as needed
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/", tags=["Root"])
async def index():
    return RedirectResponse(url="/docs")

@app.get("/train", tags=["Training"])
async def training():
    try:
        os.system("python main.py")
        return JSONResponse(content={"message": "Training successful!"})
    except Exception as e:
        return JSONResponse(status_code=500, content={"error": str(e)})

@app.post("/predict", tags=["Prediction"])
async def predict_route(input: TextInput):
    try:
        obj = PredictionPipeline()
        summary = obj.predict(input.text)
        return JSONResponse(content={"summary": summary})
    except Exception as e:
        return JSONResponse(status_code=500, content={"error": str(e)})

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8080)
