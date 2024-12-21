from flask import Flask, request, jsonify
import cv2
import numpy as np
from ultralytics import YOLO

# YOLO modelini yükle
model_path = '/Users/OPERATOR/Desktop/best14.pt'  # Modelin yolu
model = YOLO(model_path)

# Modelden sınıf isimlerini al
class_names = model.names  # Eğer modelinizin .names özelliği yoksa, bir etiket dosyasından yüklemelisiniz.

app = Flask(__name__)

@app.route('/predict', methods=['POST'])
def predict():
    # İstekten resmi al
    if 'image' not in request.files:
        return jsonify({'error': 'No image file provided'}), 400

    file = request.files['image']
    if file.filename == '':
        return jsonify({'error': 'Empty image file'}), 400

    try:
        # Resmi OpenCV formatında yükle
        np_img = np.frombuffer(file.read(), np.uint8)
        img = cv2.imdecode(np_img, cv2.IMREAD_COLOR)

        # Model ile tahmin yap
        results = model.predict(source=img)

        # Tahmin sonuçlarını JSON olarak döndür (sadece sınıf isimleri)
        predicted_classes = []
        for result in results:
            for box in result.boxes:
                class_index = int(box.cls)
                class_name = class_names[class_index] if class_index < len(class_names) else "Unknown"
                predicted_classes.append(class_name)

        return jsonify({'predictions': predicted_classes})

    except Exception as e:
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=52500)
