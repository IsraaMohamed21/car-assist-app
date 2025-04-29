import numpy as np
import pandas as pd
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.mixture import GaussianMixture
from sklearn.decomposition import PCA
import matplotlib.pyplot as plt
from textblob import TextBlob
import nltk
from nltk.corpus import movie_reviews

# Download necessary NLTK datasets
nltk.download('movie_reviews')
nltk.download('punkt')

# Load and prepare the IMDb dataset
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
    # We classify the polarity as positive, neutral, or negative
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

# Apply PCA for dimensionality reduction (optional but helps in visualization)
pca = PCA(n_components=2)
X_pca = pca.fit_transform(X.toarray())

# Apply Gaussian Mixture Model
gmm = GaussianMixture(n_components=3)  # Assuming we want to cluster into 3 clusters
gmm.fit(X_pca)
labels = gmm.predict(X_pca)

# Define a function to test the model on new data
def test_model(text):
    analysis = TextBlob(text)
    sentiment = get_sentiment(text)
    text_vectorized = vectorizer.transform([text])
    text_pca = pca.transform(text_vectorized.toarray())
    cluster_label = gmm.predict(text_pca)[0]
    return sentiment, cluster_label

# Read input from a file
def read_input_file(filename):
    with open(filename, 'r') as file:
        text = file.read()
    return text

# Test the model with input from a file
input_file = 'test.txt'  # Change this to the actual filename
test_input = read_input_file(input_file)
predicted_sentiment, predicted_cluster = test_model(test_input)
print("Predicted Sentiment for Test Input:", predicted_sentiment)
print("Predicted Cluster for Test Input:", predicted_cluster)
