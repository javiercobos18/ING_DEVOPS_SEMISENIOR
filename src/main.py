#print("App corriendo")
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def root():
    return {"msg": "ok"}

@app.get("/health")
def health():
    return {"status": "ok"}
