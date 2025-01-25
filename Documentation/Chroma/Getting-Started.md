```
Getting Started
Chroma is an AI-native open-source vector database. It comes with everything you need to get started built in, and runs on your machine. A hosted version is coming soon!

1. Install

```bash
pip install chromadb
```

2. Create a Chroma Client

```python
import chromadb
chroma_client = chromadb.Client()
```

3. Create a collection
Collections are where you'll store your embeddings, documents, and any additional metadata. Collections index your embeddings and documents, and enable efficient retrieval and filtering. You can create a collection with a name:

```python
collection = chroma_client.create_collection(name="my_collection")
```

4. Add some text documents to the collection
Chroma will store your text and handle embedding and indexing automatically. You can also customize the embedding model. You must provide unique string IDs for your documents.

```python
collection.add(
    documents=[
        "This is a document about pineapple",
        "This is a document about oranges"
    ],
    ids=["id1", "id2"]
)
```

5. Query the collection
You can query the collection with a list of query texts, and Chroma will return the n most similar results. It's that easy!

```python
results = collection.query(
    query_texts=["This is a query document about hawaii"], # Chroma will embed this for you
    n_results=2 # how many results to return
)
print(results)
```

If n_results is not provided, Chroma will return 10 results by default. Here we only added 2 documents, so we set n_results=2.

6. Inspect Results
From the above query - you can see that our query about hawaii is the semantically most similar to the document about pineapple.

```json
{
  'documents': [[
      'This is a document about pineapple',
      'This is a document about oranges'
  ]],
  'ids': [['id1', 'id2']],
  'distances': [[1.0404009819030762, 1.243080496788025]],
  'uris': None,
  'data': None,
  'metadatas': [[None, None]],
  'embeddings': None,
}
```

7. Try it out yourself
For example - what if we tried querying with "This is a document about florida"?

```python
import chromadb
chroma_client = chromadb.Client()

# switch `create_collection` to `get_or_create_collection` to avoid creating a new collection every time
collection = chroma_client.get_or_create_collection(name="my_collection")

# switch `add` to `upsert` to avoid adding the same documents every time
collection.upsert(
    documents=[
        "This is a document about pineapple",
        "This is a document about oranges"
    ],
    ids=["id1", "id2"]
)

results = collection.query(
    query_texts=["This is a query document about florida"], # Chroma will embed this for you
    n_results=2 # how many results to return
)

print(results)
```
```
