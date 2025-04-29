from flask import Flask, jsonify, request
from flask_mysqldb import MySQL
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics import classification_report
from sklearn.naive_bayes import MultinomialNB
import pandas as pd
from sklearn.model_selection import train_test_split
from flask_cors import CORS
from flask import Flask, jsonify, request
from flask_mysqldb import MySQL
import numpy as np
import pandas as pd
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.mixture import GaussianMixture
from sklearn.decomposition import PCA
from textblob import TextBlob
import nltk
from nltk.corpus import movie_reviews
from flask_cors import CORS

app = Flask(__name__)
CORS(app, resources={r"/*": {"origins": "http://localhost:3000"}})  # Enable CORS for your Flask app

# Configure MySQL
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'car'

mysql = MySQL(app)
nltk.download('movie_reviews')
nltk.download('punkt')
@app.route('/api/mechanic', methods=['POST', 'OPTIONS'])
def get_mechanics():
    if request.method == 'POST':
        mechanic_id = request.json.get('mechanic_id')
        print(mechanic_id)
        cur = mysql.connection.cursor()
        cur.execute("SELECT review FROM rating WHERE mechanicid = %s", (mechanic_id,))
        rows = cur.fetchall()
        cur.close()

        if rows:
            reviews = [row[0] for row in rows]

            # with open('test.txt', 'w') as file:
            #     for review in reviews:
            #         file.write(review + '\n')
            text = " ".join(reviews)

            # file_path = "test.txt"
            # with open(file_path, 'r') as file:
            #     text = file.read()

            data = {'text': [text]}
            input_data = pd.DataFrame(data)

            full_data = pd.read_csv("data/movie.csv")

            trainData, testData = train_test_split(full_data, test_size=0.2, random_state=42)

            vectorizer = TfidfVectorizer(min_df=5, max_df=0.8, sublinear_tf=True, use_idf=True)
            train_vectors = vectorizer.fit_transform(trainData['text'])
            test_vectors = vectorizer.transform(testData['text'])
            input_vectors = vectorizer.transform(input_data['text'])

            classifier_nb = MultinomialNB()
            classifier_nb.fit(train_vectors, trainData['label'])
            prediction_nb = classifier_nb.predict(input_vectors)

            if prediction_nb[0] == 1:
                cur = mysql.connection.cursor()
                cur.execute("UPDATE mechanic SET sentiment = 'positive' WHERE mechanicid = %s", (mechanic_id,))
                mysql.connection.commit()
                cur.close()
                sentiment = "Positive"
                print("Sentiment: Positive")
            elif prediction_nb[0] == 0:
                cur = mysql.connection.cursor()
                cur.execute("UPDATE mechanic SET sentiment = 'negative' WHERE mechanicid = %s", (mechanic_id,))
                mysql.connection.commit()
                cur.close()
                sentiment = "Negative"
                print("Sentiment: Negative")

            test_predictions = classifier_nb.predict(test_vectors)
            print("\nClassification Report for Test Data:")
            print(classification_report(testData['label'], test_predictions))

            return jsonify({'mechanic_id': mechanic_id, 'reviews': reviews, 'sentiment': sentiment})
        else:
            return jsonify({'message': 'Mechanic not found'}), 404
    elif request.method == 'OPTIONS':
        headers = {
            'Access-Control-Allow-Origin': 'http://localhost:3000',
            'Access-Control-Allow-Methods': 'POST, OPTIONS',
            'Access-Control-Allow-Headers': 'Content-Type'
        }
        return '', 200, headers



def load_imdb_data():
    reviews = []
    labels = []
    for category in movie_reviews.categories():
        for fileid in movie_reviews.fileids(category):
            reviews.append(movie_reviews.raw(fileid))
            labels.append(category)
    return pd.DataFrame({'review': reviews, 'label': labels})

df = load_imdb_data()

# Sample a subset for faster processing (optional)
df = df.sample(500, random_state=1).reset_index(drop=True)

# Perform Sentiment Analysis
def get_sentiment(text):
    analysis = TextBlob(text)
    if analysis.sentiment.polarity > 0:
        return 'positive'
    elif analysis.sentiment.polarity == 0:
        return 'neutral'
    else:
        return 'negative'

df['sentiment'] = df['review'].apply(get_sentiment)

# Vectorize the text data
vectorizer = TfidfVectorizer(stop_words='english', max_features=1000)
X = vectorizer.fit_transform(df['review'])

# Apply PCA for dimensionality reduction
pca = PCA(n_components=2)
X_pca = pca.fit_transform(X.toarray())

# Apply Gaussian Mixture Model
gmm = GaussianMixture(n_components=3)
gmm.fit(X_pca)
labels = gmm.predict(X_pca)

# Define a function to test the model on new data
def test_model(text):
    sentiment = get_sentiment(text)
    text_vectorized = vectorizer.transform([text])
    text_pca = pca.transform(text_vectorized.toarray())
    cluster_label = gmm.predict(text_pca)[0]
    return sentiment, cluster_label

@app.route('/api/mechanicRank', methods=['POST', 'OPTIONS'])
def get_Rank():
    if request.method == 'POST':
        mechanic_id = request.json.get('mechanic_id')
        cur = mysql.connection.cursor()
        cur.execute("SELECT review FROM rating WHERE mechanicid = %s", (mechanic_id,))
        rows = cur.fetchall()
        cur.close()

        if rows:
            reviews = [row[0] for row in rows]
            text = " ".join(reviews)

            predicted_sentiment, predicted_cluster = test_model(text)
            sentiment_count = {'positive': 0, 'neutral': 0, 'negative': 0}
            sentiment_count[predicted_sentiment] += 1

            if predicted_sentiment == 'positive':
                cur = mysql.connection.cursor()
                cur.execute("UPDATE mechanic SET sentiment = 'positive' WHERE mechanicid = %s", (mechanic_id,))
                mysql.connection.commit()
                cur.close()
            elif predicted_sentiment == 'negative':
                cur = mysql.connection.cursor()
                cur.execute("UPDATE mechanic SET sentiment = 'negative' WHERE mechanicid = %s", (mechanic_id,))
                mysql.connection.commit()
                cur.close()

            # Convert numpy int64 to python int before jsonify
            predicted_cluster = int(predicted_cluster)

            return jsonify({'mechanic_id': mechanic_id, 'reviews': reviews, 'sentiment': predicted_sentiment, 'cluster': predicted_cluster})
        else:
            return jsonify({'message': 'Mechanic not found'}), 404
    elif request.method == 'OPTIONS':
        headers = {
            'Access-Control-Allow-Origin': 'http://localhost:5001',
            'Access-Control-Allow-Methods': 'POST, OPTIONS',
            'Access-Control-Allow-Headers': 'Content-Type'
        }
        return '', 200, headers



if __name__ == '__main__':
    app.run(debug=True, port=5001)
