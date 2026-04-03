import requests

def check_health():
    try:
        response = requests.get("http://localhost:8000/health")
        if response.status_code == 200:
            print("✅ Servicio saludable")
        else:
            print("⚠️ Servicio responde con error:", response.status_code)
    except Exception as e:
        print("❌ Error al conectar:", e)

if __name__ == "__main__":
    check_health()
