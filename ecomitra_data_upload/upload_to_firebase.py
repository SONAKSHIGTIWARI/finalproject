import pandas as pd
import firebase_admin
from firebase_admin import credentials, firestore

# 1️⃣ Firebase से कनेक्शन
cred = credentials.Certificate("serviceAccountKey.json")
firebase_admin.initialize_app(cred)
db = firestore.client()

# 2️⃣ Excel डेटा लोड करें
df = pd.read_excel("product_eco_data.xlsx")

# 3️⃣ प्रत्येक row को Firestore में अपलोड करें
for _, row in df.iterrows():
    product_id = str(row['Barcode'])  # Barcode को document ID बना रहे हैं
    db.collection('products').document(product_id).set({
        'barcode': product_id, 
        'name': row['Product Name'],
        'transport_distance_km': row['Transport Distance (km)'],
        'transport_score': row['Transport Score'],
        'packaging_type': row['Packaging Type'],
        'packaging_score': row['Packaging Score'],
        'impacting_ingredient': row['Impacting Ingredient'],
        'ingredient_score': row['Ingredient Score'],
        'total_eco_score': row['Total Eco Score (Higher is Better)'],
        'image': row['Image']
    })

print("✅ Data uploaded successfully to Firebase Firestore!")
