
# Project Data Mining 🍽️📱

## 🧾 Proje Hakkında

Bu proje, üniversite yemekhanesinde sunulan yemekleri mobil cihaz aracılığıyla tanıyabilen ve **YOLO (You Only Look Once)** tabanlı görüntü analizi yapan bir mobil uygulamadır.  
Proje kapsamında yalnızca yemek tanıma değil, aynı zamanda **kalori tahmini** de yapılmaktadır.

Proje, veri madenciliği ve görüntü işleme tekniklerini birleştirerek, öğrencilerin yemeklerin içerik ve kalori bilgilerine daha hızlı erişmesini amaçlamaktadır.

## 🧠 Kullanılan Teknolojiler

- 📸 YOLOv5 / YOLOv8 (görüntü tanıma için)
- 📱 Mobil uygulama (Flutter veya Android Native)
- 🧮 Kalori tahmin algoritması (besin veri tabanına dayalı)
- 🧾 TensorFlow / PyTorch (model eğitimi için)
- 🗃️ Özel olarak etiketlenmiş yemek veri seti

## 🚀 Uygulama Özellikleri

- Gerçek zamanlı kamera ile yemek tanıma
- Birden fazla yemeği aynı anda tespit etme (multi-class detection)
- Tespit edilen her bir yemeğin kalori bilgisini gösterme
- Kullanıcı dostu mobil arayüz
- Yemek geçmişi/log kaydı (isteğe bağlı)

## 🔧 Projeyi Çalıştırmak İçin

1. Bu repoyu klonlayın:
   ```bash
   git clone https://github.com/innery/Project_Data_Mining.git
   ```

2. Eğer model eğitimi yapacaksanız:
   - `requirements.txt` dosyasındaki kütüphaneleri kurun
   - Eğitim verilerini `data/` klasörüne koyun
   - YOLOv5/YOLOv8 ile eğitimi başlatın

3. Mobil uygulamayı çalıştırmak için:
   - Flutter/Android Studio kullanarak `lib/` klasöründen projeyi açın
   - Gerekli API ve model dosyalarını uygulamaya dahil edin
   - Emülatör veya gerçek cihazda çalıştırın

## 📸 Örnek Çalışma

- 🍛 Pilav, kuru fasulye ve cacık aynı anda tanımlanır
- 🔢 Toplam kalori hesaplanır ve kullanıcıya gösterilir

## 📄 Lisans

Bu proje yalnızca akademik kullanım içindir. Ticari kullanım durumlarında geliştiricilere danışılmalıdır.
