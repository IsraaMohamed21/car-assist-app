import pandas as pd
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.cluster import KMeans
from sklearn.metrics import silhouette_score, classification_report
from nltk.corpus import stopwords
from nltk.tokenize import word_tokenize
from nltk.stem import WordNetLemmatizer
from sklearn.model_selection import train_test_split
import string

# Importing Libraries

# Loading Data
df = pd.read_csv('data/movie2.csv')

# Text Preprocessing
def preprocess_text(text):
    # Tokenization
    tokens = word_tokenize(text.lower())
    # Remove stopwords and punctuation
    stop_words = set(stopwords.words('english'))
    tokens = [token for token in tokens if token not in stop_words and token not in string.punctuation]
    # Lemmatization
    lemmatizer = WordNetLemmatizer()
    tokens = [lemmatizer.lemmatize(token) for token in tokens]
    return ' '.join(tokens)

df['processed_review'] = df['text'].apply(preprocess_text)

# Vectorization
vectorizer = TfidfVectorizer()
X = vectorizer.fit_transform(df['processed_review'])

# Splitting the data
true_labels = df['label']
X_train, X_test, y_train, y_test = train_test_split(X, true_labels, test_size=0.2, random_state=42)

# Clustering (K-means) on training data
k = 3  # Number of clusters
kmeans = KMeans(n_clusters=k)
kmeans.fit(X_train)

# Evaluation on testing data
silhouette_avg = silhouette_score(X_test, kmeans.predict(X_test))
print("Silhouette Score on Testing Data:", silhouette_avg)

# Printing Cluster Centroids
print("Cluster Centroids:")
order_centroids = kmeans.cluster_centers_.argsort()[:, ::-1]
terms = vectorizer.get_feature_names_out()  # Corrected method call
for i in range(k):
    print(f"Cluster {i}:")
    for ind in order_centroids[i, :10]:  # Print top 10 terms per cluster
        print(f"  {terms[ind]}")

# Classification report on testing data
classification_rep = classification_report(y_test, kmeans.predict(X_test))
print("Classification Report on Testing Data:")
print(classification_rep)
