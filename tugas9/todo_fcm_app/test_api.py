import urllib.request
import json

url = "https://firebaseinstallations.googleapis.com/v1/projects/tugas9-a9df7/installations"
headers = {
    "Content-Type": "application/json",
    "x-goog-api-key": "AIzaSyARV2yqMrfP9hnYZgYC_m7g6cBeay2-MR8",
    "X-Android-Package": "com.example.todo_fcm_app",
    "X-Android-Cert": "B6B2A814918D44FF082C41EA07C20FB9ADFDEB30"
}
data = json.dumps({"appId": "1:361179071207:android:dd01b9b0b1373bd4741842"}).encode("utf-8")

req = urllib.request.Request(url, data=data, headers=headers, method="POST")

try:
    with urllib.request.urlopen(req) as response:
        print("SUCCESS:", response.read().decode())
except urllib.error.HTTPError as e:
    print("ERROR:", e.code)
    print(e.read().decode())
